library(tidyverse)
titanic_data <- read.csv("Data\\train.csv")
library(dplyr)
titanic_data %>%
summarise_all(~sum(is.na(.)))

# Create data set and transform columns to factors
data <- mutate( titanic_data , Pclass = factor(Pclass), Embarked = factor(Embarked), Sex = factor(Sex), Survived = factor(Survived))
#data$Pclass <- factor( data$Pclass )
#data$Parch <- factor( data$Parch )
#data$SibSp <- factor( data$SibSp )
#data$Age <- factor( data$Age )

# display NA rows and remove them
colSums(is.na(data))
data <- na.omit(data)

# Create age groups and the corresponding labels
labels <- c(paste(seq(0, 95, by = 10), seq(0 + 10 - 1, 100 - 1, by = 10), sep = "-"), paste(100, "+", sep = ""))
data$AgeGroup <- cut(data$Age, breaks = c(seq(0, 100, by = 10), Inf), labels = labels, right = FALSE)
data$AgeGroup <- cut(data$Age, breaks = c(seq(0, 100, by = 10), Inf), labels = labels, right = FALSE)

# Plot data
ggplot (data = data) + geom_bar(mapping = aes(fill = Survived, x = Sex))
ggplot (data = data) + geom_bar(mapping = aes(fill = Survived, x = Pclass))

data$Age <- factor( data$Age )
ggplot (data = data) + geom_bar(mapping = aes(fill = Survived, x = Age))
ggplot (data = data) + geom_bar(mapping = aes(fill = Survived, x = AgeGroup))

# Create new column with number of people a person was with
data$numPers <- factor( data$Parch + data$SibSp )
ggplot (data = data) + geom_bar(mapping = aes(x = Survived, fill = numPers))