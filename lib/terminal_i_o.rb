class TerminalIO

  def initialize
    @message = nil
    @output = nil
  end

  def self.night_writer(input, output)

  end
  ARGV == ["message.txt", "braille.txt"]

  message = File.read(ARGV[0])


  output = File.new(ARGV[1], 'w')
  output.puts(message.upcase)
  puts "Created '#{ARGV[1]}' containing #{message.length} characters"

end