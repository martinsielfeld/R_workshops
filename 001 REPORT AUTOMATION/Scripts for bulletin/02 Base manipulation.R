## Limpiamos todo:
options(scipen=999)

## Creamos objetos para graficos base:
Table01 <- NULL

## For loop:
mes <- c(paste0('0',1:9),paste0(10:12))
trim <- c("DEF","EFM","FMA","MAM","AMJ","MJJ","JJA","JAS","ASO","SON","OND","NDE")
region <- c('Tarapaca Region','Antofagasta Region','Atacama Region','Coquimbo Region',
            'Valparaiso Region',"O'Higgins Region",'Maule Region','Bio Bio Region',
            'La Araucania Region','Los Lagos Region','Aysen Region',
            'Magallanes Region','Metropolitan Region','Los Rios Region',
            'Arica y Parinacota Region','Nuble Region','National')

## Loop for collapsing data:
for(i in 2019:params$year){
  for(j in 1:12){
    if (as.Date(paste0(params$year,'-',params$month,'-01')) < as.Date(paste0(i,'-',j,'-01'))){
      break
    }
    print(paste0('We are in: ',i," ",trim[j]))
    base <- fread(paste0('Labor data/',i,'/ene-',i,'-',mes[j],'.csv'),stringsAsFactors = F)
    
    b1 <- base[edad >= 15, .(Total = sum(fact_cal,na.rm = T)), 
               by=.(ano_trimestre,mes_central,region,edad,cae_general)]
    Table01 <- rbind(Table01,b1)
    
    rm(base,b1)
  }
}
