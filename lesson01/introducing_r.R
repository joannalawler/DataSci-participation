# Introducing R

# 1.8.1 Using R and RStudio

2 + 2
3 + 4

number <- 3
number
number * 2

number <- 5
number * 2

# 1.8.2 Vectors

c(1, 2, 3, 4)

number

anothernumber

times <- c(17, 30, 25, 35, 25, 30, 40, 20)
times

# 1.8.3 Functions Part 1

mean(times)

time_hours <- times / 60

mean(times)
range(times)
sqrt(times)

# 1.8.4 Comparisons

times > 30

times == 17

which(times > 30)
all(times > 30)
any(times > 30)

help(any)
?any
?mean

# 1.8.5 Subsetting

times[times > 30]
times[3]
times[-3]

3:5
times[3:5]

times[c(2, 4)]
times[-c(2, 4)]
times[times > 30]

times
times[1] <- 47
times

# 1.8.6 NA

times[times > 30] <- NA
times

times <- c(17, 30, 25, 35, 25, 30, 40, 20)
times[1] <- 47
times
times[times > 30] <- c(0, 1)
times

times <- c(17, 30, 25, 35, 25, 30, 40, 20)
times[1] <- 47
times[times > 30] <- NA
times

# 1.8.7 Functions Part 2

mean(times)
mean(times, na.rm = TRUE)
times[times > 20 & times < 35]
mean(times[times > 20 & times < 35], na.rm = TRUE)
times > 20 | times < 35

mean(x = times)
mean(times)
mean(times, na.rm = TRUE)
mean(times, trim = .2, na.rm = TRUE)

# 1.8.8 Data Frames

mtcars
?mtcars
head(mtcars)

str(mtcars)
names(mtcars)