library(ggplot2)
library(ggbrace)

a <- data.frame(Time=c(0:4,4:8,8:16),
                Effort=c(16,11,9,8,7.5,12,8,6,5,4.5,9,5,3.5,2.75,2.25,2,1.75,1.6,1.5))
b <- data.frame(Time=c(4:16),
                Effort=c(7.5,7+0.5/2,7+0.5/3,7+0.5/4,7+0.5/5,7+0.5/6,7+0.5/7,
                         7+0.5/8,7+0.5/9,7+0.5/10,7+0.5/11,7+0.5/12,7+0.5/13))
c <- data.frame(Time=c(8:16),
                Effort=c(4.5,4+0.5/2,4+0.5/3,4+0.5/4,4+0.5/5,4+0.5/6,4+0.5/7,
                         4+0.5/8,4+0.5/9))


ggplot() +
  geom_line(b,mapping=aes(x=Time,y=Effort),linetype='dashed') +
  geom_line(c,mapping=aes(x=Time,y=Effort),linetype='dashed') +
  geom_line(a,mapping=aes(x=Time,y=Effort),size=1) +
  geom_point(a,mapping=aes(x=Time,y=Effort),color='red',size=2) +
  geom_brace(aes(x=c(16.5,17.5), y=c(1.5,7+0.5/13),label='holi'),inherit.data=FALSE,
             rotate = 90) +
  geom_brace(aes(x=c(16.25,16.75), y=c(1.5,4+0.5/9)),inherit.data=FALSE,
             rotate = 90) +
  theme_classic() +
  geom_text(a,mapping=aes(x=0.9,y=16,label='Start')) +
  geom_text(a,mapping=aes(x=5.5,y=12,label='Reboot')) +
  geom_text(a,mapping=aes(x=9.5,y=09,label='Fixing\nissues')) +
  geom_text(a,mapping=aes(x=19,y=1.5+(7+0.5/13-1.5)/2,label='Long term\nbenefits')) +
  scale_x_continuous(breaks = seq(0, 16, by = 1)) +
  scale_y_continuous(breaks = seq(0, 16, by = 1)) +
  coord_cartesian(ylim=c(0,16),xlim=c(0,20)) 
  
