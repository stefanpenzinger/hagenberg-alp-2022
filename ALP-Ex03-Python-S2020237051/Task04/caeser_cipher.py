from collections import deque

# Given is the following alphabet (in the given order):
alphabet = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n',
            'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', ' ']


def decipher(text: str):
    alpha_string = "".join(alphabet)
    alpha_dq = deque(alphabet)

    for key in range(1, len(alpha_string)):
        alpha_dq.rotate(1)
        result = ""

        for char in text:
            index = alphabet.index(char)
            result = result + alpha_dq[index]

        print(result)


if __name__ == '__main__':
    file = open("cipher.txt")

    file_content = file.read()
    file_content = file_content.replace("\n", " ")
    decipher(text=file_content)

    file.close()
