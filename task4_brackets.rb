BRACKETS = { "(" => ")", "{" => "}", "[" => "]" }
OPENING_BRACKETS = BRACKETS.keys
CLOSING_BRACKETS = BRACKETS.values

def main()
  string = ""

  puts "Press \"^e\" to finish entering"
  loop do
    print "Enter next backet: "
    ch = gets.chomp
    if ch == "^e"
      break
    else
      string << ch
    end 
  end
  
  puts "Your string : #{string} is #{valid_brackets(String.new(string))}"
end

def valid_brackets(string)
    stack  = []
    string.each_char do |ch|
    if OPENING_BRACKETS.include?(ch)
      stack.push(ch)
    elsif CLOSING_BRACKETS.include?(ch)
      ch == BRACKETS[stack.last] ? stack.pop : (return false)
    end
  end
  return (stack.empty?)
end
main()