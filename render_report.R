## themese: https://www.datadreaming.org/post/r-markdown-theme-gallery/
knitr::spin("./get_stock_data.R", knit = FALSE)
#rmarkdown::render("./R_example.R")

rmarkdown::render(
  "./get_stock_data.R", 
  output_format = rmarkdown::html_document(
    theme = "united"
    #,
    #mathjax = NULL,
    #highlight = NULL
  )
)