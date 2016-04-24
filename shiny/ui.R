library(shiny)

shinyUI(fluidPage(
  titlePanel('Coursera Capstone: Next-word Prediction App'),
  
  fluidRow(
    column(3, textInput("text", label=h3('Text Input'), value='Enter Text...')),
    column(3, h4('Next-word suggestion:'), verbatimTextOutput("prediction"))
  ),
  
  hr(),
  fluidRow(column(3, verbatimTextOutput("value")))
  
))