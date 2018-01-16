### Week 4 Quiz worksheet ###

# *** Question 1 ***
library(stringr)
file = "./data/ACSIdaho2006.csv"
data = fread(file)
strsplit(names(data),"wgtp")[123]

# *** Question 2 ***
file = "./data/FGDP.csv"
data = fread(file,skip = 5,header = FALSE,na.strings = c(""," ","NA"))
head(data,1)
mean(as.numeric(gsub(",","",data$V5[1:190])),na.rm = TRUE)

# *** Question 3 ***
data$V4[grep("^United",data$V4)]

# *** Question 4 ***
# -- Borrowing merged data.table from Week 3 quiz
which(merged == "YE", arr.ind = TRUE) # Search an entire data frame but no regex
merged.df <- as.data.frame(merged)
fiscal.mentions <- sapply(colnames(merged.df),function(x){ y<-grep("(([Ff]iscal(.*)end(.*)[Jj]une(.*))|([Ee]nd(.*)[Ff]iscal(.*)[Jj]une(.*)))",merged.df[,x])} ) #-- errors out with data table
fiscal.mentions <- fiscal.mentions[sapply(fiscal.mentions,length)>0]
length(unlist(sapply(names(fiscal.mentions),function(x){merged.df[,x][fiscal.mentions[[x]]]})))

# *** Question 5 ***
install.packages("quantmod")
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)
head(sampleTimes); class(sampleTimes)

install.packages("lubridate")
library(lubridate)

length(sampleTimes[year(sampleTimes)==2012])
length(sampleTimes[year(sampleTimes)==2012 & wday(sampleTimes,label = TRUE)=="Mon"])
