
# Statistical Inference Course Project

# Create an empty vector to store all of our sample means. 
lambda = 0.2
n = 40
myexpd <- rep(NA, 1000)

# Simulate the distribution of the mean of 40 exponentials. Set lambda = 0.2 for all of the simulations.

set.seed(512)
for (i in 1:1000){
    tmp <- rexp(n, lambda)
    myexpd[i] <- mean(tmp)  # 40 samples of exponential distribution rexp(n, lambda) 
}

# Histogram plot
hist(myexpd)

# Mean
myexpd_m <- mean(myexpd)
myexpd_m
# 4.97779

# Variance
myexpd_v <- var(myexpd)
myexpd_v
# 0.6250162

# Compared to theoretical mean and variance
mean_t <- 1 / lambda
# 5
var_t <- (1/lambda)^2/n
# 0.625

# scale(myexpd)

hist(myexpd, probability=T, main="", xlab="")
lines(density(myexpd))

# Compare with the standard normal distribution
curve(dnorm(x,myexpd_m, sqrt(myexpd_v)), 2, 8, col="red", add=T)

# Convert to data frame for ggplot
df <- data.frame(myexpd)
# head(df)
# dim(df)

library(ggplot2)

g <- ggplot(data = df, aes(x = myexpd)) 

g + geom_histogram(aes(y=..density..), fill = I('blue'), binwidth = 0.20, color = I('black')) + stat_function(fun = dnorm, arg = list(mean = mean_t, sd = sqrt(var_t)), color = "red")

# the coverage of the confidence interval for 1/lambda
lowercl <- myexpd - qnorm(0.975) * (1/lambda)/sqrt(n)
uppercl <- myexpd + qnorm(0.975) * (1/lambda)/sqrt(n)
expci <- mean(lowercl < (1/0.2) & uppercl > (1/0.2))
expci
#The confidence interval is thus expci : 95.3%

# Evaluate the coverage of the confidence interval for 1/lambda
mean(df$myexpd) + c(-1,1)*1.96*sd(df$myexpd)/sqrt(nrow(df))
# 4.928790 5.026791












