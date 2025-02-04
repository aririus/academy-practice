STUDENTS = "students.txt"
RESULTS = "results.txt"

def age_input
  puts "Enter age. Enter '-1' for the program to end."
  age = nil
  loop do
    age = gets.to_i
    break if age > 0 || age == -1
    puts "Incorrect data. Try again."
  end
  age
end

def search_file(file_data, age)
  index = 0
  while index < file_data.length
    student_age = (file_data[index][-2] + file_data[index][-1]).to_i
    if age == student_age
      File.write(RESULTS, "#{file_data[index]}\n", mode: "a")
      file_data.delete_at(index)
    else
      index += 1
    end
  end
end

def main
  File.write(RESULTS, "")
  file_data = File.read(STUDENTS).split("\n")
  age = nil
  while !file_data.empty? && age != -1
    age = age_input
    search_file(file_data, age) if age != -1
    puts "Search completed!" if age != -1
  end
  puts File.read(RESULTS).split("\n")
end
