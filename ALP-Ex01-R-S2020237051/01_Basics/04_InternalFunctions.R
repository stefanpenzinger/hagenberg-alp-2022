values <- rpois(40, 4)
values

sum(values)
var(values)
length(values)

# generate  normal distributed observations
norm_values <- rnorm(5)
mean(norm_values)
var(norm_values)
norm_values

plot(density(norm_values))
shapiro.test(norm_values) # h0 cannot be discarded if p-value is larger than alpha

# create a poisson distribution
pois_values <- rpois(4, 2)
plot(density(pois_values))
shapiro.test(pois_values) # if the p-value is larger than the alpha-value, h0 cannot be discarded
