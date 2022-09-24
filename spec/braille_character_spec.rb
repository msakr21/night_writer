require './lib/braille_character'
require 'rspec'

RSpec.describe BrailleCharacter do
  let(:a){BrailleCharacter.new("O.\n","..\n","..\n")}

  it "1.exists" do
    expect(a).to be_a(BrailleCharacter)
  end

  it "2. has 3 readable attributes 'row_1', 'row_2' and 'row_3' each of which defaults to '..\n'" do
    expect(a.row_1).to eq("O.\n")
    expect(a.row_2).to eq("..\n")
    expect(a.row_3).to eq("..\n")
  end

  it "3. has an attribute 'upper case' that defaults to false" do
    expect(a.upper_case).to eq(false)
  end

  it "4. has a method 'is_upper_case?' that checks if the braille chracter us upper case or not" do
    expect(a.is_upper_case?).to eq(false)
  end

  it "5. has a method 'toggle_upper_case' that toggles the upper_case attribute" do
    a.toggle_upper_case
    expect(a.is_upper_case?).to eq(true)
    expect(a.upper_case).to eq(true)
  end

  it "6. has a grid for upper case letter" do
    expect(a.capital_grid).to eq("..\n..\n.O\n")
  end

  it "7. has a combined grid readable attribute" do
    expect(a.combined_grid).to eq("O.\n..\n..\n")
  end
  
end