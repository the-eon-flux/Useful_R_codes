# Week 2 Quiz

library(httr)

## Q1.

API = "https://api.github.com/users/jtleek/repos"


# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
oauth_endpoints("github")

# 2. To make your own application, register at
#    https://github.com/settings/developers. Use any URL for the homepage URL
#    (http://github.com is fine) and  http://localhost:1410 as the callback url
#
#    Replace your key and secret below.

Token = "817ed8d4b0ee0ab1fdbe"
Token_Secret = "c056b54c88eb8f38a161b3ee370253a6901647fe"

myApp <- oauth_app("github", key = Token, secret = Token_Secret)

# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myApp)

# 4. Use API
gtoken <- config(token = github_token)
jtLeek_TL <- GET(API, gtoken)

stop_for_status(jtLeek_TL)
jtLeek_Content <- content(jtLeek_TL)

# Using JSONlite function to structure the data in jtLeek_Content
jtLeek_Content2 = fromJSON(toJSON(jtLeek_Content))


## Q2

library(sqldf)

FileN = "Codes/getdata_data_ss06pid.csv"
acs = read.csv(FileN, header = T)

sqldf("select * from acs where AGEP < 50")
sqldf("select pwgtp1 from acs where AGEP < 50")

## Q3

~ unique(acs$AGEP) 

sqldf("select distinct AGEP from acs")

## Q5. 

FName = "Codes/getdata_wksst8110.for"
C = col.names=c("I","s1","s2","s3","s4","s5","s6", "s7", "s8")

T = read.fwf(FName, widths =c(-1, 10, -4, 4, -1, 3, -5, 4, -1, 3, -5, 4, -1, 3, -5, 4, -1, 3) , skip = 4, header = F, col.names = C)


## Q4. 

Url = "http://biostat.jhsph.edu/~jleek/contact.html"
Con = url(Url)
nchar(readLines(Con, 30)[30])


