library(shiny)
x_min<-10
x<-1:10
#myModel<-NULL
myResult <- NULL

simLM <- function(x,k,d) {
    
  y<-k*x+d
  return(y)
}

shinyServer(
  function(input,output){
    data<-reactive (
      {
                
        #x<-runif(input$x_number,0,100) 
        x<-seq(0,100,length.out=input$x_number) 
        #print(x)
        y<-simLM(x,input$k,input$d)    
        eps<-rnorm(input$x_number,mean=input$mue,sd=input$sigma)
        y_stochastic<-y+eps
        myModel <- lm(y_stochastic~x)
        #print(y)
        myMatrix<-cbind(x,y,y_stochastic,myModel$fitted.values)
        myResult$data <- myMatrix
        myResult$model <- myModel
        myResult
      }
      )
    
    output$plot1 <- renderPlot({
      print(data())
      myData<-data()$data
      
      #print(myData)
      plot(myData[,1:2],type="l",col="red",ylim=c(min(myData[,2:4])-5,max(myData[,2:4])+5),main="Linear Modelling")
      par(new=TRUE)
      plot(myData[,c(1,3)],type="p",ylim=c(min(myData[,2:4])-5,max(myData[,2:4])+5),xlab="",ylab="")
      par(new=TRUE)
      plot(myData[,c(1,4)],type="l",col="blue",ylim=c(min(myData[,2:4])-5,max(myData[,2:4])+5),xlab="",ylab="")
      
    })
    
    output$plot2 <- renderPlot({
      hist(data()$model$residuals,main="Histogram of Residuals",xlab="Residuals")
    })
    
    output$summary <- renderPrint({
      summary(data()$model)
    })
    
    output$table <- renderTable({
      x<-data()$data
      m<-data()$model
      myTable <- data.frame(x,m$residuals)
      names(myTable)<-c("x","real y","measured y","fitted y","residuals")
      myTable
    })
    
    
}
)