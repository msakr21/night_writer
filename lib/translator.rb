class Translator
  attr_reader :upper_case,
              :check_condition,
              :dictionary,
              :capital_grid,
              :uppercase_row_1,
              :uppercase_row_2,
              :uppercase_row_3,
              :final_output,
              :output_row_1,
              :output_row_2,
              :output_row_3

  def initialize
    @check_condition = "abcdefghijklmnopqrstuvwxyz".upcase
    @dictionary = Dictionary.load_dictionary
    @uppercase_row_1 = ".."
    @uppercase_row_2 = ".."
    @uppercase_row_3 = ".0"
    @output_row_1 = ""
    @output_row_2 = ""
    @output_row_3 = ""
    @final_output = ""
  end

  def is_upper_case?(input)
    if check_condition.include?(input)
      true
    else
      false
    end
  end

  #refactor above, remove all except check_condition.include?(input)

  def upper_case_braille(input)
    @output_row_1 += (uppercase_row_1 + dictionary.braille_characters[input.downcase].row_1.chomp)
    @output_row_2 += (uppercase_row_2 + dictionary.braille_characters[input.downcase].row_2.chomp)
    @output_row_3 += (uppercase_row_3 + dictionary.braille_characters[input.downcase].row_3.chomp)
  end

  def regular_braille(input)
    @output_row_1 += dictionary.braille_characters[input].row_1.chomp
    @output_row_2 += dictionary.braille_characters[input].row_2.chomp
    @output_row_3 += dictionary.braille_characters[input].row_3.chomp
  end

  def to_braille(input)
      if is_upper_case?(input)
        upper_case_braille(input)
      elsif is_upper_case?(input) == false && input.class == String
        regular_braille(input)
      end
  end

  def update_output
    @final_output += (output_row_1 + "\n" + output_row_2 + "\n" + output_row_3 + "\n")
  end

  def reset_output_rows
    @output_row_1 = ""
    @output_row_2 = ""
    @output_row_3 = ""
  end

  def to_braille_sentence(input)
    input.split(//).each do |character|
      to_braille(character)
      if output_row_3.length == 80
        update_output
        reset_output_rows
      end
    end
    update_output if output_row_3 != ""
    final_output
  end
end