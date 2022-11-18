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
    text = text.translate(
        str.maketrans('', '', string.punctuation + "0123456789"))  # delete punctuation characters and numbers
    text = text.replace("\n", " ")  # replace \n to whitespace in order to split afterwards
    sortedList = list(text.split(" "))  # split string in to array
    sortedList.sort()

    for word in sortedList:
        if last_word == word:  # skip if the same word comes again
            continue
        last_word = word  # save last word

        word_occurrences = word_dict.get(word)  # get word occurrences saved in dict
        if word_occurrences is None:
            word_dict[word] = sortedList.count(word)
        else:
            word_dict[word] = sortedList.count(word) + word_occurrences


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
