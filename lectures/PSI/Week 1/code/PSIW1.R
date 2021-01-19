#Open the dataset and display the column names
salary<-readRDS("salary.rds")
names(salary)
#You can look at the data in a variable by entering its name at the command prompt
salary$gender


#Or get a short overview using the str function
str(salary$gender)


#Or get a relevant statistical summary for a variable e.g. gender - this will give use a frequencies as gender is categorical
summary(salary$gender)
#To get a frequence table 

#Or for salary - this will give use median, mean, IQR, max and min for the salary as it is a scale
summary (salary$salary)

#Or get a summary of all the variables in the dataset"
summary(salary)

#To see Frequencies you need to use the plyr library 
#Either install it (once) or use the library command to load it
#IF you need to install and restart R the command is 
#install.packages('plyr')

library('plyr') 

count(salary$gender)

#To see a Contingency table/Cross tabulation you need to create a table
#So to see rank by gender how many of each gender hold each rank

tab<-table(salary$gender, salary$rank)
addmargins(tab)
tab #show the table with frequencies
prop.table(tab) # shows probabilities


#### Measures of Central Tendency
#Mode
#R doesn't have a built in function to compute the mode but there is a simple function which you can write and include in your code  that will do it for you")

getmode <- function(v)
{
  uniqv <- unique(v)
  uniqv[which.max(tabulate(match(v,uniqv)))]
}


#Using the function to get the mode of salary

getmode(salary$salary)

#Median

median(salary$salary)

#Mean
mean(salary$salary)

#You can assign the outcome to a variable

meansal <- mean(salary$salary)

#and then display it on screen

meansal


#Or use the print function to make it look the way you want

print(meansal, digits=1)

#### Measures of Dispersion


#Range

range(salary$salary)


#Quantiles

quantile(salary$salary)
#to get 1st quantile
x=quantile(salary$salary); x[1] 


#Interquartile Range
IQR(salary$salary)


#Variance
var(salary$salary)


#Standard deviation

sd(salary$salary)
#Rounded

round(sd(salary$salary,2)) #rounded to 2 decimal places


