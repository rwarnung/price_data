## update yfinance for the functions

import yfinance as yf
import pandas as pd
import numpy as np

def Return_calculate(s, dropna = True):
    '''
    Computes the returns (percentage change) of a Dataframe of Series.
    In the former case, it computes the returns for every column (Series) by using pd.aggregate
    '''
    if isinstance(s, pd.DataFrame):
        return s.aggregate( Return_calculate )
    elif isinstance(s, pd.Series):
        returns = s/s.shift(1) - 1
        if dropna:
            return returns.dropna()
        return returns
    else:
        raise TypeError("Expected pd.DataFrame or pd.Series")

symbol = "SPY"
start_date = "1990-01-01"
end_date = pd.Timestamp.today().strftime("%Y-%m-%d")
df_list = []

data = pd.DataFrame(yf.download(symbol, start=start_date, end=end_date))
data = data["Adj Close"]
data.name = symbol
data = pd.DataFrame(data)

returns = Return_calculate(data)

charts_PerformanceSummary(returns)
table_Drawdowns(returns)
