require 'rspec'
require './lib/terminal_control'
require './lib/braille_character'
require './lib/dictionary'
require './lib/translator'
require './lib/reverse_translator'

RSpec.describe TerminalControl do
  let(:terminal_control) {TerminalControl.new}
  
  it "1. exists" do
    allow(File).to receive(:read).and_return("Bla")
    expect(terminal_control).to be_a(TerminalControl)
  end

  it "2. has readable attributes 'file_name' and 'output_file_name'" do
    argv = double(:ARGV)
    allow(File).to receive(:read).and_return("Bla")
    allow(argv).to receive(:input).and_return(["message.txt", "dumdum.txt"])
    allow(terminal_control).to receive(:file_name).and_return(argv.input[0])
    allow(terminal_control).to receive(:output_file_name).and_return(argv.input[1])

    expect(terminal_control.file_name).to eq("message.txt")
    expect(terminal_control.output_file_name). to eq("dumdum.txt")
  end

  it "3. stores the content of the input file" do
    allow(File).to receive(:read).and_return("Bla")
    expect(terminal_control.message).to eq("Bla")
  end

  it "4. has an instance of the Translator class an attribute" do
    allow(File).to receive(:read).and_return("Bla")
    expect(terminal_control.translator).to be_a(Translator)
  end

  it "5. has an instance of the ReverseTranslator class as an attribute" do
    allow(File).to receive(:read).and_return("Bla")
    expect(terminal_control.reverse_translator).to be_a(ReverseTranslator)
  end

  it "6. puts out a terminal message that says which file was created and how many characters are in it" do
    allow(File).to receive(:read).and_return("Bla")
    allow(terminal_control).to receive(:output_file_name).and_return("dumdum.txt")
    allow(terminal_control).to receive(:message).and_return("Bla")

    terminal_control.generate_braille_output
    expect(terminal_control.terminal_message("Bla")).to eq(puts "Created 'braille.txt' containing 3 characters")
  end


  it "7. generates braille output to a file from English input" do
    allow(terminal_control).to receive(:output_file_name).and_return("braille.txt")
    allow(terminal_control).to receive(:message).and_return("Bla")

    terminal_control.generate_braille_output
    expect(File.read("dumdum.txt")).to eq("..0.0.0.\n..0.0...\n.0..0...\n")
  end

  it "8. generates English output to a file from braille input" do
    allow(File).to receive(:read).and_return("Bla\n")
    allow(terminal_control).to receive(:output_file_name).and_return("english.txt")
    allow(terminal_control).to receive(:message).and_return("..0.0.0.\n..0.0...\n.0..0...\n")

    terminal_control.generate_english_output
    expect(File.read("english.txt")).to eq("Bla\n")
  end
end