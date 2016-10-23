require File.join(File.dirname(__FILE__), %w(.. lib mutable_matrix.rb))

class Image
  InvalidRowsCount = Class.new(StandardError)
  InvalidColsCount = Class.new(StandardError)
  PixelNotFound = Class.new(StandardError)

  attr_accessor :rows, :cols

  def initialize(rows: 1, cols: 1)
    @rows = rows
    @cols = cols
    check_parameters
    clear
  end

  def clear
    @bitmap = MutableMatrix.build(@rows, @cols){ |row, col| Pixel.new }
  end

  def set_pixel_colour(row, col, colour)
    pixel = get_pixel(row, col)
    pixel.colour = colour
    @bitmap[row, col] = pixel
  end

  def get_pixel(row, col)
    pixel = @bitmap[row, col]
    raise PixelNotFound if pixel.nil?
    pixel
  end

  def to_s
    @bitmap.to_a.map{ |aray| aray.map(&:to_s).join("") }.join("\n")
  end

  private
  def check_parameters
    check_rows_value
    check_cols_value
  end

  def check_rows_value
    raise InvalidRowsCount, "value must be between 0 and 250" if @rows < 0 || @rows > 250
    raise InvalidRowsCount, "value must be a integer" unless @rows.is_a?(Integer)
  end

  def check_cols_value
    raise InvalidColsCount, "value must be between 0 and 250" if @cols < 0 || @cols > 250
    raise InvalidColsCount, "value must be a integer" unless @cols.is_a?(Integer)
  end
end
