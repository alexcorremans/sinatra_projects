require 'sinatra'
require 'sinatra/reloader' if development?
require_relative 'web_guesser/app'
require_relative 'caesar_cipher/app'

enable :sessions

get '/' do
  erb :index
end

