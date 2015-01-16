### Project part 1

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

# Convert to data frame for ggplot.
df <- data.frame(myexpd)

head(df)
dim(df)

library(ggplot2)

g <- ggplot(data=df, aes(x=myexpd)) 

g + geom_histogram(aes(y=..density..), fill=I('blue'), binwidth=0.40, color=I('black')) + stat_function(fun=dnorm, arg =list(mean=mean_t, sd=sqrt(var_t)), color="red") + geom_vline(xintercept=mean_t, colour="green", linetype="longdash")

# use qqplot and qqline to compare the distribution of averages of 40 exponentials to a normal distribution
qqnorm(myexpd)

qqline(myexpd, col = 2)

# Evaluate the 95% confidence interval for this simulation:
mean(df$myexpd) + c(-1,1)*1.96*sd(df$myexpd)/sqrt(nrow(df))
# 4.928790 5.026791


