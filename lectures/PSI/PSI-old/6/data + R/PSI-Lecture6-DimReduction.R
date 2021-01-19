#---------------------------------------------------------------------------------------------------------
#Adapted from R Code for Chapter 17 of:
#
#Field, A. P., Miles, J. N. V., & Field, Z. C. (2012). Discovering Statistics Using R: and Sex and Drugs and Rock 'N' Roll. #London Sage
#
#(c) 2011 Andy P. Field, Jeremy N. V. Miles & Zoe C. Field
#-----------------------------------------------------------------------------------------------------------




#------And then load these packages.-----

library(corpcor)
library(GPArotation)
library(psych)


#********************* RAQ Example ********************

#load data
raqData<-read.delim("raq.dat", header = TRUE)

#create a correlation matrix
raqMatrix<-cor(raqData)
round(raqMatrix, 2)


#Bartlett's test

cortest.bartlett(raqData)
cortest.bartlett(raqMatrix, n = 2571)

#KMO test


# KMO Kaiser-Meyer-Olkin Measure of Sampling Adequacy
# Function by G. Jay Kerns, Ph.D., Youngstown State University (http://tolstoy.newcastle.edu.au/R/e2/help/07/08/22816.html)

kmo = function( data ){
  library(MASS) 
  X <- cor(as.matrix(data)) 
  iX <- ginv(X) 
  S2 <- diag(diag((iX^-1)))
  AIS <- S2%*%iX%*%S2                      # anti-image covariance matrix
  IS <- X+AIS-2*S2                         # image covariance matrix
  Dai <- sqrt(diag(diag(AIS)))
  IR <- ginv(Dai)%*%IS%*%ginv(Dai)         # image correlation matrix
  AIR <- ginv(Dai)%*%AIS%*%ginv(Dai)       # anti-image correlation matrix
  a <- apply((AIR - diag(diag(AIR)))^2, 2, sum)
  AA <- sum(a) 
  b <- apply((X - diag(nrow(X)))^2, 2, sum)
  BB <- sum(b)
  MSA <- b/(b+a)                        # indiv. measures of sampling adequacy
  AIR <- AIR-diag(nrow(AIR))+diag(MSA)  # Examine the anti-image of the correlation matrix. That is the  negative of the partial correlations, partialling out all other variables.
  kmo <- BB/(AA+BB)                     # overall KMO statistic
  # Reporting the conclusion 
   if (kmo >= 0.00 && kmo < 0.50){test <- 'The KMO test yields a degree of common variance unacceptable for FA.'} 
      else if (kmo >= 0.50 && kmo < 0.60){test <- 'The KMO test yields a degree of common variance miserable.'} 
      else if (kmo >= 0.60 && kmo < 0.70){test <- 'The KMO test yields a degree of common variance mediocre.'} 
      else if (kmo >= 0.70 && kmo < 0.80){test <- 'The KMO test yields a degree of common variance middling.' } 
      else if (kmo >= 0.80 && kmo < 0.90){test <- 'The KMO test yields a degree of common variance meritorious.' }
       else { test <- 'The KMO test yields a degree of common variance marvelous.' }

       ans <- list( overall = kmo,
                  report = test,
                  individual = MSA,
                  AIS = AIS,
                  AIR = AIR )
    return(ans)
} 
library(REdaS)
#To use this function:
kmo(raqData)
REdaS::KMOS(raqData)
psych::KMO(raqData)

#Determinent (execute one of these):
det(raqMatrix)
det(cor(raqData))

#PCA



#Factor rotation

pc3 <-  principal(raqData, nfactors = 4, rotate = "varimax")
print.psych(pc3, cut = 0.3, sort = TRUE)


#Principal Axis Factoring
pc5 <- fa(raqMatrix, nfactors=4, obs=NA, max.iter=100, rotate="varimax", fm="pa", scores="regression")
pc5print.psych(pc5,cut=0.3, sort=TRUE)
fa.diagram(pc5)#create a diagram showing the factors and how the manifest variables load
fa.sort(pc5$loading)
pc5$Vaccounted#Variance accounted for


#To extract scores to include in the dataset 
pc6 <- principal(raqData, nfactors = 4, rotate = "VARIMAX", scores = TRUE)
pc6$scores
raqData <- cbind(raqData, pc6$scores)


#Reliability analysis

computerFear<-raqData[,c(6, 7, 10, 13, 14, 15, 18)]
statisticsFear <- raqData[, c(1, 3, 4, 5, 12, 16, 20, 21)]
mathFear <- raqData[, c(8, 11, 17)]
peerEvaluation <- raqData[, c(2, 9, 19, 22, 23)]


alpha(computerFear)
alpha(statisticsFear, keys = c(1, -1, 1, 1, 1, 1, 1, 1))
alpha(mathFear)
alpha(peerEvaluation)
alpha(statisticsFear) #for illustrative pruposes

