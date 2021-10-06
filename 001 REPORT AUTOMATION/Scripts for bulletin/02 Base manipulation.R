## Limpiamos todo:
options(scipen=999)

## Creamos objetos para graficos base:
Table01 <- NULL
Table02 <- NULL

## For loop:
mes <- c(paste0('0',1:9),paste0(10:12))
trim <- c("DEF","EFM","FMA","MAM","AMJ","MJJ","JJA","JAS","ASO","SON","OND","NDE")
region <- c('Tarapacá Region','Antofagasta Region','Atacama Region','Coquimbo Region',
            'Valparaíso Region',"O'Higgins Region",'Maule Region','Bío Bío Region',
            'La Araucanía Region','Los Lagos Region','Aysén Region',
            'Magallanes Region','Metropolitan Region','Los Ríos Region',
            'Arica y Parinacota Region','Ñuble Region','National')

## Loop for collapsing data:
for(i in 2019:params$year){
  for(j in 1:12){
    if (as.Date(paste0(params$year,'-',params$month,'-01')) < as.Date(paste0(i,'-',j,'-01'))){
      break
    }
    print(paste0('We are in: ',i," ",trim[j]))
    base <- fread(paste0('Labor data/',i,'/ene-',i,'-',mes[j],'.csv'),stringsAsFactors = F)
    
    b1 <- base[edad >= 15, .(Total = sum(fact_cal,na.rm = T)), 
               by=.(ano_trimestre,mes_central,region,cae_general)]
    Table01 <- rbind(Table01,b1)

    b5 <- base[edad >= 15, .(Total = sum(fact_cal,na.rm = T)),
               by=.(ano_trimestre,mes_central,region,edad,cae_general)]
    Table02 <- rbind(Table02,b5)

    rm(base,b1,b5)
  }
}
