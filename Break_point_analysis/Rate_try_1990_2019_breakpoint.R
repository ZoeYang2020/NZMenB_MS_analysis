library(strucchange)
library(ggplot2)
#library(datasets)
setwd('/home/zyang/NGS/active/IPL/MENINGO/analysis/HRC/zoe/AllNZMemB_2021/Break_point_analysis')
Rate <- read.csv(file = './1990_2019_disease_rate.csv')
Rate

d1 <- ts(Rate$Rate, start=c(1990), end=c(2019), frequency = 1)
d1
plot(d1)

## F statistics indicate one breakpoint

fs_rate <- Fstats(d1 ~ 1)
plot(fs_rate)
breakpoints(fs_rate)
lines(breakpoints(fs_rate))
#ggsave("One_break_point_by_Ftest.png", ftest_one_break, width=8, height=3, dpi=600)

## or
bp.rate <- breakpoints(d1 ~ 1)
summary(bp.rate)


## the BIC chooses two breakpoints
plot(bp.rate)
breakpoints(bp.rate)


## fit null hypothesis model and model with two breakpoint
fm0 <- lm(d1 ~ 1)
fm1 <- lm(d1 ~ breakfactor(bp.rate, breaks = 1))
plot(Rate)
lines(ts(fitted(fm0), start = 1990), col = 3)
lines(ts(fitted(fm1), start = 1990), col = 4)
lines(bp.rate)

## confidence interval
ci.rate <- confint(bp.rate)
ci.rate
lines(ci.rate)


