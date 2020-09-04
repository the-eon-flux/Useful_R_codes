library(lattice)
library(swirl)

swirl()

'
Functions in Lattice system 
xyplot for creating scatterplots, bwplot for box-and-whiskers plots or boxplots, 
and histogram for histograms.

Generally take a formula for their first argument, usually of the form y ~ x.
This indicates that y depends on x, so in a scatterplot y would be plotted on the
y-axis and x on the x-axis.

Typical Eg. xyplot(y ~ x | f * g, data)
        where f & g are factors
'

head(airquality)
xyplot(Ozone ~ Wind, data = airquality)


# Rerun with col
xyplot(Ozone ~ Wind, data = airquality, pch = 8, col = "red", main="Big Apple Data")

# Adding factors
xyplot(Ozone ~ Wind | as.factor(Month), data = airquality, layout=c(5,1))

# Lattice functions return a trellis class object. They don't directly print
p <- xyplot(Ozone~Wind,data=airquality)


# Properties stored in p
names(p)

p[['formula']]
p[['x.limits']]


# 
xyplot(y~x |f, layout = c(2,1))

# Panels i lattice

# Eg 1
p <- xyplot(y ~ x | f, panel = function(x, y, ...) {
    panel.xyplot(x, y, ...)  ## First call the default panel function for 'xyplot'
    panel.abline(h = median(y), lty = 2)  ## Add a horizontal line at the median
})
print(p)

# Eg 2
# Load diamonds data in ggplot2 lib

str(diamonds)
table(diamonds$color)

table(diamonds$color, diamonds$cut)

myxlab <- "Carat"
myylab <- "Price"
mymain <- "Diamonds are Sparkly!"


source(pathtofile("myLabels.R"), local = TRUE)

xyplot(price ~ carat | color*cut, data = diamonds, strip=FALSE, pch = 20, xlab = myxlab, 
      ylab= myylab, main = mymain)


# Swirl lesson under Exploratory DA : Working with colors

library(RColorBrewer)
library(jpeg)
library(datasets)

# Red to yellow
heat.colors()

# Blue to yellow/brown
topo.colors()

# Gives list of colors
sample(colors(),10)

# You can use above 600+ colors. Also you can blend 2 colors with diff. proportions
# using colorRamp & colorRampPalettes

pal <- colorRamp(c("red", "blue"))

pal(1)

pal(seq(0,1,len=6))


# colorRampPalette

p1 <- colorRampPalette(c("red", "blue"))

p1(6)

p2 <- colorRampPalette(c("red", "yellow"))
p2(2)

p2(10)

p3 <- colorRampPalette(c("blue", "green"), alpha=0.5)

# 
plot(x,y, pch = 19, col= rgb(0, 0.5, 0.5, alpha = 0.3))



# Rcolorbrewer pckg
'Interesting and useful color palettes, of which there are 3 types, sequential,
divergent, and qualitative. Which one you would choose to use depends on your data
'

cols <- brewer.pal(3, "BuGn")
showMe(cols)

pal <- colorRampPalette(cols)
showMe(pal(20))

# Plotting with colors

image(volcano, col = pal(20))
image(volcano, col = p1(20))






