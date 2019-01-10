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
      already_tried
    else
      new_letter(letter)
    end
  end

  def ended?
    over? || victory?
  end

  private

  def already_tried?(letter)
    !all_letters.include?(letter)
  end

  def already_tried
    set_message("You've tried this one already! Try again.")
  end

  def new_letter(letter)
    @guesses -= 1
    @all_letters.delete(letter)
    if solution.include?(letter)
      indexes = solution.length.times.select {|i| solution[i] == letter}
      for i in indexes
        @word[i] = letter
      end
      if word == solution
        @victory = true
        set_message("Congratulations, you found the word!")
        return
      else
        set_message("Good guess!")
      end
    else
      @wrong_letters.push(letter)
      set_message("Bad guess...")
    end
    if guesses == 0
      @over = true
      set_message("You're out of guesses!<br>The word was: #{@solution.join("")}")
    end
  end

  def set_message(text)
    @message = text
  end

  def over?
    over
  end

  def victory?
    victory
  end
end
