df_trigram <- read.csv("df_trigram.csv")

predict_word <- function(x) {
  matched <- df_trigram[grep(x, df_trigram$Trigram, ignore.case=TRUE),]
  
  prediction <- matched[order(matched$count, decreasing=TRUE), 'Trigram']
  prediction <- sapply(prediction, function(x)(strsplit(x, split=" ")[[3]]))
}