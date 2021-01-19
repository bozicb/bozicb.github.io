library(foreign)

regression <- read.spss('Regression.sav')

model1 <- lm(regression$normexam ~ regression$standlrt)
stargazer::stargazer(model1,type='text')

model2 <- lm(normexam ~ standlrt + girl, data=regression)
stargazer::stargazer(model2, type='text')

stargazer::stargazer(model1, model2, type='text')

model3 <- lm(normexam ~ standlrt + girl + interaction, data=regression)
stargazer::stargazer(model3, type='text')

model4 <- lm(normexam ~ standlrt + girl + boys_sch + girls_sch, data=regression)             
stargazer::stargazer(model4, type='text')

summary(model1)
plot(model1)
resid(model1)
plot(density(resid(model1)))
qqPlot(model1, main='QQ_Plot')
leveragePlots(model1)

library(car)
vifmodel <- vif(model2)
1/vifmodel
cooks <- cooks.distance(model1)
plot(cooks, ylab="Cook's Statistic")

durbinWatsonTest(model2)

survey <- read.table('survey.dat')
survey_nna <- na.omit(survey)
ppcor::spcor.test(survey_nna$tpcoiss, survey_nna$tpstress, survey_nna$tmarlow)
ppcor::spcor.test(survey_nna$tpcoiss, survey_nna$toptim, survey_nna$tmarlow)
ppcor::spcor.test(survey_nna$tpstress, survey_nna$toptim, survey_nna$tmarlow)
cor(survey_nna$tpcoiss, survey_nna$tpstress)
cor(survey_nna$tpcoiss, survey_nna$toptim)
cor(survey_nna$tpstress, survey_nna$toptim)
