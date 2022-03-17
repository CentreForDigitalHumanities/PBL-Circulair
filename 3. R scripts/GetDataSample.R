### Dit script maakt willekeurige samples van de datasets voor de eerste exploratieve analyses.

library(dplyr)

setwd("C:/Users/bge_j/OneDrive/Documenten/UDS/Circulair PBL/Samples")

dfwoningen <- read.csv2("woningen_complete.csv")
dfce <- read.csv2("ce_complete.csv")

dfwoningen <- dfwoningen %>%
  select(text)

dfce <- dfce %>%
  select(text)

samplewoningen <- dfwoningen[sample(nrow(dfwoningen), 20000), ]
View(samplewoningen)

samplece <- dfce[sample(nrow(dfce), 20000), ]
View(samplece)

setwd("C:/Users/bge_j/OneDrive/Documenten/UDS/Circulair PBL/Samples")
write.csv(samplewoningen, "SAMPLE_twitter_woningen.csv", row.names = FALSE)
write.csv(samplece, "SAMPLE_twitter_ce.csv", row.names = FALSE)
write.csv(dfwoningen, "ALLTEXT_twitter_woningen.csv", row.names = FALSE)
write.csv(dfce, "ALLTEXT_twitter_ce.csv", row.names = FALSE)
