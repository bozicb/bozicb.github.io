library(gmodels) 

bully <- read.table('bullying.dat')
gmodels::CrossTable(bully$rsex, bully$ubullsch, fisher = T, chisq = T, expected = T, sresid = T, format = 'SPSS')

experim <- read.table('experim.dat')
mcnemar.test(experim$dept1gp2, experim$dept2gp2)

#load data
raqData <- read.delim("raq.dat", header=T) 
#create a correlation matrix
raqMatrix <- cor(raqData) 
round(raqMatrix, 2)
#Showing significance levels also
Hmisc::rcorr(as.matrix(raqData)) 
#Visualisation of correlations using circles
corrplot::corrplot(raqMatrix, method="circle")
#Visualisation using numbers
corrplot::corrplot(raqMatrix, method="number")
#Visualisation of significance levels at 0.05
res1 <- corrplot::cor.mtest(raqMatrix, conf.level = .95) 
corrplot::corrplot(raqMatrix, p.mat = res1$p, sig.level = .05)
#Showing p−value for non−significant results
corrplot::corrplot(raqMatrix, p.mat = res1$p, insig = "p-value")

##Using ggcorrplot
p.mat <- ggcorrplot::cor_pmat(raqData) 
ggcorrplot::ggcorrplot(raqMatrix, title = "Correlation matrix for RAQ data")
#Showing Xs for non−significant correlations 
ggcorrplot::ggcorrplot(raqMatrix, title = "Correlation matrix for RAQ data", p.mat = p.mat, sig.level = .05)
#Showing lower diagonal
ggcorrplot::ggcorrplot(raqMatrix, title = "Correlation matrix for RAQ data", p.mat = p.mat, sig.level = .05, type="lower")
#Showing the co−efficients
ggcorrplot::ggcorrplot(raqMatrix, lab=T, title = "Correlation matrix for RAQ data", type="lower")


#Bartlett ’s test
psych::cortest.bartlett(raqData) #or
psych::cortest.bartlett(raqMatrix, n = 2571)
#Measure of Sampling
psych::KMO(raqData) #or
REdaS::KMOS(raqData)
#Determinant ( execute
det(raqMatrix) #or 
det(cor(raqData))

#Principal Component Analysis
#On raw data using principal components analysis, 
#nfactors is set to the number of variables we expect 
#to get out which is equal to the number going in.
pc1 <- psych::principal(raqData, nfactors = length(raqData), rotate = "none")
plot(pc1$values, type = "b") #scree plot

#Factor Analysis 
#Principal Axis Factoring
pc3 <- psych::fa(raqMatrix, nfactors=4, obs=NA, n.iter=1, rotate="varimax" , fm="pa") 
psych::print.psych(pc3,cut=0.3, sort=TRUE)
#create a diagram showing the factors and how #the manifest variables load
psych::fa.diagram(pc3)
plot(pc3$values , type = "b") #scree plot

pc1$values #output eigenvalues
#Another way to look at Eigen values plus 
#variance explained
pcf=princomp(raqData)
factoextra::get_eigenvalue(pcf)

pc1$Vaccounted#Variance accounted for


#Rotation PCA
pc2 <- psych::principal(raqData, nfactors = 4, rotate = "varimax")
#Extracting 4 factors
psych::print.psych(pc2, cut = 0.3, sort = TRUE)
#Get the output as you would for initial solution

#Reliability analysis
computerFear <- raqData[,c(6, 7, 10, 13, 14, 15, 18)] 
statisticsFear <- raqData[, c(1, 3, 4, 5, 12, 16, 20, 21)] 
mathFear <- raqData[, c(8, 11, 17)]
peerEvaluation <- raqData[, c(2, 9, 19, 22, 23)]
psych::alpha(computerFear)
psych::alpha(statisticsFear, keys = c(1, -1, 1, 1, 1, 1, 1, 1)) 
psych::alpha(mathFear)
psych::alpha(peerEvaluation)
