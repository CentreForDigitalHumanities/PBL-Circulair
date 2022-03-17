### Dit script extraheert de @-mentions uit de OBI4wan-Twitter-dataset.

library(tibble)
library(tidyr)
library(dplyr)

setwd("C:/Users/bge_j/OneDrive/Documenten/UDS/Circulair PBL/OBI/Twitter/Woningen")
df <- read.csv2("berichten-09-06-2021_12_31.csv")

text <- df$Bericht
mention <- df$Mentions

for (i in nrow(df)) {
  df$Mentions <- regmatches(df$Bericht,gregexpr('@\\w+', df$Bericht))
  print(mention)
}

View(df)

df2 <- df

for(i in nrow(df2)){
  if(is.list(df2[i,5])){
    df2[i,5]=paste(unlist(df2[i,5]),collapse=" ")
  }
}

df2_final <- df2

df2_final <- unnest(df2_final,Mentions)

df2_final <- df2_final %>%
  select(Geplaatst.door..optioneel., Mentions)

df_final <- data.frame(lapply(df2_final, gsub, pattern = "@", replacement = ""))

View(df_final)

setwd("C:/Users/bge_j/OneDrive/Documenten/UDS/Circulair PBL/")
write.csv2(df_final,"Mentions.csv", row.names = FALSE, col.names = FALSE)

