require_relative 'cipher'

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