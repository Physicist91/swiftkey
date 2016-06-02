library(NLP)
library(tm)
library(filehash)
library(tau)

# create a permanent corpus on disk in the training directory
myCorpus <- PCorpus(DirSource("training3", encoding = 'UTF-8', mode='text'),
                    dbControl=list(dbName="myCorpus.db", dbType="DB1"))

ngram <- function(n) {
  textcnt(CORPUS, method = "string",n=as.integer(n),
          split = "[[:space:][:digit:]]+",decreasing=T)
}
CORPUS<-c(myCorpus[[1]]$content)

# create unigrams
onegram <- ngram(1)
df_unigram <- data.frame(Unigram = names(onegram), count=unclass(onegram))
rm(onegram)
str(df_unigram)
df_unigram$Unigram <- as.character(df_unigram$Unigram)
df_unigram$count <- as.numeric(df_unigram$count)
fof_unigram <- table(df_unigram$count) # frequency of frequency
write.csv(df_unigram, "df_unigram.csv")
write.csv(fof_unigram, "fof_unigram.csv")
rm(df_unigram, fof_unigram)

# create bigrams
bigram <- ngram(2)
df_bigram <- data.frame(Bigram = names(bigram), count=unclass(bigram))
rm(bigram)
str(df_bigram)
df_bigram$Bigram <- as.character(df_bigram$Bigram)
df_bigram$count <- as.character(df_bigram$count)
fof_bigram <- table(df_bigram$count)
write.csv(df_bigram, "df_bigram.csv")
write.csv(fof_bigram, "fof_bigram.csv")

# create trigrams