#========================================================#
# Quantitative ALM, Financial Econometrics & Derivatives 
# ML/DL using R, Python, Tensorflow by Sang-Heon Lee 
#
# https://kiandlee.blogspot.com
#--------------------------------------------------------#
# load prices of constituents of a stock index
#========================================================#

graphics.off(); rm(list = ls())

library(quantmod)

#-------------------------------------------------
# Components of the Nasdaq 100, as of 2022-07-29
#-------------------------------------------------
vstr_nasdaq100 <- 
  "AAPL,MSFT,AMZN,TSLA,GOOG,GOOGL,NVDA,META,PEP,COST,
    AVGO,CMCSA,ADBE,CSCO,TMUS,QCOM,INTC,TXN,AMD,AMGN,
    HON,INTU,NFLX,PYPL,ADP,SBUX,AMAT,MDLZ,ADI,ISRG,
    CHTR,GILD,BKNG,VRTX,CSX,MU,FISV,LRCX,REGN,MNA,
    ATVI,SNPS,KLAC,KDP,MNST,MAR,AEP,CDNS,PANW,NXPI,
    ASML,FTNT,ORLY,PAYX,MRVL,KHC,ADSK,EXC,CTAS,ABNB,
    MELI,AZN,XEL,CRWD,EA,MCHP,CTSH,LULU,DLTR,WBA,
    DXCM,ILMN,SGEN,IDXX,JD,BIIB,ODFL,PCAR,LCID,BIDU,
    WDAY,CPRT,VRSK,TEAM,ROST,FAST,ZM,DDOG,EBAY,SIRI,
    PDD,ANSS,ZS,ALGN,MTCH,VRSN,CEG,NTES,SWKS,SPLK,
    OKTA,DOCU"

#-------------------------------------------
# split symbols and make vector
#-------------------------------------------
nasdaq100_symbols <- 
  gsub(" ", "", strsplit(vstr_nasdaq100, 
                         "\\s*,\\s*")[[1]])
nasdaq100_symbols

#-------------------------------------------
# read price information of constituents
#-------------------------------------------
sdate <- as.Date("2020-07-01")
edate <- as.Date("2022-06-30")
getSymbols(nasdaq100_symbols,from=sdate,to=edate)

#-------------------------------------------
# collect only adjusted prices
#-------------------------------------------
price <- NULL
for(i in 1:length(nasdaq100_symbols)) {
  eval(parse(text=paste0(
    "price <- cbind(price,",
    nasdaq100_symbols[i],"[,6])")))
}

# modify column name as only symbol
colnames(price) <- 
  gsub(".Adjusted", "", colnames(price))

#-------------------------------------------
# print price time series of Components
#-------------------------------------------
head(price)
tail(price)