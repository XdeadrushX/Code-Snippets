require 'colorize'

module CLI
  # Depends on Colorize
  # https://github.com/fazibear/colorize
  class Input
    # @param output [Class]
    # @param use_colors [Boolean]
    def initialize(output = STDOUT, use_colors = false)
      @col = use_colors
      @output = output
    end

    attr_accessor :col

    # For when you want to ask a question that may only
    # contain yes or not.
    #
    # @param question [String]
    # @param default [Character]
    # @return [Boolean]
    def confirm(question, default = 'y')
      respond_bool(ask(question, default), default)
    end

    # For when you want to ask a question, but interact
    # with the input manually.
    #
    # @param question [String]
    # @param options [Array]
    # @return [String] chosen option
    def prompt(question, options = [])
      result = nil

      loop do
        result = ask(question, options)

        if options.include?(result)
          break
        else
          warn("Invalid option '#{result}', please select one of the following: #{options.join(', ')}")
        end
      end

      result
    end

    # We don't know what the user will insert, but there's
    # no list to choose from.
    #
    # @param question [String]
    def input(question)
      ask(question)
    end

    # (see Input#input)
    #
    # Do not display user input to the terminal.
    def input_secure(question)
      ask(question, nil, true)
    end

    # We sort of know what the user will insert, but there's
    # no list to choose from.
    #
    # @param question [String]
    # @param type [String] A string that must contain either string, number, integer or float
    def input_strict(question, type)
      type.downcase!

      unless %w(string number integer float).include?(type)
        raise StandardError, 'Expecting either String, Number, Integer, or Float as type.'
      end

      question = question + ' (expecting a ' + type + ')'
      response = nil

      loop do
        response = ask(question)

        if validate(type, response)
          response = cast(type, response)
          break
        else
          error("Your input could not be converted to a #{type}")
        end
      end

      response
    end

    # Display a message to the screen.
    #
    # @param message [String]
    def message(msg)
      if @col
        @output.puts(msg.cyan)
      else
        @output.puts(msg)
      end
    end

    # Display a warning message in yellow if colorization is enabled
    #
    # @param message [String]
    def warn(message)
      if @col
        @output.puts(message.yellow)
      else
        @output.puts('warn: ' + message)
      end
    end

    # Display an error message in red if colorization is enabled
    #
    # @param message [String]
    def error(message)
      if @col
        @output.puts(message.red)
      else
        @output.puts('error: ' + message)
      end
    end

    # Validate if type matches the input response
    #
    # @param type [Symbol]
    # @param response [String, Integer, Float]
    # @return [Boolean]
    def validate(type, response)
      case type.to_sym
        when :string
          true
        when :number, :integer
          begin
            response.to_i
            true
          rescue
            false
          end
        when :float
          begin
            response.to_f
            true
          rescue
            false
          end
        else
          false
      end
    end

    # Cast response to type
    #
    # @param type [Symbol]
    # @param response [String, Integer, Float]
    # @return [String, Integer, Float]
    def cast(type, response)
      case type.to_sym
        when :string
          response
        when :number, :integer
          response.to_i
        when :float
          response.to_f
        else
          response
      end
    end

    # @param default [Array, String]
    # @return [Boolean]
    def defaultify(default)
      if default.is_a?(Array)
        return '' if default.empty?

        return '(' + default.join('/') + ')'
      end

      default.upcase!

      return '(Y/n)' if default == 'Y'
      '(y/N)'
    end

    # @param response []
    # @param default [Array, String]
    # @return [Boolean]
    def respond_bool(response, default)
      response.upcase!

      if %w(Y YES TRUE).include?(response)
        true
      elsif %w(N NO FALSE).include?(response)
        false
      else
        default == 'Y'
      end
    end

    # @param question [String]
    # @param default [nil, Array, String]
    # @param secure [Boolean]
    def ask(question, default = nil, secure = false)
      s = question
      s << ' ' + defaultify(default) if default

      @output.puts s.green
      read(secure)
    end

    # @param secure [Boolean]
    def read(secure = false)
      return gets.chomp unless secure

      STDIN.noecho(&:gets).chomp
    end
  end
end
