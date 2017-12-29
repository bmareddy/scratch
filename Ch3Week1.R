## Set working directory
wd <- getwd()
print(paste("Current working directory is:",wd))
dataDir <- paste0(wd,"/data")
if(!file.exists(dataDir))
{
  dir.create(dataDir)
}
setwd(dataDir)
print(paste("Workind directory is set to:",dataDir))

## Download raw data file (.csv format)
dataFile <- "cameras.csv"
download.file("https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD",dataFile)
if (file.exists(dataFile))
  print(paste(dataFile,"is successfullydownloaded at",as.character(Sys.time())))

### Read the data into memory
cameras <- read.csv(dataFile)

## Download raw data file (.xlsx format); currently doesn't work
dataFile <- "cameras.xlsx"
download.file("https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD&bom=true&format=true",dataFile)
if (file.exists(dataFile))
  print(paste(dataFile,"is successfullydownloaded at",as.character(Sys.time())))

### Read the data into memory
install.packages("xlsx")
library(xlsx)
camerasX <- read.xlsx(dataFile,sheetIndex=1,header=TRUE)

## Download raw data file (.xml format)
dataFile <- "cameras.xml"
download.file("https://data.baltimorecity.gov/api/views/dz54-2aru/rows.xml?accessType=DOWNLOAD",dataFile)
if (file.exists(dataFile))
  print(paste(dataFile,"is successfullydownloaded at",as.character(Sys.time())))

### Reading the data into memory
install.packages("XML")
library(XML)
camerasXML <- xmlTreeParse(dataFile,useInternal=TRUE)
rootNode <- xmlRoot(camerasXML)
xmlName(rootNode)
names(rootNode)
rootNode[[1]][[2]][[1]]
xpathSApply(rootNode,"//address",xmlValue)
xpathSApply(rootNode,"location_1[latitude]",xmlValue) ## Learn how to extract lat/longs

## Download raw data file (.json format)
dataFile <- "cameras..json"
download.file("https://data.baltimorecity.gov/api/views/dz54-2aru/rows.json?accessType=DOWNLOAD",dataFile)
if (file.exists(dataFile))
  print(paste(dataFile,"is successfullydownloaded at",as.character(Sys.time())))

### Reading the data into memory
install.packages("jsonlite")
library(jsonlite)
camerasJSON <- fromJSON(dataFile)
names(camerasJSON)
names(camerasJSON$data)
names(camerasJSON$meta)
names(camerasJSON$meta$view)
