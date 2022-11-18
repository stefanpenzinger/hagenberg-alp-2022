import datetime


class Transaction:
    amount: float
    date: datetime
    currency: str
    conversion_rate: float
    description: str

    def __init__(self, amount, date, currency="EUR", conversion_rate=1.0, description=None):
        self.amount = amount
        self.date = date
        self.currency = currency
        self.conversion_rate = conversion_rate
        self.description = "" if description is None else description

    def __str__(self):
        repr = "Amount " + str(self.amount) + "\nDate: " + str(self.date) + "\nCurrency: " \
               + self.currency + "\nConversion Rate: " + str(self.conversion_rate) + \
               "\nDescription: " + self.description

        return repr
