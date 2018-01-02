### Week 1 Quiz Worksheet ###

#-- Questions 1, 2 & 5 --
if(!file.exists("./data"))
  dir.create("./data")

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv","./data/ACSIdaho2006.csv")
#** Codebook for this file is located here: https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf
df <- read.csv("./data/ACSIdaho2006.csv")
colnames(df)
dfvals <- df[df$VAL==24,"VAL"]
length(dfvals[!is.na(dfvals)])
#** for question 5RT
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv","./data/ACSIdaho2006P.csv")
library(data.table)
dt <- fread("./data/ACSIdaho2006P.csv")
system.time(m1 <- mean(dt$pwgtp15,by=dt$SEX))
system.time({ m2_1 <- rowMeans(dt)[dt$SEX==1]; m2_2 <- rowMeans(dt)[dt$SEX==2] })
system.time(m3 <- sapply(split(dt$pwgtp15,dt$SEX),mean))
system.time(m4 <- dt[,mean(pwgtp15),by=SEX])
system.time({ m5_1 <- mean(dt[dt$SEX==1,]$pwgtp15); m5_2 <- mean(dt[dt$SEX==2,]$pwgtp15) })
system.time(m6 <- tapply(dt$pwgtp15,dt$SEX,mean))


#-- Question 3 --
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx","./data/NGAP.xlsx", mode="wb")
#** Original data source: http://catalog.data.gov/dataset/natural-gas-acquisition-program
library(xlsx) #** Install Java if you hit JAVA_HOME error
head(xldf)
sum(xldf$Zip*xldf$Ext, na.rm = TRUE)

#-- Question 4 --
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml","./data/BWIRestaurants.xml", mode = "wb")
library(XML)
xmldf1 <- xmlTreeParse("./data/BWIRestaurants.xml", useInternalNodes = TRUE)
rootNode <- xmlRoot(xmldf1)
zips <- xpathSApply(rootNode,"//zipcode",xmlValue)
names <- xpathSApply(rootNode,"//name",xmlValue)
xmldf2 <- data.frame(name = names, zipcode = zips)
nrow(xmldf2[xmldf2$zipcode==21231,])