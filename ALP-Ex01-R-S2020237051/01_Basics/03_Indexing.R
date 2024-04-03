(x <- 1:10)

# single element
x[4]

# sequence
x[2:4]

# selective elements
x[c(2, 4)]

# select every odd number of x
x[seq(1, 10, 2)]

# select every even number in x
x[x %% 2 == 0]

# skip first two and last two elements
x[c(-1, -2, -9, -10)]

