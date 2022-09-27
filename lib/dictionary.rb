class Dictionary
  attr_reader :braille_characters,
              :row_1,
              :row_2,
              :row_3,
              :number_to_letter

  def initialize
    @braille_characters = Hash.new("")
    @row_1 = {group_1: "abehkloruvz", group_2: "cdfgmnpqxy", group_3: "ijstw", group_4: ",;:.!?'-"}
    @row_2 = {group_1: "ackmux'-", group_2: "bfilpsv,;?", group_3: "denozy", group_4: "ghjqrtw:.!"}
    @row_3 = {group_1: "abcdefghij,:", group_2: "klmnopqrst;!'", group_3: "uvxyz?-", group_4: "w."}
    @number_to_letter = Hash.new("")
  end

  def add_character(character, row_1, row_2, row_3)
    @braille_characters[character] = BrailleCharacter.new(row_1, row_2, row_3)
  end

  def english_characters
    "abcdefghijklmnopqrstuvwxyz,;:.!?'-".split(//)
  end

  def row_1_input(character)
    if @row_1[:group_1].include?(character)
      "0.\n"
    elsif @row_1[:group_2].include?(character)
      "00\n"
    elsif @row_1[:group_3].include?(character)
      ".0\n"
    elsif @row_1[:group_4].include?(character)
      "..\n"
    end
  end

  def row_2_input(character)
    if @row_2[:group_1].include?(character)
      "..\n"
    elsif @row_2[:group_2].include?(character)
      "0.\n"
    elsif @row_2[:group_3].include?(character)
      ".0\n"
    elsif @row_2[:group_4].include?(character)
      "00\n"
    end
  end

  def row_3_input(character)
    if @row_3[:group_1].include?(character)
      "..\n"
    elsif @row_3[:group_2].include?(character)
      "0.\n"
    elsif @row_3[:group_3].include?(character)
      "00\n"
    elsif @row_3[:group_4].include?(character)
      ".0\n"
    end
  end

  def fill_braille_characters
    english_characters.each do |character|
      add_character(character, row_1_input(character), row_2_input(character), row_3_input(character))
    end
  end

  def add_space
    add_character(" ", "..\n", "..\n", "..\n")
  end

  def add_digits
    i = 0
    "jabcdefghi".split(//).each do |letter|
      @number_to_letter["#{i}"] = letter
      i += 1
    end
  end

  def self.load_dictionary
    dictionary = new
    dictionary.fill_braille_characters
    dictionary.add_space
    dictionary.add_digits
    dictionary
  end
end