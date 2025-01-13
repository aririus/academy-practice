# Написать набор методов для работы с файлом
# index – выводит все строки
# find(id) – находит конкретную строку в файле и выводит ее
# where(pattern) – находит все строки, где есть указанный паттерн
# update(id, text) – обновляет конкретную строку файла
# delete(id) – удаляет строку
# create(name) – добавляет строку в конец файла

FILE = "input.txt"
BUFFER = "buffer.txt"

def index
  puts "All the lines:"
  File.foreach(FILE) { |line| puts line }
end

def find(id)
  file_data = File.read(FILE).split("\n")
  if id > 0 && id <= file_data.length
    puts "Line No. #{id}: #{file_data[id-1]}"
  else
    puts "Line No. #{id} doesn't exist"
  end
end

def where(pattern)
  result = ""
  File.foreach(FILE).with_index do |line, index|
    result += line if line.include?(pattern)
  end
  if result.empty?
    puts "No lines with pattern '#{pattern}'"
  else
    puts "Lines with pattern '#{pattern}':"
    puts result
  end
end

def update(id, text)
  file = File.open(BUFFER, 'w')
  upd = false

  File.foreach(FILE).with_index do |line, index|
    if index == id - 1
      file.puts(text)
      upd = true
    else
      file.puts(line)
    end
  end
  file.close

  if upd
    File.write(FILE, File.read(BUFFER))
    puts "File has been updated"
  else
    puts "Nothing to update"
  end

  File.delete(BUFFER) if File.exist?(BUFFER)
end

def delete(id)
  file = File.open(BUFFER, 'w')
  del = false

  File.foreach(FILE).with_index do |line, index|
    if index == id - 1
      del = true
    else
      file.puts(line)
    end
  end
  file.close

  if del
    File.write(FILE, File.read(BUFFER))
    puts "Line No. #{id} was deleted"
  else
    puts "No line to delete"
  end

  File.delete(BUFFER) if File.exist?(BUFFER)
end

def create(name)
  File.write(FILE, "\n#{name}", mode: "a")
  puts "Line has been added"
end
