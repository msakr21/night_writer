class TerminalIO
  attr_reader :message,
              :file_name,
              :output_file_name,
              :translator,
              :reverse_translator

  def initialize
    @file_name = ARGV[0]
    @message = File.read(file_name)
    @output_file_name = ARGV[1]
    @translator = Translator.new
    @reverse_translator = ReverseTranslator.new
  end

  def self.night_writer
    terminal_i_o = new
    terminal_i_o.generate_braille_output
    terminal_i_o.terminal_message
  end

  def self.night_reader
    terminal_i_o = new
    terminal_i_o.generate_english_output
    terminal_i_o.terminal_message
  end

  def generate_english_output
    output = File.new(output_file_name, 'w+')
    output_content = reverse_translator.to_english(message)
    output.puts(output_content)
    output.close
  end



  def generate_braille_output
    output = File.new(output_file_name, 'w+')
    output_content = translator.to_braille_sentence(message)
    output.puts(output_content)
    output.close
  end

  def terminal_message
    puts "Created '#{output_file_name}' containing #{message.length} characters"
  end
end