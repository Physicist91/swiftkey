library(shiny)

df_trigram <- read.csv("df_trigram_final.csv", stringsAsFactors = FALSE)



predict_word <- function(x) {
  
  x <- tolower(x)
  x <- gsub("[^[:alnum:][:space:]]", " ", x)
  splitted <- unlist(strsplit(x, split=" "))
  
  N <- length(splitted)
  
  subdata1 <- df_trigram[df_trigram$word2 == splitted[N],]
  subdata2 <- subdata1[subdata1$word1 == splitted[N-1],]
  
  if(nrow(subdata2) > 0)
    predicted <- subdata2[order(subdata2$count, decreasing=TRUE), "word3"]
  else if (nrow(subdata1 > 0))
    predicted <- subdata1[order(subdata1$count, decreasing=TRUE), "word3"]
  else
    predicted <- 'kimbek'
  
  predicted[1:3]
}

shinyServer(
  function(input, output){
    
    output$value <- renderPrint({ input$text })
    output$prediction <- renderPrint({predict_word(input$text)})
        
  }
)
  
