require_relative 'web_guesser'

game = WebGuesser.new

get '/web_guesser' do
  num = game.num
  guess = params["guess"]
  cheat = params["cheat"]
  if guess.nil?
    message = "Guess a number!"
    colour = "white"
  elsif game.guesses == 0
    game = WebGuesser.new
    message = "You've lost! A new number has been generated."
    colour = "white"
  else
    game.check_guess(guess)
    message = game.message
    colour = game.colour
    if game.winner?
      game = WebGuesser.new
    end
  end
  erb :'web_guesser/index', {:layout => false, :locals => {:number => num, :message => message, :colour => colour, :cheat => cheat }}
end