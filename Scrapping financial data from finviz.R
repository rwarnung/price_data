## Scrapping financial data from finviz with R and rvest package

## taken from here: https://typethepipe.com/post/scraping-financial-data-finviz-rvest-package/

library(tidyverse)
  
  Get_finviz_data <- function(symbol){
    
    Sys.sleep(1)          # It's a good practice to use a sleep to make repeated calls to the server
    
    finviz_url <- glue::glue("https://finviz.com/quote.ashx?t={symbol}")
    finviz_html <- tryCatch(rvest::read_html(finviz_url), error=function(e) NULL)
    
    if(is.null(finviz_html)) return(NULL)
    
    sector_str <- finviz_html %>% 
      rvest::html_element(xpath = '/html/body/div[4]/div/table[1]') %>% 
      rvest::html_table() %>% 
      head(1) %>% 
      pull(X4) 
    
    sector_df <- sector_str %>% 
      str_split("[|]", simplify = T) %>% 
      str_squish() %>% 
      as_tibble() %>% 
      mutate(variable = c("sector", "industry", "country")) %>% 
      relocate(variable) %>% 
      add_row(variable = "ticker", value = symbol, .before = 1)
    
    raw_tbl <- finviz_html %>% 
      rvest::html_element(xpath = '/html/body/div[4]/div/table[2]') %>% 
      rvest::html_table() 
    
    headers <- raw_tbl %>% select(seq(1,11,2)) %>% flatten_chr() 
    values <- raw_tbl %>% select(seq(2,12,2)) %>% flatten_chr()
    
    finviz_df <- tibble(value = values) %>%
      bind_cols(variable = headers, .) %>% 
      bind_rows(sector_df, .)
    
    return(finviz_df)
  }

## the Microsoft stock
symbol <- "MSFT"

sdata = Get_finviz_data(symbol)
sdata


