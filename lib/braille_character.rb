class BrailleCharacter
  attr_reader :row_1,
              :row_2,
              :row_3,
              :upper_case,
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

  def is_upper_case?
    @upper_case
  end

  def toggle_upper_case
    @upper_case = !@upper_case
  end
end