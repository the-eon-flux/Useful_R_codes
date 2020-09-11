library(swirl)
install_from_swirl("Getting and Cleaning Data")
swirl()

FileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(FileUrl, destfile = "./Input.csv")

CodeBookUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf"
download.file(CodeBookUrl, destfile = "./Codebook.pdf", method = "curl")

# Q1 : 

InputDf <- read.csv("Input.csv", header = TRUE)
str(InputDf)
View(InputDf)


# Q3
XlsxFile <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(XlsxFile, destfile = "./SomeXLSX_File.xlsx", method = "curl")

library(xlsx)
?read.xlsx

rowIndex = 18:23
colIndex = 7:15

dat<- read.xlsx("SomeXLSX_File.xlsx", 1, rowIndex = rowIndex, colIndex = colIndex)
sum(dat$Zip*dat$Ext,na.rm=T)

# Q3

XMLUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
download.file(XMLUrl, destfile = "./SomeXML.xml", method = "curl")

library(XML)
XMLData <- xmlTreeParse("./SomeXML.xml", useInternalNodes = TRUE)
RootNode <- xmlRoot(XMLData)

xmlName(RootNode)
names(RootNode[[1]])


names(RootNode[[1]][[1]])



X <- xmlSApply(RootNode[[1]], xmlValue)
X <- xmlSApply(RootNode[[1]], xmlChildren)

# Q5

FileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(FileUrl, destfile = "./Q5Input.csv", method = "curl")


InputDf <- read.csv("./Q5Input.csv", header = TRUE)
str(InputDf)

library(data.table)
DT <- data.table(InputDf)
head(DT,3)

tables() # to see the memory 

X1 <- mean(DT[DT$SEX == 1,]$pwgtp15);mean(DT[DT$SEX == 2,]$pwgtp15)
T1 <- system.time(X1)[1]

X2 <- rowMeans(DT)[DT$SEX ==1 ]; rowMeans(DT)[DT$SEX == 2]
T2 <- system.time(X2)[1]

T3 <- Sys.time(DT[, mean(pwgtp15), by = SEX])[1]

T4<- Sys.time(mean(DT$pwgtp15, by =SEX))[1]

T5 <- system.time(sapply(split(DT$pwgtp15, DT$SEX), mean))[1]

T6 <- system.time(tapply(DT$pwgtp15, DT$SEX, mean))[1]

which(c(T3,T4,T5) == M)
M <- min(c(T3,T4,T5))


vars <- c("Injuries"="firebrick1", "CROPDMG"="darkolivegreen", "Fatalities" = "darkslateblue","PROPDMG" ="firebrick1")



Plot3 <- ggplot( ) + geom_line(data = Year_Casualty, aes(y = log2(INJURIES)+1, x =Year, colour="Injuries"), size = 1, show.legend = T) +   
			geom_line(data = Year_Casualty, aes(y = log2(FATALITIES)+1, x =Year, colour="Fatalities"), linetype="twodash", show.legend = T) + 
            	geom_line(data = Year_Casualty, aes(y = log2(PROPDMG)+1, x =Year, colour="PROPDMG"), show.legend	 = T) + 
                	geom_line(data = Year_Casualty, aes(y = log2(CROPDMG)+1, x =Year, colour="CROPDMG"), linetype="twodash", show.legend = T) + 
                    	labs(title = "Time trend for Events", subtitle = "Fatalities V/S Injuries", y = "log 2 ( Damage Measurements )", x = " Year ")  +
                    		facet_wrap(~EVTYPE) + scale_colour_manual(name="Measures:", values=vars) + theme(legend.position="bottom")

