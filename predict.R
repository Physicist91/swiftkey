df_trigram <- read.csv("df_trigram_final.csv", stringsAsFactors = FALSE)
df_trigram$word1 <- as.character(df_trigram$word1)
df_trigram$word2 <- as.character(df_trigram$word2)
df_trigram$word3 <- as.character(df_trigram$word3)

predict_word <- function(x) {
  
  x <- tolower(x)
  splitted <- unlist(strsplit(x, split=" "))
  
  N <- length(splitted)
  
  subdata1 <- df_trigram[grep(splitted[N], df_trigram$word2),]
  subdata2 <- subdata1[grep(splitted[N-1], subdata1$word1),]
  
  if(nrow(subdata2) > 0)
    predicted <- subdata2[which.max(subdata2$count), "word3"]
  else if (nrow(subdata1 > 0))
    predicted <- subdata1[which.max(subdata1$count), "word3"]
  else
    predicted <- 'kimbek'
  
  predicted
}