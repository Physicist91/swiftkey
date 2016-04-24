library(shiny)

shinyUI(fluidPage(
  titlePanel('Coursera Capstone: Next-word Prediction App'),
  
  fluidRow(
    column(3, textInput("text", label=h3('Text Input'), value='Enter a sentence...')),
    column(3, h4('Next-word suggestion:'), verbatimTextOutput("prediction"))
  ),
  
  hr(),
  fluidRow(
      column(3, verbatimTextOutput('value'))
  ),
  actionButton("goButton", "Predict!"),
  fluidRow(column(3, h4('Please be patient after hitting the button as the text preprocessing is slow, ~10mins')))

))