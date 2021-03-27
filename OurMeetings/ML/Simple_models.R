data <- iris
data[["Species"]] <- ifelse(data[["Species"]]=="versicolor", "versicolor", "others")

linear_model <- glm(Species ~ Sepal.Length + Sepal.Width, iris, family = "binomial")
predict(linear_model)
