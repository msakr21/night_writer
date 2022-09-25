require 'rspec'
require './lib/translator'
require './lib/braille_character'
require './lib/dictionary'

RSpec.describe Translator do
  let(:translator) {Translator.new}

  it "1. exists" do
    expect(translator).to be_a(Translator)
  end

  it "2. has attribute upper_case that is false by default" do
    expect(translator.upper_case).to eq(false)
  end

  it "3. has a method check_upper_case that determines if input is capitalized or not" do
    expect(translator.is_upper_case?("a")).to eq(false)
    expect(translator.is_upper_case?("A")).to eq(true)
  end

  it "4. has a method 'toggle_upper_case' that toggles the upper_case attribute if input is upper case" do
    translator.toggle_upper_case("a")
    expect(translator.upper_case).to eq(false)
    translator.toggle_upper_case("A")
    expect(translator.upper_case).to eq(true)
  end

  it "5. converts letters to their braille equivalent" do
    expect(translator.to_braille("a")).to eq("0.\n..\n..\n")
    expect(translator.to_braille("A")).to eq("..0.\n....\n.0..\n")
  end
end