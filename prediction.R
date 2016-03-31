library(NLP)
library(tm)

# Reading data
blog.con <- file("/Users/kevins/swiftkey/final/en_US/en_US.blogs.txt", "r")
blog.lines <- readLines(blog.con)
tweet.con <- file("/Users/kevins/swiftkey/final/en_US/en_US.twitter.txt", "r")
tweet.lines <- readLines(tweet.con)
news.con <- file("/Users/kevins/swiftkey/final/en_US/en_US.news.txt", "r")
news.lines <- readLines(news.con)
combined.data <- c(blog.lines, tweet.lines, news.lines)

# preprocessing the corpus
combined.data <- removePunctuation(combined.data)
combined.data <- tolower(combined.data)
combined.data <- stemDocument(combined.data)
combined.data <- removeWords(combined.data, words=c('the', stopwords("english")))
combined.data <- stripWhitespace(combined.data)

# further processing on the corpus before tokenization
combined.data <- paste0(unlist(combined.data), collapse=" ")
combined.data <- strsplit(combined.data, " ", fixed=TRUE)[[1L]]
combined.data <- combined.data[combined.data != ""]

trigrams <- vapply(ngrams(combined.data, 3L), paste, "", collapse=" ")

predict.ngram <- function(pattern) {
  matching <- grep(pattern, trigrams)
  if(length(matching) < 5)
    top5 <- sort(table(matching), decreasing=T)[1:length(matching)]
  else
    top5 <- sort(table(matching), decreasing=T)[1:5]
}
