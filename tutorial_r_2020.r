#############################################################################
# Codes for R tutorial FY2020
# First build: 12th. May 2020
# by Yuzuru Utsunomiya, Ph. D.

# ---- load.library ----
library(tidyverse)
library(jpndistrict)
library(sf)
library(mapview)

# ---- obtain.jpn.map ----
# # read the SSDSE data (Time-series data set by prefecture)
# ssdse.2020.b <- 
#   readxl::read_excel(
#     "SSDSE-2020B.xlsx",
#     sheet = "SSDSE-2020B" # If necessary, add argument range()
#   ) %>% 
#   dplyr::mutate(
#     # pick up certain parts from prefectures' code
#     code.prefecture = as.character(stringr::str_sub(.$Code, 2, 3))
#   ) %>% 
#   dplyr::slice(-1,-2)%>% # remove columns' name
#   dplyr::select(
#     Year,
#     Code, 
#     code.prefecture, # Prefectures' codes to use jpn_pref() function
#     Prefecture, 
#     everything()
#     ) %>% 
#   # omit data of year 2017. There is no data of Hokkaido in this year
#   filter(Year != 2017) 
# 
# # function obtaining map information by prefecture
# jpnPrefFun <- function(code.prefecture){
#   jpndistrict::jpn_pref(
#     code.prefecture, 
#     district = FALSE
#     )
# }
# 
# Obtain map information by prefecture
# WARNING!!
# Above needs very long omputation periods.
# (Approx. 15 minutes)
# 
# Comment out below when not in use
# jpn.pref.47.2006.2016 <- 
#   ssdse.2020.b %>% 
#   dplyr::mutate(
#     pref.map = map(
#       .$code.prefecture, 
#       jpnPrefFun
#       )
#     ) 

# omit list form for convenient use
# DO NOT connect codes above by using %>%.
# do.call() function often raise malfunction 
# when we use the %>% 
# Regarding use of do.call(), refer to the following page
# https://gis.stackexchange.com/questions/251641/how-to-combine-sfc-objects-from-r-package-sf
# jpn.pref.47.pref.map <- 
#   do.call(
#     rbind,
#     jpn.pref.47.2006.2016$pref.map
#     ) 
# # combine the original data set and geometric
# # information
# jpn.pref.47.2006.2016.01 <- 
#   dplyr::bind_cols(
#     jpn.pref.47.pref.map,
#     jpn.pref.47.2006.2016
#     ) %>% 
#   dplyr::select(!pref.map)
# 
# save the data set with geometric data
# to save computation period
# When in use, read the data again by using
# readRDS() function.
# saveRDS(jpn.pref.47.2006.2016.01, "jpn.pref.47.2006.2016.01.rds")
# read the RDS file
# Note
# When in use, transform data type in advance. 
jpn.pref.47.2006.2016.01 <- readRDS("jpn.pref.47.2006.2016.01.rds")

jpn.pref.47.2006.2016.01.2016 <- 
  jpn.pref.47.2006.2016.01 %>% 
  filter(Year == 2016)

sample.jpn.map <- 
  jpn.pref.47.2006.2016.01.2016 %>% 
  ggplot(aes(fill = as.numeric(A1101))) +
  geom_sf() +
  scale_fill_viridis_c(
    begin = 1,
    end = 0,
    option = "plasma"
    ) +
  labs(
    x = "Longitude", 
    y = "Latitude", 
    fill = "Population", 
    subtitle = "Population by prefecture (Year 2016)"
    ) +
  theme_classic() +
  theme(
    legend.position = c(0.85, 0.25)
    )
#
## 
### --- END ---

