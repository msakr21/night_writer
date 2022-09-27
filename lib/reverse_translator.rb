class ReverseTranslator < Translator
  attr_reader :braille_lookup,
              :collector,
              :uppercase,
              :is_number,
              :letter_to_number_lookup,
              :uppercase_grid,
              :number_grid

  def initialize
    @braille_lookup = Hash.new(0)
    @collector = Hash.new(0)
    @uppercase = false
    @is_number = false
    @uppercase_grid = "..\n..\n.0\n"
    @number_grid = ".0\n.0\n00\n"
    super
    @letter_to_number_lookup = dictionary.number_to_letter.invert
  end

  def fill_braille_lookup
    dictionary.braille_characters.each do |letter, braille|
      braille_lookup[braille.combined_grid] = letter
    end
  end

  def collect_braille_rows(input)
    i = 1
    input.split.each do |row|
      @collector["#{i}"] = row.split(/(..)/)
      @collector["#{i}"].delete("")
      i += 1
    end
  end

  def input_character_collect(row_input, character_input)
      row_1 = collector.values[row_input][character_input] + "\n"
      row_2 = collector.values[(row_input + 1)][character_input] + "\n"
      row_3 = collector.values[(row_input + 2)][character_input] + "\n"
      (row_1 + row_2 + row_3)
  end

  def braille_is_uppercase?(row_input, character_input)
    input_character_collect(row_input, character_input) == uppercase_grid
  end

  def braille_is_number?(row_input, character_input)
    input_character_collect(row_input, character_input) == number_grid
  end

  def toggle_uppercase
    @uppercase = !uppercase
  end

  def toggle_number
    @is_number = !is_number
  end

  def single_braille_conversion(row_input, character_input)
      @final_output += braille_lookup[input_character_collect(row_input, character_input)]
  end

  def uppercase_braille_conversion(row_input, character_input)
    @final_output += braille_lookup[input_character_collect(row_input, character_input)].upcase
  end

  def number_braille_conversion(row_input, character_input)
    @final_output += letter_to_number_lookup[braille_lookup[input_character_collect(row_input, character_input)]]
  end

  def uppercase_conversion_logic(row_input, character_input)
    if braille_is_uppercase?(row_input, character_input) == false && uppercase == true
      uppercase_braille_conversion(row_input, character_input)
      toggle_uppercase
    elsif braille_is_uppercase?(row_input, character_input)
      toggle_uppercase
    end
  end

  def number_conversion_logic(row_input, character_input)
    if braille_is_number?(row_input, character_input) == false && is_number == true
      number_braille_conversion(row_input, character_input)
      toggle_number
    elsif braille_is_number?(row_input, character_input)
      toggle_number
    end
  end

  def combined_conversion_logic(row_input, character_input)
    if braille_is_number?(row_input, character_input) == true || is_number == true
      number_conversion_logic(row_input, character_input)
    elsif braille_is_uppercase?(row_input, character_input) == true || uppercase == true
      uppercase_conversion_logic(row_input, character_input)
    else
      single_braille_conversion(row_input, character_input)
    end
  end

  def conversion_loop(row_input, character_input)
    until row_input >= collector.values.length do
      combined_conversion_logic(row_input, character_input)
      character_input += 1
      if character_input >= 40 or character_input == collector.values[row_input].length
        row_input += 3
        character_input = 0
      end
    end
  end

  def multi_braille_conversion
    character_input_counter = 0
    row_input_counter = 0
    conversion_loop(row_input_counter, character_input_counter)
  end

  def to_english(input)
    final_output_reset
    fill_braille_lookup
    collect_braille_rows(input)
    multi_braille_conversion
    final_output
  end
end