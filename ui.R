shinyUI(
  pageWithSidebar(
    headerPanel("SIR Model - Mathematical Epidemiology"),
    sidebarPanel(
#       radioButtons("Instructions","Instructions",c("do not show","show")),
#       conditionalPanel(condition="input.Instructions=='show'",
#                        p("This application shows the most simple mathematical model applied to epidemiology. 
#                        The next steps are necessary:
#                        1.- Input the number of days for which the disease will be followed
#                         slide the transmission rate, i.e., probability at which a suceptible person could become infected3.- slide the number of days that said person will be infecting others until recovered from  the disease
#                        4.- Initialize values, indicating the suceptible population, already infected population, and already recovered population
#                       ")),
                       numericInput("days","Days of disease",50),
                       sliderInput("beta",label="Transmission rate",min=0,max=1,value=0.5,step=0.01),
                       sliderInput("gama",label="days until recovery",min=0,max=15,value=2.5,step=0.1),
                       numericInput("Suceptible","Initial Suceptible Population",50),
                       numericInput("Infectious","Initial Infectious Population",1),
                       numericInput("Recovered","Initial Recovered Population",0)
                       
      ),
    mainPanel(
      #These are tests runs.
      h4("Resultados"),
      verbatimTextOutput("Result"),
      plotOutput("Plot"),
      h4("Basic Reproductive Number"),
      h4(textOutput("R_0"))
            
    )
  )
)


