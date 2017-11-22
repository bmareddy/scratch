add2 <- function(x,y) {
    x+y
}

aboveN <- function(x, n=10) {
    use <- x>n
    x[use]
}

columnMean <- function(x) {
    nc <- ncol(x)
    means <- numeric(nc)
    for (i in 1:nc) {
        means[i] <- mean(x[,i])
    }
    means
}