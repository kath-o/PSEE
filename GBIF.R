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

#for all unique species names, we will check them against the GBIF backbone taxonomy, and keep the accepted species name if possible
##prepare progress bar – this is just to see how far we are in the loop. This is useful for large databases
pb <- txtProgressBar(min=0, max=n_spp, initial=0,style = 3)

for(i in 1:n_spp){
  toto <- name_backbone(spp[i],verbose=T,strict=T) 
  if(length(which(names(toto)=="acceptedUsageKey"))==1){ 
    toto <- toto[,-which(names(toto)=="acceptedUsageKey")]
  }
  if(ncol(toto)==ncol(spp.check.ok)){
    if(length(which(toto$status=="ACCEPTED"))>0){ 
      spp.check.ok <- rbind(spp.check.ok,toto[which(toto$status=="ACCEPTED"),]) 
    }else if(length(which(toto$status=="SYNONYM"))>0){ 
      warning(paste("Species",spp[i],"is a synonmy")) 
      spp.check.ok <- rbind(spp.check.ok,toto[which(toto$status=="SYNONYM")[1],]) 
    }else if(length(which(toto$status=="DOUBTFUL"))>0){ 
      warning(paste("Species",spp[i],"is doubtful"))
      spp.check.ok <- rbind(spp.check.ok,toto[which(toto$status=="DOUBTFUL")[1],]) 
    }else{
      stop("Status unknown") 
    }   
  }else if(ncol(toto)==ncol(spp.check.bad)){
    spp.check.bad <- rbind(spp.check.bad,toto)
  }
  else{
    stop("Unknown length") 
  }
  info <- sprintf("%d%% done", round((i/n_spp)*100))
  setTxtProgressBar(pb, i, label=info)
}
close(pb)

#now want to examine our output
#we will check if we have the same species appearing more than once: that would indicate that synonym were used in the database

