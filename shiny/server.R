library(shiny)
library(NLP)
library(tm)

predict.ngram <- function(pattern) {
  matching <- grep(pattern, trigrams)
  if(length(matching) < 5)
    top5 <- sort(table(matching), decreasing=T)[1:length(matching)]
  else
    top5 <- sort(table(matching), decreasing=T)[1:5]
  
  top5
}

shinyServer(
  function(input, output){
    output$value <- renderPrint({ input$text })
    output$prediction <- renderPrint({
      withProgress(message='Computing for the next word...', value=0, {
        
        incProgress(0.1, detail='Loading text files...')
        tweet.con <- file("en_US.twitter.txt", "r")
        combined.data <- readLines(tweet.con)
        close(tweet.con)
        
        incProgress(0.1, detail = 'Preprocessing corpus...')
        combined.data <- removePunctuation(combined.data)
        combined.data <- tolower(combined.data)
        combined.data <- stripWhitespace(combined.data)
        
        incProgress(0.1, detail='Creating 3-grams...')
        combined.data <- strsplit(combined.data, " ", fixed=TRUE)
        trigrams <- sapply(combined.data, ngrams, 3L)
        trigrams <- vapply(trigrams, paste, "", collapse=" ")
        
        incProgress(0.1, detail='Getting your top suggestions...')
        predict.ngram(input$text)[1]
      })
      })
  }
)