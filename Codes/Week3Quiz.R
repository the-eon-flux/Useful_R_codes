library(dplyr)

## Q1

Url = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(Url, "./Q1.csv", method = "curl" )

df = read.csv("./Q1.csv", header = T)
tdf = tbl_df(df)

tdf.s <- select(tdf, ACR, AGS)
X = mutate(tdf.s, agricultureLogical = ifelse((ACR = 3 & AGS >5), T, F))

agricultureLogical = ifelse((tdf.s$ACR = 3 & tdf.s$AGS >5), T, F)

which(X$agricultureLogical == T)

head(X[which(X$agricultureLogical == T),])


## Q2
library(jpeg)

ImgLink = "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
download.file(Url, "./Q2.jpg", method = "curl" ) # curl gave error
Img <- readJPEG("./Q3.jpg", native = T)
quantile(Img, c(0.3, 0.8))


## Q3

Url ="https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(Url, "./Q3.csv", method = "curl" )
df = read.csv("./Q3.csv", header = T, stringsAsFactors = F)

Url2 = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(Url2, "./Q3B.csv", method = "curl" )
dfB = read.csv("./Q3B.csv", header = T, stringsAsFactors = F)


Mdf <- merge(df, dfB, by.x = "X", by.y = "CountryCode", all = T)
Mtdf <- tbl_df(Mdf)
Mtdf$Gross.domestic.product.2012 = as.numeric(as.character(Mtdf$Gross.domestic.product.2012))

Mtdf.sorted <- arrange(Mtdf, Gross.domestic.product.2012)

Mtdf_IncomeGrp <- group_by(Mtdf.sorted, Income.Group)
summary(Mtdf_IncomeGrp)

H <- Mtdf.sorted %>% group_by(Income.Group)
H$Rank = as.numeric(as.character(row.names(H)))

quantile(H$Rank)


group_by(H, Income.Group)
summarise(H, Avg = mean(Rank, na.rm = T))

## Q5

H.Cut <- cut(H$Rank, breaks = quantile(H$Rank) )
table(H$Income.Group, H.Cut
      )








