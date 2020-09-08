'
  The study creating this database involved 30 volunteers "performing activities of daily
    living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors.
    Each person performed six activities wearing a smartphone (Samsung Galaxy S II) on the waist.

  The experiments have been video-recorded to label the data manually.
    The obtained dataset has been randomly partitioned into two sets, where 70% of the
    volunteers was selected for generating the training data and 30% the test data."
'

dim(ssd)
# 7352  563

names(ssd[562:563])
# last 2 columns contain subject and activity information.

table(ssd$subject)
sum(table(ssd$subject))

' We can infer that this data is supposed to train machines to recognize activity collected 
 from the accelerometers and gyroscopes built into the smartphones that the subjects had strapped
 to their waists. 
' 

# Activity performed
table(ssd$activity)

"
We're interested in questions such as, 'Is the correlation between the
 measurements and activities good enough to train a machine?' so that 
 'Given a set of 561 measurements, would a trained machine be able to determine 
 which of the 6 activities the person was doing? '
"

#---------------------- Taking a subset of data. Subject 1
sub1 <- subset(ssd, subject == 1)
dim(sub1) 
# 347 563

#So sub1 has fewer than 400 rows now, but still a lot of columns which contain measurements.

# Looking at the data
names(sub1[1:12])

# We see X, Y, and Z (3 dimensions) of different aspects of body acceleration 
# measurements, such as mean and standard deviation.


myedit("showXY.R")
# From plot we see that the active activities related to walking (shown in the two blues and magenta) show more
# variability than the passive activities (shown in black, red, and green), particularly in the X dimension.

showMe(1:6)
### Hclustering (row wise)
    
    # Focusing on the 3 variables.
    mdist <- dist(sub1[,1:3])
    hclustering <- hclust(mdist)
    myplclust(hclustering, lab.col = unclass(sub1$activity))
    
    # Dendogrm for first 3 cols not very useful. Looking at cols 10:12 (Max accleration)
    # as the scatterplot for each of those vars (x,y,z) shows diff according to activity
    
    mdist <- dist(sub1[,10:12])
    hclustering <- hclust(mdist)
    myplclust(hclustering, lab.col = unclass(sub1$activity))
    
    # Now we see clearly that the data splits into 2 clusters, active and passive activities.
    # But within passive activity : They seem all jumbled together with no clear pattern visible.

### SVD 

svd1 <- svd(scale(sub1[,-c(562,563)]))

dim(svd1$u)
# u has left singular vector; u matrix is a 347 by 347 matrix.
'Each row in u corresponds to a row in the
 matrix sub1. Recall that in sub1 each row has an associated activity.'

# Plot first 2 cols of u vs index (2 plots) & color by activity
# looking at the 2 left singular vectors of svd1 (the first 2 columns of svd1$u)

'
First column of u shows separation of the nonmoving (black, red, and green) from the walking
The second column is harder to interpret.
The magenta cluster, which represents walking up, seems separate from the others.
 We will try to figure out why that is.
 
To do that we will have to find which of the 500+ measurements 
(represented by the columns of sub1) contributes to the variation of that component.

Since we are interested in sub1 columns, we will look at the RIGHT singular vectors
 (the columns of svd1$v), and in particular, the second one since the separation of the magenta
 cluster stood out in the second column of svd1$u.

' 
# Since we're interested in sub1 columns, we'll look at the RIGHT singular vectors
# (the columns of svd1$v), and in particular, the second one since the separation of the magenta
# cluster stood out in the second column of svd1$u.

# Let's use clustering to find the feature (out of the 500+) which
# contributes the most to the variation of this second column of svd1$v.

maxCon <- which.max(svd1$v[,2])
mdist <- dist(sub1[,c(10:12, maxCon)]) # 10:12 from hclust & maxCon col/var from SVD

hclustering <- hclust(mdist)
myplclust(hclustering, lab.col = unclass(sub1$activity))

# Some changes are seen. The nonmoving activities still are jumbled together.
names(sub1[maxCon])

# So the mean body acceleration in the frequency domain in the Z direction is the main
# contributor to this clustering phenomenon we're seeing. Let's move on to k-means clustering to
# see if this technique can distinguish between the activities. 


# kmeans

kClust <- kmeans(sub1[,-c(562,563)], centers = 6)
#generate starting points randomly. Here we did only 1 random start (the default).

table(kClust$cluster, sub1$activity)


kClust <- kmeans(sub1[,-c(562,563)], centers = 6, nstart = 100)
table(kClust$cluster, sub1$activity)
dim(kClust$centers)

laying <- which(kClust$size==29)
plot(kClust$centers[laying,1:12], pch = 19, ylab = "Laying Cluster")

walkdown <- which(kClust$size==49)
plot(kClust$centers[walkdown,1:12], pch = 19, ylab = "Walkdown Cluster")






