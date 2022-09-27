class ReverseTranslator < Translator
  attr_reader :braille_lookup,
              # :input_row_1,
              # :input_row_2,
              # :input_row_3,
              :collector,
              :uppercase,
              :is_number,
              :letter_to_number_lookup


  def initialize
    @braille_lookup = Hash.new(0)
    # @input_row_1 = ""
    # @input_row_2 = ""
    # @input_row_3 = ""
    @collector = Hash.new(0)
    @uppercase = false
    @is_number = false
    super
    @letter_to_number_lookup = Hash.new(0)
  end

  def fill_lookups
    dictionary.braille_characters.each do |letter, braille|
      braille_lookup[braille.combined_grid] = letter
    end
    fill_letter_number_lookup
  end

  def fill_letter_number_lookup
    @letter_to_number_lookup = dictionary.number_to_letter.invert
  end

  def collect_braille_rows(input)
    i = 1
    input.split.each do |row|
      @collector["#{i}"] = row.split(/(..)/)
      @collector["#{i}"].delete("")
      i += 1
    end
  end

  def input_row_update(row_input, character_input)
      row_1 = collector.values[row_input][character_input] + "\n"
      row_2 = collector.values[(row_input + 1)][character_input] + "\n"
      row_3 = collector.values[(row_input + 2)][character_input] + "\n"
      (row_1 + row_2 + row_3)
  end

  def reverse_is_uppercase?(row_input, character_input)
    input_row_update(row_input, character_input) == "..\n..\n.0\n"
  end

  def reverse_is_number?(row_input, character_input)
    input_row_update(row_input, character_input) == ".0\n.0\n00\n"
  end

  def toggle_uppercase
    @uppercase = !uppercase
  end

  def toggle_number
    @is_number = !is_number
  end

  def single_braille_conversion(row_input, character_input)
      @final_output += braille_lookup[input_row_update(row_input, character_input)]
  end

  def uppercase_braille_conversion(row_input, character_input)
    @final_output += braille_lookup[input_row_update(row_input, character_input)].upcase
  end

  def number_braille_conversion(row_input, character_input)
    @final_output += letter_to_number_lookup[braille_lookup[input_row_update(row_input, character_input)]]
  end

  def uppercase_conversion_logic(row_input, character_input)
    if reverse_is_uppercase?(row_input, character_input) == false && uppercase == true
      uppercase_braille_conversion(row_input, character_input)
      toggle_uppercase
    elsif reverse_is_uppercase?(row_input, character_input)
      toggle_uppercase
    end
  end

  def number_conversion_logic(row_input, character_input)
    if reverse_is_number?(row_input, character_input) == false && is_number == true
      number_braille_conversion(row_input, character_input)
      toggle_number
    elsif reverse_is_number?(row_input, character_input)
      toggle_number
    end
  end

  def combined_conversion_logic(row_input, character_input)
    if reverse_is_number?(row_input, character_input) == true || is_number == true
      number_conversion_logic(row_input, character_input)
    elsif reverse_is_uppercase?(row_input, character_input) == true || uppercase == true
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
    fill_lookups
    collect_braille_rows(input)
    multi_braille_conversion
    final_output
  end
end