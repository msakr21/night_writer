require 'rspec'
require './lib/terminal_i_o'

RSpec.describe TerminalIO do
  let(:terminal_i_o) {TerminalIO.new}
  
  it "1. exists" do
    expect(terminal_i_o).to be_a(TerminalIO)
  end

  it "2. has 2 readable attributes message and output that are nil by default" do
    expect(terminal_i_o.message).to eq(nil)
    expect(terminal_i_o.output).to eq(nil)
  end

  it "3. sets command line terminal input and output to the message and output attributes respectively" do
    # require 'pry';binding.pry
    
    TerminalIO.set_input_and_output
    
    expect(terminal_i_o.message).to eq("Bob Ross Quotes")
    expect(terminal_i_o.output).to be_a(File)
    expect(File.read(terminal_i_o.output)).to eq("Bob Ross Quotes\n")
  end

  it "4. puts out a terminal message that says which file was created and how much" do
  end
end