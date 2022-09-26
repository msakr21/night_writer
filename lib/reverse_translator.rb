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
    @collector = []
    super
  end

  def fill_lookup
    dictionary.braille_characters.each do |letter, braille|
      braille_lookup[braille.combined_grid] = letter
    end
  end

  def to_english_sentence(input)
    input.split.each do |row|
      @collector << row.split(/(..)/)
      #.delete("")
      #@collector = Hash.new(0)
      #collect, set row1 row2 and row3 to whatever the rows are going to be, one at a time then combine then iterate and compare to combined grid to find key.
      #will need to set up child class of translator with input_rows rather than output_rows, final output can just add regular characters
  end
end