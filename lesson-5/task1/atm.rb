class CashMachine
  def initialize
    @balance = File.exist?("balance.txt") ? File.read("balance.txt").to_f : 100.0
    puts "Welcome to your bank account management!"
    menu
  end

  def menu
    puts
    puts "Enter 'D' to make a deposit"
    puts "Enter 'W' to withdraw"
    puts "Enter 'B' to see your balance"
    puts "Enter 'Q' to quit"
    puts
  end

  def deposit
    puts "Enter any amount of money to make a deposit"

    amount = nil
    loop do
      amount = gets.to_f
      break if amount.positive?
      puts "The amount of money for a deposit must be over 0. Try again."
    end

    @balance += amount
    balance_screen
    @balance
  end

  def withdraw
    puts "Enter any amount of money to withdraw"

    amount = nil
    loop do
      amount = gets.to_f
      if amount <= 0
        puts "The amount of money to withdraw must be over 0. Try again."
      elsif amount > @balance
        puts "The amount of money to withdraw cannot be over your balance. Try again."
      else
        break
      end
    end

    @balance -= amount
    balance_screen
    @balance
  end

  def balance_screen
    puts "Your balance: #{@balance}"
    puts
  end

  def init
    button_pressed = ""
    until button_pressed.casecmp?("Q") do
      button_pressed = gets.chomp
      case button_pressed.downcase.to_sym
      when :d
        deposit
      when :w
        withdraw
      when :b
        balance_screen
      when :q
        break
      else
        puts "Unknown operation. Choose an operation from the list."
        menu
      end
    end

    File.write("balance.txt", @balance.to_s)
    puts "Goodbye!"
  end
end

#CashMachine.new.init