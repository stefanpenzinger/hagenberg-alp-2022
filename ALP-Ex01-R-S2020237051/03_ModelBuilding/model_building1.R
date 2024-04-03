# model building

library(tidyverse)
library(modelr)
options(na.action = na.warn)

# There is a simple simulated dataset
?sim1

head(sim1)

# there are two variables (int, dbl), therefore we use a scatter plot
# for visualization
ggplot(data = sim1, mapping = aes(x=x, y=y)) + geom_point()

# there seems to be a strong positive correlation between x and y
# probably it is linear

ggplot(sim1, aes(x, y)) + geom_abline(aes(intercept=0, slope=4)) + geom_point()

# lets take a look at linear models, generate 250 linear models y = k*x + d (intercept and slope)
models = tibble(
  a1 = runif(250, -20, 40),
  a2 = runif(250, -5, 5)
)
models
# and draw them 
ggplot(sim1, aes(x, y)) + geom_abline(aes(intercept= a1, slope=a2), data=models, alpha = 1/4) + geom_point()

# some of them are very bad, we want to know the model which fits the points best
# y ~ x is a formular and means y = a_0 + a_1 * x, i.e. the left hand side can be described using the right hand side and some formular, in this case linear (km)
model_sim1 <- lm(y ~ x, sim1)
summary(model_sim1)
# plot data and model
#fig <- abline(model_sim1)
ggplot(sim1, mapping = aes(x, y)) + geom_point() + stat_smooth(method = "lm", color="red")

                                      