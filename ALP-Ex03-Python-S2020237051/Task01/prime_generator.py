def primes(start: int, stop=None):
    if start == 0 or start == 1:
        raise ValueError(str(start) + " is not a valid start value (min 2)")
    elif start < 0:
        raise ValueError("Negative Values not allowed")

    if stop is None:
        stop = 100  # default value for stop

    prime_list = list()

    if start == 2:
        prime_list.append(start)  # 2 is the first prime number, later we see if a division with two leaves a rest
        # with two this would fail so we check if we can already it beforehand

    for i in range(start, stop):
        if isPrime(i):
            prime_list.append(i)

    return prime_list


def isPrime(number: int):
    for i in range(2, int(number / 2)):  # if number is not divisible by any number in range 2 - number / 2 it is a
        # prime
        if number % i == 0:
            return False
    return True


if __name__ == '__main__':
    try:
        x = primes(-1, 200)
        print(x)
    except ValueError as ve:
        print(ve)
