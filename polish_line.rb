require_relative "read_next_value"

OPERATOR_PRIORITY = {
    "(" => 0,
    "+" => 1,
    "-" => 1,
    "*" => 2,
    "/" => 2,
    "^" => 3, 
    "sin" => 4,
    "cos" => 4,
    "tan" => 4,
    "cot" => 4
}

TRIGONOMETRICAL_OPERATOR = ["sin", "cos", "tan", "cot"]
SIMPLE_OPERATION = ["+", "-", "/", "*", "^"]

def calculate_single_operator(operator, value)
    res = 0.0

    if operator == "cos"
        res = Math::cos(value)
    elsif operator == "sin"
        res = Math::sin(value)
    elsif operator == "tan"
        res = Math::tan(value)
    elsif operator == "cot"
        res = Math::cot(value)
    end

    res
end

def calculate_binary_operator(operator, number1, number2)
    res = 0.0

    if operator == "+"
        res = number1 + number2
    elsif operator == "-"
        res = number1 - number2
    elsif operator == "*"
        res = number1 * number2
    elsif operator == "/"
        begin
            res = number1 / number2
        rescue ZeroDivisionError => error
            puts error.message
            return 0
        end
    elsif operator == "^"
        res = number1 ** number2
    end

    res
end

def calculate_polish_line(polishLine)
    stackcResult = Array.new

    iter = 0
    while iter < polishLine.length do 
        ch =  get_next(iter, polishLine)

        iter += ch.length()
        if ch =~ /[[:blank:]]/ 
            next
        end

        if ch =~ /[[:digit:]]/
            stackcResult.push(ch)
        else
            res = 0.0
            if TRIGONOMETRICAL_OPERATOR.include?(ch)
                val = stackcResult.pop.to_f
                res = calculate_single_operator(ch, val)
            elsif SIMPLE_OPERATION.include?(ch)
                b = stackcResult.pop.to_f
                a = stackcResult.pop.to_f
                res = calculate_binary_operator(ch, a, b)
            else
                puts "Error in calculate_polish_line(), non undefined operation"
                exit(1)
            end
            stackcResult.push(res)
        end
    end

    stackcResult.pop
end


def parse_in_polish_line(simpleLine)
    polishLine = ""
    stackcOperation = Array.new

    iter = 0
    while iter < simpleLine.length do 
        ch = get_next(iter, simpleLine)

        iter += ch.length()
        if ch =~ /[[:blank:]]/ 
            next
        end

        if ch =~ /[[:digit:]]/
            polishLine << ch << " "
        elsif ch == "("
            stackcOperation.push(ch)
        elsif ch == ")"
            while stackcOperation.last != "(" do
                polishLine << stackcOperation.pop << " "
            end

            stackcOperation.pop
        else
            if stackcOperation.empty? || 
                OPERATOR_PRIORITY[stackcOperation.last] < OPERATOR_PRIORITY[ch]
                stackcOperation.push(ch)
            else
                while !stackcOperation.empty? && 
                    OPERATOR_PRIORITY[stackcOperation.last] >= OPERATOR_PRIORITY[ch] do
                    polishLine << stackcOperation.pop << " "
                end
                
                stackcOperation.push(ch)
            end
        end
    end

    while !stackcOperation.empty?
        polishLine << stackcOperation.pop
    end

    polishLine
end

def main
    puts "Common mate expression: "
    mate_expression = gets.chomp
    polish_line = parse_in_polish_line(mate_expression)
    calline =  calculate_polish_line(polish_line)
    
    puts polish_line
    puts calline
end

main()