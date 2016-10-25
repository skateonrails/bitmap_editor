class Image
  InvalidRowsCount = Class.new(StandardError)
  InvalidColsCount = Class.new(StandardError)
  PixelNotFound = Class.new(StandardError)
  InvalidPixelRange = Class.new(StandardError)

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
  end

  def get_pixel(row, col)
    check_parameters(row, col)

    pixel = @bitmap[row-1, col-1]
    raise PixelNotFound, "pixel not found" if pixel.nil?
    pixel
  end

  def set_vertical_pixel_colour_segment(col, row_range, colour)
    raise InvalidPixelRange, "invalid range of pixels" unless valid_pixel_range?(row_range, @rows)
    row_range.each do |row|
      self.set_pixel_colour(row, col, colour)
    end
  end

  def set_horizontal_pixel_colour_segment(col_range, row, colour)
    raise InvalidPixelRange, "invalid range of pixels" unless valid_pixel_range?(col_range, @cols)
    col_range.each do |col|
      self.set_pixel_colour(row, col, colour)
    end
  end

  def to_s
    @bitmap.to_a.map{ |aray| aray.map(&:to_s).join("") }.join("\n")
  end

  private
  def check_parameters(rows, cols)
    check_cols_value(cols)
    check_rows_value(rows)
  end

  def check_rows_value(rows)
    error_message = check_value(rows, "Rows")
    raise InvalidRowsCount, error_message unless error_message.empty?
  end

  def check_cols_value(cols)
    error_message = check_value(cols, "Columns")
    raise InvalidColsCount, error_message unless error_message.empty?
  end

  def check_value(value, type)
    return "#{type} value must be a integer" unless value.is_a?(Integer)
    return "#{type} value must be between 1 and 250" if value < 1 || value > 250
    return ""
  end

  def valid_pixel_range?(range, ref)
    sorted_range = range.sort
    first_in_range = sorted_range.first
    last_in_range = sorted_range.last

    !first_in_range.nil? && first_in_range > 0 && !last_in_range.nil? && last_in_range <= ref
  end
end
