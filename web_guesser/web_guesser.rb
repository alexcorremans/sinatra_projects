class WebGuesser
  attr_reader :num, :message, :colour, :guesses

  def initialize
    @num = rand(101)
    @message = nil
    @colour = nil
    @guesses = 4
  end

  def check_guess(guess)
    if guess.to_i > num
      if guess.to_i > num + 5
        @message = "Way too high!"
        @colour = "crimson"
      else
        @message = "Too high!"
        @colour = "salmon"
      end
    elsif guess.to_i < num
      if guess.to_i < num - 5
        @message = "Way too low!" 
        @colour = "crimson"
      else
        @message = "Too low!"
        @colour = "salmon"
      end
    else
      @message = "You got it right!"
      @colour = "springgreen"
    end
    @guesses -= 1
  end

  def winner?
    message == "You got it right!"
  end
end