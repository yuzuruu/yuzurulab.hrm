library(tidyverse)
library(openxlsx)
library(GGally)

# 松井さんが書いたコード
# readxl::read_excel("SSDSEa.xlsx") -> hoge
# dplyr::slice(hoge,-1) -> hoge
# 
# readxl::read_xlsx("SSDSEa.xlsx", 
#                   sheet = "SSDSEa",
#                   col_names = TRUE ) ->hoge 
# 
# dplyr::select(hoge,ct,yn,traf,A1101) -> piyo

# 宇都宮先生が書いたコード
# もともとのExcelファイルにctやynやtrafに相当する変数名を記入すると
# うまく読み込めるはずです。
# なかったのでつけておきました
# データを読み込む
catsle.transportation <-
  readxl::read_xlsx("SSDSEa.xlsx",
                    sheet = "SSDSEa",
                    col_names = TRUE 
                    ) 
# 名前がない変数（列）に名前を与える
names(catsle.transportation)[4] <- c("catsle.name")　#城名
names(catsle.transportation)[5] <- c("ct")　#天守閣有無
names(catsle.transportation)[6] <- c("yn")　#城郭有無
# 使うデータだけ取り出す　
catsle.transportation <- 
  catsle.transportation %>% 
  dplyr::select(ct,yn,tram,A1101) 
# 必要がない行を削除し変数型を変更する
catsle.transportation <- 
  catsle.transportation[-1,] %>% 　# 使わない行を削除
  mutate(ct = as.numeric(ct), 　# 変数型を数値に変更
         total.population = as.numeric(A1101)　# 総人口名称を変更しつつ変数型を数値に変更
         ) %>% 
  dplyr::select(-A1101) %>% # 使わないデータを削除
  tidyr::replace_na(list(ct = 0, yr = 0, tram = 0))　# 空白（NA）を0に変更
# 相関行列と散布図行列を作図
ggpairs(catsle.transportation) +
  theme_classic()


<<<<<<< matsui
library(tidyverse)
=======

#　松井さんが書いたコード
# cor(hoge[,c(5,6,11,12)])
# hoge
# 
# ggplot(data = piyo) +
#   geom_point(mapping = aes(x = ct, y = traf))
# 
# library(ggplot2)
# library(GGally)
# 
# ggpairs(piyo)
>>>>>>> master

