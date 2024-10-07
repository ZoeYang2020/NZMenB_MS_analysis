#install.packages("strucchange")
library(strucchange)
setwd("/home/zyang/NGS/active/IPL/MENINGO/analysis/HRC/zoe/AllNZMemB_2021/Break_point_analysis")
Case_Rate <- read.csv(file = '1990_2019_disease_rate.csv')
head(Case_Rate)
bp.rate <- breakpoints(Case_Rate ~ 1)
  

library(datasets)
Nile


head(Nile)

data(Nile)
plot(Nile)

Nile

bp.nile <- breakpoints(Nile ~ 1)
bp.nile

fs.nile <- Fstats(Nile ~ 1)
plot(fs.nile)
breakpoints(fs.nile)
lines(breakpoints(fs.nile))


plot(Nile, ylab="Annual Flow of the river Nile")
abline(h= mean(Nile),col='blue')

plot(merge(
   Nile = as.zoo(Nile),
   zoo(mean(Nile), time(Nile)),
   CUSUM = cumsum(Nile - mean(Nile)),
   zoo(0, time(Nile)),
   MOSUM = rollapply(Nile - mean(Nile), 15, sum),
   zoo(0, time(Nile))
   ), screen = c(1, 1, 2, 2, 3, 3), main = "", xlab = "Time",
   col = c(1, 4, 1, 4, 1, 4)
  )


plot(merge(
   Nile = as.zoo(Nile),
   zoo(c(NA, cumsum(head(Nile, -1))/1:99), time(Nile)),
   CUSUM = cumsum(c(0, recresid(lm(Nile ~ 1)))),
   zoo(0, time(Nile))
   ), screen = c(1, 1, 2, 2), main = "", xlab = "Time",
   col = c(1, 4, 1, 4)
   )

ocus.nile <- efp(Nile ~ 1, type = "OLS-CUSUM")
omus.nile <- efp(Nile ~ 1, type = "OLS-MOSUM")
rocus.nile <- efp(Nile ~ 1, type = "Rec-CUSUM")


opar <- par(mfrow=c(2,2))
plot(ocus.nile)
plot(omus.nile)
plot(rocus.nile)
par(opar)


plot(1870 + 5:95, sapply(5:95, function(i) {
   before <- 1:i
   after <- (i+1):100
   res <- c(Nile[before] - mean(Nile[before]), Nile[after] - mean(Nile[after]))
   sum(res^2)
   }), type = "b", xlab = "Time", ylab = "RSS")

bp.nile <- breakpoints(Nile ~ 1)
nile.fac <- breakfactor(bp.nile, breaks = 1 )
fm1.nile <- lm(Nile ~ nile.fac - 1)
plot(bp.nile)

opar <- par(mfrow=c(2,1), mar=c(2,2,0,2))
plot(ocus.nile, alt.boundary=F,main="")
abline(v= 1898, lty=2, col='red')
plot(Nile, ylab="Annual Flow of the river Nile")
abline(h= mean(Nile),col='blue')
abline(v= 1898, lty=2, col='red')
lines(ts(predict(fm1.nile),start=1871,freq=1), col='darkgreen',lwd=2)
par(opar)


