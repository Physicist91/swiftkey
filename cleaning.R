library(NLP)
library(tm)
library(filehash)

########
### End of sentence markers will be put in place of fullstops/question marks/exclamation marks.
### All punctuations will be removed except End of sentence markers.
### All letters will be standardized to lowercase.
### The shiny app will be case-insensitive and will ignore punctuations.

# create a permanent corpus on disk in the training directory
myCorpus <- PCorpus(DirSource("training2", encoding = 'UTF-8', mode='text'),
        dbControl=list(dbName="myCorpus.db", dbType="DB1"))

head(myCorpus[[1]]$content)

# to lowercase
myCorpus <- tm_map(myCorpus, content_transformer(tolower))
dbInit("myCorpus.db")

# remove >, <
myCorpus <- tm_map(myCorpus, content_transformer(function(x)(gsub("<", " ", x))))
myCorpus <- tm_map(myCorpus, content_transformer(function(x)(gsub(">", " ", x))))
dbInit('myCorpus.db')

# create End of Sentence markers
myCorpus <- tm_map(myCorpus, content_transformer(function(x)(gsub("\\. |\\.$","  <EOS> ", x)))); dbInit('myCorpus.db')
myCorpus <- tm_map(myCorpus, content_transformer(function(x)(gsub("\\? |\\?$","  <EOS> ", x)))); dbInit('myCorpus.db')
myCorpus <- tm_map(myCorpus, content_transformer(function(x)(gsub("\\! |\\!$","  <EOS> ", x)))); dbInit('myCorpus.db')


#  remove numbers
myCorpus <- tm_map(myCorpus, content_transformer(removeNumbers))
dbInit('myCorpus.db')

# remove URLs
myCorpus <- tm_map(myCorpus, content_transformer(function(x)(gsub(" www(.+) ", " ", x))))
dbInit('myCorpus.db')

#  remove punctuations except EOS tag
myCorpus <- tm_map(myCorpus, content_transformer(function(x) (gsub("[^[:alnum:][:space:]<>]", " ", x))))
dbInit('myCorpus.db')

#  remove all single letters except a, i
myCorpus <- tm_map(myCorpus, content_transformer(function(x)(gsub(" [b-hj-z] "," ", x))))
dbInit('myCorpus.db')



# strip extra whitespaces
myCorpus <- tm_map(myCorpus, content_transformer(stripWhitespace))
dbInit('myCorpus.db')


write(myCorpus[[1]]$content, "training3/training.txt")
