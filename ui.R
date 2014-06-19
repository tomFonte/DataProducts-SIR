shinyUI(
  pageWithSidebar(
    headerPanel("SIR Model - Mathematical Epidemiology"),
    sidebarPanel(
                       numericInput("days","Days of disease",50),
                       sliderInput("beta",label="Transmission rate",min=0,max=1,value=0.5,step=0.01),
                       sliderInput("gama",label="days until recovery",min=0,max=15,value=2.5,step=0.1),
                       numericInput("Suceptible","Initial Suceptible Population",50),
                       numericInput("Infectious","Initial Infectious Population",1),
                       numericInput("Recovered","Initial Recovered Population",0)
                       
      ),
    mainPanel(
      h4("Resultados"),
      verbatimTextOutput("Result"),
      plotOutput("Plot"),
      h4("Basic Reproductive Number"),
      h4(textOutput("R_0"))
            
    )
  )
)

