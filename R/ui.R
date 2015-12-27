library(shiny)
shinyUI(pageWithSidebar(
    headerPanel("Study of Behaviour of a Linear Model"),
    sidebarPanel(h5('X is called input value and lies between 0 and 1000.'),
                 h5('You have to choose the number of x values on which the model should be calculated.'),
      numericInput("x_number","number of x",10,10,1000,1,'100px'),
      h6('You should not do the calculation with less than 10 and more than 1000 values.'),
      h5('k is called slope.'),
      h5('Now choose the value of k please.'),
      numericInput("k","k:",0,-1000,1000,1,'100px'),
      h5('d is called intercept.'),
      h5('Now choose the value of d please.'),
      numericInput("d","d:",0,-1000,1000,1,'100px'),
      h5('Now let us describe the stochastic error eps. It will be normal distributed with mue and sigma.'),
      sliderInput('mue',"value of mue:",value=0,min=-5,max=5,step=0.01),
      sliderInput('sigma',"value of sigma:",value=0,min=0,max=200,step=0.01),
      submitButton('Calculate')),      
    mainPanel(h5('A perfect linear model is described by following equation: Y=k*X+d'),
              h5('In real world\'s behaviour the model will be y=k*x+d+eps where eps is called STOCHASTIC ERROR.'),
              tabsetPanel(
                              tabPanel("Plot of Model", plotOutput("plot1")), 
                              tabPanel("Plot of Residuals", plotOutput("plot2")), 
                              tabPanel("Fitted Model Summary", verbatimTextOutput("summary")),  
                              tabPanel("Table", tableOutput("table")))
              )
        )
    )
