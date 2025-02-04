def menu
  puts
  puts "Enter 'D' to make a deposit"
  puts "Enter 'W' to withdraw"
  puts "Enter 'B' to see your balance"
  puts "Enter 'Q' to quit"
  puts
end

def deposit(balance)
  puts "Enter any amount of money to make a deposit"

  amount = nil
  loop do
    amount = gets.to_f
    break if amount.positive?
    puts "The amount of money for a deposit must be over 0. Try again."
  end

  balance += amount
  balance_screen(balance)
  balance
end

def withdraw(balance)
  puts "Enter any amount of money to withdraw"

  amount = nil
  loop do
    amount = gets.to_f
    if amount <= 0
      puts "The amount of money to withdraw must be over 0. Try again."
    elsif amount > balance
      puts "The amount of money to withdraw cannot be over your balance. Try again."
    else
      break
    end
  end

  balance -= amount
  balance_screen(balance)
  balance
end

def balance_screen(balance)
  puts "Your balance: #{balance}"
  puts
end

def main
  balance = File.exist?('balance.txt') ? File.read('balance.txt').to_f : 100.0

  puts "Welcome to your bank account management!"
  menu

  button_pressed = ""
  until button_pressed.casecmp?("Q") do
    button_pressed = gets.chomp
    case button_pressed.downcase.to_sym
    when :d
      balance = deposit(balance)
    when :w
      balance = withdraw(balance)
    when :b
      balance_screen(balance)
    when :q
      break
    else
      puts "Unknown operation. Choose an operation from the list."
      menu
    end
  end
  
  File.write("balance.txt", balance.to_s)
  puts "Goodbye!"
end
