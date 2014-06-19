require(shiny)
require(deSolve)
require(rmarkdown)

par(oma=c(0,0,0,2.1))

SIR <- function(time, state, parameters) {
  N<-state[1]+state[2]+state[3]
  S<-state[1]
  I<-state[2]
  R<-state[3]
  
  beta<-parameters[1]
  gamma<-parameters[2]
  with(as.list(c(state, parameters)), {
    if(state[1]>1) {
      dS <- -beta * S*I/N
      dI <- beta * S*I/N - gamma * I
      dR <- gamma * I
    }
    return(list(c(dS, dI, dR)))
  })
}

dynamics=function(Type,time,state,parameters){
    SIR.out <- data.frame( ode(state, time, SIR, parameters) )
    colnames(SIR.out)<-c("day","S","I","R")
  return(SIR.out)
}


shinyServer(
  function(input,output){
    
    time<-reactive({seq(from=1,to=input$days,by=1)})
    init<-reactive({c(input$Suceptible,input$Infectious,input$Recovered)})
    params<-reactive({c(input$beta,1/input$gama)})
    dynamic<-reactive(dynamics(Type="SIR",time=as.numeric(time()),state=init(),parameters=params()))
     r0<-reactive(input$beta/(1/input$gama))
#     
    output$iniciales<-renderText({init()})
    output$parametros<-renderText({params()})
     output$R_0<-renderText({r0()})
     
    output$tiempo<-renderText({time()})
    output$Result<-renderPrint({dynamic()[input$days,-1]})
     
    output$Plot<-renderPlot({
#       Error in as.vector(x, mode) : 
#         cannot coerce type 'closure' to vector of type 'any'
                 matplot(time(), dynamic()[,-1], type = "l", xlab = "Time",
                         ylab = "Susceptibles and Recovereds", main = "SIR Model", lwd = 1, lty = 1, bty = "l", col=c(4,3,2))
                 legend('right', c('R', 'I', 'S'), lty=3:1, col=c(4,3,2), bty='n',cex=1.5)
                 matplot(time(), dynamic()[,c(2,4)], type = "l", ylab='',xlab='',axes=FALSE, 
                         main = "SIR Model", lwd = 1, lty = 1, bty = "l", col=c(4,3))
                 axis(1,at=seq(1,max(time())),labels=seq(1,max(time())))
                 axis(2,at=seq(0,max(dynamic()[,2]),by=1000))
                 mtext("Susceptibles and Recovered",side=2,line=3,cex=1.5)
                 par(new=TRUE);
                 matplot(time(), dynamic()[,3], type = "l", ylab='',xlab='',axes=FALSE, lwd = 1, lty = 1, bty = "l", col=2)
                 axis(4,at=seq(0,max(dynamic()[,3]),by=100));
                 mtext("Infected",side=4,line=3,cex=1.5);legend('right', c('S','I','R'), lty=1, col=c(4,2,3), bty='n',cex=1.5)
    })
  })
