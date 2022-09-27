require 'rspec'
require './lib/translator'
require './lib/braille_character'
require './lib/dictionary'

RSpec.describe Translator do
  let(:translator) {Translator.new}

  it "1. exists" do
    expect(translator).to be_a(Translator)
  end

  it "2. has readable attributes 'output_row_1', 'output_row_2', 'output_row_3' and 'final_output' that are blank strings by default" do
    expect(translator.output_row_1).to eq("")
    expect(translator.output_row_2).to eq("")
    expect(translator.output_row_3).to eq("")
    expect(translator.final_output).to eq("")
  end

  it "3. has readable attributes 'uppercase_row_1, 'uppercase_row_2', 'uppercase_row_3', 'number_row_1', 'number_row_2' and 'number_row_3' that have their respective braille respresentations for uppercase and number blocks" do
    expect(translator.uppercase_row_1). to eq("..")
    expect(translator.uppercase_row_2). to eq("..")
    expect(translator.uppercase_row_3). to eq(".0")
    expect(translator.number_row_1). to eq(".0")
    expect(translator.number_row_2). to eq(".0")
    expect(translator.number_row_3). to eq("00")
  end

  it "4. has a readable attribute dictionary that is an instance of the Dictionary class set up with its class method" do
    expect(translator.dictionary).to be_a(Dictionary)
    expect(translator.dictionary.braille_characters.length).to eq(35)
    expect(translator.dictionary.number_to_letter.length).to eq(10)
  end

  it "5. has a method that determines if input is uppercase or not" do
    expect(translator.is_uppercase?("a")).to eq(false)
    expect(translator.is_uppercase?("A")).to eq(true)
  end

  it "6. has a method that determines if input is number or not" do
    expect(translator.is_number?("a")).to eq(false)
    expect(translator.is_number?("1")).to eq(true)
  end

  it "7. has a method that fills up the contents of the three output_row attributes" do
    translator.regular_braille("c")
    expect(translator.output_row_1).to eq("00")
    expect(translator.output_row_2).to eq("..")
    expect(translator.output_row_3).to eq("..")
  end

  it "8. has a method that updates the final_output with the contents of the output_row attributes" do
    translator.regular_braille("c")
    translator.update_final_output
    expect(translator.final_output).to eq("00\n..\n..\n")
  end

  it "9. has a method that resets the output_row attributes" do
    translator.regular_braille("c")
    translator.reset_output_rows
    expect(translator.output_row_1).to eq("")
    expect(translator.output_row_2).to eq("")
    expect(translator.output_row_3).to eq("")
  end

  it "10. has a method that resets final_output attribute" do
    translator.regular_braille("c")
    translator.update_final_output
    translator.final_output_reset
    expect(translator.final_output).to eq("")
  end

  it "11. has a method line_width_control called at the end of regular_braille that stops the width from exceeding 80 dots or 40 characters by updating the final_output attribute when it hits 80 dots in width and resetting the output rows" do
    42.times do
     translator.regular_braille("a") 
    end
    expect(translator.output_row_1).to eq("0.0.")
    expect(translator.output_row_2).to eq("....")
    expect(translator.output_row_3).to eq("....")
    expect(translator.final_output.length).to eq(243) #3 rows of 80 with newlines at the end of each
  end

  it "12. has a has a method that fills up the contents of the three output_row attributes with uppercase input" do
    translator.upper_case_braille("C")
    expect(translator.output_row_1).to eq("..00")
    expect(translator.output_row_2).to eq("....")
    expect(translator.output_row_3).to eq(".0..")
  end

  it "13. has a has a method that fills up the contents of the three output_row attributes with number input" do
    translator.braille_number(translator.dictionary.number_to_letter["3"])
    expect(translator.output_row_1).to eq(".000")
    expect(translator.output_row_2).to eq(".0..")
    expect(translator.output_row_3).to eq("00..")
  end

  it "14. has a method that controls the logic for input flow for numbers, uppercase, and regular characters" do
    translator.to_braille("c")
    expect(translator.output_row_1).to eq("00")
    expect(translator.output_row_2).to eq("..")
    expect(translator.output_row_3).to eq("..")
    translator.to_braille("3")
    expect(translator.output_row_1).to eq("00.000")
    expect(translator.output_row_2).to eq("...0..")
    expect(translator.output_row_3).to eq("..00..")
    translator.to_braille("C")
    expect(translator.output_row_1).to eq("00.000..00")
    expect(translator.output_row_2).to eq("...0......")
    expect(translator.output_row_3).to eq("..00...0..")
  end

  it "14. has a method that resets all output attributes" do
    translator.to_braille("c")
    expect(translator.output_row_1).to eq("00")
    expect(translator.output_row_2).to eq("..")
    expect(translator.output_row_3).to eq("..")
    translator.to_braille("3")
    expect(translator.output_row_1).to eq("00.000")
    expect(translator.output_row_2).to eq("...0..")
    expect(translator.output_row_3).to eq("..00..")
    translator.to_braille("C")
    expect(translator.output_row_1).to eq("00.000..00")
    expect(translator.output_row_2).to eq("...0......")
    expect(translator.output_row_3).to eq("..00...0..")
    translator.total_reset
    expect(translator.output_row_1).to eq("")
    expect(translator.output_row_2).to eq("")
    expect(translator.output_row_3).to eq("")
    expect(translator.final_output).to eq("")
  end

  it "16. converts english to its braille equivalent" do
    expect(translator.to_braille_sentence("b")).to eq("0.\n0.\n..\n")
    expect(translator.to_braille_sentence("c")).to eq("00\n..\n..\n")
  end

  it "17. is case sensitive in its conversion" do
    expect(translator.to_braille_sentence("a")).to eq("0.\n..\n..\n")
    expect(translator.to_braille_sentence("A")).to eq("..0.\n....\n.0..\n")
  end

  it "18. can support number strings as well" do
    expect(translator.to_braille_sentence("1")).to eq(".00.\n.0..\n00..\n")
    expect(translator.to_braille_sentence("2")).to eq(".00.\n.00.\n00..\n")
  end
end