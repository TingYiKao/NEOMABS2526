1+2
2+3

# Variables
a = 5
a <- 6

# Is equal to
a == 5

x <- 42         # numeric
y <- 42L        # integer
z <- "Hello"    # character
flag <- TRUE    # logical
cnum <- 3 + 4i  # complex

# creates a numerical vector
vec <- c(2, 210, 456, 78, 53)
## pick up specific values
vec[2:3]
vec[-1]
vec[-1:-3]

# create a continuous vector
con_vec <- seq(from = 1, to = 100)
## addition by 2
con_vec_sep <- seq(from = 1, to = 100, by = 2)
## how many numbers I will get eventually
con_vec_sep2 <- seq(from = 1, to = 100, length = 20)
## ask for help '?'
?seq

# repeat numbers (values, how many times you want to repeat)
rep(2 , 5)
seq(1, 10)

# factors (only for one data type)
gender <- c("male", "female", "male", "male", "male", "female")
genderf <- factor(gender)
gender
genderf
?factor

## orders
edu <- c("h", "h", "h", "u", "u", "p", "p", "u", "h", "p")
eduord <- ordered(edu, levels=c("h", "u", "p"))
eduord

## orders with labels
eduord <- ordered(edu, 
                  levels = c("h", "u", "p"), 
                  labels = c("high school", "undergraduate", "postgraduate"))
eduord

# Matrices (values, rows, columns)
mat1 <- matrix(4, 5, 6)
mat1

mat2 <- matrix(seq(1, 12), 3, 4)
mat2

mat3 <- matrix(rep(2, 10), 5, 2)
mat3

mat4 <- matrix(seq(1, 12), 3, 4, byrow = TRUE)
mat4

mat5 <- matrix(seq(1, 12), 3, 5, byrow = TRUE)
mat5

mat5
mat5[2, 3:5]
mat5[-2, 3:5]
mat5[2, c(3, 5)] # select specific values c(N,N)
mat5[mat5>10]

v1 <- c(1 ,2, 3)
v2 <- c(2, 5, 6)
v1+v2
v1*v2
v1/v2

# normal distribution (rnorm) 
mat6 <- matrix(rnorm(10, 5, 2), 3, 4)
mat6
mat7 <- matrix(rnorm(10, 2, 5), 4, 3)
mat7
mat6+mat6
mat6%*%mat7

# data frames
?data.frame
mydatafr_c <- data.frame(cbind(c(2,1,5)),c(3,5,6))
colnames(mydatafr_c) <- c("Column1", "Column2")
mydatafr_c

colnames(mydatafr_c) <- c("Column_1", "Column_2")
mydatafr_c[,2]
mydatafr_c$Column_2

mydatafr_c$Name <- c("Joe", "Louis", "Susan")

# Lists
a = 3
b = c(2,6)
c = matrix(4, 3, 5)
d = c("Joe", "Martin", "Jessica")

mylist <- list(a, b, c, d)
mylist

## nest lists
mylist2 <- list(a, b, c, d, mylist)
mylist2
mylist2[[2]]
mylist2[[2]][2]
mylist2[[5]][[2]][2]

mylist2 <- list(a=a, b=b, c=c, d=d, e=mylist)
mylist2
mylist2$b[2]
mylist2$c[2,4]
