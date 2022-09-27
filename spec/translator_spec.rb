require 'rspec'
require './lib/translator'
require './lib/braille_character'
require './lib/dictionary'

RSpec.describe Translator do
  let(:translator) {Translator.new}

  it "1. exists" do
    expect(translator).to be_a(Translator)
  end

  it "2. has readable attributes "

  it "2. has a method check_upper_case that determines if input is capitalized or not" do
    expect(translator.is_uppercase?("a")).to eq(false)
    expect(translator.is_uppercase?("A")).to eq(true)
  end

  it "2. has a method check_upper_case that determines if input is number or not" do
    expect(translator.is_number?("a")).to eq(false)
    expect(translator.is_number?("1")).to eq(true)
  end

  it "3. converts letters to their braille equivalent" do
    expect(translator.to_braille_sentence("b")).to eq("0.\n0.\n..\n")
    expect(translator.to_braille_sentence("c")).to eq("00\n..\n..\n")
  end

  it "4. is case sensitive in its conversion" do
    expect(translator.to_braille_sentence("a")).to eq("0.\n..\n..\n")
    expect(translator.to_braille_sentence("A")).to eq("..0.\n....\n.0..\n")
  end

  it "5. can support number strings as well" do
    expect(translator.to_braille_sentence("1")).to eq(".00.\n.0..\n00..\n")
    expect(translator.to_braille_sentence("2")).to eq(".00.\n.00.\n00..\n")
  end
end