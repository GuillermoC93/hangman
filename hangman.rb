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
      elsif guess =~ /[0-9]/ || guess.length > 1
        puts 'Please input only 1 letter.'
      else
        return guess
      end
    end
  end

  def start_game
    puts 'Welcome to Hangman.'
    puts @hidden_word
    puts 'Guess a letter.'
    puts "You have #{guesses} guesses remaining."
    game_loop
    puts 'Thanks for playing.'
  end

  def check_guess(guess)
    @guessed_letters << guess
    if word.include?(guess)
      word.each_char.with_index do |_c, idx|
        @hidden_word[idx] = guess if word[idx] == guess
      end
    else
      @guesses -= 1
    end
    @hidden_word
  end

  def game_loop
    while guesses.positive?
      game_round
      if win?
        puts 'You won the game!'
        break
      end
    end
  end

  def game_round
    puts check_guess(player_guess)
    puts "You have #{guesses} guesses remaining."
    puts 'Guess a letter.'
  end

  def win?
    @hidden_word == word
  end
end
