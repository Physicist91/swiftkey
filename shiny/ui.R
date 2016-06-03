library(shiny)
library(shinythemes)

shinyUI(fluidPage(
  theme=shinytheme('cosmo'),
  titlePanel('Just A Word Prediction App'),
  
  
  sidebarLayout(
    
    # Sidebar with a text input
    sidebarPanel(
      textInput("text", label=h3('Text Input'), placeholder='Enter at least two words'),
      h5('You typed:'),
      verbatimTextOutput('value')
    ),
    
    # Show the prediction
    mainPanel(
      h4('Top suggestions:'),
      verbatimTextOutput("prediction")
    )
  ),
  
  hr(),
  
  fluidRow(
    column(2, h5('Created by', strong('Kevin Siswandi'), '.'),
            h5('https://sg.linkedin.com/in/kevinsiswandi'))
  )
  

))