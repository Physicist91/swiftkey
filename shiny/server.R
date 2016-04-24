library(shiny)
library(NLP)
library(tm)

predict.ngram <- function(pattern, trigrams) {
  matching <- grep(pattern, trigrams, ignore.case=TRUE)
  if(length(matching) == 0)
      top5 <- 'the'
  else if(length(matching) < 5)
      top5 <- sort(table(matching), decreasing=T)[1:length(matching)]
  else
    top5 <- sort(table(matching), decreasing=T)[1:5]
  
  top5
}

shinyServer(
  function(input, output){
    output$value <- renderPrint({ input$text })
    output$prediction <- renderPrint({
        if(input$goButton == 1){
            withProgress(message='Computing the next word:', value=0, {
                
                incProgress(0.25, detail='Loading text files...')
                tweet.con <- file("en_US.twitter.txt", "r")
                combined.data <- readLines(tweet.con)
                close(tweet.con)
                
                incProgress(0.25, detail = 'Preprocessing corpus...')
                combined.data <- removePunctuation(combined.data)
                combined.data <- tolower(combined.data)
                combined.data <- stripWhitespace(combined.data)
                
                incProgress(0.25, detail='Creating 3-grams...')
                combined.data <- strsplit(combined.data, " ", fixed=TRUE)
                trigrams <- sapply(combined.data, ngrams, 3L)
                trigrams <- vapply(trigrams, paste, "", collapse=" ")
                
                incProgress(0.25, detail='Getting your top suggestions...')
                x <- predict.ngram(input$text, trigrams)
            })
            x[1]
        }
        
      })
      })
  
