### Week 3 Quiz worksheet ###

## *** Question 1 ***
# -- Data is alredy downloaded for a previous quiz
library(data.table)
file = "./data/ACSIdaho2006.csv"
data = fread(file, stringsAsFactors = FALSE)
agricultureLocal = data$ACR==3 & data$AGS==6
which(agricultureLocal)

## *** Question 2 ***
install.packages("jpeg")
library(jpeg)
file = "./data/DrJeff.jpg"
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg",file,mode = "wb")
img.n <- readJPEG(file,native = TRUE)
quantile(img.n,c(0.3,0.8,1))

## *** Question 3 ***
library(data.table)
fileGDP = "./data/FGDP.csv"
fileEDU = "./data/FEDSTATS_Country.csv"
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv",fileGDP,mode = "wb")
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv",fileEDU,mode = "wb")
dataGDP = fread(fileGDP,stringsAsFactors = FALSE,header = FALSE,skip = 5,na.strings = c(""," ","NA"))
dataEDU = fread(fileEDU,stringsAsFactors = FALSE,na.strings = c(""," ","NA"))
colnames(dataGDP); colnames(dataEDU)
head(dataGDP);head(dataEDU)
dim(dataGDP);dim(dataEDU)
dataGDP$V2 <- as.numeric(dataGDP$V2)
merged <- merge(dataGDP,dataEDU,by.x = "V1",by.y = "CountryCode",all.x = FALSE,all.y = FALSE,suffixes = c(".GDP",".EDU"))
dim(merged);head(merged,1)
sorted <- merged[order(V2, decreasing = TRUE),]
dim(sorted[which(!is.na(sorted$V2))]);sorted[13,c("V4")]

## *** Question 4 ***
tapply(merged$V2,merged$`Income Group`,mean,na.rm = TRUE)

## *** Question 5 ***
merged$ranking.q <- cut(merged$V2,breaks = quantile(merged$V2,probs=seq(0,1,0.20),na.rm = TRUE))
table(merged$ranking.q,merged$`Income Group`,useNA = "ifany")
max(unlist(merged$V2[!is.na(merged$V2)]))
sorted[which(!is.na(sorted$V2)),]$seq <- seq(190,2,-1)
sorted[which(!is.na(sorted$V2) & between(sorted$V2,129,133)),c("V1","V2","V4","seq"),]
fsetdiff(sorted$V2,sorted$seq)