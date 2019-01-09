def caesar_cipher(text, number)
  characters = text.split("")
  characters.map! do |character|
    if character =~ /[a-z]/
      new_ascii = character.ord + number
      if new_ascii > 122
        new_ascii -= 26
      end
      character = new_ascii.chr
    elsif character =~ /[A-Z]/
      new_ascii = character.ord + number
      if new_ascii > 90
        new_ascii -= 26
      end
      character = new_ascii.chr
    else
      character = character
    end
  end
  return characters.join
end