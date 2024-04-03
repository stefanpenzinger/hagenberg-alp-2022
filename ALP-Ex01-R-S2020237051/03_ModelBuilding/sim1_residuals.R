library(tidyverse)
library(modelr)
sim1

ggplot (data = sim1) + geom_point(mapping = aes(x=x, y=y))

model <- lm(y~x, data = sim1)
model

ggplot (data = sim1) + geom_point(mapping = aes(x=x, y=y)) + geom_abline(intercept = 4.22, slope=2.0515)

#alternatively, you can use geom_smooth
#ggplot (data = sim1, mapping = aes(x=x, y=y)) + geom_point() + geom_smooth(method="lm", se = FALSE)

sim1 <- add_residuals(sim1, model)
sim1
ggplot (data = sim1) + geom_point(mapping = aes(x = x, y= resid))

# use predict to predict values
grid <- tibble(x = 15:20)
grid
add_predictions(grid, model, var="y_pred")

ggplot(data = sim1) + geom_freqpoly(mapping = aes(resid), binwidth=0.5)
