class Game
  attr_reader :word

  def initialize
    @word = random_word
  end

  def random_word
    random = File.readlines('5desk.txt').sample.strip.downcase
    until random.length.between?(5, 12)
      random = File.readlines('5desk.txt').sample.strip.downcase
    end
    random
  end
end
