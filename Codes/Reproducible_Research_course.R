# Reproducible Research

# Dataset used : spam daa from kernlab pckg

library(kernlab)
data(spam)

# Perform subsampling

set.seed(3435)
trainIndicator <- rbinom(4601, size = 1, prob = 0.5)
table(trainIndicator)


trainSpam <- spam[trainIndicator == 1, ]
testSpam <- spam[trainIndicator ==0, ]

# Exploratory DA. Distribution, basic summary stats etc.

names(testSpam)
View(head(testSpam))
## Data shows freq of words in each of the mails (rows)

table(testSpam$type)
#Contains labels for spam or not

## Observing relationship between 2 vars
plot(trainSpam$capitalAve ~ trainSpam$type) # Data is skewed so taking log10 of var 

plot(log10(trainSpam$capitalAve +1) ~ trainSpam$type) # Adding 1 because lot of values are 0; else NA's are added
# In spam on an avg there are more capital letters.

## Looking for relationships between multiple vars
plot(log10(trainSpam[, 1:4]+1))

## Cluster analysis
hCluster <- hclust(dist(t(trainSpam[,1:57])))
# transpose coz dist() calcs dist between rows of input
plot(hCluster) # CapitalAvg was standing out

# Clustering is not reliable much for skewed data. Hence log tranformation
hCluster <- hclust(dist(t(log10(trainSpam[,1:57] +1 ))))
plot(hCluster)
# CapTotal & CapLong are standing out; 
# These can be explored further in statistical modelling or prediction

## Prediction & Stat modelling
# depends on the question asked. Measures of uncertanity should be reported.

# Fitting a basic stat model to each variable. Fitting a logistic regression (general model)

trainSpam$numType <- as.numeric(trainSpam$type) - 1
costFunction <- function(x, y) {sum( x != (y < 0.5))}
cvError <- rep(NA, 55)

library(boot)

for(i in 1:55){
    lmForula <- reformulate(names(trainSpam)[i], response = "numType")
    print(lmForula)
    glmFit <- glm(lmForula, family = "binomial", data= trainSpam)
    cvError[i] <- cv.glm(trainSpam, glmFit, costFunction, 2)$delta[2]
    # calculating the error rate of predicting spam emails with above models
}

# Which predictor has min cross-validated error ?
names(trainSpam)[which.min(cvError)]


# Take the best model for predictions

predictionModel <- glm(numType ~ report, family = "binomial", data = trainSpam)
predictionModel1 <- glm(numType ~ charDollar, family = "binomial", data = trainSpam)

# Getting predictions on test data

predictionTest <- predict(predictionModel, testSpam)
predictedSpam <- rep("nonSpam", dim(testSpam)[1])

predictionTest1 <- predict(predictionModel1, testSpam)
predictedSpam1 <- rep("nonSpam", dim(testSpam)[1])

# Here we don't get absolute classfication whether it's spam or not. we get probs. 
#   so we classify based on prob > 0.5

predictedSpam[predictionModel$fitted.values > 0.5] = "spam"
predictedSpam1[predictionModel1$fitted.values > 0.5] = "spam"  

# Comparing with actual values

table(predictedSpam, testSpam$type)
'
  predictedSpam nonspam spam
      nonSpam    1398  896
      spam          9   11
  ' # 9 were classified as spam were not actually spam [FP] & 896 were classfied as nonSpam but they
# weren't spam

table(predictedSpam1, testSpam$type)
'
  predictedSpam1 nonspam spam
       nonSpam    1346  458
       spam         61  449
  '# 61 were classified as spam were not actually spam. FP & 458 were classfied as nonSpam but they
# weren't spam

# Calculating the error rate
Report_Error <- (896+9) / (1398 + 896 + 9 + 11)
charDollar_Error <- (61 + 458) / (61 + 458 + 1346 + 449)

## Interpreting results
# Statements made from above model
"
  Fraction of characters that're dollar signs can be used to predict if an email is spam.
  More dollars mean more likely to be spam
  Out test set error rate is 22.4%
  
  "
## Really imp to challenge yourself. Your code, interpretation. Question everything
#   Summarise properly. Form a story.

'------------------------------------------------------------- Organising Data analysis --------------------------------------------'

# Data, figures (exploratory & final), Codes (Raw scripts, Final scripts & R markdowns, ) 
#  & text files (readme, report  & codebook)  












