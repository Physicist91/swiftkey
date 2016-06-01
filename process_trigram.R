df_trigram <- read.csv("df_trigram.csv", stringsAsFactors = FALSE)

# remove single trigrams
df_trigram <- df_trigram[df_trigram$count > 1,]


# create bigrams + unigram for every trigram
grams <- strsplit(df_trigram$Trigram, split=" ")
mat <- matrix(unlist(grams), ncol=3, byrow=TRUE)
mat <- as.data.frame(mat)
rm(grams)
colnames(mat) <- c("word1", "word2", "word3")
df_trigram <- cbind(df_trigram, mat)
rm(mat)



write.csv(df_trigram, file='df_trigram_final.csv')

