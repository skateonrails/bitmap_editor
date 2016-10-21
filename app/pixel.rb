class Pixel
  WHITE_COLOUR = "O"

  def initialize
    @colour = WHITE_COLOUR
  end

  def colour
    @colour
  end

  def colour=(colour_string)
    if colour_string =~ /^[A-Z]{1}$/
      @colour = colour_string
    end
  end
end
