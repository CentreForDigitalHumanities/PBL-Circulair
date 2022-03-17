### Dit script doorzoekt de verschillende datasets op vernoemingen van 'PBL' of 'Planbureau voor de Leefomgeving' en maakt een subset van berichten die deze woorden noemen.

df <- read.csv2("D:/UDS/Circulair PBL/TwitterAPI/finalcsv/woningen_complete.csv")

df <- df %>%
  select(text,created_at)

words <- "PBL|Planbureau voor de Leefomgeving"

df[grep(words, df$text, value = F), "pbl_woningen"] <- 1

View(df)

write.csv2(df,"D:/UDS/Circulair PBL/Tableau/woningen_PBL.csv", row.names = FALSE)

df2 <- read.csv2("D:/UDS/Circulair PBL/TwitterAPI/Subset/twitter_CE_PBL_subset.csv")

df2 <- df2 %>%
  select(text,created_at)

words <- "PBL|Planbureau voor de Leefomgeving"

df2[grep(words, df2$text, value = F), "pbl_ce"] <- 1

View(df2)

write.csv2(df2,"D:/UDS/Circulair PBL/Tableau/ce_PBL_subset.csv", row.names = FALSE)

dffinal <- full_join(df,df2)

dffinal <- dffinal %>%
  select(created_at,pbl_woningen,pbl_ce)

dffinal[is.na(dffinal)] <- 0

View(dffinal)

write.csv2(dffinal,"D:/UDS/Circulair PBL/Tableau/full_PBL.csv", row.names = FALSE)

#########################

library(dplyr)

df <- read.csv2("D:/UDS/Circulair PBL/Mediaberichten/WONINGEN_TOTALE_DATASET.csv")

df <- df %>%
  select(Bron, Bericht,Publicatiedatum)

words <- "PBL|Planbureau voor de Leefomgeving"

df[grep(words, df$Bericht, value = F), "pbl_woningen"] <- 1

View(df)

write.csv2(df,"D:/UDS/Circulair PBL/Tableau/media_woningen_PBL.csv", row.names = FALSE)

df2 <- read.csv2("D:/UDS/Circulair PBL/Mediaberichten/CE_TOTALE_DATASET.csv")

df2 <- df2 %>%
  select(Bron,Bericht,Publicatiedatum)

words <- "PBL|Planbureau voor de Leefomgeving"

df2[grep(words, df2$Bericht, value = F), "pbl_ce"] <- 1

View(df2)

write.csv2(df2,"D:/UDS/Circulair PBL/Tableau/media_CE_PBL.csv", row.names = FALSE)

dffinal <- full_join(df,df2)

dffinal <- dffinal %>%
  select(Publicatiedatum,pbl_woningen,pbl_ce)

dffinal[is.na(dffinal)] <- 0

View(dffinal)

write.csv2(dffinal,"D:/UDS/Circulair PBL/Tableau/media_full_PBL.csv", row.names = FALSE)

############# CE filter

df <- read.csv2("D:/UDS/Circulair PBL/Tableau/ce_PBL.csv")

View(df)

words <- "2dehands|2ehands|circulair|circulaire economie|kringloopeconomie|circular|circular economy|cradle-to-cradle|hernieuwbare grondstoffen|lease|leasen|huren|levensduurverlenging|mobility as a service|mobility-as-a-service|modulair|recycle|recyclen|recycling|refurbished|secundaire bouwstoffen|secundaire grondstoffen|tweede hands|tweede leven|tweedehands|tweedehandse|upcycling|zero waste|product-as-a-service|pay-per-use|sharing|deeleconomie|minder consumeren|consuminderen|reparatie|opknappen|remanufacture|repurpose|hergebruik|hergebruiken|terugwinnen"
pbl <- "PBL|Planbureau voor de Leefomgeving|Planbureau|@Leefomgeving"

dfsubset <- df[grep(words, df$text, ignore.case = TRUE),]
dfsubset[grep(pbl, dfsubset$text, value = F, ignore.case = TRUE), "pbl_ce"] <- 1

nrow(dfsubset)
nrow(df)

View(dfsubset)

write.csv2(dfsubset,"D:/UDS/Circulair PBL/Tableau/ce_PBL_subset.csv", row.names = FALSE)



df2 <- read.csv2("D:/UDS/Circulair PBL/Mediaberichten/CE_TOTALE_DATASET.csv")

df2 <- df2 %>%
  select(Bron,Bericht,Publicatiedatum)

words <- "2dehands|2ehands|circulair|circulaire economie|kringloopeconomie|circular|circular economy|cradle-to-cradle|hernieuwbare grondstoffen|lease|leasen|huren|levensduurverlenging|mobility as a service|mobility-as-a-service|modulair|recycle|recyclen|recycling|refurbished|secundaire bouwstoffen|secundaire grondstoffen|tweede hands|tweede leven|tweedehands|tweedehandse|upcycling|zero waste|product-as-a-service|pay-per-use|sharing|deeleconomie|minder consumeren|consuminderen|reparatie|opknappen|remanufacture|repurpose|hergebruik|hergebruiken|terugwinnen"
pbl <- "PBL|Planbureau voor de Leefomgeving|Planbureau"

dfsubset <- df2[grep(words, df2$Bericht, ignore.case = TRUE),]
dfsubset[grep(pbl, dfsubset$Bericht, value = F), "pbl_ce"] <- 1

nrow(dfsubset)
nrow(df2)

View(dfsubset)

write.csv2(dfsubset,"D:/UDS/Circulair PBL/Tableau/media_CE_PBL_subset.csv", row.names = FALSE)



df3 <- read.csv2("D:/UDS/Circulair PBL/YouTube/CE_YOUTUBE_DATASET_Unieke_NLse_posts.csv")

words <- "2dehands|2ehands|circulair|circulaire economie|kringloopeconomie|circular|circular economy|cradle-to-cradle|hernieuwbare grondstoffen|lease|leasen|huren|levensduurverlenging|mobility as a service|mobility-as-a-service|modulair|recycle|recyclen|recycling|refurbished|secundaire bouwstoffen|secundaire grondstoffen|tweede hands|tweede leven|tweedehands|tweedehandse|upcycling|zero waste|product-as-a-service|pay-per-use|sharing|deeleconomie|minder consumeren|consuminderen|reparatie|opknappen|remanufacture|repurpose|hergebruik|hergebruiken|terugwinnen"
pbl <- "PBL|Planbureau voor de Leefomgeving|Planbureau"

dfsubset <- df3[grep(words, df3$videoDescription, ignore.case = TRUE),]
dfsubset[grep(pbl, dfsubset$videoDescription, value = F), "pbl_ce"] <- 1

nrow(dfsubset)
nrow(df3)

View(dfsubset)

write.csv2(dfsubset,"D:/UDS/Circulair PBL/Tableau/YT_CE_PBL_subset.csv", row.names = FALSE)
