class TerminalIO
  attr_reader :message,
              :file_name,
              :output_file_name

  def initialize
    @file_name = ARGV[0]
    @message = File.read(file_name)
    @output_file_name = ARGV[1]
  end

  def self.night_writer
    terminal_i_o = new
    terminal_i_o.generate_output
    terminal_i_o.terminal_message
  end

  def generate_output
    output = File.new(output_file_name, 'w+')
    output.puts(message)
    output.close
  end

  def terminal_message
    puts "Created '#{output_file_name}' containing #{message.length} characters"
  end
end