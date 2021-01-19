data <- read.delim('heart-disease.data', sep = ',', header=FALSE)
names(data) <- c('age','sex','cp','trestbps','chol','fbs', 'restecg','thalach', 'exang', 
                      'oldpeak','slope','ca','thal','goal')

data$sex[data$sex==0]='female'
data$sex[data$sex==1]='male'
data$cp[data$cp==1]='typical angina'
data$cp[data$cp==2]='atypical angina'
data$cp[data$cp==3]='non-anginal pain'
data$cp[data$cp==4]='asymptomatic'
data$slope[data$slope==1]='upsloping'
data$slope[data$slope==2]='flat'
data$slope[data$slope==3]='downsloping'

stat.desc(data$trestbps)
skew <- semTools::skew(data$trestbps)
skew
kurt <- semTools::kurtosis(data$trestbps)
kurt

quantile(data$trestbps)

histo <- ggplot(data, aes(x=data$trestbps))
histo + geom_histogram(binwidth=3, colour='black',aes(y=..density.., fill=..count..)) + scale_fill_gradient("Count", low="#DCDCDC", high="#7C7C7C") + labs(title='Blood Pressure Density Histogram', x='Blood Pressure', y='Density') + stat_function(fun=dnorm, color="red",args=list(mean=mean(data$trestbps, na.rm=TRUE), sd=sd(data$trestbps, na.rm=TRUE)))

stem(data$trestbps)

stats::cor.test(data$chol, data$trestbps, method='pearson')
stats::cor.test(data$chol, data$trestbps, method='spearman')
psych::describeBy(data$goal,group=data$sex)
car::leveneTest(goal ~ as.factor(sex), data=data)
stats::t.test(goal~sex,var.equal=TRUE,data=data)
men <- subset(data, sex=1)
women <- subset(data, sex=0)

ggplot(data, aes(x=goal))+
  geom_histogram(aes(y=..density..,fill=sex),binwidth = 1)+
  facet_grid(sex~.) + labs(title='Independent-Samples Mann-Whitney U Test')   

stats::wilcox.test(goal~sex, data=data) 
coin::wilcox_test(goal~as.factor(sex), data=data)

boxcp <- ggplot(data, aes(x=data$cp,y=data$goal))
boxcp + geom_boxplot(outlier.colour="black", outlier.shape=16,
             outlier.size=2, notch=FALSE) + labs(x='Chest Pain Type', y='Goal', title='Independent Samples Kruskal-Wallis')
stats::kruskal.test(goal~cp,data=data)
bartlett.test(data$goal, data$cp)
res.aov <- aov(data$goal ~ data$cp)
summary(res.aov)
TukeyHSD(res.aov)
