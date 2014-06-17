#server

library(shiny)
library(deSolve)
par(oma=c(0,0,0,2.1))

SIR <- function(time, state, parameters) {
  if(state[1]>1) N=state[1]+state[2]+state[3]
  with(as.list(c(state, parameters)), {
    if(state[1]>1) {
      dS <- -beta * S*I/N
      dI <- beta * S*I/N - gamma * I
      dR <- gamma * I
    }
    if(state[1]<=1) {
      dS <- -beta * S*I
      dI <- beta * S*I - gamma * I
      dR <- gamma * I
    }
    return(list(c(dS, dI, dR)))
  })
}

Exponential.Growth <- function(time, state, parameters) {
  with(as.list(c(state, parameters)), {
    dI <- r*I
    return(list(dI))
  })
}

dynamics=function(Type,time,state,parameters){
  if(Type=="SIR"){
    SIR.out <- data.frame( ode(state, time, SIR, parameters) )
#    if(graph=="TRUE"||graph=="T") 
#      matplot(time, SIR.out[,-1], type = "l", xlab = "Time", ylab = "Susceptibles and Recovereds", main = "SIR Model", lwd = 1, #lty = 1, bty = "l", col=c(4,3,2));legend('right', c('R', 'I', 'S'), lty=3:1, col=c(4,3,2), bty='n',cex=1.5)
      
    
#    R0=parameters[parameters="beta"]/parameters[parameters="gamma"]
  }
  if(Type=="Growth"){
    SIR.out <- data.frame( ode(state, time, Exponential.Growth, parameters) )
  }
  return(SIR.out)
}


shinyServer(
  function(input,output){

    time<-reactive({seq(from=0,to=input$days,by=1)})
    
    observe({
      if(input$radiobutton=='Growth'){
        init <-input$Suceptible
        params<-input$beta
        dynamic<-reactive({
          dynamicalModel<-dynamics(Type="Growth",time=time(),state=init,parameters=params)
          })
        output$iniciales<-renderText({init()})
        output$parametros<-renderText({params()})
        output$R_0<-renderPrint({r0})
      }
      if(input$radiobutton=='sir'){
        init<-reactive({paste(input$Suceptible,",",input$Infectious,",",input$Recovered)})
        params<-reactive({paste(input$beta,",",input$gama)})
        dynamic<-reactive({
        dynamicalModel<-dynamics(Type="SIR",time=time(),state=init(),parameters=params())
        })
        r0<-params()[1]/params()[2]
        output$iniciales<-renderText({init()})
        output$parametros<-renderText({params()})
        output$R_0<-renderPrint({r0})
      }
      })
    
    output$tiempo<-renderPrint({time()})
    


       output$Plot<-renderPlot({
	    observe({
     if(input$radiobutton=="SIR"){
           matplot(time, dinamicalModel[,c(2,4)], type = "l", ylab='',xlab='',axes=FALSE, main = "SIR Model", lwd = 1, lty = 1, bty = "l", col=c(4,3))
           axis(1,at=seq(1,max(time)),labels=seq(1,max(time)))
           axis(2,at=seq(0,max(SIR.out[,2]),by=1000))
           mtext("Susceptibles and Recovered",side=2,line=3,cex=1.5)
           par(new=TRUE);
           matplot(time, dinamicalModel[,3], type = "l", ylab='',xlab='',axes=FALSE, lwd = 1, lty = 1, bty = "l", col=2)
           axis(4,at=seq(0,max(dinamicalModel[,3]),by=100));
           mtext("Infected",side=4,line=3,cex=1.5);legend('right', c('S','I','R'), lty=1, col=c(4,2,3), bty='n',cex=1.5)
         }
         if(input$radiobutton=="Growth"){
           matplot(time, dinamicalModel[,-1], type='l', xlab = "Time", ylab = "Growth Rate", main = "Exponential Growth Model", lwd = 1, lty = 1, bty = "l", col=2);legend('right', 'I', lty=1, col=2, bty='n')
         }
       })
       })
  })
 