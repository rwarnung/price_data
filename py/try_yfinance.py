## update yfinance for the functions

import pandas as pd
import yfinance as yf
import numpy as np
import matplotlib as mp

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

start_date = "1990-01-01"
end_date = pd.Timestamp.today().strftime("%Y-%m-%d")
df_list = []

data = pd.DataFrame(yf.download(symbol, start=start_date, end=end_date))
data = data["Adj Close"]
data.name = symbol
data = pd.DataFrame(data)

returns = Return_calculate(data)

tickers = yf.Tickers('msft aapl goog')

tickers.tickers['MSFT'].actions
tickers.tickers['GOOG'].actions

## https://ibkrcampus.com/ibkr-quant-news/python-download-stock-prices-using-the-yfinance-package/

symbols = ['^GSPC','^VIX', '^FTSE', '^N225', '^HSI']
data = yf.download(symbols, start='2020-11-01', end  ='2022-12-06')
print(data)

close_data = data['Adj Close'].fillna(method="ffill")

cor_mat = np.corrcoef( Return_calculate(close_data), rowvar=False)
pd.DataFrame(cor_mat, columns = symbols)
## better
Return_calculate(close_data).corr()

Return_calculate(close_data).plot.line()

## rolling vol over 20 days
pd.DataFrame(Return_calculate(close_data).rolling(20).agg("std")*np.sqrt(250)).plot.line()


## does not work

#yf.charts_PerformanceSummary(returns)
#table_Drawdowns(returns)
