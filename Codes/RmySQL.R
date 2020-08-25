# Reading from mySQL
library(RMySQL)

ucscDb <- dbConnect(MySQL(), user="genome", host = "genome-mysql.soe.ucsc.edu")
result <- dbGetQuery(ucscDb, "show databases;"); dbDisconnect(ucscDb)


# Connecting to specific Db "hg19"

hg19 <- dbConnect(MySQL(), user= "genome", db="hg19", host="genome-mysql.soe.ucsc.edu")

# List all the tables in the dB
allTables <- dbListTables(hg19)
length(allTables)

# Lists the Fields/ Columns in that dB
dbListFields(hg19, 'affyU133Plus2')

# To get the number of rows
dbGetQuery(hg19, "select count(*) from affyU133Plus2")

# To store a table from dB locally we read it using
AffyData <- dbReadTable(hg19, "affyU133Plus2")

## To get a subset of dB

# Construct a query and send it. Clear the query after using
query <- dbSendQuery(hg19, "select * from affyU133Plus2 where misMatches between 1 and 3")

# Fetching the query results here
affyMis <- fetch(query)
quantiles(affyMis$misMatches)

affyMis.Mini <- fetch(query, n =10)

# Clearing query
dbClearResult(query)

dbDisconnect(hg19)
