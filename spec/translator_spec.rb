require 'rspec'
require './lib/translator'
require './lib/braille_character'
require './lib/dictionary'

RSpec.describe Translator do
  let(:translator) {Translator.new}

  it "1. exists" do
    expect(translator).to be_a(Translator)
  end

  it "2. has a method check_upper_case that determines if input is capitalized or not" do
    expect(translator.is_uppercase?("a")).to eq(false)
    expect(translator.is_uppercase?("A")).to eq(true)
  end

  it "3. converts letters to their braille equivalent" do
    expect(translator.to_braille_sentence("a")).to eq("0.\n..\n..\n")
    expect(translator.to_braille_sentence("A")).to eq("..0.\n....\n.0..\n")
  end
end