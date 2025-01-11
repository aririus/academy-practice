require 'rspec'
require './pokemons.rb'

RSpec.describe 'pokemon collection' do
  context "def add_pokemon" do
    it "returns an array of _count_ pokemons" do
      pokemons = add_pokemon(2)
      expect(pokemons.length).to eq(2)
    end
  end

  context "def output_array" do
    it "prints the array of pokemons" do
      pokemons = [
        { name: "Pikachu", colour: "Yellow" },
        { name: "Bulbasaur", colour: "Green" }
      ]
      expect { output_array(pokemons) }.to output(
        "[{ name: 'Pikachu', colour: 'Yellow' }, { name: 'Bulbasaur', colour: 'Green' }]\n"
      ).to_stdout
    end
  end
end
