class Game
  attr_reader :solution, :word, :guesses, :wrong_letters, :all_letters, :message, :over, :victory

  def initialize(words)
    @solution = words[rand(words.length)].split("")
    @word = set_word
    @guesses = 12
    @wrong_letters = []
    @all_letters = ("a".."z").to_a
    @message = nil
    @over = false
    @victory = false
  end

  def set_word
    word = []
    solution.length.times do
      word.push("_")
    end
    word
  end

  def check(letter)
    letter = letter.downcase
    if already_tried?(letter)
      @message = "You've tried this one already! Try again."
    else
      @guesses -= 1
      if guesses == 0
        @over = true
        @message = "You're out of guesses!"
      end
      @all_letters.delete(letter)
      if solution.include?(letter)
        indexes = solution.length.times.select {|i| solution[i] == letter}
        for i in indexes
          @word[i] = letter
        end
        if word == solution
          @victory = true
          @message = "Congratulations, you found the word!"
        else
          @message = "Good guess!"
        end
      else
        @message = "Bad guess..."
        @wrong_letters.push(letter)
      end
    end
  end

  def ended?
    over? || victory?
  end

  def over?
    over && !victory?
  end

  def victory?
    victory
  end

  private

  def already_tried?(letter)
    !all_letters.include?(letter)
  end
end
