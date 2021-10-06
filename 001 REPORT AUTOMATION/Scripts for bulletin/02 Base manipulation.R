## Limpiamos todo:
options(scipen=999)

## Creamos objetos para graficos base:
Table01 <- NULL
Table02 <- NULL

## For loop:
mes <- c(paste0('0',1:9),paste0(10:12))
trim <- c("DEF","EFM","FMA","MAM","AMJ","MJJ","JJA","JAS","ASO","SON","OND","NDE")

## Loop for collapsing data:
for(i in 2019:params$year){
  for(j in 1:12){
    if (as.Date(paste0(params$year,'-',params$month,'-01')) < as.Date(paste0(i,'-',j,'-01'))){
      break
    }
    print(paste0('We are in: ',i," ",trim[j]))
    ## Cargamos bases:
    base <- fread(paste0('Labor data/',i,'/ene-',i,'-',mes[j],'.csv'))
    ## Colapsamos base para graficos 01, 02 y 03:
    b1 <- base[edad >= 15, .(Total = sum(fact_cal,na.rm = T)), 
               by=.(ano_trimestre,mes_central,region,cae_general,cae_especifico)]
    Table01 <- rbind(Table01,b1)
    ## Colapsamos base para tabla 02:
    b5 <- base[edad >= 15, .(Total = sum(fact_cal,na.rm = T)),
               by=.(ano_trimestre,mes_central,region,edad,cae_general)]
    Table02 <- rbind(Table02,b5)
    ## Eliminamos objetos inecesrios:
    rm(base,b1,b5)
  }
}
