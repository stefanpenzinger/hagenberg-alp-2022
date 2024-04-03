# Vector
(v1 <- vector("double", 3))

# Factor example
sex <- c("male", "female")
fs <- factor(sex)
fs[1]
fs[2]

# Arrays
array <- array(1:10, dim=c(2, 5)); array 
# redimension
dim(array) <- c(5, 2); array 

# matrix
matrix(c(10:19), nrow=2, ncol = 5) 

# data frame
z1 <- c(4, 4, 7, 7, 8, 9) 
z2 <- c(2, 10, 4, 22, 16, 10) 
z1; z2 

df <- data.frame(speed=z1, distance=z2)
df
colnames(df)

(df1 <- data.frame(X=1:2, Y=3:4))
(df2 <- data.frame(U=10:11, V=15:16))

colnames(df2) <- c("X", "Y")
df2
rbind(df1, df2)

(colnames(df2) <- c("Y", "X"))
rbind(df1, df2)

# Time Series
ts(1:10, start = 1900) 

ts(1:47, frequency = 12, start=c(1959, 2)) 

# List
(l1 <- list(1:5, 42.0, "Name", TRUE))