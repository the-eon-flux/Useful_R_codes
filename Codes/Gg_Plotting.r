library(swirl)
swirl()

'
ggplot2 combines the best of base and lattice.
    Allows for multipanel (conditioning) plots (as lattice does) but also post facto annotation (as base does), so
you can add titles and labels. 
    As part of its grammar philosophy, ggplot2 plots are composed of
        aesthetics (attributes such as size, shape, color) and 
        geoms (points, lines, and bars), the geometric objects you see on the plot.

'
# 2 workhorse functions : 

# A.) qplot (quick plot) Produces many types of plots (scatter, histograms, box and whisker)
# B.) ggplot more flexible and can be customized for doing things qplot cannot do.

library(ggplot2)
str(mpg)


# A.) qplot

    # tibble [234 x 11]
    
    # see if there's a correlation betn engine displacement (displ) and highway miles per gallon (hwy)
    
    qplot(displ, hwy, data = mpg)
    # The negative trend (increasing displacement and lower gas mileage) is pretty clear.
    
    # Adding color to a 3rd variable
    qplot(displ, hwy, data = mpg, color = drv)
    
    # Adding regression lines to data according to the factor variable
    qplot(displ, hwy, data = mpg, color = drv, geom = c("point", "smooth"))
    
    # So, specifying the y parameter only, without an x argument, plots the values of the y
        #argument in the order in which they occur in the data.
    qplot(y= hwy, data=mpg, color = drv)
    
    # box and whisker plot using qplot
    qplot(drv, hwy, data = mpg, geom = "boxplot",color=manufacturer)
    
    # Histograms
    qplot(hwy, data = mpg, fill = drv)
    qplot(hwy, data=mpg, color = drv)
    
    # Facets
    
    qplot(displ, hwy, data = mpg, facets = .~drv) # column wise plots
    
    qplot(hwy, data = mpg, facets = drv ~., binwidth = 2) # row-wise plots


# B.) ggplot
    
    # 7 basic components of ggplot2 : 
        # 4 we know now are : Dataframe, Aesthetic, geometric objs & facets (panels used for conditioning)
        # 3 remaining are : 
            # Stats (statistical transformations such as binning, quantiles, and smoothing)
            # Scales : show what coding an aesthetic map uses (for example, male = red, female = blue)
            # Coordinate System : Default usage
    
    # We will build this plot again  with more customizations
    qplot(displ, hwy, data = mpg, geom = c("point","smooth"), facets = .~drv)

    g <- ggplot(data = mpg, aes(displ, hwy))
    
    # check if its proper with 
    summary(g)

    # Loess smoothing
    g+geom_point() + geom_smooth()

    # Linear model customization
    g+geom_point() + geom_smooth(method = "lm")

    # Adding facets
    g+geom_point() + geom_smooth(method = "lm") + facet_grid(.~ drv)
    
    # Adding titles
    g+geom_point() + geom_smooth(method = "lm") + facet_grid(.~ drv) + ggtitle("Swirl Rules!")
    
    ## Customizations that can be added
    g + geom_point(color = "pink", size = 4, alpha = 1/2)
    
    ## modify the aesthetics so that color indicates which drv type
    g + geom_point(size = 4, alpha = 1/2, aes(color=drv))
    
    ## adding labels and other things
    g + geom_point(aes(color=drv)) + labs(title = "Swirl Rules!") + labs(x= "Displacement", y = "Hwy Mileage")
    
    ## practice customizing the geom_smooth calls
    g + geom_point(aes(color=drv), size = 2, alpha = 1/2) + geom_smooth(size =4, linetype=3, method="lm", se= FALSE)
    
    # Changing the theme
    g + geom_point(aes(color = drv)) + theme_bw(base_family = "Times")
    
    
    plot(myx, myy, type = "l", ylim=c(-3,3))
    g <- ggplot(data = testdat, aes( x = myx, y=myy) )
    
    g + geom_line() + ylim(-3,3)
    ' Instead of adding ylim(-3,3) to the expression g+geom_line(),
     add a call to the function coord_cartesian with the argument ylim set equal to
     c(-3,3).
    '
    g + geom_line() + coord_cartesian(ylim = c(-3,3))
    
    # New eg. 
    
    g <- ggplot(data= mpg, aes(x= displ, y = hwy, color = factor(year)))
    
    g + geom_point() + facet_grid( drv~cyl, margins = TRUE)
        # margins argument tells ggplot to display the marginal totals over each row and column
    
    
    g + geom_point() + facet_grid( drv~cyl, margins = TRUE) + geom_smooth(method = "lm", se = FALSE, size = 2, color = "black") + labs( x = "Displacement", y = "Highway Mileage", title = "Swirl Rules!")
    
## GGplot Extra lesson
    
    # Diamond data
    str(diamonds)
    
    range(diamonds$price)
    
    Diff <- max(diamonds$price) - min(diamonds$price) # 18497
  ## Histograms
    
    Histogram_Price <- qplot(price, data = diamonds, binwidth = 18497/30, fill = cut)
        # Don't put y = price for hist.
    
    Histogram_Price_Density <- qplot(price, data = diamonds, geom = "density")
    
    # Spike seen around 4000 dollars.
    qplot(price, data = diamonds, geom = "density", color = cut)

  ## Scatterplots
    
    qplot(carat, price, data = diamonds)
    
    qplot(carat, price, data = diamonds, shape = cut)

    qplot(carat, price, data = diamonds, color = cut)    
    
    qplot(carat, price, data = diamonds, color = cut, facets = .~cut) + geom_smooth( method = "lm")

        
  ## Quiz
    
    g <- ggplot(data = diamonds, aes(depth, price))
    summary(g)    
    
    g + geom_point(alpha= 1/3)
    
    cutpoints <- quantile(diamonds$carat, seq(0,1,length=4), na.rm = TRUE)
    
    diamonds$car2 <- cut(diamonds$carat, cutpoints)
    
    g <- ggplot(data = diamonds, aes(depth, price))
    
    g + geom_point(alpha= 1/3) + facet_grid(cut~car2) + geom_smooth( method = "lm", size =3, color = "pink")
    
    
    
    g <- ggplot(data = diamonds, aes(carat, price)) 
    
    g + geom_boxplot() + facet_grid(.~cut)
    
    
    
    
        