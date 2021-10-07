##################################
### Plot 01: number of workers ###
##################################

{
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
}

###########################################################
### Table 01: Employed, Unemployed and Inactive workers ###
###########################################################

{
Table01[edad %in% c(15:29), Age := "15 - 29"]
Table01[edad %in% c(30:44), Age := "30 - 44"]
Table01[edad %in% c(45:59), Age := "45 - 59"]
Table01[edad >= 60, Age := "60 or more"]

Table01[cae_general %in% c(1:3), cae_general_red := 'Employed']
Table01[cae_general %in% c(4:5), cae_general_red := 'Unemployed']
Table01[cae_general %in% c(6:9), cae_general_red := 'Inactive']

if(region[params$reg] != 'National'){
  data02 <- Table01[region == params$reg & !is.na(Age) & mes_central == params$month &
                    ano_trimestre >= params$year-1,.(Total=sum(Total,na.rm=T)),
                    by=.(ano_trimestre,Age,cae_general_red)]
  data03 <- Table01[region == params$reg & !is.na(Age) & mes_central == params$month &
                    ano_trimestre >= params$year-1,.(Total=sum(Total,na.rm=T)),
                    by=.(ano_trimestre,cae_general_red)]
} else {
  data02 <- Table01[!is.na(Age) & mes_central == params$month & ano_trimestre >= params$year-1,
                    .(Total=sum(Total,na.rm=T)),by=.(ano_trimestre,Age,cae_general_red)]
  data03 <- Table01[!is.na(Age) & mes_central == params$month &ano_trimestre >= params$year-1,
                    .(Total=sum(Total,na.rm=T)),by=.(ano_trimestre,cae_general_red)] 
}

data02[,cae_general_red := factor(cae_general_red,levels = c('Employed','Unemployed','Inactive'))]
data03[,cae_general_red := factor(cae_general_red,levels = c('Employed','Unemployed','Inactive'))]

data02 <- dcast.data.table(data02,Age ~ cae_general_red + ano_trimestre, value.var = 'Total',fill=0)
data03 <- dcast.data.table(data03,''~ cae_general_red + ano_trimestre, value.var = 'Total')[,2:7]

data04 <- rbind(data02,data03,fill=T)
data04[is.na(Age), Age := 'Overall']
names(data04)[2:7] <- c('A','B','C','D','E','F')

flextable01 <-
flextable(data04) %>% 
  add_header_lines() %>%
  add_header_row(values = c(" ",rep("Employed",2),rep("Unemployed",2),rep("Inactive",2))) %>%
  merge_at(i = 1, j = 2:3, part = "header") %>% 
  merge_at(i = 1, j = 4:5, part = "header") %>% 
  merge_at(i = 1, j = 6:7, part = "header") %>%
  set_header_labels(A = paste(trim[params$month],params$year-1,sep = "-"), 
                    B = paste(trim[params$month],params$year,sep = "-"),
                    C = paste(trim[params$month],params$year-1,sep = "-"),
                    D = paste(trim[params$month],params$year,sep = "-"), 
                    E = paste(trim[params$month],params$year-1,sep = "-"), 
                    `F` = paste(trim[params$month],params$year,sep = "-")) %>%
  bold(part = "header") %>%
  bold(part = "body", j = 1) %>%
  bg(bg = "#00A297", part = "header", i = 2) %>%
  bg(bg = "grey95", part = "body", i = c(2,4)) %>%
  color(color = "white", part = "header", i = 2) %>%
  fontsize(size = 7, part = "all") %>%
  align(align = "center", part = "header", i = 1) %>%
  align(align = "center", part = "header", i = 2, j = 2:7) %>%
  align(align = "right", part = "body", j = 2:7) %>%
  colformat_num(j = c(2:7), i = c(1:5),big.mark="," ,digits = 0) %>%
  border_remove() %>%
  vline(part = "body", border = fp_border(color="grey85"), j = c(1,3,5)) %>%
  autofit() %>%
  width(width = 1.25, j = 1)
}