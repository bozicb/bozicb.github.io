# Question 1 
#Import the file places.csv and determine the place names that end in either a ‘y’ or a ‘u’
places <- read.csv('places.csv')
unlist(lapply(places$city_ascii, function(x) grep('[y,u]$',x,value=T)))

# Question 2 
# How would you match the literal string “$^$”?
library(stringr)
s <- "$^$"
str_detect(s,"\\$\\^\\$")

# Question 3
#Given the vector of common words in stringr::words, create regular expressions to find all the words that:
#  a. Start with “y”
#  b. Are exactly 3 letters long
#  c. Have seven letters or more
unlist(lapply(stringr::words, function(x) grep('^y',x,value=T)))
unlist(lapply(stringr::words, function(x) grep('^[a-z]{3}$',x,value=T)))
unlist(lapply(stringr::words, function(x) grep('^[a-z]{7,}$',x,value=T)))

# Question 4
# Import the file contained in isoc_ec_ibuy.tsv.gz and use string processing to separate the columns.
eu_data <- read.table("isoc_ec_ibuy.tsv",sep = '\t',header = TRUE)
library(tidyr)
eudata <- separate(eu_data,indic_is.ind_type.unit.geo.time,c('indic_is','ind_type','unit','geo','time'),',')

# Question 5
# Your colleague, who does data modelling, is looking for a quick assessment of the usability of the data in this data frame (Question 4). Can you help her out with some summary information.
summary(eudata)

# Question 6
# Use the appropriate lubridate function to parse each of the following dates: 
#“January 1, 2010”
# “2015-Mar-07”
# "06-Jun-2017"
# c(“August 19 (2015)”, “July 1 (2015)”) 
# “12/30/14” 
# Dec 30, 2014
library(lubridate)
mdy("January 1, 2010")
ymd("2015-Mar-07")
dmy("06-Jun-2017")
mdy(c("August 19 (2015)", "July 1 (2015)"))
mdy("12/30/14")
mdy("Dec 30, 2014")

# Question 7
# Using the flights dataset in the nycflights13 library, confirm Hadley’s hunch that the early departures of flights in minutes 20 – 30 and 50 – 60 are caused by scheduled flights that leave early.
library(nycflights13)
make_datetime_100 <- function(year, month, day, time) {
  make_datetime(year, month, day, time %/% 100, time %% 100)
}
flights_dt <- flights %>%
  filter(!is.na(dep_time), !is.na(arr_time)) %>%
  mutate(
    dep_time = make_datetime_100(year, month, day, dep_time),
    arr_time = make_datetime_100(year, month, day, arr_time),
    sched_dep_time = make_datetime_100(year, month, day, sched_dep_time),
    sched_arr_time = make_datetime_100(year, month, day, sched_arr_time)
  )
flights_dt %>%
  mutate(
    minute = minute(dep_time),
    early = dep_delay < 0
  ) %>%
  group_by(minute) %>%
  summarise(
    early = mean(early, na.rm = TRUE),
    n = n()
  ) %>%
  ggplot(aes(minute, early)) +
  geom_line()

# Question 8
# The file ‘dates.csv’ contains data about the dates of this year. Suppose a friend of yours who gets paid on the first Friday of each month is curious to know these dates in 2018. Can you find the answer for them?
dates <- read.csv('dates.csv')
dates$dates[wday(dates$dates,label = TRUE) == "Fri" & day(dates$dates) <= 7]
