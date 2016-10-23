require 'matrix'

class MutableMatrix < Matrix
  def []=(row, column, value)
    @rows[row][column] = value
  end
end
