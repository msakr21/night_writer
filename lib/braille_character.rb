class BrailleCharacter
  attr_reader :row_1,
              :row_2,
              :row_3,
              :combined_grid

  def initialize(row_1, row_2, row_3)
    @row_1 = row_1
    @row_2 = row_2
    @row_3 = row_3
    @combined_grid = row_1 + row_2 + row_3
  end
end