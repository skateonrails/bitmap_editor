class ImageProcessor
  HELP_OUTPUT = "? - Help
I M N - Create a new M x N image with all pixels coloured white (O).
C - Clears the table, setting all pixels to white (O).
L X Y C - Colours the pixel (X,Y) with colour C.
V X Y1 Y2 C - Draw a vertical segment of colour C in column X between rows Y1 and Y2 (inclusive).
H X1 X2 Y C - Draw a horizontal segment of colour C in row Y between columns X1 and X2 (inclusive).
S - Show the contents of the current image
X - Terminate the session".freeze

  TERMINATE_OUTPUT = "goodbye!".freeze

  InvalidInputType = Class.new(StandardError)
  ImageNotFound = Class.new(StandardError)

  attr_accessor :terminate, :output

  def initialize
    @image = nil
    @terminate = false
  end

  def process(input)
    raise InvalidInputType, "invalid input class" unless input.is_a?(Input)

    @output = nil
    case input.command
      when "I"
        @image = Image.new(rows: input.row, cols: input.col)
      when "C"
        check_image
        @image.clear
      when "L"
        check_image
        @image.set_pixel_colour(input.row, input.col, input.colour)
      when "V"
        check_image
        @image.set_vertical_pixel_colour_segment(input.col, input.row, input.colour)
      when "H"
        check_image
        @image.set_horizontal_pixel_colour_segment(input.col, input.row, input.colour)
      when "S"
        @output = @image.to_s
      when "?"
        @output = HELP_OUTPUT
      when "X"
        @output = TERMINATE_OUTPUT
        @terminate = true
    end
  end

  private
  def check_image
    raise ImageNotFound, "Image must be created first. Use the '?' command for help." if @image.nil?
  end
end
