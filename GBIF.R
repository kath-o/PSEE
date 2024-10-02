#installing and loading rgbif R package 

install.packages("rgbif")
library(rgbif)

#downloaded PaciFlora data 
setwd("~/Desktop/MSc EEB/WD/PSEE/data")

#loading data into a variable named dat.messy 
dat.messy <- read.csv("PaciFlora/Species_list_full_2905.csv",sep=";")
