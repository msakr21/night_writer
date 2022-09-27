require './lib/braille_character'
require './lib/dictionary'
require 'rspec'

RSpec.describe Dictionary do
  let(:dictionary) {Dictionary.new}

  it "1. exists" do
    expect(dictionary).to be_a(Dictionary)
  end

  it "2. has readable hash attributes 'braille_characters' and 'number_to_letter' that are blank by default" do
    expect(dictionary.braille_characters).to eq({})
    expect(dictionary.number_to_letter).to eq({})
  end

  it "3. has 3 readable hash attributes 'row_1', 'row_2' and 'row_3' that have English characters divided into groups in them based on their respective rows' braille configuration" do
    expect(dictionary.row_1).to eq({group_1: "abehkloruvz", group_2: "cdfgmnpqxy", group_3: "ijstw", group_4: ",;:.!?'-"})
    expect(dictionary.row_2).to eq({group_1: "ackmux'-", group_2: "bfilpsv,;?", group_3: "denozy", group_4: "ghjqrtw:.!"})
    expect(dictionary.row_3).to eq({group_1: "abcdefghij,:", group_2: "klmnopqrst;!'", group_3: "uvxyz?-", group_4: "w."})
  end

  it "4. has a method to add braille characters to the hash" do
    dictionary.add_character("a", "0.\n", "..\n", "..\n")
    expect(dictionary.braille_characters["a"]).to be_a(BrailleCharacter)
    expect(dictionary.braille_characters["a"].combined_grid).to eq("0.\n..\n..\n")
  end

  it "5. has a method that returns an array of all the letters and some punctuation marks in the english_characters" do
    expect(dictionary.english_characters).to eq("abcdefghijklmnopqrstuvwxyz,;:.!?'-".split(//))
    expect(dictionary.english_characters.length).to eq(34)
    expect(dictionary.english_characters[0]).to eq("a")
    expect(dictionary.english_characters[9]).to eq("j")
    expect(dictionary.english_characters[25]).to eq("z")
    expect(dictionary.english_characters[33]).to eq("-")
  end

  it "6. has a method that determines what the first row of a braille character should have for a letter of the english_characters" do
    expect(dictionary.row_1_input("a")).to eq("0.\n")
  end

  it "7. has a method that determines what the second row of a braille character should have for a letter of the english_characters" do
    expect(dictionary.row_2_input("a")).to eq("..\n")
  end

  it "8. has a method that determines what the third row of a braille character should have for a letter of the english_characters" do
    expect(dictionary.row_3_input("a")).to eq("..\n")
  end


  it "9. has a method that adds all of the English english_characters and some punctuation marks along with their corresponding braille characters hash as key value pairs" do
    dictionary.fill_braille_characters
    expect(dictionary.braille_characters.keys.length).to eq(34)
    expect(dictionary.braille_characters.keys).to eq("abcdefghijklmnopqrstuvwxyz,;:.!?'-".split(//))
    expect(dictionary.braille_characters["a"]).to be_a(BrailleCharacter)
    expect(dictionary.braille_characters["a"].combined_grid).to eq("0.\n..\n..\n")
    expect(dictionary.braille_characters["q"].combined_grid).to eq("00\n00\n0.\n")
  end

  it "10. has a method that adds decimal digits to the number_to_letter hash as key value pairs" do
    expect(dictionary.number_to_letter).to eq({})
    dictionary.add_digits
    expect(dictionary.number_to_letter["1"]).to eq("a")
    expect(dictionary.number_to_letter["0"]).to eq("j")
    expect(dictionary.number_to_letter["9"]).to eq("i")
    expect(dictionary.number_to_letter.values.length).to eq(10)
  end

  it "11. has a method that adds a space to the braille_characters hash" do
    expect(dictionary.braille_characters).to eq({})
    dictionary.add_space
    expect(dictionary.braille_characters[" "]).to be_a(BrailleCharacter)
    expect(dictionary.braille_characters[" "].combined_grid).to eq("..\n..\n..\n")
  end

  it "12. has a class method 'load_dictionary' that creates an instance of itself, fills the attributes up and returns itself" do
    dictionary = Dictionary.load_dictionary
    expect(dictionary.number_to_letter.values.length).to eq(10)
    expect(dictionary.braille_characters.keys.length).to eq(35)
    expect(dictionary.row_1).to eq({group_1: "abehkloruvz", group_2: "cdfgmnpqxy", group_3: "ijstw", group_4: ",;:.!?'-"})
    expect(dictionary.row_2).to eq({group_1: "ackmux'-", group_2: "bfilpsv,;?", group_3: "denozy", group_4: "ghjqrtw:.!"})
    expect(dictionary.row_3).to eq({group_1: "abcdefghij,:", group_2: "klmnopqrst;!'", group_3: "uvxyz?-", group_4: "w."})
  end
end