require 'rspec'
require './search.rb'

describe "search" do
  context "when -1 is entered straight away" do
    it "the program ends" do
      allow_any_instance_of(Kernel).to receive(:gets).and_return("-1\n")
      expected_output = "Enter age. Enter '-1' for the program to end.\n"
      expect { main }.to output(expected_output).to_stdout
    end
  end

  context "when age < 0 && age != -1" do
    it "asks to enter a new number" do
      allow_any_instance_of(Kernel).to receive(:gets).and_return("-3\n", "18\n", "-1\n")
      expected_output = "Enter age. Enter '-1' for the program to end.\n"
      expected_output += "Incorrect data. Try again.\n"
      expected_output += "Search completed!\n"
      expected_output += "Enter age. Enter '-1' for the program to end.\n"
      expected_output += "Harry Potter 18\nPaddington Bear 18\nTom Sawyer 18\n"
      expect { main }.to output(expected_output).to_stdout
    end
  end

  context "when all ages entered" do
    it "returns full list of students" do
      allow_any_instance_of(Kernel).to receive(:gets).and_return("18\n", "19\n", "20\n", "21\n", "22\n", "23\n")
      expected_output = "Enter age. Enter '-1' for the program to end.\n"
      expected_output += "Search completed!\nEnter age. Enter '-1' for the program to end.\n" * 5
      expected_output += "Search completed!\n"
      results_list = "Harry Potter 18\nPaddington Bear 18\nTom Sawyer 18\nWinnie Pooh 19\nPeter Parker 20\nJohn Watson 21\nLuke Skywalker 21\nJames Bond 22\nSherlock Holmes 22\nBilbo Baggins 23\n"
      expect { main }.to output(expected_output + results_list).to_stdout
      expect(File.read("results.txt")).to eq(results_list)
    end
  end
end
