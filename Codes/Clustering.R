# Swirl course > Exploratory DA > Hierarchical Clustering

# Hierarchical clustering, a simple way of quickly examining and displaying multi-dimensional data
Distance <- dist(dataFrame)

# Dendogram
hclust(Distance)

#
hc <- hclust(distxy)
plot(hc)

plot(as.dendrogram(hc))
abline(h = 1.5, col = "blue")
abline(h = 0.05, col = "green")

# Heatmap
heatmap(dataMatrix, col = cm.colors(25))

### # k-means 


points(cx, cy, col = c("red", "orange", "purple"), pch=3,cex=2,lwd=2)
mdist(x, y, cx, cy)


apply(distTmp, 2, which.min)
points(x, y, pch = 19, cex=2, col = cols1[newClust])


tapply(x, newClust, mean)
tapply(y, newClust, mean)
points(newCx, newCy, col = cols1, pch=8,cex=2,lwd=2)
mdist(x, y, newCx, newCy)


apply(distTmp2, 2, which.min)
points(x, y, pch = 19, cex=2, col = cols1[newClust2])
tapply(x, newClust2, mean)
tapply(y, newClust2, mean)

points(finalCx, finalCy, col = cols1, pch=9, cex=2, lwd=2)


kmeans(dataFrame, centers = 3)

plot(x, y, col = kmObj$cluster, pch =19, cex=2)
points(kmObj$centers, col = c("black","red","green"), pch=3, cex=3, lwd=3)

plot(x, y, col = kmeans(dataFrame,6)$cluster, pch =19, cex=2)






