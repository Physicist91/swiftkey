library(NLP)
library(tm)
library(filehash)

# create a permanent corpus on disk in the training directory
myCorpus <- PCorpus(DirSource("training2", encoding = 'UTF-8', mode='text'),
        dbControl=list(dbName="myCorpus.db", dbType="DB1"))

# data cleaning 1: to lowercase
myCorpus <- tm_map(myCorpus, content_transformer(tolower))
dbInit("myCorpus.db")

# data cleaning 2: remove hyphens, slashes, and other punctuations
myCorpus <- tm_map(myCorpus, content_transformer(removePunctuation))
dbInit('myCorpus.db')

# data cleaning 3: remove numbers
myCorpus <- tm_map(myCorpus, content_transformer(removeNumbers))
dbInit('myCorpus.db')

# data cleaning 5: remove URLs
myCorpus <- tm_map(myCorpus, content_transformer(function(x)(gsub("httpwww(.+) ", " ", x))))
dbInit('myCorpus.db')

# data cleaning 4: strip extra whitespaces
myCorpus <- tm_map(myCorpus, content_transformer(stripWhitespace))
dbInit('myCorpus.db')


write(myCorpus[[1]]$content, "training3/training.txt")
