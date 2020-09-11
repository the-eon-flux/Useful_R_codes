# Casestudy : Exploratory DA
    # Air pollution Data : pm25.
    # Data from 2 years : 1999 (pm0 variable) & 2012 (pm1 variable)

library(swirl)
swirl()

# Data Prep

    dim(pm0)
        #  117421      5
    head(pm0)
    
    # Col names in cnames
    cnames
    cnames <- strsplit(cnames, "|", fixed = TRUE)
    names(pm0) <- make.names(cnames[[1]][wcol])

    head(pm0)    
    x0 <- pm0$Sample.Value
    str(x0)

    # What % values are missing ?
    mean(is.na(x0))
        #11% of the 117000+ are missing
    
    # Doing the same to 2012 data
    names(pm1) <- make.names(cnames[[1]][wcol])
    dim(pm1)
        # 1304287       5
    x1 <- pm1$Sample.Value
    
    # What % values are missing ?
    mean(is.na(x1))
        # 5.6% of the total values
    
# Data exploring
    summary(x0)
    summary(x1)    
    # both the median and the mean of measured particulate matter have declined from 1999 to 2012.    
    
    # We see some extreme vals. Let's check them out
    boxplot(x0, x1) 
        # Nothing can be made out from it. Let's take log
    
    boxplot(log10(x0), log10(x1))
    
    # return to the question of the negative values in x1. Counting them
    negative <- x1 < 0
    sum(negative, na.rm = TRUE)
        # there are over 26000 negative values. Does that trouble us ?
    mean(negative, na.rm = TRUE)
        #  2% of the x1 values are negative, thus we can ignore them
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    