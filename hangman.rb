class Game
  attr_reader :guesses, :word, :hidden_word

  def initialize
    @word = random_word
    @guesses = 6
    @hidden_word = '_' * word.length
    @guessed_letters = []
  end

  def random_word
    random = File.readlines('5desk.txt').sample.strip.downcase
    until random.length.between?(5, 12)
      random = File.readlines('5desk.txt').sample.strip.downcase
    end
    random
  end

  def player_guess
    loop do
      guess = gets.chomp.downcase
      if @guessed_letters.include?(guess)
        puts 'Please input a different guess.'
      else
        return guess
      end
    end
  end

  def start_game
    puts 'Welcome to Hangman.'
    puts "You have #{guesses} guesses remaining."
    puts @hidden_word
    puts 'Guess a letter.'
    puts guess_check
  end

  def guess_check
    guess = player_guess
    @guessed_letters << guess
    if word.include?(guess)
      word.each_char.with_index do |c, idx|
        if word[idx] == guess
          @hidden_word[idx] = guess
        end
      end
    end
    @hidden_word
  end
end
