library(stargazer)
library(foreign)

mydata <- read.spss("youthcohort.sav")
logmodel1 <- glm(satmath ~ s1gender + s1pared, data=mydata, na.action=na.exclude, family=binomial())
logmodel1
lmtest::lrtest(logmodel1)

modelChi <- logmodel1$null.deviance - logmodel1$deviance
modelChi

chidf <- logmodel1$df.null - logmodel1$df.residual
chidf

chisq.prob <- 1 - pchisq(modelChi, chidf)
chisq.prob

summary(logmodel1)
exp(coefficients(logmodel1))
rcompanion::nagelkerke(logmodel1, restrictNobs = T)
Epi::ROC(form=mydata$satmath ~ mydata$s1gender+mydata$s1pared, plot="ROC")
