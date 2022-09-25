class BrailleCharacter
  attr_reader :row_1,
              :row_2,
              :row_3,
              :capital_grid,
              :combined_grid

  def initialize(row_1, row_2, row_3)
    @row_1 = row_1
    @row_2 = row_2
    @row_3 = row_3
    @upper_case = false
    @capital_grid = "..\n..\n.O\n"
    @combined_grid = row_1 + row_2 + row_3
  end

end