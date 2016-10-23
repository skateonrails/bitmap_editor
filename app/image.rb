require File.join(File.dirname(__FILE__), %w(.. lib mutable_matrix.rb))

class Image
  InvalidRowsCount = Class.new(StandardError)
  InvalidColsCount = Class.new(StandardError)
  PixelNotFound = Class.new(StandardError)

  attr_accessor :rows, :cols

  def initialize(rows: 1, cols: 1)
    @rows = rows
    @cols = cols
    check_parameters(@rows, @cols)
    clear
  end

  def clear
    @bitmap = MutableMatrix.build(@rows, @cols){ |row, col| Pixel.new }
  end

  def set_pixel_colour(row, col, colour)
    pixel = self.get_pixel(row, col)
    pixel.colour = colour
    @bitmap[row, col] = pixel
  end

  def get_pixel(row, col)
    check_parameters(row, col)

    pixel = @bitmap[row-1, col-1]
    raise PixelNotFound if pixel.nil?
    pixel
  end

  def set_vertical_pixel_colour_segment(col, row_range, colour)
    row_range.each do |row|
      self.set_pixel_colour(row, col, colour)
    end
  end

  def set_horizontal_pixel_colour_segment(col_range, row, colour)
    col_range.each do |col|
      self.set_pixel_colour(row, col, colour)
    end
  end

  def to_s
    @bitmap.to_a.map{ |aray| aray.map(&:to_s).join("") }.join("\n")
  end

  private
  def check_parameters(rows, cols)
    check_rows_value(rows)
    check_cols_value(cols)
  end

  def check_rows_value(rows)
    error_message = check_value(rows)
    raise InvalidRowsCount, error_message unless error_message.empty?
  end

  def check_cols_value(cols)
    error_message = check_value(cols)
    raise InvalidColsCount, error_message unless error_message.empty?
  end

  def check_value(value)
    return "value must be a integer" unless value.is_a?(Integer)
    return "value must be between 0 and 250" if value < 1 || value > 250
    return ""
  end
end
