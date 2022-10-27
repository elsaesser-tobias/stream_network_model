library(ggplot2);
library(deSolve);
library(simecol);
library(OCNet);

setwd("C:/Users/elsae/Documents/R_Model");


set.seed(12)
OCN <- create_OCN(30, 20, outletPos = 1)
OCN <- aggregate_OCN(landscape_OCN(OCN), thrA = 0, streamOrderType = "Shreve")
# thrA = 0 damit nichts zusammengefasst wird und primäre Quellen angezeigt werden
#eventuell später ändern auf 1 oder 2 mit größerem OCN
#eventuell für andere stream order nochmal mit gleichem seed

draw_simple_OCN(OCN)
title("Optimal Channel Network")


OCN$FD$downNode # gibt an in welchen node die jeweilige node fließt
OCN$AG$streamOrder # gibt primäre Quellen an jedem Punkt an

stream_net <- list("downNode" = OCN$FD$downNode, "streamOrder" = OCN$AG$streamOrder, "nUpStream" = OCN$AG$nUpstream)

#remove(OCN) later use to clear memory
#stream_net[["test"]] <- c(1,2,3) how to append
# add OCN$FD$A für contamination?

#add to list: Wachstums- und Sterbefaktoren im Wasser 

stream_net[["growth"]] <- replicate(length(stream_net$downNode),0)
stream_net[["death"]] <- replicate(length(stream_net$downNode),0)


# set growth and death rates at primary points

#gute idee? am Ende überall gleich wenn verteilt
#stream order behalten aber an jedem punkt downstream mehr growth / death??
growth_source <- 10
death_source <- 50
n = 1
# for(i in stream_net$streamOrder){
#   if(i==1){
#     stream_net$growth[n] <- growth_source
#     stream_net$death[n] <- death_source
#   }
#   
#   
#   n = n + 1
# }
# str shift c
  
  
#add spread through network

#add upstream nodes for each point


#dNODE[x] / dt = dNode [upstream1] * streamOrder[1] +  dNode [upstream2] * streamOrder[2] / streamOrder[1] 
#+ streamOrder[2] + 0.1     0.1 weil Nährstoffe und Pestizide akkumulieren
#+ 
#+ 
#+ 
#+ #create upstreamnodes vector for each node
#+ 
#+ 
#+ table with 8 rows since maxium of directions that can be upward nodes
stream_net$upStreamNodes <- matrix(0, nrow = length(stream_net$downNode), ncol = 8)



nodenumber <- 1
for(i in stream_net$downNode){
  if(i != 0){
    for(j in 1:8){
      if(stream_net$upStreamNodes[i,j] == 0){
        stream_net$upStreamNodes[i,j] <- nodenumber
        break
      }
      
    }
  }
  nodenumber <- nodenumber + 1
}

stream_net$upStreamNodes


# clean up and create names for the parameters used, see if parameters work as variables

parameters <- c()
state <- c(1:10)
a <- c()
for(i in 1:10){
  a[i] <- paste("X", i, sep = "")
  
}
names(state) = a

ODE_test<-function(t, state, parameters) {
  with(as.list(c(state, parameters)),{
    # rate of change
    a <- list(c())
    for(i in 1:10){
      assign(paste("dX", i, sep = ""), X1/25 * i)
      a[[1]][i] <- get(paste("dX", i, sep =""))
    }
    # return the rate of change
    a
  }) # end with(as.list ...
}


times <- seq(0, 100, by = 0.01)

out <- ode(y = state, times = times, func = ODE_test, parms = parameters)
head(out)


par(oma = c(0, 0, 3, 0))
plot(out, xlab = "time", ylab = "-")
plot(out[, "X1"], out[, "X3"], pch = ".")
mtext(outer = TRUE, side = 3, "Lorenz model", cex = 1.5)

  