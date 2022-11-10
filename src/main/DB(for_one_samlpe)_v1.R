#clear data
rm(list=ls())
library("clv")
#read .txt into matrix
directory<-"/Users/Tomy_Chan/Documents/OneDrive - HKUST Connect/Yr4/Spring/MATH4983F/MATH4983F/Code/Code_for_ORL/Clustering_ORL/v2/test1/calculation_ans/R"
New_no_match_file<-file.path(directory,"New_no_match_v2_test1_1.txt")
New_no_match<-scan(file=New_no_match_file,sep = ",")
New_no_match<-matrix(New_no_match, nrow = 100, ncol = 100, dimnames = NULL)
#New_no_match<-read.table(file=New_no_match_file,header = FALSE,sep = ",")

clust_file<-file.path(directory,"clust_v2_test1_1.txt")
#clust<-read.table(file=clust_file,header = FALSE,sep = ",")
clust<-scan(file=clust_file, sep = ",")
clust1<-matrix(clust, nrow = 100, ncol = 100, byrow = TRUE, dimnames = NULL)
#clust1<-matrix(clust, nrow = 100, ncol = 100, byrow = FALSE, dimnames = NULL)
clust<-as.integer(clust1)

#DB
DB1<-matrix(0, 1, 99)
intraclust = c("complete","average","centroid")
interclust = c("single", "complete", "average","centroid", "aveToCent", "hausdorff")
for (i in 2:100) {
  n = i
  k = 100
  a = (n-1)*k+1
  b = n*100
  cls.scatt1<-cls.scatt.data(New_no_match, clust[a:b], dist="manhattan")
  DB<-clv.Davies.Bouldin(cls.scatt1,intraclust, interclust)
  DB1[,n-1]<-DB[1,1]
}