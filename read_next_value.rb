def get_numer(position, string)
    number = ""

    while string[position] =~ /[[:digit:]]/ do 
        number << string[position]
        position += 1
    end

    number
end

def get_operator(position, string)
    operator = ""

    while string[position] =~ /[[:alpha:]]/ do 
        operator << string[position]
        position += 1
    end

    operator
end

def get_next(position, string)
    subString = ""

    if string[position].match(/[[:digit:]]/)
        subString << get_numer(position, string)
    elsif string[position].match(/[[:alpha:]]/)
        subString << get_operator(position, string)
    else
        subString = string[position]
    end

    subString
end