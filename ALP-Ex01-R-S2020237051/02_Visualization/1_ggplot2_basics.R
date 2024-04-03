# take a look at the database
# the dataset has 234 observations and 11 variables
# https://archive.ics.uci.edu/ml/datasets/auto+mpg

library(tidyverse)
# to get information on the data set:
?mpg

unique(mpg$class)

mpg
names(mpg)

head(mpg)
tail(mpg)

# first plot of the mpg dataset
ggplot (data = mpg) + geom_point(mapping = aes(x = displ, y = hwy))

# with ggplot2 you begin a plot with the function ggplot(), it creates a coordinate system where you can add layers
# the first argument of ggplot2 is the dataset to use in the graph.

# the graph is completed by adding one or more layers
# the function geom_point() adds a layer of points to your plot, which creates a scatter plot.

# each geom_point() takes a mapping argument which is always paired with aes() and the x and y arguments of aes()

# in the plot on the upper right corner, there are some points which seem a little bit out of order
# we can add an additional attribute to the plot, called aesthetic, which is a visual property of the plot, i.e. color

ggplot (data = mpg) + geom_point(mapping = aes(x = displ, y = hwy, color = class))

# it is also possible to map class to: size, alpha, shape

# you can also set the color manually
ggplot (data = mpg) + geom_point(mapping = aes(x = displ, y = hwy), color = "blue")

ggplot (data = mpg) + geom_point(mapping = aes(x = displ, y = hwy, color = drv, size=cyl))

# lay out a line over the variable drv
ggplot (data = mpg) + geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv))

ggplot (data = mpg) + geom_point(mapping = aes(x = displ, y = hwy, color = drv)) #+ geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv))

# There is some code duplication, therefore we can move the global mapping to the front
ggplot (data = mpg, mapping = aes(x = displ, y = hwy)) + geom_point(mapping = aes(color = drv)) + geom_smooth(mapping = aes(linetype = drv))

plt <- ggplot (data = mpg, mapping = aes(x = displ, y = hwy)) #+ 
  plt + geom_point(mapping = aes(color = class)) #+ geom_smooth()

# the plot contains far less points than observations. 
# to get a better idea of the density of the points jitter can be used.
# even though the plot is somewhat inaccurate, it may reveal additional information
ggplot (data = mpg, mapping = aes(x = displ, y = hwy)) + geom_point(mapping = aes(color = class), position = "jitter") #+ geom_smooth()
ggplot (data = mpg, mapping = aes(x = displ, y = hwy)) + geom_jitter(mapping = aes(color = class)) + geom_smooth()

# facets example
# the variable passed to facet_wrap should be discrete
ggplot (data = mpg) + geom_point(mapping = aes(x = displ, y = hwy)) + facet_wrap(~ class, nrow=2)
ggplot (data = mpg) + geom_point(mapping = aes(x = displ, y = hwy)) + facet_grid(drv ~ cyl)
ggplot (data = mpg) + geom_point(mapping = aes(x = displ, y = hwy)) + facet_grid(. ~ cyl)
ggplot (data = mpg) + geom_point(mapping = aes(x = displ, y = hwy)) + facet_grid( ~ cyl)

# bar chart with the number of cars per manufacterer
ggplot (data = mpg) + geom_bar(mapping = aes(x = manufacturer))

# colored bar chart
# stacked bar chart manufacturer and class
ggplot (data = mpg) + geom_bar(mapping = aes(x = manufacturer, fill = class))
# dodged bar chart
ggplot (data = mpg) + geom_bar(mapping = aes(x = manufacturer, fill = class), position = "dodge")


# you can specify the statistical transformation
# plot the highway efficiency per manufacturer
ggplot (data = mpg) + stat_summary(mapping = aes(x = manufacturer, y = hwy), fun.ymin = min, fun.ymax = max, fun.y = median)

# how are the highway and city efficiencies per manufacturer
ggplot (data = mpg) + geom_boxplot(mapping = aes(x = manufacturer, y=hwy))
ggplot (data = mpg) + geom_boxplot(mapping = aes(x = class, y = hwy))
