### Met dit script voeren we een geautomatiseerde tekstanalyse uit op de verschillende datasets. We kijken hierbij zowel naar de meest gebruikte woorden in het algemeen,
### als ook de meest genoemde termen gerelateerd aan de R-strategieën. We maken gebruik van de library Quanteda voor de tekstanalyse.

library(quanteda)
library(readtext)
library(spacyr)

df <- read.csv2("D:/UDS/Circulair PBL/Quanteda/twitter_CE_PBL_subset.csv")
data_txt <- df$text

nrow(df)

summary(data_txt)
corpus_txt <- corpus(data_txt)

tokpbl <- tokens(corpus_txt,
                 what = "word",
                 remove_punct = TRUE,
                 remove_numbers = TRUE,
                 remove_symbols = TRUE,
                 remove_url = TRUE,
                 verbose = TRUE) %>%
  tokens_tolower() %>% 
  tokens_remove(stopwords::stopwords(language = "nl",source="stopwords-iso"))  %>%
  tokens_remove("?") %>%
  tokens_remove("000*")

dfm_pbl <- dfm(tokpbl)
topfeatures(dfm_pbl, 20)


### R strats
kwic_pbl <- kwic(corpus_txt,c("circulair*","recycl*","repar*","recover*","verminder*","hergebruik*","afwijs*","afwijz*"))
kwic_df <- as.data.frame(kwic_pbl)
View(kwic_df)

toks_rstrat <- tokens(kwic_df$keyword,verbose=TRUE)
dfm_rstrat <- dfm(toks_rstrat)
textplot_wordcloud(dfm_rstrat, min_count = 20, min_size=1,max_size=6,rotation = 0)

features_dfm_pbl <- textstat_frequency(dfm_rstrat, n = 25)
features_dfm_pbl$feature <- with(features_dfm_pbl, reorder(feature, -frequency))
ggplot(features_dfm_pbl, aes(x = frequency, y = feature)) +
  geom_col() + 
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

library("quanteda.textplots")
textplot_wordcloud(dfm_pbl, min_count = 2000, min_size=1,max_size=6,rotation = 0)

library(ggplot2)
library("quanteda.textstats")
features_dfm_pbl <- textstat_frequency(dfm_pbl, n = 25)
features_dfm_pbl$feature <- with(features_dfm_pbl, reorder(feature, -frequency))
ggplot(features_dfm_pbl, aes(x = frequency, y = feature)) +
  geom_col() + 
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

### 

df <- read.csv2("D:/UDS/Circulair PBL/Quanteda/woningen_complete.csv")
data_txt <- df$text

summary(data_txt)
corpus_txt <- corpus(data_txt)

tokpbl <- tokens(corpus_txt,
                 what = "word",
                 remove_punct = TRUE,
                 remove_numbers = TRUE,
                 remove_symbols = TRUE,
                 remove_url = TRUE,
                 verbose = TRUE) %>%
  tokens_tolower() %>% 
  tokens_remove(stopwords::stopwords(language = "nl",source="stopwords-iso")) %>%
  tokens_remove("?") %>%
  tokens_remove("000*")

dfm_pbl <- dfm(tokpbl)
topfeatures(dfm_pbl, 20)

### R strats
kwic_pbl <- kwic(corpus_txt,c("circulair*","recycl*","repar*","recover*","verminder*","hergebruik*","afwijs*","afwijz*"))
kwic_df <- as.data.frame(kwic_pbl)
View(kwic_df)

toks_rstrat <- tokens(kwic_df$keyword,verbose=TRUE)
dfm_rstrat <- dfm(toks_rstrat)
textplot_wordcloud(dfm_rstrat, min_count = 20, min_size=1,max_size=6,rotation = 0)

library("quanteda.textplots")
textplot_wordcloud(dfm_pbl, min_count = 5000, min_size=1,max_size=6)

library(ggplot2)
library("quanteda.textstats")
features_dfm_pbl <- textstat_frequency(dfm_pbl, n = 25)
features_dfm_pbl$feature <- with(features_dfm_pbl, reorder(feature, -frequency))
ggplot(features_dfm_pbl, aes(x = frequency, y = feature)) +
  geom_col() + 
  theme(axis.text.x = element_text(angle = 90, hjust = 1))
### 

### 

df <- read.csv2("D:/UDS/Circulair PBL/Quanteda/media_CE_PBL_subset.csv")
data_txt <- df$Bericht
  
summary(data_txt)
corpus_txt <- corpus(data_txt)

tokpbl <- tokens(corpus_txt,
                 what = "word",
                 remove_punct = TRUE,
                 remove_numbers = TRUE,
                 remove_symbols = TRUE,
                 remove_url = TRUE,
                 verbose = TRUE) %>%
  tokens_tolower() %>% 
  tokens_remove(stopwords::stopwords(language = "nl",source="stopwords-iso")) %>%
  tokens_remove("?") %>%
  tokens_remove("000*")

dfm_pbl <- dfm(tokpbl)
topfeatures(dfm_pbl, 20)

### R strats
kwic_pbl <- kwic(corpus_txt,c("circulair*","recycl*","repar*","recover*","verminder*","hergebruik*","afwijs*","afwijz*"))
kwic_df <- as.data.frame(kwic_pbl)
View(kwic_df)

toks_rstrat <- tokens(kwic_df$keyword,verbose=TRUE)
dfm_rstrat <- dfm(toks_rstrat)
textplot_wordcloud(dfm_rstrat, min_count = 100, min_size=1,max_size=6,rotation = 0)

features_dfm_pbl <- textstat_frequency(dfm_rstrat, n = 25)
features_dfm_pbl$feature <- with(features_dfm_pbl, reorder(feature, -frequency))
ggplot(features_dfm_pbl, aes(x = frequency, y = feature)) +
  geom_col() + 
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

library("quanteda.textplots")
textplot_wordcloud(dfm_pbl, min_count = 5000, min_size=1,max_size=6)

library(ggplot2)
library("quanteda.textstats")
features_dfm_pbl <- textstat_frequency(dfm_pbl, n = 25)
features_dfm_pbl$feature <- with(features_dfm_pbl, reorder(feature, -frequency))
ggplot(features_dfm_pbl, aes(x = frequency, y = feature)) +
  geom_col() + 
  theme(axis.text.x = element_text(angle = 90, hjust = 1))
### 

### 

df <- read.csv2("D:/UDS/Circulair PBL/Quanteda/WONINGEN_TOTALE_DATASET.csv")
data_txt <- df$Bericht

summary(data_txt)
corpus_txt <- corpus(data_txt)

tokpbl <- tokens(corpus_txt,
                 what = "word",
                 remove_punct = TRUE,
                 remove_numbers = TRUE,
                 remove_symbols = TRUE,
                 remove_url = TRUE,
                 verbose = TRUE) %>%
  tokens_tolower() %>% 
  tokens_remove(stopwords::stopwords(language = "nl",source="stopwords-iso")) %>%
  tokens_remove("?") %>%
  tokens_remove("000*")

dfm_pbl <- dfm(tokpbl)
topfeatures(dfm_pbl, 20)

### R strats
kwic_pbl <- kwic(corpus_txt,c("circulair*","recycl*","repar*","recover*","verminder*","hergebruik*","afwijs*","afwijz*"))
kwic_df <- as.data.frame(kwic_pbl)
View(kwic_df)

toks_rstrat <- tokens(kwic_df$keyword,verbose=TRUE)
dfm_rstrat <- dfm(toks_rstrat)
textplot_wordcloud(dfm_rstrat, min_count = 15, min_size=1,max_size=6,rotation = 0)

library("quanteda.textplots")
textplot_wordcloud(dfm_pbl, min_count = 5000, min_size=1,max_size=6)

library(ggplot2)
library("quanteda.textstats")
features_dfm_pbl <- textstat_frequency(dfm_pbl, n = 25)
features_dfm_pbl$feature <- with(features_dfm_pbl, reorder(feature, -frequency))
ggplot(features_dfm_pbl, aes(x = frequency, y = feature)) +
  geom_col() + 
  theme(axis.text.x = element_text(angle = 90, hjust = 1))
### 

df <- read.csv2("D:/UDS/Circulair PBL/Quanteda/CE_YOUTUBE_DATASET_Unieke_NLse_posts.csv")
data_txt <- df$videoTitle

summary(data_txt)
corpus_txt <- corpus(data_txt)

tokpbl <- tokens(corpus_txt,
                 what = "word",
                 remove_punct = TRUE,
                 remove_numbers = TRUE,
                 remove_symbols = TRUE,
                 remove_url = TRUE,
                 verbose = TRUE) %>%
  tokens_tolower() %>% 
  tokens_remove(stopwords::stopwords(language = "nl",source="stopwords-iso")) %>%
  tokens_remove("?") %>%
  tokens_remove("000*") %>%
  tokens_remove("ðÿ") 

dfm_pbl <- dfm(tokpbl)
topfeatures(dfm_pbl, 20)

### R strats
kwic_pbl <- kwic(corpus_txt,c("circulair*","recycl*","repar*","recover*","verminder*","hergebruik*","afwijs*","afwijz*"))
kwic_df <- as.data.frame(kwic_pbl)
View(kwic_df)

toks_rstrat <- tokens(kwic_df$keyword,verbose=TRUE)
dfm_rstrat <- dfm(toks_rstrat)
textplot_wordcloud(dfm_rstrat, min_count = 1, min_size=1,max_size=6,rotation = 0)

library("quanteda.textplots")
textplot_wordcloud(dfm_pbl, min_count = 50, min_size=0.3,max_size=4)

library(ggplot2)
library("quanteda.textstats")
features_dfm_pbl <- textstat_frequency(dfm_pbl, n = 25)
features_dfm_pbl$feature <- with(features_dfm_pbl, reorder(feature, -frequency))
ggplot(features_dfm_pbl, aes(x = frequency, y = feature)) +
  geom_col() + 
  theme(axis.text.x = element_text(angle = 90, hjust = 1))
### 