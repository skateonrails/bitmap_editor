class Input
  SUPPORTED_COMMANDS = %w(I C L V H S ? X).freeze

  UnsupportedCommand = Class.new(StandardError)
  InvalidInput = Class.new(StandardError)

  attr_accessor :command, :row, :col, :colour

  def initialize(input_string)
    @input_string = input_string
    @command = nil
    @row = nil
    @col = nil
    @colour = nil
    parse
  end

  private
  def parse
    input_parameters = @input_string.split(' ')
    raise InvalidInput if input_parameters.empty?

    @command = input_parameters.shift
    raise UnsupportedCommand, "unrecognised command :(" unless SUPPORTED_COMMANDS.include?( @command )

    case @command
      when "I"
        check_image_creation_parameters(input_parameters)
        @col = input_parameters[0].to_i
        @row = input_parameters[1].to_i
      when "L"
        check_colour_set_parameters(input_parameters)
        @col = input_parameters[0].to_i
        @row = input_parameters[1].to_i
        @colour = input_parameters[2].to_s
      when "V"
        check_range_parameters(input_parameters)
        @col = input_parameters[0].to_i
        @row = input_parameters[1].to_i..input_parameters[2].to_i
        @colour = input_parameters[3].to_s
      when "H"
        check_range_parameters(input_parameters)
        @col = input_parameters[0].to_i..input_parameters[1].to_i
        @row = input_parameters[2].to_i
        @colour = input_parameters[3].to_s
      else
        raise InvalidInput if input_parameters.any?
    end
  end

  def check_image_creation_parameters(input_parameters)
    raise InvalidInput if input_parameters[0].nil? || input_parameters[1].nil? || input_parameters.size > 2
  end

  def check_colour_set_parameters(input_parameters)
    raise InvalidInput if input_parameters[0].nil? || input_parameters[1].nil? || input_parameters[2].nil? || input_parameters.size > 3
  end

  def check_range_parameters(input_parameters)
    raise InvalidInput if input_parameters[0].nil? || input_parameters[1].nil? || input_parameters[2].nil? || input_parameters[3].nil? || input_parameters.size > 4
  end
end
