require 'sinatra'
require 'sinatra/reloader' if development?

enable :sessions

get '/' do
  erb :index
end

# Web Guesser
require_relative 'web_guesser/web_guesser'

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


# Caesar Cipher
require_relative 'caesar_cipher/cipher'

get '/caesar_cipher' do
  @message = session.delete(:message)
  @text = params['text']
  @number = params['num']
  erb :'caesar_cipher/index', layout: :'caesar_cipher/layout'
end

post '/caesar_cipher' do
  text = params['text']
  number = params['number'].to_i
  encrypted = caesar_cipher(text, number)
  session[:message] = "Result: #{encrypted}"
  redirect "/caesar_cipher?text=#{text}&num=#{number}"
end

# Guess the word

# Mastermind

