def add_pokemon(count)
  pokemons = []
  count.times do
    puts "Enter the following information about the pokemon"
    print "Name: "
    name = gets.chomp
    print "Colour: "
    colour = gets.chomp
    pokemons << { name: name, colour: colour }
  end
  pokemons
end

def output_array(pokemons)
  puts "[#{ pokemons.map { |pokemon| "{ name: '#{pokemon[:name]}', colour: '#{pokemon[:colour]}' }" }.join(', ') }]"
end

def main
  puts "How many pokemons would you like to add?"
  count = gets.to_i

  pokemons = add_pokemon(count)
  output_array(pokemons)
end

main
