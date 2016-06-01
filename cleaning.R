library(NLP)
library(tm)
library(filehash)

# create a permanent corpus on disk in the training directory
myCorpus <- PCorpus(DirSource("training2", encoding = 'UTF-8', mode='text'),
        dbControl=list(dbName="myCorpus.db", dbType="DB1"))

head(myCorpus[[1]]$content)

# data cleaning 1: to lowercase
myCorpus <- tm_map(myCorpus, content_transformer(tolower))
dbInit("myCorpus.db")

# data cleaning 6: remove errant >, <
myCorpus <- tm_map(myCorpus, content_transformer(function(x)(gsub("<", " ", x))))
myCorpus <- tm_map(myCorpus, content_transformer(function(x)(gsub(">", " ", x))))
dbInit('myCorpus.db')

# data cleaning 9: create End of Sentence markers
myCorpus <- tm_map(myCorpus, content_transformer(function(x)(gsub("\\. |\\.$","  <EOS> ", x))))
myCorpus <- tm_map(myCorpus, content_transformer(function(x)(gsub("\\? |\\?$","  <EOS> ", x))))
myCorpus <- tm_map(myCorpus, content_transformer(function(x)(gsub("\\! |\\!$","  <EOS> ", x))))
dbInit('myCorpus.db')

# data cleaning 3: remove numbers
myCorpus <- tm_map(myCorpus, content_transformer(removeNumbers))
dbInit('myCorpus.db')

# data cleaning 5: remove URLs
myCorpus <- tm_map(myCorpus, content_transformer(function(x)(gsub(" www(.+) ", " ", x))))
dbInit('myCorpus.db')

# data cleaning 2: remove punctuations except apostrophe and EOS tag
myCorpus <- tm_map(myCorpus, content_transformer(function(x) (gsub("[^[:alnum:][:space:]\'<>]", " ", x))))
dbInit('myCorpus.db')

# data cleaning 8: remove all single letters except a, i
myCorpus <- tm_map(myCorpus, content_transformer(function(x)(gsub(" [b-hj-z] "," ", x))))
dbInit('myCorpus.db')

# data cleaning 4: strip extra whitespaces
myCorpus <- tm_map(myCorpus, content_transformer(stripWhitespace))
dbInit('myCorpus.db')


write(myCorpus[[1]]$content, "training3/training.txt")
