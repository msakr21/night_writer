class TerminalIO
  attr_accessor :message,
                :output

  def initialize
    @message = nil
    @output = nil
  end

  def self.night_writer
    terminal_i_o = new
    set_input_and_output(ARGV[0], ARGV[1], terminal_i_o)
    terminal_message(ARGV[1], terminal_i_o)
    terminal_i_o
  end

  def self.set_input_and_output(input, output, terminal_i_o)
   terminal_i_o.message = File.read(input)
   terminal_i_o.output = File.new(output, 'w+')
   terminal_i_o.output.puts(terminal_i_o.message)
   terminal_i_o.output.close
  #  require 'pry';binding.pry
  end

  def self.terminal_message(file_name, terminal_i_o)
    # terminal_i_o.output.puts(terminal_i_o.message)
    puts "Created '#{file_name}' containing #{terminal_i_o.message.length} characters"
  end
end