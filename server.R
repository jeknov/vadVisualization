formatInput <- function(v,a,d){
  ## This function formats the user's input of Valence-Arousal-Dominance
  ## and outputs them as a vector
  
  c(v,a,d)
}

predictEmo <- function(v,a,d){
  ## This function predicts the possible emotion based on 
  ## the user's selection of Valence-Arousal-Dominance.
  ## It uses a k-Nearest Neighbours algorithm with k = 5.
  ## The training data was collected during the experiments
  ## performed by J.Novikova during April-May 2014.
  ## The accuracy of prediction is 61%.
  
  df <-read.csv('vadTestSet2.csv')  #read the data
  colnames(df)<-c("valence",'arousal','dominance','expr')
  
  train <- df[,1:3]  # define training data
  lbl = factor(c(df[,4]))  # define labels
  test = c(v,a,d)  # definethe object for prediction
  
  library(class)	# Load the class package that holds the knn() function
  result<-knn(train, test, lbl, k = 3)	#get the result
  
  # format the numeric result as an emotional term
  if (result == 1){
    print("Fear")}
  if (result == 2){
    print("Anger")}
  if (result == 3){
    print("Happiness")}
  if (result == 5){
    print("Surprise")}
  if (result == 6){
    print("Not emotional")}
}

plotVAD <- function(x,y){
  # This function creates the 2-dimensional scatter plot
  # where axes are changed based on user's input.
  
  df <- read.csv('vadTestSet2.csv')  # read the data
  colnames(df) <- c("valence",'arousal','dominance','expr') # create headers

  # assign the axes based on the user's input
  x1 <- as.integer(x)
  y1 <- as.integer(y)
  xA <- df[,x1]
  yA <- df[,y1]
  
  # label the axes
  if (x1 == 1) {xLbl = 'Valence'} 
  if (x1 == 2) {xLbl = 'Arousal'}
  if (x1 == 3) {xLbl = 'Dominance'}
  if (y1 == 1) {yLbl = 'Valence'}
  if (y1 == 2) {yLbl = 'Arousal'}
  if (y1 == 3) {yLbl = 'Dominance'}
  
  # create the plot with a legend
  plot(xA, yA, col=as.integer(df$expr), xlim = range(-3:3), ylim = range(-3:3), xlab=xLbl, ylab=yLbl, pch=19, cex = 4)
  legend("topleft", legend=c('Fear','Anger','Happiness','Surprise','Not emotional'), text.col = levels(factor(df$expr)), cex = 1.2)
}

shinyServer(
  function(input, output){
    output$vadPlot <- renderPlot({plotVAD(input$x1, input$y1)})
    output$inputValue <- renderPrint({formatInput(input$valence,input$arousal,input$dominance)})
    output$prediction <- renderPrint({predictEmo(input$valence,input$arousal,input$dominance)})
  }
)