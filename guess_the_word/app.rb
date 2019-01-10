require_relative 'guess_the_word'

all_words = File.readlines("./guess_the_word/5desk.txt").map {|line| line.chomp}
words = Array.new
all_words.each do |word|
  words.push(word.downcase) if word.length.between?(5,12)
end

game = Game.new(words)

get '/guess_the_word' do
  @message = session.delete(:message)
  @game_ended = game.ended?
  @guesses = game.guesses
  @word = game.word
  @wrong_letters = game.wrong_letters unless game.wrong_letters.empty?
  @solution = game.solution
  @cheat = params['cheat']
  erb :'guess_the_word/index', layout: :'guess_the_word/layout'
end

post '/guess_the_word' do
  letter = params['letter']
  if letter =~ /[a-z]/i
    game.check(letter)
    session[:message] = game.message
  else
    session[:message] = "That's not a letter! Try again."
  end
  redirect '/guess_the_word'
end

post '/guess_the_word/new' do
  game = Game.new(words)
  redirect '/guess_the_word'
end