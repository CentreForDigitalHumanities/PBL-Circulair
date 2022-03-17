### Dit script combineert alle Twitter-datasets en schoont de data op.

library(dplyr)
library(readr)
library(stringr)
library(tidyverse)
library(urltools)

##Sites
df <- list.files(path="D:/UDS/Circulair PBL/TwitterAPI/", full.names = TRUE) %>% 
  lapply(read_csv) %>% 
  bind_rows 

###extract urls
url_pattern <- '_url": "http[s]?://(?:[a-zA-Z]|[0-9]|[$-_@.&+]|[!*\\(\\),]|(?:%[0-9a-fA-F][0-9a-fA-F]))+'
df$imageURL <- str_extract(df$attachments.media, url_pattern)
df$URLz <- str_extract(df$entities.urls, url_pattern)
df$URLz <- gsub('_url": "', "", df$URLz)
doms <- suffix_extract(domain(df$URLz)) 
doms$host <- gsub('www.', "", doms$host)

View(df)

View(doms)

write.csv2(doms,"D:/UDS/Circulair PBL/TwitterAPI/woningen_links.csv")


df_select <- df %>%
  select(created_at,author.username,author.name, author.location,text,imageURL,public_metrics.retweet_count,public_metrics.like_count,author.public_metrics.followers_count) %>%
  rename(username = author.username, name = author.name,  location = author.location, retweet_count = public_metrics.retweet_count, like_count = public_metrics.like_count, followers_count = author.public_metrics.followers_count)

df_select<- df_select %>% 
  mutate(across(everything(), as.character))

df_select[is.na(df_select)] <- ""
df_select <- df_select[!apply(df_select == "", 1, all),] %>%
  arrange(created_at) %>%
  unique()

setwd("D:/UDS/Circulair PBL/TwitterAPI/finalcsv")
write.csv2(df_select,"woningen_complete.csv", row.names = FALSE)

View(df_select)

##### make timeline for woningen

tijdlijn <- df_select
tijdlijn <- tijdlijn %>%
  select(created_at)
tijdlijn$created_at <- tijdlijn$created_at %>% as.Date()

View(tijdlijn)

tijdlijn2 <- subset(tijdlijn, created_at > "2020-04-30")

freq <- table(tijdlijn2$created_at)
freq <- freq %>% as.data.frame()

for (i in freq) {if (freq$Var1 == "2020-08-24") {freq$pbl <- "PUBLICATIE WOONLASTENNEUTRAAL KOOPWONINGEN VERDUURZAMEN"}}

write.csv2(freq,"tijdlijn_woningen.csv", row.names = FALSE)


##### make timeline for CE

df_select <- read.csv2("D:/UDS/Circulair PBL/TwitterAPI/Subset/twitter_CE_PBL_subset.csv")

tijdlijn <- df_select
tijdlijn <- tijdlijn %>%
  select(created_at)
tijdlijn$created_at <- tijdlijn$created_at %>% as.Date()

View(tijdlijn)

tijdlijn2 <- subset(tijdlijn, created_at > "2020-04-30")

freq <- table(tijdlijn2$created_at)
freq <- freq %>% as.data.frame()

write.csv2(freq,"D:/UDS/Circulair PBL/TwitterAPI/Subset/tijdlijn_ce.csv", row.names = FALSE)


#Handmatig toevoegen in de Excelsheet:
#"2020-08-24","PUBLICATIE WOONLASTENNEUTRAAL KOOPWONINGEN VERDUURZAMEN","")
#"2021-01-23","PUBLICATIE ICER-RAPPORT 2021")
#"2021-07-06","PUBLICATIE ECORYS-RAPPORT")
