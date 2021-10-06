##################################
### Plot 01: number of workers ###
##################################

if(region[params$reg] != 'National'){
  data01 <- Table01[cae_general %in% c(1:3) & region == params$reg,.(Total=sum(Total,na.rm=T)),
                    by=.(ano_trimestre,mes_central)]
} else {
  data01 <- Table01[cae_general %in% c(1:3),.(Total=sum(Total,na.rm=T)),
                    by=.(ano_trimestre,mes_central)] 
}

data01[,trimester := factor(mes_central,levels = 1:12, labels = trim)]
data01[,date := as.Date(paste0(ano_trimestre,'-',mes_central,'-01'))]

Plot01 <-
ggplot(data01,aes(x=trimester,y=Total,group=factor(ano_trimestre),color=factor(ano_trimestre))) +
  geom_line() +
  geom_point() +
  theme_minimal() +
  labs(x=NULL,y=NULL,color=NULL) +
  theme(legend.position = 'bottom') +
  scale_y_continuous(labels = number_format(scale = 0.001,suffix = 'K'))
