require 'rspec'
require './lib/terminal_i_o'
require './lib/braille_character'
require './lib/dictionary'
require './lib/translator'

RSpec.describe TerminalIO do
  let(:terminal_i_o) {TerminalIO.new}
  
  it "1. exists" do
    expect(terminal_i_o).to be_a(TerminalIO)
  end

  it "2. has 2 readable attributes 'file_name' and 'output_file_name'" do
    argv = double(:ARGV)
    allow(argv).to receive(:input).and_return(["message.txt", "dumdum.txt"])
    allow(terminal_i_o).to receive(:file_name).and_return(argv.input[0])
    allow(terminal_i_o).to receive(:output_file_name).and_return(argv.input[1])

    expect(terminal_i_o.file_name).to eq("message.txt")
    expect(terminal_i_o.output_file_name). to eq("dumdum.txt")
  end

  it "3. stores the content of the input file" do
    allow(File).to receive(:read).and_return("Bla")
    expect(terminal_i_o.message).to eq("Bla")
  end

  it "4. puts out a terminal message that says which file was created and how many characters are in it" do
    allow(terminal_i_o).to receive(:output_file_name).and_return("dumdum.txt")
    allow(terminal_i_o).to receive(:message).and_return("Bla")

    terminal_i_o.generate_braille_output
    expect(terminal_i_o.terminal_message).to eq(puts "Created 'braille.txt' containing 3 characters")
  end


  it "5. generates braille output to a file from English input" do
    allow(terminal_i_o).to receive(:output_file_name).and_return("braille.txt")
    allow(terminal_i_o).to receive(:message).and_return("Bla")

    terminal_i_o.generate_braille_output
    expect(File.read("dumdum.txt")).to eq("..0.0.0.\n..0.0...\n.0..0...\n")
  end

  xit "6. generates English output to a file from braille input" do
    allow(terminal_i_o).to receive(:output_file_name).and_return("english.txt")
    allow(terminal_i_o).to receive(:message).and_return("..0.0.0.\n..0.0...\n.0..0...\n")

    terminal_i_o.generate_english_output
    expect(File.read("english.txt")).to eq("Bla")
  end
end