## Week 3 


set.seed(13435)

X <- data.frame("var1" = sample(1:5), "var2" = sample(6:10), "var3" = sample(11:15))
X <- X[sample(1:5),] # Reordering

X$var2[c(1,3)] <- NA
X


# Ordering df with plyr

library(plyr)

arrange(X, var1) # Ascending order
arrange(X, desc(var1)) # Descending order


# Cross tabs

data("UCBAdmissions")
DF = as.data.frame(UCBAdmissions)

summary(DF)

xt <- xtabs(Freq ~ Gender + Admit, data = DF)
xt


# fTable (flat tables) to easily visualize multi list components

warpbreaks$Replicate <- rep(1:9, len = 54)
xt = xtabs(breaks ~., data = warpbreaks)

# Visualizing xt is tedious hence ftables

ftable(xt)


fakeData = rnorm(1e5)
S = object.size(fakeData)

# Print in MB by
print(S, units = "Mb")


##### Creating subset of df by quantiles or any other condition

RDf <- read.csv("../Datasets/Restaurants.csv", header = T)

RDf$ZipGroups <- cut(RDf$zipCode, breaks = quantile(RDf$zipCode))
# Dividing ZipGroups according to factor variable of quantiles ( 0-25, 25-50, 50-75 & 75-100)

table(RDf$ZipGroups, RDf$zipCode)




##### Reshaping the Data

library(reshape2)
data("mtcars")

mtcars$CarNames <- row.names(mtcars)

# Melting the data : Makes df tall and skinny

MtCarsMelted <- melt(mtcars, id=c("CarNames", "gear", "cyl"), measure.vars = c("mpg", "hp") )

head(MtCarsMelted) # Basically we have removed 2 columns and added it as rows. 
#   Also cols not needed are removed

# Recasting into different shapes after melting

Cyl_mtcars = dcast(MtCarsMelted, cyl ~ variable) # summarises the data; Freq
Cyl_mtcars <- dcast(MtCarsMelted, cyl ~ variable, mean) # summarises the data; Mean 

data("InsectSprays")
str(InsectSprays)



##### dplyr pckg ; Some highlights of dplyr are
'
select : returns a subset of cols in df
filter : extract subset of rows based on expr
arrange : reorder rows of df
rename : rename variables in df
mutate : add/change new cols/variables
summarise : Generate summary stats

Also has easy print methods. 
'
library(dplyr)

str(RDf)

# select
head(select(RDf, name:neighborhood)) # subset cols by striding with col names
head(select(RDf, -c(name:neighborhood))) # similarly use '-' for removing those cols

# filter
head(filter(RDf, zipCode == 21206))

#arrange
Res <- arrange(RDf, name) # reordering rows 
head(Res)

Res <- arrange(RDf, desc(name))

#rename ; Renaming cols; New_Name = Old_Name
Res <- rename(RDf, Address = Location.1, Neighborhoods_2010Census = X2010.Census.Neighborhoods )

#mutate 

Res <- mutate(RDf, is_Precincts_NA = is.na(X2010.Census.Wards.Precincts))

# group_by

Police_help_Grp <- group_by(RDf, policeDistrict)

summarise(Police_help_Grp, Mean_CD = mean(councilDistrict), Sub.Add = substr(Location.1,1,10))
# 2 new summary cols were custom created with just 1 line of code

# operator %>% ; Merge everything in 1 cmd [pipeline operator]

RDf %>% group_by(neighborhood) %>% summarise(Shortform = substr(neighborhood,1,15))


##### Merging datasets

# Consider 2 dfs X & Y to merge

merge(X ,Y, by.X = "X_ColName", by.y= "Y_colname", all =T) # all = T arg means to add extra row if
# 1 row val is present in 1 table and not other

# Join in plyr is fast but it works only if col names are same in 2 dfs

# Tible df; Diff printing

Tdf <- tbl_df(mydf)



##### TidyR

# gather; To merge cols into 1 var
gather(students, sex, count, -grade)

#spread; To undo gather; i.e, to create cols from multi valued col.

#   separate(data, col, into, sep="", ...)
separate(res, sex_class, c("sex", "class"))


# readR
library(readr)



































