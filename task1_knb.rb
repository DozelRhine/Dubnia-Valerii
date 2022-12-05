def main()
	puts "[0 - Ножницы, 1 - Камень, 2 - Бумага]"
	computer_choise = rand(3)
	user_choise = gets.to_i

	result = user_choise - computer_choise

	if (result == 1) || (result == -2) 
		puts "Победа пользователя: компьютер выбрал " + convert_to_text(computer_choise)
	elsif  (result == -1) || (result == 2)  
		puts "Проигрыш пользователя: компьютер выбрал " + convert_to_text(computer_choise)
	else
		puts "Ничья: компьютер выбрал " + convert_to_text(computer_choise)
	end
end

def convert_to_text(digit_t)

	if digit_t == 0
		return "Ножницы"
	elsif digit_t == 1
		return "Камень"
	elsif digit_t == 2
		return "Бумагу"
	else
		return ""
	end
end

	main()