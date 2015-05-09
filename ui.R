library(shiny)

shinyUI(fluidPage(
  titlePanel("Visualization and Prediction of Emotions Based on Experimental Data"),
  
  fluidRow(
    
    column(3,
           wellPanel(
             h3('Select values to visualize emotions'),
             selectInput('x1', 'X axis', choices =
                           c('Valence' = 1, 'Arousal' = 2, 'Dominance' = 3),
                         selected = 1),
             selectInput('y1', 'Y axis', choices = 
                           c('Valence' = 1, 'Arousal' = 2, 'Dominance' = 3),
                         selected = 2),
             submitButton('Submit')
           ),
           wellPanel(
             h3('Select values to predict emotion'),
             numericInput("valence",'Input a value of Valence:', 0, min = -2, max = 2, step = 0.2),
             numericInput("arousal",'Input a value of Arousal:', 0, min = -2, max = 2, step = 0.2),
             numericInput("dominance",'Input a value of Dominance:', 0, min = -2, max = 2, step = 0.2),
             submitButton('Submit')
           )
    ), 
    
    column(9,
           plotOutput("vadPlot"),
           
           wellPanel(
             span(
               h3('Result of prediction'),
               h4('You have entered:'),
               verbatimTextOutput("inputValue"),
               h4('This is probably the following emotion:'),
               verbatimTextOutput('prediction')
             ) 
             
           ) 
    )
  )
))