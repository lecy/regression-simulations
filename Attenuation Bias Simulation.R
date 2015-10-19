
# SAMPLING DISTRIBUTION OF THE SLOPE


sampDistOfSlope <- function( num.trials=1000 )
{

	slopes1 <- NULL

	x <- 1:100 
	z <- x + rnorm(100, 0, 100)

	for( i in 1:num.trials )
	{

		samp.id <-sample(x,10)
		
		x2 <- x[samp.id]
		
		z2 <- z[samp.id]
		
		r1 <- lm( z2 ~ x2 )		
		
		slopes1[i] <- r1$coefficients[2]
		
		stan.errs[i] <- r1$
		
		par( mfrow=c(1,2) )
		
		plot( x, z, xlim= c(0,100), ylim=c(-300, 300 ),
		      main="Regression Simulation", xlab="Class Size", ylab="Test Performance" )

		points( x2, z2, pch=8, cex=2, col="blue" )

		abline( a=0, b=1 )

		abline( a= r1$coefficients[1], b= r1$coefficients[2], col="red", lwd=2 )
		
		plot.new()

	
	}
	
	return( slopes1 )


}

slps <- sampDistOfSlope(1000)






# RANDOM MEASUREMENT DV

slopes1 <- NULL

x <- 1:100 

for( i in 1:1000 )
{

	z <- x + rnorm(100, 0, i/10)
	plot( x, z, xlim= c(0,100), ylim=c(-300, 300 ) )
	abline( a=0, b=1 )
	r1 <- lm( z ~ x )
	abline( a= r1$coefficients[1], b= r1$coefficients[2], col="red", lwd=2 )

	slopes1[i] <- r1$coefficients[2]

}

hist( slopes1, col="dark blue" )





# MEASUREMENT ERROR IN IV



## POSITIVE SLOPE
   
slopes2 <- NULL

for( i in 1:1000 )
{

	x <- 1:100 
	z <- x + rnorm(100, 0, i/10)
	y <- 2*x + 10*rnorm(100)

	r2 <- lm( y ~ z )

	plot( z, y, xlim= c(-300,300), ylim=c(-500, 500 ) )
	abline( a=0, b=2 )
	abline( a= r2$coefficients[1], b= r2$coefficients[2], col="red", lwd=2 )

	# slopes2[i] <- r2$coefficients[2]

}




## NEGATIVE SLOPE

slopes2 <- NULL

for( i in 1:1000 )
{

	x <- 1:100 
	z <- x + rnorm(100, 0, i/10)
	y <- -2*x + 10*rnorm(100)

	r2 <- lm( y ~ z )

	plot( z, y, xlim= c(-300,300), ylim=c(-500, 500 ) )
	abline( a=0, b=-2 )
	abline( a= r2$coefficients[1], b= r2$coefficients[2], col="red", lwd=2 )

	# slopes2[i] <- r2$coefficients[2]

}


