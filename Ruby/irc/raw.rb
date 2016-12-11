module IRC
  # The maximum length a message may be before it should be split into a separate message.
  # By default, this is 512 characters.
  #
  # This value should only be used by outgoing messages. Incoming messages can vary in size.
  # A notable example is messages from the mammon ircd.
  MAX_LENGTH = 512

  # A list of capabilities that exist and are known to Octorb, but not necessarily supported.
  # This list is sorted in an alphabetical fashion, split by IRCv3 version.
  CAPS = [
    # v3.1
    :account_notify,
    :away_notify,
    :extended_join,
    :multi_prefix,
    :sasl,
    :server_time,
    :tls,

    # v3.2
    :account_tag,
    :batch,
    :cap_notify,
    :chghost,
    :echo_message,
    :invite_notify,
    # :sasl also reappears in 3.2
    :userhost_in_names,

    # v3.3
  ]

  # The template-format a hostmask has to be in order to be valid.
  Hostmask = '%{nick}!%{ident}@%{host}'
  # The template-format a full hostmask (including geckos) has to be in order to be valid.
  Fullmask = '%{nick}!%{ident}@%{host} :%{geckos}'

  # An utility class that formats events based on information given.
  #
  # It is used for sending outgoing messages, and faking data in a manner a client should expect.
  class Raw
    # Helper method that quickly formats a single-use raw message.
    #
    # @param [Symbol, String] event The event format to use, and method to call.
    # @param [String] message The message to send.
    # @param [Target] receiver The person or channel to that has received this message.
    # @param [Target, nil] sender The person, server, or channel that has sent this message.
    # @param [Array] capabilities A list of capabilities that are enabled.
    # @return [String] A raw formatted-message ready to send away.
    def self.fmt(event, message, receiver, sender = nil, capabilities = [])
      Raw.new(receiver, sender, capabilities).format(event.to_sym, message)
    end

    # A list of default templates for raw messages.
    #
    # Each existing format should have a lowercase corresponding method that
    # formats a message using said format.
    FORMATS = {
      ERROR: '%{tags}:%{sender} ERROR :%{message}',
      JOIN: '%{tags}:%{sender} JOIN :%{receiver}',
      MODE: '%{tags}:%{sender} MODE %{receiver} %{modes} %{params}',
      NOTICE: '%{tags}:%{sender} NOTICE %{receiver} :%{message}',
      NUMERIC: '%{tags}:%{sender} %{numeric} :%{message}',
      PART: '%{tags}:%{sender} PART %{receiver}%{message}',
      PRIVMSG: '%{tags}:%{sender} PRIVMSG %{receiver} :%{message}',
      QUIT: '%{tags}:%{sender} QUIT :%{message}',
      RAW: '%{tags}:%{sender} %{event} %{message}'
    }

    # @param [Target] receiver The person or channel to that has received this message.
    # @param [Target] sender The person, server, or channel that has sent this message.
    # @param [Array] capabilities A list of capabilities that are enabled.
    def initialize(receiver, sender, capabilities = [])
      @receiver = receiver
      @sender = sender
      @capabilities = capabilities
    end

    attr_accessor :sender
    attr_accessor :receiver
    attr_accessor :capabilities

    # Helper method that quickly formats a raw message.
    #
    # @param [Symbol, String] event The event format to use, and method to call.
    # @param [String] message The message to send.
    # @return [String] A raw formatted-message ready to send away.
    def format(event, message)
      method(event.to_sym).call(message)
    end

    # Helper method that quickly formats a single-use raw message.
    #
    # @param [Symbol, String] event The event format to use, and method to call.
    # @param [Array] fill Fields to fill.
    # @return [String] A template with only the fields filled by `fill`.
    def template(event, fill = [:tags])
      event = event.upcase.to_sym

      return false unless FORMATS.include?(event)

      tpl = FORMATS[event]
      filler = {}

      fill.each do |f|
        case f
          when :tags
            filler[:tags] = tagize(@capabilities)
          else
            false
        end
      end

      tpl % filler
    end

    # Following are all FORMAT methods, in alphabetical order:

    # Format a incoming CTCP request event.
    #
    # @param [String] request The request to receive.
    # @return [String] A raw formatted-message ready to send away.
    def ctcp(request, receiver = nil, sender = nil)
      receiver = @receiver unless receiver
      sender = @sender unless sender

      message = "\x01#{request}\x01".upcase

      FORMATS[:PRIVMSG] % { message: message, receiver: receiver, sender: sender, tags: tagize(@capabilities) }
    end

    # Format a outgoing CTCP response message.
    #
    # @param [String] response The response to send.
    # @return [String] A raw formatted-message ready to send away.
    def ctcp_response(response, receiver = nil, sender = nil)
      receiver = @receiver unless receiver
      sender = @sender unless sender

      message = "\x01#{response}\x01"

      FORMATS[:NOTICE] % { message: message, receiver: receiver, sender: sender, tags: tagize(@capabilities) }
    end

    # Format a error-message event.
    #
    # @param [String] message The message to send.
    # @return [String] A raw formatted-message ready to send away.
    def error(message, receiver = nil, sender = nil)
      receiver = @receiver unless receiver
      sender = @sender unless sender

      FORMATS[:ERROR] % { message: message, receiver: receiver, sender: sender, tags: tagize(@capabilities) }
    end

    def join(receiver = nil, sender = nil)
      receiver = @receiver unless receiver
      sender = @sender unless sender

      FORMATS[:JOIN] % { receiver: receiver, sender: sender, tags: tagize(@capabilities) }
    end

    # Format a mode event.
    #
    # @param [String] modes One or more modes to set. Includes +/- prefixes. ('+bb-b')
    # @param [String, nil] params The mode parameters, if any. ('one!*@* two!*@* three!*@*')
    # @return [String] A raw formatted-message ready to send away.
    def mode(modes, params = nil, receiver = nil, sender = nil)
      receiver = @receiver unless receiver
      sender = @sender unless sender

      FORMATS[:MODE] % { modes: modes, params: params, receiver: receiver, sender: sender, tags: tagize(@capabilities) }
    end

    # Format a notice event.
    #
    # @param [String] message The message to send.
    # @return [String] A raw formatted-message ready to send away.
    def notice(message, receiver = nil, sender = nil)
      receiver = @receiver unless receiver
      sender = @sender unless sender

      fmt_output(FORMATS[:NOTICE] % {
        message: message, receiver: receiver, sender: sender, tags: tagize(@capabilities)
      })
    end

    # Format a numeric event.
    #
    # @param [Integer, String] numeric the numeric to send.
    # @param [String] message The message to send.
    # @return [String] A raw formatted-message ready to send away.
    def numeric(numeric, message, receiver = nil, sender = nil)
      receiver = @receiver unless receiver
      sender = @sender unless sender

      fmt_output(FORMATS[:NUMERIC] % {
        numeric: numeric, message: message, receiver: receiver, sender: sender, tags: tagize(@capabilities)
      })
    end

    # Format a part event.
    #
    # @param [String, nil] message The part message. nil if no message was left.
    # @param [Target, String, nil] receiver The person whom parted. Defaults to @receiver
    # @param [Target, String, nil] sender The person to send the broadcast, always the server. Defaults to @sender
    # @return [String] A raw formatted-message ready to send away.
    def part(message = nil, receiver = nil, sender = nil)
      receiver = @receiver unless receiver
      sender = @sender unless sender

      # The PART format realizes part messages are optional. We construct part of the raw message ourselves here.
      # A different implementation would be to have a different format for part() and part_with_message(),
      # but that feels a bit bloaty.
      message = " :#{message}" unless message.nil?

      FORMATS[:PART] % { message: message, receiver: receiver, sender: sender, tags: tagize(@capabilities) }
    end

    # Format a private-message event.
    #
    # @param [String] message The message to send.
    # @return [String] A raw formatted-message ready to send away.
    def privmsg(message, receiver = nil, sender = nil)
      receiver = @receiver unless receiver
      sender = @sender unless sender

      fmt_output(FORMATS[:PRIVMSG] % {
        message: message, receiver: receiver, sender: sender, tags: tagize(@capabilities)
      })
    end

    # Format a quit event.
    #
    # @param [String] message The quit message. Should include the prefix (e.g. 'Quit', 'Ping timeout', 'Read error')
    # @param [Target, String, nil] quitter The person whom quit. Considering the receiver is always you in this case,
    #  specifying a quitter parameter will let you know who has quit. Otherwise defaults to @receiver
    # @return [String] A raw formatted-message ready to send away.
    def quit(message, quitter = nil)
      quitter = @receiver if quitter.nil?

      FORMATS[:QUIT] % { message: message, receiver: quitter, sender: @sender, tags: tagize(@capabilities) }
    end

    # Construct your own event by providing the event name, and the message following the event.
    #
    # An example use case is to mimic an existing v3.x capability.
    # Here's how you could mimic away_notify:
    #   r.raw(:away, "#{r.receiver} :I am now away!") # Receiver has gone away.
    #   r.raw(:away, r.receiver) # Receiver has come back.
    # Would produce:
    #   "tags :server.someserver.net AWAY the_receiver :I am now away!"
    #   "tags :server.someserver.net AWAY the_receiver"
    #
    # @param [Symbol, String] event The event to construct
    # @param [String] contents The message after the event
    # @return [String] The constructed event
    def raw(event, contents, receiver = nil, sender = nil)
      receiver = @receiver unless receiver
      sender = @sender unless sender

      event = event.upcase.to_sym

      FORMATS[:RAW] % { event: event, message: contents, receiver: receiver, sender: sender, tags: tagize(@capabilities) }
    end

    # Validate if the format exists
    #
    # @param [String] format The message to send.
    # @return [Boolean] True if it exists, false if it does not.
    def exist?(format)
      format.upcase!

      FORMATS.include?(format.to_sym)
    end

    # Return a list of tags based on the specified capabilities.
    # While some capabilities send normal events, some of them apply tags to the message.
    # For example, server-time ensures each message has a @time prefix for the client to parse.
    # This method ensures they are present.
    #
    # @param [Array] capabilities A list of symbols with enabled capabilities.
    # @param [Hash] args A map of capability: arguments - for example, account-tag requires an account name.
    # @return [String] A raw formatted-message ready to send away.
    def tagize(capabilities, args = {})
      tags = ''

      if capabilities.include?(:account_tag) && args.key?(:account)
        tags << "@account=#{args[:account]} "
      end

      if capabilities.include?(:server_time)
        tags << "@time=#{Time.now.utc.iso8601} "
      end

      tags
    end

    # Helper method that returns a string of split messages (delimited by \n)
    #
    # @param [String] raw_message Full raw message to split.
    # @param [Integer, nil] len The length to split by. Defaults to IRC::MAX_LENGTH
    # @return [String] A string of \n-joined messages, or a single message if nothing had to be split.
    def fmt_output(raw_message, len = nil)
      Array(split_raw_message(raw_message, len)).join("\n")
    end

    # Sometimes messages are too large (see IRC::MAX_LENGTH)
    #
    # When this limit is exceeded, we need to carefully split the message from the rest of the data.
    # Because some events (particularily MODE) are tricky to split, this method ensures everything gets done right.
    #
    # @param [String] raw_message Full raw message to split.
    # @param [Integer, nil] len The length to split by. Defaults to IRC::MAX_LENGTH
    # @return [String, Array] List of messages if split, the string if MAX_LENGTH was not exceeded.
    def split_raw_message(raw_message, len = nil)
      len = len.nil? ? MAX_LENGTH : len

      return Array(raw_message) if raw_message.length < len

      # No tags attached to this message. To easily split it, we prepend a space.
      # We can't just split by ':' because it can collide with channel names that have a colon in it.
      if raw_message.start_with?(':')
        tmp_message = ' ' + raw_message

        spl = tmp_message.split(' :', 2)
        raw_partial = spl.take(2).join(' :').strip
        msg = spl.last
      else
        spl = raw_message.split(' :', 2)
        raw_partial = spl.take(2).join(' :')
        msg = spl.last
      end

      messages = []
      msg_len = len - raw_partial.length + 2

      split_message(msg, msg_len).each do |m|
        messages << "#{raw_partial} :#{m}"
      end

      messages
    end

    # Sometimes messages are too large (see IRC::MAX_LENGTH)
    #
    # This method truncates the outgoing message by the permitted remaining length
    # so that the IRCd will not truncate your messages.
    #
    # If you have a raw message to split, refer to #split_raw_message
    #
    # @param [String] message The message to split. Should not be a full RAW message, just the actual message.
    # @param [Integer] len The length to split by. Should be maximum_len - (raw_message_len - message_len)
    # @return [Array] List of messages, may be only one if the message fits.
    def split_message(message, len)
      message.chars.each_slice(len).map(&:join)
    end
  end
end
