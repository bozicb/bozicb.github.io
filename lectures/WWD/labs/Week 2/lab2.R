# 1.) Open the ChickWeight dataset, what is the average weight of a chick after 21 days? How many chicks weigh more than this average? How many chicks are on each diet?

mean(ChickWeight[which(ChickWeight$Time==21),]$weight) 

table(ChickWeight$Diet) #table counts at each combination of factor levels

# 2.) Convert the Titanic dataset to a dataframe. What percentage of the crew survived? How many of these were female? Based on the entire dataset, if you could choose to be a particular type of passenger on the Titanic, which would it be? Explain your reasoning.

titanic_df <- as.data.frame(Titanic)
crew <- titanic_df[which(titanic_df$Class=='Crew'),]
crew_survived <- crew[which(crew$Survived=='Yes'),]
sum(crew_survived$Freq)/sum(crew$Freq)*100
fem_surv <- crew_survived[which(crew_survived$Sex=='Female'),]
sum(fem_surv$Freq)

first <- titanic_df[which(titanic_df$Class=='1st'),]
first_survived <- first[which(first$Survived=='Yes'),]
sum(first_survived$Freq)/sum(first$Freq)*100
second <- titanic_df[which(titanic_df$Class=='2nd'),]
second_survived <- second[which(second$Survived=='Yes'),]
sum(second_survived$Freq)/sum(second$Freq)*100
third <- titanic_df[which(titanic_df$Class=='3rd'),]
third_survived <- third[which(third$Survived=='Yes'),]
sum(third_survived$Freq)/sum(third$Freq)*100

# If you could choose, you should be a first class passanger, as they have a survival rate of 62.46154%.

# 3.)  Open the iris dataset, What is the average of the ratio of Sepal.Length to Petal.Length for the virginica species? Store the aveage values of each column in a named vector.

virginica <- iris[which(iris$Species=='virginica'),]
mean(virginica$Sepal.Length/virginica$Petal.Length)

vir_avg <- c(mean(virginica$Sepal.Length),mean(virginica$Sepal.Width),mean(virginica$Petal.Length),mean(virginica$Petal.Width))
names(vir_avg) <- c('Sepal.Length', 'Sepal.Width', 'Petal.Length', 'Petal.Width')

# 4.) Open the  mtcars dataset. What are the names of the cars that have a mpg greater than  the average value and a wt above 2000 lbs. What are the names of the cars with manual transmission?

mpg_wt <- mtcars[which(mtcars$mpg>mean(mtcars$mpg)&mtcars$wt>2),]
row.names(mpg_wt)

manual <- mtcars[which(mtcars$am==1),]
row.names(manual)

# 5.) Open the occupationalStatus dataset. What is the most likely occupational status shared by fathers and sons?

which.max(occupationalStatus[row(occupationalStatus)==col(occupationalStatus)])

# 6.) Open the ggplot2::mpg dataset. What is the difference between the average values of the numeric columns for the years 1999 and 2008?

mpg99 <- ggplot2::mpg[which(ggplot2::mpg$year==1999),]
mpg08 <- ggplot2::mpg[which(ggplot2::mpg$year==2008),]

mean(mpg99$cty)-mean(mpg08$cty)
mean(mpg99$hwy)-mean(mpg08$hwy)

# 7.) Open the lubridate::lakers dataset. What percentage of the rows have NA values in columns (a) x, (b) y, (c) both? (You need to have the package lubridate installed for this question)

require(lubridate)
sum(is.na(lubridate::lakers$x))/length(lubridate::lakers$x)*100
sum(is.na(lubridate::lakers$y))/length(lubridate::lakers$y)*100
(sum(is.na(lubridate::lakers$x))+sum(is.na(lubridate::lakers$y)))/(length(lubridate::lakers$x)+length(lubridate::lakers$y))*100

# 8.) Open the nycflights13::flights dataset. What are the (a) average, (b) maximum and (c) minimum arrival and departure delays for each month? (You need to  have the package nycflights13 installed for this question)

require(nycflights13)
tapply(nycflights13::flights$dep_delay,nycflights13::flights$month,mean,na.rm=TRUE)
tapply(nycflights13::flights$arr_delay,nycflights13::flights$month,mean,na.rm=TRUE)
tapply(nycflights13::flights$dep_delay,nycflights13::flights$month,max,na.rm=TRUE)
tapply(nycflights13::flights$arr_delay,nycflights13::flights$month,max,na.rm=TRUE)
tapply(nycflights13::flights$dep_delay,nycflights13::flights$month,min,na.rm=TRUE)
tapply(nycflights13::flights$arr_delay,nycflights13::flights$month,min,na.rm=TRUE)
