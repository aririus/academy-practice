require 'rspec'
require './word_check.rb'

RSpec.describe "check method" do
  context "when ends with CS" do
    it "returns 2 ** word.length" do
      expect { check("abcs") }.to output("16\n").to_stdout
      expect { check("aBcbCs") }.to output("64\n").to_stdout
    end
  end

  context "when doesn't end with CS" do
    it "returns the word reversed" do
      expect { check("abc") }.to output("cba\n").to_stdout
      expect { check("AbCdeF") }.to output("FedCbA\n").to_stdout
    end
  end
end
