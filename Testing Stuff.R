library(ggplot2);
library(deSolve);
library(simecol);
library(OCNet);

setwd("C:/Users/elsae/Documents/R_Model");

#generisches setup für Länge Anzahl der Connections ...

set.seed(3)
OCN <- create_OCN(30, 20, outletPos = 1)
OCN <- aggregate_OCN(landscape_OCN(OCN), thrA = 0, streamOrderType = "Shreve")
#par(mfrow = c(1, 3), mai = c(0, 0, 0.2, 0.2))


draw_simple_OCN(OCN)
title("Optimal Channel Network")
#draw_elev3D_OCN(OCN, drawRiver = FALSE, addColorbar = FALSE, expand = 0.2, theta = -30)
#title("Elevation")
#draw_thematic_OCN(OCN$AG$streamOrder, OCN, discreteLevels = TRUE, colPalette = rainbow(4))
#title("Strahler stream order");


# nur number of streams für Wassergehalt oder auch Länge?

# linerae Abhänigkeit zwischen ANzahl an primären Nodes die zum Stream führen und Belastung / Nährstoffe

#OCN$FD$downNode für Anzahl der Downstream nodes für jeden node; upnodes wäre besser 
#-> an jedem Punk n upnodes = Belastung / Nährstoffe ACHTUNG nicht alle upstream nodes = Primäre nodes


#OCN$FD$W[,1] gibt Interaktionen von Node 1






# Function für source nodes in FD



#OCN$FD$A  = Menge an Wasser
# kombinieren mit 2. Tabelle die anzeigt welches [] von diesem Node befüllt wird
#kombinieren mit 3. Tabelle die Anzahl der primären Zuläufe angibt  (PRIMÄR ODER GESAMT????)


set.seed(6)
OCN <- create_OCN(30, 20, outletPos = 1)
OCN <- aggregate_OCN(landscape_OCN(OCN), thrA = 0, streamOrderType = "Shreve")
draw_simple_OCN(OCN)

set.seed(6)
OCN <- create_OCN(30, 20, outletPos = 1)
OCN <- aggregate_OCN(landscape_OCN(OCN), thrA = 0, streamOrderType = "Strahler")
draw_simple_OCN(OCN)





# library(ggplot2);
# library(deSolve);
# library(simecol);
# library(OCNet);
# 
# setwd("C:/Users/elsae/Documents/R_Model");
# 
# parameters <- c(a = -8/3,
#                 b = -10,
#                 c = 28)
# 
# state <- c(X1 = 1,
#            X2 = 1,
#            X3 = 1)
# 
# Lorenz<-function(t, state, parameters) {
#   with(as.list(c(state, parameters)),{
#     # rate of change
#     dX1 <- a*X1 + X2*X3
#     dX2 <- b * (X2-X3)
#     dX3 <- -X1*X2 + c*X2 - X3
#     
#     # return the rate of change
#     list(c(dX1, dX2, dX3))
#   }) # end with(as.list ...
# }
# 
# times <- seq(0, 100, by = 0.01)
# 
# out <- ode(y = state, times = times, func = Lorenz, parms = parameters)
# head(out)
# 
# 
# par(oma = c(0, 0, 3, 0))
# plot(out, xlab = "time", ylab = "-")
# plot(out[, "X1"], out[, "X3"], pch = ".")
# mtext(outer = TRUE, side = 3, "Lorenz model", cex = 1.5)


