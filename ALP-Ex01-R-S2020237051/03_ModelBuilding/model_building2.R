# model building 2
library(tidyverse)
library(modelr)
options(na.action = na.warn)

# Why have low quality diamonds higher prices
?diamonds
ggplot(diamonds, aes(cut, price)) + geom_boxplot()
ggplot(diamonds, aes(color, price)) + geom_boxplot()
ggplot(diamonds, aes(clarity, price)) + geom_boxplot()

# we did not include the carat variable
# this is the single, most important variable which determines the price
ggplot(diamonds, aes(carat, price)) + geom_boxplot()
ggplot(diamonds, aes(carat, price)) + geom_point()
ggplot(diamonds, aes(carat, price)) + geom_hex(bins = 50)

# transform the data (log price and carat)
?log2
diamonds2 <- mutate(diamonds, lprice=log2(price), lcarat=log2(carat))
diamonds2 

# the log transformation seems to make the pattern linear
ggplot(diamonds2, aes(lcarat, lprice)) + geom_point()
#ggplot(diamonds2, aes(lcarat, lprice)) + geom_hex(bins = 50)

# fit a linear model
mod_diamond <- lm(lprice ~ lcarat, data = diamonds2)
mod_diamond
# this model removes the strong relationship between carat and price 
#(carat dominates the price over all other aspects (cut, color))

# therefore we are able to analyze the influence of cut and color on the price

# create a prediction grid (pipes)
#grid <- diamonds2 %>%
#  data_grid(carat = seq_range(carat, 20)) %>%
#  mutate(lcarat = log2(carat)) %>%
#  add_predictions(mod_diamond, "lprice") %>%
#  mutate(price = 2^lprice)

# creat a prediction grid (without pipes)
# data_grid generates a grid
# seq_range generate evently distributed values
grid <- data_grid(diamonds2, carat = seq_range(carat, 20))
grid
# transform the values 
grid <- mutate(grid, lcarat = log2(carat))
grid <- add_predictions(grid, mod_diamond, "lprice")
grid <- mutate(grid, price = 2^lprice)
grid

#ggplot(diamonds2, aes(carat, price)) + geom_hex(bins=50) + geom_line(data=grid, color="red", size=1)
ggplot(diamonds2, aes(carat, price)) + geom_point() + geom_line(data=grid, color="red")

# to analyze the effect of color, cut and clarity, we must remove the influence of
# the carat.
# this can be achieved by calculating the residuals
# residuals are the the difference of observed and predicted value
diamonds2 <- add_residuals(diamonds2, mod_diamond, "lresid")
ggplot(diamonds2, aes(lcarat, lresid)) + geom_point() # geom_hex(bins=50)

# redo the plots using lresid
# this column is now without the influence of the carat on the price
# when we use the 

ggplot(diamonds2, aes(cut, lresid)) + geom_boxplot()
ggplot(diamonds2, aes(color, lresid)) + geom_boxplot()
ggplot(diamonds2, aes(clarity, lresid)) + geom_boxplot()

#mod_diamond <- lm(lprice ~ lcarat, data = diamonds2)

# split the data set in train and evaluation set
train <- slice(diamonds2, 1:(n()-10))
validation <- slice(diamonds2, (n()-10):n())

mod_diamond <- lm(lprice ~ lcarat, data = train)
mod_diamond
#summary(mod_diamond)

# use the r method predict and the model mod_diamond on the data validation
prediction <- predict(mod_diamond, validation)
# calculate the error
sum(abs(validation$lprice - prediction))/11
# or mean squared error (mse)
mean( (validation$lprice - prediction)^2 )


validation
# add predictions (which are based on the logarithmic scale)
validation_predictions = add_predictions(validation, mod_diamond, var="lprice_pred")
# and transform it back
mutate(validation_predictions, price_pred = 2^lprice_pred)
