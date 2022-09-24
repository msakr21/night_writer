class Dictionary

  attr_reader :braille_characters,
              :row_1,
              :row_2,
              :row_3

  def initialize
    @braille_characters = Hash.new(0)
    @row_3 = {group_1: "abcdefghij", group_2: "klmnopqrst", group_3: "uvxyz", group_4: "w"}
    @row_1 = {group_1: "abehkloruvz", group_2: "cdfgmnpqxy", group_3: "ijstw"}
    @row_2 = {group_1: "ackmux", group_2: "bfilpsv", group_3: "denozy", group_4: "ghjqrtw"}
  end

  def add_character(character, row_1, row_2, row_3)
    @braille_characters[character] = BrailleCharacter.new(row_1, row_2, row_3)
  end

  def alphabet
    "abcdefghijklmnopqrstuvwxyz".split(//)
  end

  def row_1_input(character)
    if @row_1[:group_1].include?(character)
      "O.\n"
    elsif @row_1[:group_2].include?(character)
      "OO\n"
    elsif @row_1[:group_3].include?(character)
      ".O\n"
    end
  end

  def row_2_input(character)
    if @row_2[:group_1].include?(character)
      "..\n"
    elsif @row_2[:group_2].include?(character)
      "O.\n"
    elsif @row_2[:group_3].include?(character)
      ".O\n"
    elsif @row_2[:group_4].include?(character)
      "OO\n"
    end
  end

  def row_3_input(character)
    if @row_3[:group_1].include?(character)
      "..\n"
    elsif @row_3[:group_2].include?(character)
      "O.\n"
    elsif @row_3[:group_3].include?(character)
      "OO\n"
    elsif @row_3[:group_4].include?(character)
      ".O\n"
    end
  end

  def fill_braille_characters
    alphabet.each do |character|
      add_character(character, row_1_input(character), row_2_input(character), row_3_input(character))
    end
  end
end