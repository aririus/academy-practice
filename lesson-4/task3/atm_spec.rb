require 'rspec'
require './atm.rb'

welcome_text = "Welcome to your bank account management!\n\n"
start_text = "Enter 'D' to make a deposit\n"
start_text += "Enter 'W' to withdraw\n"
start_text += "Enter 'B' to see your balance\n"
start_text += "Enter 'Q' to quit\n\n"

File.write("balance.txt", "1500.0")

describe "atm machine" do
  context "when wrong operation is entered" do
    it "says it's unknown" do
      allow_any_instance_of(Kernel).to receive(:gets).and_return("M\n", "q\n")
      expected_output = welcome_text + start_text
      expected_output += "Unknown operation. Choose an operation from the list.\n\n"
      expected_output += start_text
      expected_output += "Goodbye!\n"
      expect { main }.to output(expected_output).to_stdout
      expect(File.read("balance.txt").to_f).to eq(1500.0)
    end
  end

  context "user wants to withdraw more money than possible" do
    it "says that amount can't be over balance" do
      allow_any_instance_of(Kernel).to receive(:gets).and_return("w\n", "3000\n", "1000\n", "q\n")
      expected_output = welcome_text + start_text
      expected_output += "Enter any amount of money to withdraw\n"
      expected_output += "The amount of money to withdraw cannot be over your balance. Try again.\n"
      expected_output += "Your balance: 500.0\n\n"
      expected_output += "Goodbye!\n"
      expect { main }.to output(expected_output).to_stdout
      expect(File.read("balance.txt").to_f).to eq(500.0)
    end
  end

  context "user quits after making a deposit" do
    it "updates balance.txt" do
      File.write("balance.txt", "1500.0")
      expect(File.read("balance.txt").to_f).to eq(1500.0)
      allow_any_instance_of(Kernel).to receive(:gets).and_return("D\n", "100\n", "Q\n")
      expected_output = welcome_text + start_text
      expected_output += "Enter any amount of money to make a deposit\n"
      expected_output += "Your balance: 1600.0\n\n"
      expected_output += "Goodbye!\n"
      expect { main }.to output(expected_output).to_stdout
      expect(File.read("balance.txt").to_f).to eq(1600.0)
    end
  end
end
