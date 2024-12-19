#ЗАДАНИЕ 2
# Шипилова С.С. ДВ 21-24
#постройте картосхему максимальных высот стволов деревьев родов Вяз и Дуб 
# install.packages("sf")
library(sf)
library(ggplot2)
library(readr)
library(dplyr)
#очистим полностью память 
rm(list=ls())
#считаем данные в переменные
greendb= read.csv("greendb.csv"); greendb
map=sf :: read_sf("moscow.geojson")
# график с заливкой
ggplot(map)+geom_sf(aes(fill=NAME))+theme(legend.position="none")
# Вяз и Дуб
spec=greendb$species_ru
spec
genus=stringr::str_split(spec, pattern=" ",simplify=T)[,1]
genus
data=greendb%>%mutate(Genus=genus)
data

max_height=data %>% group_by(adm_region,Genus)%>% 
  summarise(max_h=max(height_m), na.rm = T)%>% 
  filter(Genus %in% c("Вяз","Дуб"))
max_height

# install.packages("tidyr")
library(tidyr)
max_height=pivot_wider(max_height,names_from = Genus, values_from = max_h)

map=map %>% mutate(adm_region=NAME)
map=left_join(map, max_height, by="adm_region")

ggplot(map)+
  geom_sf(aes(fill=`Вяз`))+theme()

ggplot(map)+
  geom_sf(aes(fill=`Дуб`))+theme()
