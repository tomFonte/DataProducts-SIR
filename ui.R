shinyUI(
  pageWithSidebar(
    headerPanel("Shiny Application"),
    sidebarPanel(
      numericInput("days","Days of disease",50),
      radioButtons("radiobutton","Model type:",c("SIR"="sir","Exponential Growth"="growth")),
      conditionalPanel(condition="input.radiobutton=='sir'",
        sliderInput("beta",label="Transmission rate",min=0,max=5,value=2.5,step=0.1),
        sliderInput("gama",label="days until recovery",min=0,max=15,value=2.5,step=0.1),
        numericInput("Suceptible","Initial Suceptible Population",50),
        numericInput("Infectious","Initial Infectious Population",1),
        numericInput("Recovered","Initial Recovered Population",0)#, 
        #actionButton("radiobutton","Submit")
      ),
      conditionalPanel(condition="input.radiobutton=='growth'",
                       sliderInput("beta",label="Growth rate",min=0,max=5,value=2.5,step=0.1),
                       numericInput("Suceptible","Initial Suceptible Population",50)#,
#                        actionButton("radiobutton","Submit")
      )
    ),
  mainPanel(
    textOutput("tiempo"),
    textOutput("iniciales"),
    textOutput("parametros"),
    textOutput("R_0"),
    plotOutput("Plot")   
    
    
  )
  )
)