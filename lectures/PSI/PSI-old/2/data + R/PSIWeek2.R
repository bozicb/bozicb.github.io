#Initiate ggplot2
library(ggplot2)
library(reshape)
library(plyr)
library (Hmisc)

#-- Some Basics with ggplot
#facebookNarcissim - data file from a study that looked at ratings of Facebook profile pictures
#which were rated (on coolness, fashion, atrractiveness and galmour)
#and predicting from this how high the person predicted rates on narcissim
facebookData <- read.delim("facebookNarcissism.dat",  header = TRUE)

graph <- ggplot(facebookData, aes(NPQC_R_Total, Rating))
graph + geom_point() + ggtitle("geompoint")
ggsave("Week2 Example with point.png", plot=last_plot())

graph + geom_point(shape = 17) + ggtitle("geom_point(shape = 17)")
ggsave("Week2 Example with triangle.png", plot=last_plot())

graph + geom_point(size = 6) + ggtitle ("geom_point(size = 3)")
ggsave("Week2 Example changing size.png", plot=last_plot())

#using a black and white theme, using Triangles
graph + theme_bw(base_size=13)  + geom_point(shape = 17) + ggtitle ("theme_bw(base_size=13")
ggsave("Week2 using theme.png", plot=last_plot())

#using another theme, using Triangles
graph + theme_dark() + geom_point(shape = 17) + ggtitle ("theme_dark")
ggsave("Week2 using another theme.png", plot=last_plot())


#show each rating as a different colour
graph + geom_point(aes(colour = Rating_Type)) + ggtitle("geom_point(aes(colour = Rating_Type))")
ggsave("Week2 Example changing colour.png", plot=last_plot())

#Jitter adds a small amount of random variation to the location of each point - spreads the data out
graph + geom_point(aes(colour = Rating_Type), position = "jitter") + ggtitle ("geom_point(aes(colour = Rating_Type), position = jitter)")
ggsave("Week2 Example jitter.png", plot=last_plot())



#--------HISTOGRAMS----------

##Load the data file into R. This is a tab-delimited file hence use of read.delim

festivalData <- read.delim("DownloadFestival.dat",  header = TRUE)
#Create the histogram and remove the legends related to the aesthetics
festivalHistogram <- ggplot(festivalData, aes(day1)) + theme(legend.position="none")
festivalHistogram + geom_histogram(binwidth = 0.4) + labs(x = "Hygiene (Day 1 of Festival)", y = "Frequency")
ggsave("Week 2 Download Festival Histogram with Outlier.png")


#Density without outlier

festivalData2 = read.delim("DownloadFestival(No Outlier).dat",  header = TRUE)
festivalDensity <- ggplot(festivalData2, aes(day1))
festivalDensity + geom_density() + labs(x = "Hygiene (Day 1 of Festival)", y = "Density Estimate")
ggsave("Week2 Download Density.png")
#by gender
festivalDensity + geom_density(aes(fill = gender), alpha = 0.5) + labs(x = "Hygiene (Day 1 of Festival)", y = "Density Estimate")
ggsave("Week 2 Download gender Density.png")

festivalDensity + geom_histogram(binwidth = 0.4) + labs(x = "Hygiene (Day 1 of Festival)", y = "Frequency") + theme(legend.position="none")
ggsave("Week 2 Download Festival Histogram without Outlier.png")



#---Stem and Leaf----

stem(facebookData$NPQC_R_Total)
stem(festivalData$day1)

#--------BOXPLOTS----------

festivalBoxplot <- ggplot(festivalData, aes(gender, day1))
festivalBoxplot <- ggplot(festivalData, aes(gender, day1))
festivalBoxplot + geom_boxplot() + labs(x = "Gender", y = "Hygiene (Day 1 of Festival)")

ggsave("Week 2 Download Festival Boxplot with Outlier.png")

#with outlier removed

festivalData2 = read.delim("DownloadFestival(No Outlier).dat",  header = TRUE)
festivalBoxplot2 <- ggplot(festivalData2, aes(gender, day1))
festivalBoxplot2 + geom_boxplot() + labs(x = "Gender", y = "Hygiene (Day 1 of Festival)")
ggsave("Week 2 Download Festival Boxplot.png")

#days 2 and 3

festivalBoxplot <- ggplot(festivalData, aes(gender, day2))
festivalBoxplot + geom_boxplot() + labs(x = "Gender", y = "Hygiene (Day 2 of Festival)")
ggsave("Week 2 Download Festival Boxplot day 2.png")

festivalBoxplot <- ggplot(festivalData, aes(gender, day3))
festivalBoxplot + geom_boxplot() + labs(x = "Gender", y = "Hygiene (Day 3 of Festival)")
ggsave("Week 2 Download Festival Boxplot day 3.png")



#--------OUTLIERS----------

#Function to work out wether a dataset has outliers or not
outlierSummary<-function(variable, digits = 2){
  
  zvariable<-(variable-mean(variable, na.rm = TRUE))/sd(variable, na.rm = TRUE)
  
  outlier95<-abs(zvariable) >= 1.96
  outlier99<-abs(zvariable) >= 2.58
  outlier999<-abs(zvariable) >= 3.29
  
  ncases<-length(na.omit(zvariable))
  
  percent95<-round(100*length(subset(outlier95, outlier95 == TRUE))/ncases, digits)
  percent99<-round(100*length(subset(outlier99, outlier99 == TRUE))/ncases, digits)
  percent999<-round(100*length(subset(outlier999, outlier999 == TRUE))/ncases, digits)
  
  cat("Absolute z-score greater than 1.96 = ", percent95, "%", "\n")
  cat("Absolute z-score greater than 2.58 = ",  percent99, "%", "\n")
  cat("Absolute z-score greater than 3.29 = ",  percent999, "%", "\n")
}
outlierSummary(festivalData$day1)
outlierSummary(festivalData$day2)
outlierSummary(festivalData$day3)


#--------Bar Charts----------

chickFlick = read.delim("ChickFlick.dat",  header = TRUE)
#basic bar chart simplt a frequency count
bar<-ggplot(chickFlick, aes(x=interest)) + geom_bar()
bar
#basic bar chart of  mean interest per film
#Create a bar chart from the data showing bars for interest for each film by gender
bar <- ggplot(chickFlick, aes(film, interest))
bar + stat_summary(fun.y=mean, geom="bar")


#Here we are using the stat_summary function to calculate and then plot the mean values for each film

#Adding gender to the mix

bar <- ggplot(chickFlick, aes(film, interest, fill = gender ))
#Create a bar chart showing mean values for each gender, and using the scale_fill_manual function to change the colours
bar + stat_summary(fun.y = mean, geom = "bar", position="dodge") + labs(x="Film") + labs(y="Mean interest") + scale_fill_manual("Gender", values=c("Female" = "#008000", "Male" = "#0000FF"))
#position="dodge" adjusts horizontal positioning while maintaining vertical positions - to handle overlaps

ggsave("Week 2 Chick Flick Clustered Error Bar Custom Colours.png")



