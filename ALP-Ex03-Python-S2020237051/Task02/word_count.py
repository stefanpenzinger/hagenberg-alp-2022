import string
import re


def print_word_dict(word_dict):
    print("Ordered by occurence (decreasing)")
    for pair in sorted(word_dict.items(), key=lambda item: item[1], reverse=True):
        print("'" + pair[0] + "' occurs " + str(pair[1]) + " times")

    print("\nOrdered by alphabetically")
    for key in sorted(word_dict.keys()):
        print("'" + key + "' occurs " + str(word_dict.get(key)) + " times")


def create_word_dict(file_content):
    word_dict = dict()
    last_word = ""

    text = file_content.lower()
    text = text.translate(str.maketrans('', '', string.punctuation + "0123456789"))
    text = text.replace("\n", " ")
    sortedList = list(text.split(" "))
    sortedList.sort()

    for word in sortedList:
        if last_word == word:
            continue
        last_word = word
        word_dict[word] = sortedList.count(word)

    return word_dict


def count_words(filename):
    if filename is None:
        raise NameError("Choose a valid filename")

    file = open(filename, 'r')
    file_content = file.read()
    file.close()

    word_dict = create_word_dict(file_content)
    print_word_dict(word_dict)


if __name__ == '__main__':
    count_words('test.txt')
