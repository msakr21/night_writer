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

  it "2. has attributes 'input_row_1', 'input_row_2', and 'input_row_1' that are blank strings by default" do
    expect(reverse_translator.input_row_1).to eq("")
    expect(reverse_translator.input_row_2).to eq("")
    expect(reverse_translator.input_row_3).to eq("")
  end

  it "3. has attribute reverse_lookup that is an empty hash by default" do
    expect(reverse_translator.braille_lookup).to eq({})
  end

  it "4. fill reverse_lookup with braille characters as keys and their letters as values" do
    expect(reverse_translator.braille_lookup).to eq({})
    reverse_translator.fill_lookup
    expect(reverse_translator.braille_lookup.length).to eq(26)
    expect(reverse_translator.braille_lookup["0.\n..\n..\n"]).to eq("a")
  end

  it "5. converts braille to their letter equivalent" do
    expect(reverse_translator.to_english("0.\n..\n..\n")).to eq("a")
    expect(reverse_translator.to_english("..0.\n....\n.0..\n")).to eq("A")
  end

end
