require 'singleton'
require 'net/http'

module Utility
  # An utility class that helps you send HTTP requests easily.
  class HttpRequest
    include Singleton

    # Send a HTTP GET request.
    #
    # @param uri [Uri] - URI to send a request to
    # @param verify_cert [Boolean] - Validates the certificate
    # @param headers [Hash] - A key: value hash of headers.
    #
    # @return [Net::HTTPResponse]
    def self.get(uri, verify_cert = true, headers = {})
      HttpRequest.instance.request(uri, :get, verify_cert, nil, headers)
    end

    # Send a HTTP POST request.
    #
    # @param uri [Uri] - URI to send a request to
    # @param verify_cert [Boolean] - Validates the certificate
    # @param payload [Hash] - The payload to send.
    # @param headers [Hash] - A key: value hash of headers.
    #
    # @return [Net::HTTPResponse]
    def self.post(uri, verify_cert = true, payload = nil, headers = {})
      HttpRequest.instance.request(uri, :post, verify_cert, payload, headers)
    end

    # Send a HTTP request.
    #
    # @param uri [Uri] - URI to send a request to
    # @param verify_cert [Boolean] - Validates the certificate
    # @param payload [Hash] - The payload to send.
    # @param headers [Hash] - A key: value hash of headers.
    #
    # @return [Net::HTTPResponse]
    def request(uri, method, verify_cert = true, payload = nil, headers = {})
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = uri.scheme == 'https'

      if http.use_ssl?
        http.verify_mode = verify_cert ? OpenSSL::SSL::VERIFY_PEER : OpenSSL::SSL::VERIFY_NONE
      end

      if method == :get
        request = Net::HTTP::Get.new(uri)
      else
        request = Net::HTTP::Post.new(uri, payload)
      end

      headers.each { |header, value| request[header] = value }

      response = http.request(request)

      begin
        response.value
      rescue Net::HTTPRetriableError
        location = URI(response.header['location'])

        response = request(location, method, payload, verify_cert)
      end

      response
    end
  end
end
