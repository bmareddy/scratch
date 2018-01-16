download.file("https://data.cityofnewyork.us/api/views/43nn-pn8j/rows.csv?accessType=DOWNLOAD","./data/NYCRestInspection_20180114.csv")
data <- read.csv("./data/NYCRestInspection_20180114.csv")
data <- fread("./data/NYCRestInspection_20180114.csv",stringsAsFactors = TRUE)
summary(data)
table(data$DBA,data$ZIPCODE,useNA = "ifany")
colSums(is.na(data))
all(colSums(is.na(data))==0)
data[(data$ZIPCODE %in% c(10003,10010)),2,]
xtabs(!is.na(DBA) ~ BORO+GRADE, data=data)
xtabs(!is.na(DBA) ~ BORO+GRADE+SCORE, data=data)
ftable(xtabs(!is.na(DBA) ~ BORO+GRADE+VIOLATION_CODE, data=data))
colnames(data)[11] <- "VIOLATION_CODE"

## ** Reshaping **
library(reshape2)
dcast()

## ** dplyr **
