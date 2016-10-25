class Pixel
  WHITE_COLOUR = "O".freeze

  InvalidColour = Class.new(StandardError)

  def initialize
    @colour = WHITE_COLOUR
  end

  def colour
    @colour
  end

  def colour=(colour_string)
    raise InvalidColour, "Colour must be a capital letter, from A to Z" unless colour_string =~ /^[A-Z]{1}$/
    @colour = colour_string
  end

  def to_s
    @colour
  end
end
