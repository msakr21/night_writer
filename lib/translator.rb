class Translator
  attr_reader :upper_case,
              :check_condition,
              :dictionary,
              :capital_grid,
              :uppercase_row_1,
              :uppercase_row_2,
              :uppercase_row_3

  def initialize
    @upper_case = false
    @check_condition = "abcdefghijklmnopqrstuvwxyz".upcase
    @dictionary = Dictionary.new
    @uppercase_row_1 = ".."
    @uppercase_row_2 = ".."
    @uppercase_row_3 = ".O"
  end

  def is_upper_case?(input)
    if check_condition.include?(input)
      true
    else
      false
    end
  end

  def toggle_upper_case(input)
    @upper_case = true if is_upper_case?(input) == true
  end

  def upper_case_braille(input)
   row_1 = (uppercase_row_1 + dictionary.braille_characters[input.downcase].row_1)
   row_2 = (uppercase_row_2 + dictionary.braille_characters[input.downcase].row_2)
   row_3 = (uppercase_row_3 + dictionary.braille_characters[input.downcase].row_3)
  #  require 'pry';binding.pry
   combined_grid = row_1 + row_2 + row_3
   combined_grid
  end

  def to_braille(input)
    dictionary.fill_braille_characters
    toggle_upper_case(input)
    if upper_case == true
      upper_case_braille(input)
    elsif upper_case == false && input.class == String
      # require 'pry';binding.pry
      dictionary.braille_characters[input].combined_grid
    end
  end
end
