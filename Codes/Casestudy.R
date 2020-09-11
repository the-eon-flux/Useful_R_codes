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
        #  2% of the x1 values are negative, thus we can ignore them.
        # Before we ignore them, though, let's see if they occur during certain times of the year.
    
    # Checking to see if there is any pattern in neg values
    dates <- pm1$Date
    str(dates)    
        # Int vector. 
    dates <- as.Date(as.character(dates), "%Y%m%d")
    head(dates)
    
    #Histogram of Neg values acording to month
    hist(dates[negative], "month")
    
    # Look at one monitor that was taking measurements in both 1999 and 2012.
    
    str(siteo) # NY variable for 1999, with unique values
        # variables created by paste(pm1$county_codes, pm1$monitorIDs) ; county.site. 
    
    # Getting common monitors in both times for NY
    both <- intersect(site0, site1)
        # 10 monitors in New York State were active in both 1999 and 2012.
    
    # how many measurements were taken by the 10 New York monitors working in both of the years
    head(pm0)
    
    # Let's create a subset of data which will have a filter for 2 characteristics. The first is State.Code equal to 36 (the code
    #| for New York), and the second is that the county.site (the component we added) is in the vector 'both'.
    
    cnt0 <- subset(pm0, State.Code == 36 & county.site %in% both)
    cnt1 <- subset(pm1, State.Code == 36 & county.site %in% both)
    
    # Getting counts for each monitors
    sapply(split(cnt0, cnt0$county.site), nrow)
    sapply(split(cnt1, cnt1$county.site), nrow)    
    
    # Looking at monitor with ID 63.2008.
    pm0sub <- subset(cnt0, County.Code == 63 & Site.ID == 2008)
    pm1sub <- subset(cnt1, County.Code == 63 & Site.ID == 2008)    
    
    # compare the pm25 measurements of this particular monitor between 2 yrs
    x0sub <- pm0sub$Sample.Value
    x1sub <- pm1sub$Sample.Value    
    
    dates0 <- as.Date(as.character(pm0sub$Date), "%Y%m%d")
    dates1 <- as.Date(as.character(pm1sub$Date), "%Y%m%d")    
    
    # Plotting
    par(mfrow = c(1,2), mar = c(4, 4, 2, 1))
    plot(dates0, x0sub, pch = 20)
    abline(h = median(x0sub, na.rm = TRUE), lwd = 2)

    plot(dates1, x1sub, pch = 20)
    abline(h = median(x1sub, na.rm = TRUE), lwd = 2)    
    
    # Adjusting the scales
    rng <- range(x0sub, x1sub, na.rm = TRUE)
    rng
    
    # Lastly comparison of statewise data
        # mean (average measurement) for each state in 1999.
        mn0 <- with ( pm0, tapply(Sample.Value, State.Code, mean, na.rm = TRUE))
        str(mn0)    
    
        # mean (average measurement) for each state in 2012.
        mn1 <- with ( pm1, tapply(Sample.Value, State.Code, mean, na.rm = TRUE))
        str(mn1)
    
    summary(mn0)
    summary(mn1)    
    
    # creating df for plotting
    d0 <- data.frame("state" = names(mn0), "mean" = mn0)
    d1 <- data.frame("state" = names(mn1), "mean" = mn1)    

    # Merging
    mrg <- merge(d0, d1, by = "state")
    dim(mrg)
    head(mrg)
    
    with(mrg, plot(rep(1,52), mrg[,2], xlim = c(0.5, 2.5)))
    with(mrg, points(rep(2,52), mrg[,3]))    
    segments(rep(1 , 52), mrg[,2], rep(2, 52), mrg[,3])
        #  plot that the vast majority of states have indeed improved their pm25 counts
    
    mrg[mrg$mean.x < mrg$mean.y, ]
    
    
    
    
    
    
    