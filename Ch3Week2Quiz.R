library(httr)
library(jsonlite)

## Question 1

#-- Initialize GitHub App
oauth_endpoints("github")
my_git = oauth_app("github",key = "31daa35c07057b3286bd",secret = "ba0cab1e1cabd8de88f7951b44503e2ec6427f6f")

#-- Get OAuth credentials
github_token = oauth2.0_token(oauth_endpoints("github"),my_git)
token = config(token = github_token)

#-- Get jtleek repository content
repos_req = GET("https://api.github.com/users/jtleek/repos",token)
repos_content = content(repos_req,as="text") # this returns a character vector of length 1 with the http reposonse converted to text format
repos = fromJSON(repos_content) # this returns a data frame
repos[repos$full_name=="jtleek/datasharing",c("description","created_at")] # Get the time at which datasharing repo was created 

## Question 2 & 3

library(sqldf)

#-- Download the ACS file
acs_file = "./data/ACSIdaho2006P.csv"
df = read.csv(acs_file,stringsAsFactors = FALSE)
sqldf("select pwgtp1 from df where AGEP < 50 limit 10")
sqldf("select distinct AGEP from df order by AGEP")

## Question 4
page = url("http://biostat.jhsph.edu/~jleek/contact.html")
q4_lines = readLines(page)
nchar(q4_lines[c(10,20,30,100)])

## Question 5
file = "./data/ch3q5.for"
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for",file)
widths <- c(10,9,4,9,4,9,4,9,4)
for_df = read.fwf(file,widths,skip=4,strip.white=TRUE)
sum(for_df[,4])
