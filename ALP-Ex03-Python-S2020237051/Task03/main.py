from datetime import datetime

from Transaction import Transaction
from Account import Account

if __name__ == '__main__':
    transaction1 = Transaction(amount=5, date=datetime.now())
    transaction7 = Transaction(amount=30, date=datetime.now(),
                                    currency="USD",
                                    conversion_rate=0.33,
                                    description="McDonald's")
    print("Standard Transaction:")
    print(transaction1)

    print("\nAdvanced Transaction:")
    print(transaction7)

    transactions = list()

    transactions.append(Transaction(amount=5, date=datetime.now()))
    transactions.append(Transaction(amount=10, date=datetime.now()))
    transactions.append(Transaction(amount=15, date=datetime.now()))
    transactions.append(Transaction(amount=20, date=datetime.now()))
    transactions.append(Transaction(amount=25, date=datetime.now()))
    transactions.append(Transaction(amount=30, date=datetime.now()))
    transactions.append(Transaction(amount=30, date=datetime.now(),
                                    currency="USD",
                                    conversion_rate=0.32,
                                    description="McDonald's"))
    try:
        account1 = Account(4710, "Stefan Penzinger", transactions=transactions)
        print("\nBalance of Account:")
        print(account1.balance())
        print("\nHave all Transactions EUR as currency:")
        print(account1.all_eur())

        account2 = Account(4710, "SPE", transactions=list)
        print("\nBalance of Account:")
        print(account2.balance())
        print("\nHave all Transactions EUR as currency:")
        print(account2.all_eur())
    except AttributeError as ae:
        print("\n--- ERROR OCCURED ---")
        print(ae)