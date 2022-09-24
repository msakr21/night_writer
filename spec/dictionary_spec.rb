require './lib/braille_character'
require './lib/dictionary'
require 'rspec'

RSpec.describe Dictionary do
  let(:dictionary){Dictionary.new}

  it "1. exists" do
    expect(dictionary).to be_a(Dictionary)
  end

  it "2. has readable hash attribute 'braille_characters' that is blank by default" do
    expect(dictionary.braille_characters).to eq({})
  end

  it "3. has a method to add braille characters to the hash" do
    dictionary.add("a", "O.\n", "..\n", "..\n")
    expect(dictionary.braille_characters["a"]).to be_a(BrailleCharacter)
    expect(dictionary.braille_characters["a"].combined_grid).to eq("O.\n..\n..\n")
  end
end