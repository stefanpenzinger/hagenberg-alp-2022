import datetime


class Account:
    account_number: int
    account_name: datetime
    transactions: list

    def __init__(self, account_number, account_name, transactions):
        self.account_number = account_number
        if len(account_name) >= 4:
            self.account_name = account_name
        else:
            raise AttributeError("Account name has to be at least 4 characters long.")
        self.transactions = transactions

    def __len__(self):
        return self.transactions.count()

    def balance(self):
        balance = 0.0
        for transaction in self.transactions:
            balance = balance + float(transaction.amount * transaction.conversion_rate)

        return balance

    def all_eur(self):
        for transaction in self.transactions:
            if transaction.currency != "EUR":
                return False

        return True

    def __str__(self):
        repr = "Amount " + str(self.amount) + "\nDate: " + str(self.date) + "\nCurrency: " \
               + self.currency + "\nConversion Rate: " + str(self.conversion_rate) + \
               "\nDescription: " + self.description

        return repr
