require 'rspec'
require './methods.rb'

FILE = "input.txt"
File.write(FILE, "ab\nrac\nadab\nra")

describe "file methods" do
  context "def index" do
    it "outputs all the lines" do
      expect { index }.to output("All the lines:\nab\nrac\nadab\nra\n").to_stdout
    end
  end

  context "def find" do
    it "outputs a specified line" do
      expect { find(2) }.to output("Line No. 2: rac\n").to_stdout
    end
    it "can't find the specified line" do
      expect { find(7) }.to output("Line No. 7 doesn't exist\n").to_stdout
    end
  end

  context "def where" do
    it "ouputs lines with a pattern" do
      expect { where("ab") }.to output("Lines with pattern 'ab':\nab\nadab\n").to_stdout
    end
    it "can't find any lines with a pattern" do
      expect { where("abr") }.to output("No lines with pattern 'abr'\n").to_stdout
    end
  end

  context "def update" do
    it "updates a specified line" do
      expect { update(2, "rc") }.to output("File has been updated\n").to_stdout
      file_data = File.read(FILE).split("\n")
      expect(file_data[1]).to eq("rc")
    end
    it "can't find a specified line to update" do
      expect { update(7, "rc") }.to output("Nothing to update\n").to_stdout
    end
  end

  context "def delete" do
    it "deletes a specified line" do
      expect { delete(3) }.to output("Line No. 3 was deleted\n").to_stdout
      file_data = File.read(FILE).split("\n")
      expect(file_data[2]).to eq("ra")
    end
    it "can't find a line to delete" do
      expect { delete(7) }.to output("No line to delete\n").to_stdout
    end
  end

  context "def create" do
    it "adds a line" do
      expect { create("da") }.to output("Line has been added\n").to_stdout
      file_data = File.read(FILE).split("\n")
      expect(file_data[-1]).to eq("da")
    end
  end
end
