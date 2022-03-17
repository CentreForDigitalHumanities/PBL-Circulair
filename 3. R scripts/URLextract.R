### Dit script haalt hyperlinks uit een dataset en voegt deze toe aan een nieuwe kolom.

library(dplyr)
library(stringr)
library(tidyr)
library(RCurl)

theme = "CE"

df <- read.csv2(paste("D:/UDS/Circulair PBL/TwitterAPI/finalcsv/",theme,"_complete.csv",sep=""))

View(df)

df_select <- df %>%
  select(text)

#extraheer de URLs uit de nested attachments.media kolom
url_pattern <- "http[s]?://(?:[a-zA-Z]|[0-9]|[$-_@.&+]|[!*\\(\\),]|(?:%[0-9a-fA-F][0-9a-fA-F]))+"
df_select$URL <- str_extract(df$text, url_pattern)

decode.short.url <- function(u) {
  x <- try( getURL(u, header = TRUE, nobody = TRUE, followlocation = FALSE) )
  if(class(x) == 'try-error') {
    return(u)
  } else {
    x <- strsplit(x, "Location: ")[[1]][2]
    return(strsplit(x, "\r")[[1]][1])
  }
}

df_new <- decode.short.url(df_select$URL)

View(df_new)
