class Game
  attr_reader :guesses, :word

  def initialize
    @word = random_word
    @guesses = 6
  end

  def random_word
    random = File.readlines('5desk.txt').sample.strip.downcase
    until random.length.between?(5, 12)
      random = File.readlines('5desk.txt').sample.strip.downcase
    end
    random
  end

  def start_game
    puts "Welcome to Hangman."
    puts "You have #{guesses} guesses remaining."
    puts '_' * word.length
  end
end
