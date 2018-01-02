## Reading data using MySQL

#-- Install and load RMySQL packages
library(RMySQL)

#-- Connect to University of California Santa Cruz public facing MySQL server
ucscDb <- dbConnect(MySQL(), user="genome",host="genome-mysql.cse.ucsc.edu")
result <- dbGetQuery(ucscDb,"show databases;"); dbDisconnect(ucscDb);

#-- Connect to hg19 db and get all tables
hg19 <- dbConnect(MySQL(), user="genome", db="hg19", host="genome-mysql.cse.ucsc.edu")
allTables <- dbListTables(hg19)
allTables[1:5]
#** Work with a single table
dbListFields(hg19,"affyU133Plus2")
dbGetQuery(hg19,"select count(1) from affyU133Plus2")
affyData <- dbReadTable(hg19,"affyU133Plus2")
head(affyData)
#** Work with subsets of data from a table
query <- dbSendQuery(hg19,"select * from affyU133Plus2 where misMatches between 1 and 3")
affyMis <- fetch(query)
quantile(affyMis$misMatches)
dbGetRowCount(query)
dbGetRowsAffected(query)
affyMisSmall <- fetch(query,n=10)
dbClearResult(query)
dim(affyMisSmall) #-- get # of rows and # of columns

#-- Close the connection
dbDisconnect(hg19)

## Reading data from HDF5

#-- Install packages from bioconductor
source("http://bioconductor.org/biocLite.R")
biocLite("rhdf5")

#-- Create files and file groups
library(rhdf5)
created = h5createFile("./data/example.h5")
h5createGroup("./data/example.h5","foo")
h5createGroup("./data/example.h5","baa")
h5createGroup("./data/example.h5","foo/foobaa")
h5ls("./data/example.h5")

#-- Write data to h5
A = matrix(1:10,5,2)
h5write(A,"./data/example.h5","foo/A")
B = array(seq(0.1,2.0,by=0.1),dim=c(5,2,2))
attr(B,"scale") <- "liter"
h5write(B,"./data/example.h5","foo/foobaa/B")
h5ls("./data/example.h5")
df = data.frame(1L:5L,seq(0,1,length.out = 5),c("ab","cde","fghi","a","s"),stringsAsFactors = FALSE)
h5write(df,"./data/example.h5","df")
h5ls("./data/example.h5")
h5write("Lab","./data/example.h5","title")

#-- Read data from h5
readB = h5read("./data/example.h5","/foo/foobaa/B")
readA = h5read("./data/example.h5","/foo/A")

#-- Write to an existing data object
h5write(c(12,13,14),"./data/example.h5","/foo/A",index=list(1:3,1))
h5read("./data/example.h5","/foo/A")

## Reading data from the web
#-- html page - All members of congess
con = url("https://www.congress.gov/members?q=%7B%22congress%22%3A%22115%22%7D")
htmlCode = readLines(con)
close(con)
htmlCode[1:10] #-- Line 221 contains all members of congress

#-- using xml
library(XML)
htmlX <- htmlTreeParse("https://www.congress.gov/members?q=%7B%22congress%22%3A%22115%22%7D",useInternalNodes = TRUE)
membersX <- htmlTreeParse(htmlCode[221],useInternalNodes = T)
titles <- xpathSApply(membersX,"//option",xmlValue)
titles

#-- using httr package
library(httr)
url = "https://www.congress.gov/members?q=%7B%22congress%22%3A%22115%22%7D"
htmlCode2 = GET(url)
content = content(htmlCode2,as="text")
parsed = htmlParse(content, asText = TRUE)
members = xpathSApply(parsed,"//option",xmlValue)
members

auth = GET("https://github.com/login",authenticate("bmareddy","ydder2@MM"))
names(auth)
authContent = content(auth, as="text")
authParsed = htmlParse(authContent, asText = TRUE)
xpathSApply(authParsed,"//span",xmlValue)

## Reading from APIs
#-- Practive twitter API; explore facebook APIs