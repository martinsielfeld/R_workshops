#########################
### Amount of workers ###
#########################

## One year ago:
a <- data01[date == as.Date(paste0(params$year,'-',params$month,'-01'))]$Total ## This year
b <- data01[date == as.Date(paste0(params$year-1,'-',params$month,'-01'))]$Total ## Last year
ab <- ifelse(a > b,'more','less')

## Last trimester:
c <- data01[date == as.Date(paste0(params$year,'-',params$month,'-01')) %m+% months(-1)] 
cy <- year(c$date)
cm <- month(c$date)
c <- c$Total
ac <- ifelse(a > c,'more','less')

#############
### Rates ###
#############

## Unemplyment rate
d <- data04$D[5]/(data04$B[5]+data04$D[5]) ## This trimester
e <- data04$C[5]/(data04$A[5]+data04$C[5]) ## Last year
de <- ifelse(d > e,'more','less')

f <- (data04$B[5]+data04$D[5])/(data04$B[5]+data04$D[5]+data04$`F`[5]) ## This trimester
g <- (data04$A[5]+data04$C[5])/(data04$A[5]+data04$C[5]+data04$E[5]) ## Last year
fg <- ifelse(f > g,'more','less')
