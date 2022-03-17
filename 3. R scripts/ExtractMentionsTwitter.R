### Dit script zet de Twitter-dataset om in een bestand dat door Gephi kan worden gelezen. 
### Vervolgens voeren we analyses uit in Gephi, exporteren we de data en verrijken deze vervolgens weer met de data uit de PBL-vermeldingendataset. 
### Deze kan vervolgens weer in Gephi worden geladen om te analyseren welke accounts over het PBL tweeten.

library(dplyr)
library(stringr)
library(tidyr)

df <- read.csv2("D:/UDS/Circulair PBL/Tableau/ce_PBL_subset.csv")

nrow(df)

#extraheer de mentions uit de text kolom, maak aantal nieuwe kolommen voor aantal mentions
users <- function(x){
  xx <- strsplit(x, " ")
  lapply(xx, function(xx)xx[grepl("@[[:alnum:]]", xx)])
}

df_select <- df

df_select$mentions <- users(df$text)
df_select <- df_select %>% unnest_wider(mentions)

df_select<- df_select %>% 
  mutate(across(everything(), as.character))

df_select[is.na(df_select)] <- ""
df_select <- df_select[!apply(df_select == "", 1, all),]

setwd("D:/UDS/Circulair PBL/Gephi/mentions")

df_select <- df_select %>%
  select(-name,-text,-imageURL,-retweet_count,-like_count,-followers_count,-location,-created_at)

df_final <- df_select %>%
  mutate_all(funs(gsub("([_])|[[:punct:]]","\\1",.)))

View(df_final)

df_final2 <- data.frame(lapply(df_final,
                               function(vari) {
                                 if (is.character(vari)) {
                                   return(tolower(vari))
                                 } else {
                                   return(vari)
                                 }
                               }
), stringsAsFactors = FALSE)

View(df_final2)
write.csv2(df_final2,"ce_subset_mentions.csv",row.names = FALSE)

samplewoningen <- df_final[sample(nrow(df_final), 50000), ]
write.csv2(samplewoningen,"SAMPLE_ce_mentions.csv",row.names = FALSE)


### Laad de dataset in Gephi, extract nodes en edges. Onderstaande code koppelt vervolgens de PBL-vermeldingendataset en de Gephi-nodesdataset.
df <- read.csv2("D:/UDS/Circulair PBL/Tableau/ce_PBL_subset.csv")
df_nodes <- read.csv("D:/UDS/Circulair PBL/Gephi/ce_subset/nodes_total.csv")

df_ce <- df %>%
  select(username,pbl_ce) %>%
  rename(Id = username)

df_merge <- inner_join(df_ce,df_nodes)

View(df_merge)

write.csv2(df_merge,"D:/UDS/Circulair PBL/Gephi/ce_subset/nodes_pbltag.csv",row.names = FALSE)