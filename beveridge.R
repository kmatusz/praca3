#niemcy beveridge
library(tidyr)
library(readr)
library(dplyr)
library(ggplot2)
setwd("...")
vacancy_niemcy <- read_delim("vacancy niemcy.csv", 
                             ";", escape_double = FALSE, trim_ws = TRUE, 
                             skip = 4)


vacancy_niemcy<-vacancy_niemcy%>%select(-X3)
vacancy_niemcy<-vacancy_niemcy[7:17,]%>%rename(TIME=`last update`)

unemployed <- read_csv("une_rt_a_3_Data.csv")
unemployed<-unemployed%>%select(TIME, Value)

vacancy_niemcy$`03.05.2017 10:51`<-as.integer(vacancy_niemcy$`03.05.2017 10:51`)
vacancy_niemcy$`03.05.2017 10:51`<-vacancy_niemcy$`03.05.2017 10:51`/1000



baza<-left_join(vacancy_niemcy, unemployed, by='TIME')
baza$Value<-as.integer(baza$Value)
baza$`03.05.2017 10:51`<-as.integer(baza$`03.05.2017 10:51`)
ggplot(data=baza, aes(x=Value, y=`03.05.2017 10:51`))+
  geom_point(size=3)+geom_text(aes(label=TIME), vjust=1)+
  scale_y_continuous(labels = scales::comma)+
  labs(x='Ilość bezrobotnych (w tys.)', 
       y="Ilość wakatów (w tys.)", 
       title="Krzywa Beveridge'a dla Niemiec")+
  
  geom_smooth(alpha=0, color='red')+
  theme_classic()


