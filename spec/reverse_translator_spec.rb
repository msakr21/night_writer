require 'rspec'
require './lib/translator'
require './lib/braille_character'
require './lib/dictionary'
require './lib/reverse_translator'

RSpec.describe Translator do
  let(:reverse_translator) {ReverseTranslator.new}

  it "1. exists" do
    expect(reverse_translator).to be_a(ReverseTranslator)
  end

  it "2. it inherits from Translator" do
    expect(reverse_translator.class.superclass).to eq(Translator)
    expect(reverse_translator.final_output).to eq("")
    expect(reverse_translator.dictionary).to be_a(Dictionary)
  end

  it "3. has readable attributes 'uppercase_grid' and 'number_grid' that are braille representations of the grids that indicate the character is uppercase or a number, respectively." do
    expect(reverse_translator.uppercase_grid).to eq("..\n..\n.0\n")
    expect(reverse_translator.number_grid).to eq(".0\n.0\n00\n")
  end

  it "4. has readable attributes 'uppercase' and 'is_number' that are false by default" do
    expect(reverse_translator.uppercase).to eq(false)
    expect(reverse_translator.is_number).to eq(false)
  end

  it "4. has readable attributes 'braille_lookup' and 'collector' that are empty hashes by default" do
    expect(reverse_translator.braille_lookup).to eq({})
    expect(reverse_translator.collector).to eq({})
  end

  it "5. has readable hash attribute 'letter_to_number_lookup' that has letters from a to j as keys and numbers as values" do
    expect(reverse_translator.letter_to_number_lookup).to be_a(Hash)
    expect(reverse_translator.letter_to_number_lookup.keys).to include("a", "j", "f", "c", "b")
    expect(reverse_translator.letter_to_number_lookup.keys.length).to eq (10)
  end

  it "6. has a method to fill up the collector braille with rows of input with the rows being arrays" do
    expect(reverse_translator.collector).to eq({})
    reverse_translator.collect_braille_rows("0.\n..\n..\n")
    expect(reverse_translator.collector).to eq({"1" => ["0."], "2" => [".."], "3" =>  [".."]})
    reverse_translator.collect_braille_rows("0.0.\n....\n....\n") 
    expect(reverse_translator.collector).to eq({"1" => ["0.","0."], "2" => ["..",".."], "3" =>  ["..",".."]})
    reverse_translator.collect_braille_rows("0.\n..\n..\n0.\n..\n..\n") 
    expect(reverse_translator.collector).to eq({"1" => ["0."], "4" => ["0."], "2" => [".."], "5" => [".."], "3" =>  [".."], "6" => [".."]})
  end

  it "7. fill reverse_lookup with braille characters as keys and their letters as values" do
    expect(reverse_translator.braille_lookup).to eq({})
    reverse_translator.fill_braille_lookup
    expect(reverse_translator.braille_lookup.length).to eq(27)
    expect(reverse_translator.braille_lookup["0.\n..\n..\n"]).to eq("a")
  end

  it "8. has a method to recombine the rows of input into a single character" do
    input = ("0.00\n....\n....\n")
    reverse_translator.collect_braille_rows(input) 
    expect(reverse_translator.collector.values).to eq ([["0.","00"], ["..",".."], ["..",".."]])
    expect(reverse_translator.input_character_collect(0, 0)).to eq("0.\n..\n..\n")
    expect(reverse_translator.input_character_collect(0, 1)).to eq("00\n..\n..\n")
    input2 = "0.\n..\n..\n0.\n..\n..\n"
    reverse_translator.collect_braille_rows(input2)
    expect(reverse_translator.collector.values).to eq ([["0."], [".."], [".."], ["0."], [".."], [".."]])
    expect(reverse_translator.input_character_collect(3, 0)).to eq("0.\n..\n..\n")
  end

  it "9. can check if a character is the uppercase grid or not" do
    input = "0.\n..\n..\n..\n..\n.0\n"
    reverse_translator.collect_braille_rows(input) 
    expect(reverse_translator.braille_is_uppercase?(0, 0)).to eq(false)
    expect(reverse_translator.braille_is_uppercase?(3, 0)).to eq(true)
  end

  it "10. can check if a character is the number grid or not" do
    input = "0.\n..\n..\n.0\n.0\n00\n"
    reverse_translator.collect_braille_rows(input) 
    expect(reverse_translator.braille_is_number?(0, 0)).to eq(false)
    expect(reverse_translator.braille_is_number?(3, 0)).to eq(true)
  end

  it "11. can toggle uppercase attribute from false to true and back" do
    expect(reverse_translator.uppercase).to eq(false)
    reverse_translator.toggle_uppercase
    expect(reverse_translator.uppercase).to eq(true)
    reverse_translator.toggle_uppercase
    expect(reverse_translator.uppercase).to eq(false)
  end

  it "12. can toggle is_number attribute from false to true and back" do
    expect(reverse_translator.is_number).to eq(false)
    reverse_translator.toggle_number
    expect(reverse_translator.is_number).to eq(true)
    reverse_translator.toggle_number
    expect(reverse_translator.is_number).to eq(false)
  end

  it "13. converts a single braille character to English equivalent" do
    input = "0.\n..\n..\n.0\n.0\n00\n"
    reverse_translator.collect_braille_rows(input)
    reverse_translator.fill_braille_lookup
    reverse_translator.single_braille_conversion(0, 0)
    expect(reverse_translator.final_output).to eq("a")
  end

  it "14. converts braille character to uppercase English equivalent" do
    input = "..00\n....\n.0..\n"
    reverse_translator.collect_braille_rows(input)
    reverse_translator.fill_braille_lookup
    reverse_translator.uppercase_braille_conversion(0, 1)
    expect(reverse_translator.final_output).to eq("C")
  end

  it "15. converts braille character to English(Eastern-India *cough cough*) number equivalent" do
    input = ".000\n.0..\n00..\n"
    reverse_translator.collect_braille_rows(input)
    reverse_translator.fill_braille_lookup
    reverse_translator.number_braille_conversion(0, 1)
    expect(reverse_translator.final_output).to eq("3")
  end

  it "16. has logic to handle uppercase conversion" do
    input = "..00\n....\n.0..\n"
    reverse_translator.collect_braille_rows(input)
    reverse_translator.fill_braille_lookup
    reverse_translator.uppercase_conversion_logic(0, 0)
    expect(reverse_translator.uppercase).to eq(true)
    reverse_translator.uppercase_conversion_logic(0, 1)
    expect(reverse_translator.final_output).to eq("C")
  end

  it "17. has logic to handle number conversion" do
    input = ".000\n.0..\n00..\n"
    reverse_translator.collect_braille_rows(input)
    reverse_translator.fill_braille_lookup
    reverse_translator.number_conversion_logic(0, 0)
    expect(reverse_translator.is_number).to eq(true)
    reverse_translator.number_conversion_logic(0, 1)
    expect(reverse_translator.final_output).to eq("3")
  end

  it "18. has combined logic for regular, uppercase, and number conversions that can loop" do
    input = "..00\n....\n.0..\n"
    reverse_translator.collect_braille_rows(input)
    reverse_translator.fill_braille_lookup
    reverse_translator.combined_conversion_logic(0, 0)
    expect(reverse_translator.uppercase).to eq(true)
    reverse_translator.combined_conversion_logic(0, 1)
    expect(reverse_translator.final_output).to eq("C")

    input = ".000\n.0..\n00..\n"
    reverse_translator.collect_braille_rows(input)
    reverse_translator.fill_braille_lookup
    reverse_translator.combined_conversion_logic(0, 0)
    expect(reverse_translator.is_number).to eq(true)
    reverse_translator.combined_conversion_logic(0, 1)
    expect(reverse_translator.final_output).to eq("C3")

    input = "0.\n..\n..\n.0\n.0\n00\n"
    reverse_translator.collect_braille_rows(input)
    reverse_translator.fill_braille_lookup
    reverse_translator.combined_conversion_logic(0, 0)
    expect(reverse_translator.final_output).to eq("C3a")
  end

  it "19. reads braille characters by reading input two columns and 3 rows at a time - part 1" do
    input = "..00..00..00..00..00..00..00..00..00..00\n........................................\n.0...0...0...0...0...0...0...0...0...0...0..\n..00..00..00..00..00..00..00..00..00..00\n........................................\n.0...0...0...0...0...0...0...0...0...0...0..\n"
    reverse_translator.collect_braille_rows(input)
    reverse_translator.fill_braille_lookup
    reverse_translator.conversion_loop(0, 0)
    expect(reverse_translator.final_output).to eq("CCCCCCCCCCCCCCCCCCCC")
  end

  it "20. reads braille characters by reading input two columns and 3 rows at a time - part 2 (had to divide this test to two because collector wasn't resetting. There is no situation with the runner where that would happen." do
    input = "..00..00..00..00..00..00..00..00..00..00..00..00..00..00..00..00..00..00..00..00\n................................................................................\n.0...0...0...0...0...0...0...0...0...0...0...0...0...0...0...0...0...0...0...0...0...0..\n"
    reverse_translator.collect_braille_rows(input)
    reverse_translator.fill_braille_lookup
    reverse_translator.conversion_loop(0, 0)
    expect(reverse_translator.final_output).to eq("CCCCCCCCCCCCCCCCCCCC")
  end

  it "21. it specifies the starting row and character counters as 0s automatically" do
    input = "..00..00..00..00..00..00..00..00..00..00..00..00..00..00..00..00..00..00..00..00\n................................................................................\n.0...0...0...0...0...0...0...0...0...0...0...0...0...0...0...0...0...0...0...0...0...0..\n"
    reverse_translator.collect_braille_rows(input)
    reverse_translator.fill_braille_lookup
    reverse_translator.multi_braille_conversion
    expect(reverse_translator.final_output).to eq("CCCCCCCCCCCCCCCCCCCC")
  end

  it "22. converts braille to their letter equivalent" do
    expect(reverse_translator.to_english("0.\n..\n..\n")).to eq("a")
    expect(reverse_translator.to_english("0.0.0000\n..0....0\n........\n")).to eq("abcd")
    expect(reverse_translator.to_english("..0...0.\n......0.\n.0...0..\n")).to eq("AB")
  end

  it "23. converts braille to their number equivalent" do
    expect(reverse_translator.to_english("0.\n..\n..\n")).to eq("a")
    expect(reverse_translator.to_english("0.0.0000\n..0....0\n........\n")).to eq("abcd")
    expect(reverse_translator.to_english(".00.\n.0..\n00..\n")).to eq("1")
    expect(reverse_translator.to_english(".00.\n.0..\n00..\n.000\n.0..\n00..\n.00.\n.00.\n00..\n.000\n.0.0\n00..\n")).to eq("1324")
  end

  it "24. converts braille to a combination of letters and numbers" do
    expect(reverse_translator.to_english("0..000..0.\n...0.0..0.\n..00...0..\n")).to eq("a4B")
  end
end
