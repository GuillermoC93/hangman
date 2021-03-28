require 'yaml'

# hangman game class
class Game
  attr_reader :guesses, :hidden_word, :word

  def initialize
    @word = random_word
    @guesses = 6
    @hidden_word = '_' * word.length
    @guessed_letters = []
  end

  def random_word
    random = File.readlines('5desk.txt').sample.strip.downcase
    random = File.readlines('5desk.txt').sample.strip.downcase until random.length.between?(5, 12)
    random
  end

  def save
    puts 'Enter a name for your save file.'
    save_name = gets.chomp.downcase
    serialize(save_name)
  end

  def player_guess
    loop do
      guess = gets.chomp.downcase
      if guess == 'save'
        save
        break
      elsif @guessed_letters.include?(guess)
        puts 'Please input a different guess.'
      elsif guess =~ /[0-9]/ || guess.length > 1
        puts 'Please input only 1 letter.'
      else
        return guess
      end
    end
  end

  def load_or_play
    puts 'Press "1" for a new game.'
    puts 'Press "2" to load a saved game.'
    answer = gets.chomp
    case answer
    when '1' then start_game
    when '2'
      puts 'Enter the save file name.'
      file_name = gets.chomp.downcase
      loaded = deserialize(file_name)
      loaded.start_game
    else puts 'Incorrect input.'
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
      puts 'You lose :(' if @guesses.zero?
    end
  end

  def game_round
    puts check_guess(player_guess)
    puts "You have #{guesses} guesses remaining."
    guessed_str = 'Guessed letters are: '
    @guessed_letters.map { |c| str << ' ' << c }
    puts guessed_str
    puts 'Guess a letter or type "save" to save game.'
  end

  def win?
    @hidden_word == word
  end

  def serialize(save_name)
    yaml = YAML.dump(self)
    game_file = File.new(File.join('saved_games', "#{save_name}.yaml"), 'w+')
    game_file.write(yaml)
  end

  def deserialize(save_name)
    game_file = File.new(File.join('saved_games', "#{save_name}.yaml"))
    yaml = game_file.read
    YAML.load(yaml)
  end
end

play = Game.new
play.load_or_play
