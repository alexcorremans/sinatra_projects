class Game
  attr_reader :solution, :word, :guesses, :tried_letters, :wrong_letters, :wrong_words, :message, :over, :victory

  def initialize(words)
    @solution = words[rand(words.length)].split("")
    @word = set_word
    @guesses = 12
    @tried_letters = []
    @wrong_letters = []
    @wrong_words = []
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

  def check_word(guess)
    guess = guess.downcase
    if wrong_length?(guess)
      wrong_length
    elsif already_tried_word?(guess)
      already_tried
    else
      new_word(guess)
    end
  end


  def ended?
    over? || victory?
  end

  private

  def already_tried?(letter)
    tried_letters.include?(letter)
  end

  def already_tried_word?(guess)
    wrong_words.include?(guess)
  end

  def already_tried
    set_message("You've tried this one already! Try again.")
  end

  def wrong_length?(guess)
    guess.length != solution.length
  end

  def wrong_length
    set_message("That word isn't the right length! Try again.")
  end

  def new_letter(letter)
    @guesses -= 1
    @tried_letters.push(letter)
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
      set_message("You're out of guesses!<br>The word was: #{@solution.join}")
    end
  end

  def new_word(guess)
    @guesses -= 1
    if guess == solution.join
      @word = solution
      @victory = true
      set_message("Congratulations, you guessed the word!")
      return
    else
      @wrong_words.push(guess)
      set_message("No, that's not the word!")
    end
    if guesses == 0
      @over = true
      set_message("You're out of guesses!<br>The word was: #{@solution.join}")
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
