#installing and loading rgbif R package 

install.packages("rgbif")
library(rgbif)

#downloaded PaciFlora data 
setwd("~/Desktop/MSc EEB/WD/PSEE/data")

#loading data into a variable named dat.messy 
dat.messy <- read.csv("PaciFlora/Species_list_full_2905.csv",sep=";")

#this data frame contains data on species presence in Pacific islands
#the same species will then appear multiple times
#we will start by setting a list of unique species names
spp <- unique(dat.messy$species)
spp <- spp[-which(is.na(spp))] ##remove na data
spp <- spp[1:200] ##we will only use the 200 first species to be quicker
n_spp <- length(spp) ##the number of species. Here it is obviously 200, but in practice you may not know.
