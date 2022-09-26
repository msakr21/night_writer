class ReverseTranslator < Translator
  attr_reader :braille_lookup,
              :input_row_1,
              :input_row_2,
              :input_row_3,
              :collector

  def initialize
    @braille_lookup = Hash.new(0)
    @input_row_1 = ""
    @input_row_2 = ""
    @input_row_3 = ""
    @collector = Hash.new(0)
    super
  end

  def fill_lookup
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

  def input_row_update(row_input, character_input)
    # require 'pry';binding.pry
      input_row_1 = collector.values[row_input][character_input] + "\n"
      input_row_2 = collector.values[(row_input + 1)][character_input] + "\n"
      input_row_3 = collector.values[(row_input + 2)][character_input] + "\n"
      (input_row_1 + input_row_2 + input_row_3)
  end

  def single_braille_conversion(row_input, character_input)
    # require 'pry';binding.pry
      @final_output += braille_lookup[input_row_update(row_input, character_input)]
  end

  def conversion_loop(row_input, character_input)
    until row_input >= collector.values.length do
      single_braille_conversion(row_input, character_input)
      character_input += 1
      # require 'pry';binding.pry
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

  def final_output_reset
    @final_output = ""
  end

  def to_english(input)
    final_output_reset
    fill_lookup
    collect_braille_rows(input)
    multi_braille_conversion
    final_output
  end
end