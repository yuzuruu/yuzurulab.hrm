


library(tidyverse)
readxl::read_excel(path = "SSDSEa.xlsx")

iris

install.packages('openxlsx')
library(openxlsx)


read.xlsx("SSDSEa.xlsx") -> hoge
dplyr::slice(hoge,-1) -> hoge

readxl::read_xlsx("SSDSEa.xlsx", 
                  sheet = "SSDSEa",
                  col_names = TRUE ) ->hoge 

dplyr::select(hoge,ct,yn,traf,A1101) -> piyo

install.packages('GGally')

cor(hoge[,c(5,6,11,12)])
hoge

ggplot(data = piyo) +
  geom_point(mapping = aes(x = ct, y = traf))

library(ggplot2)
library(GGally)

ggpairs(piyo)
