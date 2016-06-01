library(NLP)
library(tm)
library(filehash)
library(tau)
library(foreach)
library(dplyr)

# create a permanent corpus on disk in the training directory
myCorpus <- PCorpus(DirSource("training3", encoding = 'UTF-8', mode='text'),
                    dbControl=list(dbName="myCorpus.db", dbType="DB1"))

ngram <- function(n, corpus) {
  textcnt(corpus, method = "string",n=as.integer(n),
          split = "[[:space:][:digit:]]+",decreasing=T)
}
CORPUS<-c(myCorpus[[1]]$content)
rm(myCorpus)

# create unigrams
onegram <- ngram(1, CORPUS)
df_unigram <- data.frame(Unigram = names(onegram), count=unclass(onegram))
rm(onegram)
str(df_unigram)
df_unigram$Unigram <- as.character(df_unigram$Unigram)
df_unigram$count <- as.numeric(df_unigram$count)
fof_unigram <- table(df_unigram$count) # frequency of frequency
write.csv(df_unigram, "df_unigram.csv",row.names=FALSE)
write.csv(fof_unigram, "fof_unigram.csv")
rm(df_unigram, fof_unigram)

# create bigrams
bigram <- ngram(2, CORPUS)
df_bigram <- data.frame(Bigram = names(bigram), count=unclass(bigram))
rm(bigram)
str(df_bigram)
df_bigram$Bigram <- as.character(df_bigram$Bigram)
df_bigram$count <- as.numeric(df_bigram$count)
fof_bigram <- table(df_bigram$count)
write.csv(df_bigram, "df_bigram.csv", row.names = FALSE)
write.csv(fof_bigram, "fof_bigram.csv")
rm(df_bigram, fof_bigram)

# create trigrams, processing 10k docs at a time
N <- floor(length(CORPUS)/10000)
for(step in 1:N){
  if(step < N){
    trigram <- ngram(3, CORPUS[1:10000])
  } else {
    trigram <- ngram(3, CORPUS)
  }
  
  df_trigram <- data.frame(Trigram = names(trigram), count=unclass(trigram))
  df_trigram$Trigram <- as.character(df_trigram$Trigram)
  df_trigram$count <- as.numeric(df_trigram$count)
  #fof_trigram <- table(df_trigram$count)
  
  cat("Iteration", step, "\n")
  
  write.csv(df_trigram, file=paste0("df_trigram_", step, ".csv"), row.names=FALSE)
  #write.csv(fof_trigram, file=paste0("fof_trigram_", step, ".csv"))
  
  CORPUS <- CORPUS[-(1:10000)]
}
rm(CORPUS, df_trigram, trigram)
df_trigram <- foreach(step=1:N, .combine=rbind) %do% { #aggregating the csv's into one file
  
  df <- read.csv(paste0("df_trigram_", step, ".csv"))
  
  cat("Iteration", step, "\n")
  
  df
}
rm(df)
df_trigram <- df_trigram %>%
  group_by(Trigram) %>%
  summarise(count = sum(count))
fof_trigram <- table(df_trigram$count)
write.csv(df_trigram, file='df_trigram.csv')
write.csv(fof_trigram, file='fof_trigram.csv')
for(i in 1:N) {file.remove(paste0("df_trigram_", i, ".csv"))}
#for(i in 1:N) {file.remove(paste0("fof_trigram_", i, ".csv"))}
rm(fof_trigram)


