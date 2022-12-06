def main()
	num1 = get_number_protect("Введите первое число:")
    num2 = get_number_protect("Введите второе  число:")
    puts "Выберете желаемую операцию [+, -, *, /]:"
    op = gets.chomp

    if op == '+'
        puts num1 + num2
    elsif op == '-'
        puts num1 - num2
    elsif op == '*'
        puts num1 * num2
    elsif op == '/'
        begin
            puts num1 / num2
        rescue ZeroDivisionError => error
            puts error.message
            puts error.backtrace.inspect
        end
    else
        puts "You put incorrect operation"
    end
end


def get_number_protect(sms)
    correct_input_d = false
    input_d = 0

    puts "#{sms}"
    while (!correct_input_d)
        input_d = gets.chomp

        if input_d =~ /^[0-9]*$/
            correct_input_d = true
        else
            puts "Incorrect data type"
        end
    end

    res = input_d.to_i
    return res
end

main()
            
