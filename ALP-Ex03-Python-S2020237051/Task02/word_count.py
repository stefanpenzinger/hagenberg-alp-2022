import string


def print_word_dict(word_dict):
    print("Ordered by occurence (decreasing)")
    for pair in sorted(word_dict.items(), key=lambda item: item[1], reverse=True):
        print("'" + pair[0] + "' occurs " + str(pair[1]) + " times")

    print("\nOrdered by alphabetically")
    for key in sorted(word_dict.keys()):
        print("'" + key + "' occurs " + str(word_dict.get(key)) + " times")


def add_to_word_dict(word_dict, line):
    last_word = ""
    text = line.lower()
    text = text.translate(str.maketrans('', '', string.punctuation + "0123456789"))
    text = text.replace("\n", " ")
    sortedList = list(text.split(" "))
    sortedList.sort()

    for word in sortedList:
        if last_word == word:
            continue
        last_word = word

        word_occurences = word_dict.get(word)
        if word_occurences is None:
            word_dict[word] = sortedList.count(word)
        else:
            word_dict[word] = sortedList.count(word) + word_occurences


def count_words(filename):
    if filename is None:
        raise NameError("Choose a valid filename")

    file = open(filename, 'r')

    word_dict = dict()
    for line in file:
        add_to_word_dict(word_dict, line)
    print_word_dict(word_dict)

    file.close()


if __name__ == '__main__':
    count_words('big.txt')
