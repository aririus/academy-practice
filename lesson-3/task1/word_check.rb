def check(word)
  if (word[-2] + word[-1]).upcase == "CS"
    puts 2 ** word.length
  else
    puts word.reverse
  end
end
