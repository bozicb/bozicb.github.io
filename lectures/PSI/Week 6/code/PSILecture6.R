#1

edata <- read.table('experim.dat')

t.test(edata$fost1, edata$fost2, paired=T)

#2

drinkset <- read.table('Field-BDI-Non-parametric.dat')
vodkadata <- subset(drinkset, drinkset$drink == 'Vodka')
beerdata <-subset(drinkset, drinkset$drink == 'Beer')

stats::wilcox.test(beerdata$bdisun, beerdata$bdiwed, paired=T)

#3

sdata <- read.table('survey.dat')

library(dplyr)
group_by(sdata, sdata$agegp3) %>% 
  summarise(count=n(), mean=mean(toptim, na.rm=T, sd=sd(toptim, na.rm=T)))

bartlett.test(sdata$toptim, sdata$agegp3)
res.aov <- aov(sdata$toptim ~ sdata$agegp3, data = sdata)
summary(res.aov)
TukeyHSD(res.aov)

#4

ydata <- read.table('youthcohort.dat')
library(psych)
describeBy(as.numeric(ydata$gradmath), factor(ydata$ethsfr))
stats::kruskal.test(gradmath ~ ethsfr, data = ydata)
library(FSA)
dunn <- dunnTest(x = as.numeric(ydata$gradmath), g = factor(ydata$ethsfr), method = 'bonferroni')
print(dunn, dunn.test.results = T)

#5

diet <- read.table('diet.dat')
responses <- na.omit(with(diet, cbind(month1, month2, start)))
cat("\nMedians:\n")
print(apply(responses, 2, median))
friedman.test(responses) 
