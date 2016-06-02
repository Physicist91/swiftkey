# Less meaningful trigrams are removed as follows:
# single-count trigrams are removed
# Trigrams containing <EOS> tag are removed


df_trigram <- read.csv("df_trigram.csv", stringsAsFactors = FALSE)

# remove single trigrams
df_trigram <- df_trigram[df_trigram$count > 1,]

# convert to character
df_trigram$Trigram <- as.character(df_trigram$Trigram)

# remove any grams containing <EOS>
df_trigram <- df_trigram[-grep('<eos>', df_trigram$Trigram, fixed=TRUE),]

# create bigrams + unigram for every trigram
grams <- strsplit(df_trigram$Trigram, split=" ")
mat <- matrix(unlist(grams), ncol=3, byrow=TRUE)
mat <- as.data.frame(mat)
rm(grams)
colnames(mat) <- c("word1", "word2", "word3")
df_trigram <- cbind(df_trigram, mat)
rm(mat)

df_trigram$Trigram <- NULL

write.csv(df_trigram, file='df_trigram_final.csv', row.names=FALSE)

