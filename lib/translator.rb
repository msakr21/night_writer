class Translator
  attr_reader :check_uppercase,
              :dictionary,
              :uppercase_row_1,
              :uppercase_row_2,
              :uppercase_row_3,
              :final_output,
              :output_row_1,
              :output_row_2,
              :output_row_3,
              :number_row_1,
              :number_row_2,
              :number_row_3,
              :check_numbers

  def initialize
    @check_uppercase = "abcdefghijklmnopqrstuvwxyz".upcase
    @check_numbers = "0123456789"
    @dictionary = Dictionary.load_dictionary
    @uppercase_row_1 = ".."
    @uppercase_row_2 = ".."
    @uppercase_row_3 = ".0"
    @number_row_1 = ".0"
    @number_row_2 = ".0"
    @number_row_3 = "00"
    @output_row_1 = ""
    @output_row_2 = ""
    @output_row_3 = ""
    @final_output = ""
  end

  def is_uppercase?(input)
    check_uppercase.include?(input)
  end

  def is_number?(input)
    check_numbers.include?(input)
  end
  
  def upper_case_braille(input)
    @output_row_1 += uppercase_row_1 
    @output_row_2 += uppercase_row_2 
    @output_row_3 += uppercase_row_3 
    line_width_control
    @output_row_1 += dictionary.braille_characters[input.downcase].row_1.chomp
    @output_row_2 += dictionary.braille_characters[input.downcase].row_2.chomp
    @output_row_3 += dictionary.braille_characters[input.downcase].row_3.chomp
    line_width_control
  end

  def regular_braille(input)
    @output_row_1 += dictionary.braille_characters[input].row_1.chomp
    @output_row_2 += dictionary.braille_characters[input].row_2.chomp
    @output_row_3 += dictionary.braille_characters[input].row_3.chomp
    line_width_control
  end

  def braille_number(input)
    @output_row_1 += number_row_1
    @output_row_2 += number_row_2
    @output_row_3 += number_row_3
    line_width_control
    regular_braille(input)
  end

  def to_braille(input)
      if is_uppercase?(input)
        upper_case_braille(input)
      elsif is_number?(input)
        braille_number(dictionary.number_to_letter[input])
      else
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

  def final_output_reset
    @final_output = ""
  end

  def total_reset
    reset_output_rows
    final_output_reset
  end

  def line_width_control
    if output_row_3.length >= 80
      update_output
      reset_output_rows
    end
  end

  def to_braille_sentence(input)
    total_reset
    input.split(//).each do |character|
      to_braille(character) if character != "\n"
    end
    update_output if output_row_3 != ""
    final_output
  end
end