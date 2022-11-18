def primes(start: int, stop=None):
    if start == 0 or start == 1:
        raise ValueError(str(start) + " is not a valid start value (min 2)")
    elif start < 0:
        raise ValueError("Negative Values not allowed")

    if stop is None:
        stop = 100

    prime_list = list()

    if start == 2:
        prime_list.append(start)

    for i in range(start, stop):
        if isPrime(i):
            prime_list.append(i)

    return prime_list


def isPrime(number: int):
    for i in range(2, int(number/2)):
        if number % i == 0:
            return False
    return True


if __name__ == '__main__':
    try:
        x = primes(-1, 200)
        print(x)
    except ValueError as ve:
        print(ve)
