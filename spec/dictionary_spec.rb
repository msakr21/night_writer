require './lib/braille_character'
require './lib/dictionary'
require 'rspec'

RSpec.describe Dictionary do
  let(:dictionary) {Dictionary.new}

  it "1. exists" do
    expect(dictionary).to be_a(Dictionary)
  end

  it "2. has readable hash attribute 'braille_characters' that is blank by default" do
    expect(dictionary.braille_characters).to eq({})
  end

  it "3. has a method to add braille characters to the hash" do
    dictionary.add_character("a", "0.\n", "..\n", "..\n")
    expect(dictionary.braille_characters["a"]).to be_a(BrailleCharacter)
    expect(dictionary.braille_characters["a"].combined_grid).to eq("O.\n..\n..\n")
  end

  it "4. has a method that returns an array of all the letters in the alphabet in order" do
    expect(dictionary.alphabet).to eq("abcdefghijklmnopqrstuvwxyz".split(//))
    expect(dictionary.alphabet.length).to eq(26)
    expect(dictionary.alphabet[0]).to eq("a")
    expect(dictionary.alphabet[9]).to eq("j")
    expect(dictionary.alphabet[25]).to eq("z")
  end

  it "5. has a method that determines what the first row of a braille character should have for a letter of the alphabet" do
    expect(dictionary.row_1_input("a")).to eq("O.\n")
  end

  it "6. has a method that determines what the second row of a braille character should have for a letter of the alphabet" do
    expect(dictionary.row_2_input("a")).to eq("..\n")
  end

  it "7. has a method that determines what the third row of a braille character should have for a letter of the alphabet" do
    expect(dictionary.row_3_input("a")).to eq("..\n")
  end


  it "8. has a method that adds all of the alphabet letters and their corresponding braille characters into the braille characters container" do
    dictionary_1 = Dictionary.fill_braille_characters
    expect(dictionary_1.braille_characters.keys.length).to eq(26)
    expect(dictionary_1.braille_characters.keys).to eq("abcdefghijklmnopqrstuvwxyz".split(//))
    expect(dictionary_1.braille_characters["a"]).to be_a(BrailleCharacter)
    expect(dictionary_1.braille_characters["a"].combined_grid).to eq("0.\n..\n..\n")
    expect(dictionary_1.braille_characters["q"].combined_grid).to eq("00\n00\n0.\n")
  end
end