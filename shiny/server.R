library(shiny)
library(dplyr)

df_trigram <- read.csv("df_trigram_final.csv", stringsAsFactors = FALSE)

predict_word <- function(x) {
  
  x <- tolower(x)
  x <- gsub("[^[:alnum:][:space:]]", " ", x)
  
  splitted <- unlist(strsplit(x, split=" "))
  
  N <- length(splitted)
  if(N < 2)
    stop('2 words at least please.')
  
  subdata1 <- df_trigram[df_trigram$word2 == splitted[N],]
  subdata2 <- subdata1[subdata1$word1 == splitted[N-1],]
  
  if(nrow(subdata2) > 0)
    predicted <- subdata2[order(subdata2$count, decreasing=TRUE), "word3"]
  else if (nrow(subdata1) > 0){
    predicted <- subdata1 %>%
      group_by(word2, word3) %>%
      summarise(count=n()) %>%
      arrange(desc(count))
    predicted <- predicted$word3
  }
  else
    predicted <- 'the'
  
  predicted <- na.omit(predicted)
  
  if(length(predicted) >= 3)
    predicted[1:3]
  else
    predicted[1:length(predicted)]
}

shinyServer(
  function(input, output){
    
    output$value <- renderPrint({ input$text })
    output$prediction <- renderPrint({predict_word(input$text)})
    
  }
)