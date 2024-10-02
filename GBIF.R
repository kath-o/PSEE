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

#we can compare a species name to the GBIF backbone taxonomy using function name_backbone()
#name_backbone() will generate a data frame
#initialize our data frames
spp.check.ok <- name_backbone("Felis catus",verbose=T,strict=T) ##we initialize a data frame for a species that we are sure is in the backbone taxonomy: the cat.
spp.check.ok <- spp.check.ok[-1,] ##we remove this row
spp.check.bad <- name_backbone("xxx",verbose=T,strict=T) ##we initialize a data frame for a word that is not a species name.
spp.check.bad <- spp.check.bad[-1,] ##we remove this row


