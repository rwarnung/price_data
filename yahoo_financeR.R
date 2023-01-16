## taken from https://blog.rsquaredacademy.com/introducing-yahoofinancer-fetch-data-from-yahoo-finance-api/
library(yahoofinancer)

aapl <- Ticker$new('aapl')

validate('aapl')

aapl$quote$regularMarketPrice
aapl$summary_detail

head(purrr::map(aapl$key_stats, 'raw'))

aapl$valuation_measures

head(aapl$get_history())


aapl$get_history(start = '2022-10-20', interval = '1d')

aapl$get_history(start = '2022-10-01', end = '2022-10-14', interval = '1d')

aapl$summary_profile


aapl$get_balance_sheet('annual')

aapl$get_income_statement('annual')

aapl$get_cash_flow()

aapl$earnings_trend$earnings_estimate

aapl$earnings_trend$revenue_estimate

head(aapl$option_chain)

aapl$option_expiration_dates

aapl$option_strikes

## holding pattern 

aapl$major_holders

## recommendations:
aapl$recommendation_trend

## Indices

## currencies

## converter

