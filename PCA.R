#step to read in dataset, -1 values are set as "Nauto#step to read in dataset, -1 values are set as "NA"
library(ggplot2)
library(grid)
library(gridExtra)
library(ggfortify)

#Change the name of the file depending what species we want to look at
df<-read.delim('DATASETS_FINAL/KAESS/PSI/PSI_lv_KAESS.tab', sep="\t", header=FALSE, na.strings='-1')

#change column names to species number, remove exon count from [1,1] in dataset
names(df)<-c("Exons", "HUM1", "HUM1", "CH", "CH", "MA", "MA", "MI", "MI","MI")

#removes exon names from dataset to prep for converting to matrix
data<-df[-c(1)]
#convert dataset to matrix to run pca

datatran <- t(data)
datatran <- datatran[,-1]
datatran[!is.finite(datatran)] <- 0

#runs PCA on XSAnno dataset in matrix format ignoring fields with missing information
data_pca<-prcomp(na.omit(datatran))
summary(data_pca) 
#Check that PCA ran correctly
View(data_pca)
plot(data_pca)

#This produces the graph we need, from mine I can see clustering by SPECIES, which is what we expect given our assumptions about the data
#we assume that there are at least two diffferent species, and we assume that those individuals belonging to the same species will cluster together
#biplot(data_pca)
autoplot(data_pca,label=TRUE,colour=c('red','red','blue','blue','green','green','purple','purple','purple'),main="KAESS LIVER")


