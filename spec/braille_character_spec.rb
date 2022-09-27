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

  it "3. has a combined grid readable attribute" do
    expect(a.combined_grid).to eq("O.\n..\n..\n")
  end
end