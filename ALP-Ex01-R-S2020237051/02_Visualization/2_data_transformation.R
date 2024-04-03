library(tidyverse)
library(nycflights13)

?flights

flights

# to view the complete data
View(flights)

# before the data can be analyzed it must be transformed
# 5 basics operation 
# 1. pick observations by their value: filter()
# 2. reorder the rows: arrange()
# 3. pick variables by their name: select()
# 4. create new variables with functions of existing variables: mutate()
# 5. collapse many values down to a single summary: summarize()

# these can be used with group_by()

# 1. filter()

# pick every flight on 1. January 2013
flights01_01 <- filter(flights, month == 1, day == 1)

# how many flights are there per month and carrier
ggplot (data = flights) + geom_bar ( mapping = aes(x = month, fill = carrier))
ggplot (data = flights) + geom_bar ( mapping = aes(x = month, fill = carrier), position = "dodge")

# how is the distribution of the flights during the 31st of december
(dec31 <- filter(flights, month == 5 | month == 6))
ggplot (data = dec31) + geom_histogram (mapping = aes(x = dep_time))


# find all flights which departure in november or december
filter(flights, month == 11 | month == 12)
filter(flights, month %in% c(11,12))

# filter removes NA values, in case you want to preserve NA values
#filter(flights, is.na(air_time))

# find all flights with a delay over 1 hour
delay300min <- filter(flights, dep_delay > 300)

# plot the number flights to each destination for flights with a delay over 1 hour
ggplot(data = delay300min) + geom_bar(mapping = aes(x = dest))

# ----

# 2. arrange()

# order flights according to the date
arrange(flights, year, month, day)

# order flights according to arrival delay, ascending
arrange(flights, arr_delay)
# order flights according to arrival delay, descending
arrange(flights, desc(arr_delay))

# 3. select()

# select columns you are interested in
new_tibble <- select(flights, year, month, day)


# ----

# 4. mutate()
# add new variables
flights
# select year:date, all columns which end with "delay", distance and air_time
flights_sml <- select(flights, year:day, ends_with("delay"), distance, air_time)
flights_sml
# calculate new variables gain and speed
flights_sml <- mutate(flights_sml, gain = arr_delay - dep_delay, speed = distance / air_time * 60)
flights_sml

# now flights_sml contains the columns gain and speed, those can be used further
# if you only want to keep the new variables you can use transmute
flight_gain_speed <- transmute(flights, gain = arr_delay - dep_delay, speed = distance / air_time * 60)
flight_gain_speed
# ----

# 5. summarize()
# collapses a data frame to a single row

# calculate the mean of dep_delay, remove NA values
summarize(flights, delay=mean(dep_delay, na.rm = TRUE))

# count NA values for variable dep_delay
count(filter(flights, is.na(dep_delay)))
# alternative approach
summarize(flights, nadelay=count(filter(flights, is.na(dep_delay))))

# variables can be grouped using the group_by statement

# calculate the average delay by date:
# first create a grouping
by_day <- group_by(flights, year, month, day)
by_day
summarize(by_day, delay = mean(dep_delay, na.rm = TRUE))

# calculate the average delay by airline
by_airline = group_by(flights, carrier)
by_airline
summarize(by_airline, delay = mean(dep_delay, na.rm = TRUE))
# boxplot delay by carrier
ggplot(data = flights) + geom_boxplot(mapping = aes(x = carrier, y = dep_delay))

# there are a few delays which are very long, 
# filter very long dalys, and only analyse delays in the interval 0, 300 (5 hours)
delay_less300 <- filter(flights, dep_delay < 300, dep_delay > 0)
ggplot(data = delay_less300) + geom_boxplot(mapping = aes(x = carrier, y = dep_delay))
# get a summary on negative departure delay
summarize(filter(flights, dep_delay < 0), delay=mean(dep_delay, na.rm=TRUE), min=min(dep_delay), max=max(dep_delay))
summary(filter(select(flights, dep_delay), dep_delay < 0))

# combining multiple operations with a pipe

# analyze the relationship between distance and average delay for each location
# the function n counts the number of observations in the current group
# na.rm = TRUE removes NA values
by_dest <- group_by(flights, dest)
delay <- summarize(by_dest, count = n(), dist=mean(distance, na.rm=TRUE), delay=mean(arr_delay, na.rm = TRUE))
delay
# filter noisy points and honolulu which is as twice as far as the next closest point
delay <- filter(delay, count > 20, dest != "HNL")

ggplot (data = delay, mapping = aes(x = dist, y = delay)) + geom_point(aes(size=count), alpha=1/3) + geom_smooth() #se = FALSE)
ggplot (data = delay, mapping = aes(x = dist, y = delay)) + geom_point(aes(size=count), alpha=1/3) + geom_smooth(se = FALSE) #se = FALSE)

# we can use a pipe to tackle this problem, this is a functionality from the tidyverse
delays <- flights %>%
  group_by(dest) %>%
  summarize(
    count = n(),
    dist = mean(distance, na.rm = TRUE),
    delay = mean(arr_delay, na.rm = TRUE)
  ) %>%
  filter(count > 20, dest != "HNL")

# alternatively you can write the same operation this way (which is R functionality)
delays <- filter(summarize(
  group_by(flights, dest), 
  count=n(), 
  dist=mean(distance, na.rm = TRUE), 
  delay=mean(arr_delay, na.rm=TRUE)
), count > 20, dest != "HNL")

delays

# subtleties when analyzing data
# lets look at the planes that have the highest average delays

# first we create a dataset which contains all non-cancelled flights
not_cancelled <- filter(flights, !is.na(dep_delay) , !is.na(arr_delay))
delays <- summarize(group_by(not_cancelled, tailnum), delay = mean(arr_delay))
arrange(delays, desc(delay))
# there are flights which have an average delay of over 300 hours
# histogram
ggplot (data = delays, mapping=aes(delay)) + geom_freqpoly(binwidth=10)

# plot the number of flights versus average delay
delays <- filter(summarize(group_by(flights, tailnum), n = n(), delay=mean(arr_delay, na.rm=TRUE)))

ggplot(data = delays, mapping=aes(x = n, y = delay)) + geom_point(alpha=1/10)

delays <- filter(summarize(group_by(flights, tailnum), n = n(), delay=mean(arr_delay, na.rm=TRUE)), n > 10, n < 500)

ggplot(data = delays, mapping=aes(x = n, y = delay)) + geom_point(alpha=1/10)

## summarize and group_by examples

# get the number of flights group by tailnum
summarize(group_by(flights, tailnum), n = n())
# get the number of flights per month
summarize(group_by(flights, month), n = n())
ggplot(data = flights) + geom_bar(mapping = aes(x = month))
# get the number of flights, per carrier and the delay
carrier_delay_n <- summarize(group_by(flights, carrier), n = n(), delay=mean(dep_delay, na.rm=TRUE))
ggplot(data = carrier_delay_n) + geom_point(mapping = aes(x = n, y=delay))
