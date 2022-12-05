def main
    string1 = "In a village of La Mancha, the name of which I have no desire to call to
    mind, there lived not long since one of those gentlemen that keep a lance
    in the lance-rack, an old buckler, a lean hack, and a greyhound for
    coursing. An olla of rather more beef than mutton, a salad on most
    nights, scraps on Saturdays, lentils on Fridays, and a pigeon or so extra
    on Sundays, made away with three-quarters of his income."
    string2 = "  //wont won't won't"
    string3 = "e e e e DDD ddd DdD: ddd ddd aa aA Aa, bb cc cC e e e"

    print getTopThreeWord(string1)
    print getTopThreeWord(string2)
    print getTopThreeWord(string3)
end

def getTopThreeWord(string)
    # divide the sentence into words
    words = string.downcase.split(/[^[[:word:]'-]]+/)

    # add words to the hash, where keys are words and values are the number of repetitions 
    words_hash = Hash.new
    for word in words do
        if word.length == 0 || words_hash.include?(word)
            next
        else
            words_hash[word] = words.count(word)
        end
    end

    # sort by decreasing number of repetitions end get the top 3
    sorter_words = words_hash.sort_by {|k, v| v}.reverse.to_h.keys
    top3 = sorter_words[0..2]
end

main()




