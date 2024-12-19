# Шипилова С.С. ДВ 21-24
# Шипилова С.С. для района Южное Бутово докажите что высота родов Вяз и Дуб значимо отличаются
getwd()
setwd("C:/MODINF1")
library(readr)
library(dplyr)
#очистим полностью память 
rm(list=ls())
greendb= read.csv("greendb.csv")
greendb
# для района Южное Бутово докажите что высота родов Вяз и Дуб круглолистная значимо отличаются
spec=greendb$species_ru
spec
#род
genus=stringr::str_split(spec, pattern=" ",simplify=T)[,1]
genus
data=greendb%>%mutate(Genus=genus)
data

data=data%>%filter(Genus%in% c("Вяз","Дуб")) %>%
  filter(adm_region=="район Южное Бутово")


greendb$Genus%>%unique()
greendb$adm_region%>%unique()
#ДА. ЕСЛИ ОТВЕРГАЕМ Но, ТО ЗНАЧИМО ОТЛИЧАЮТСЯ
data.aov=aov(height_m~Genus, data=data)
summary(data.aov)
# нет значимых различий между высотами.т.к. p>0,05 принимаем Но



