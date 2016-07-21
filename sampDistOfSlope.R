# SAMPLING DISTRIBUTION OF THE SLOPE


sampDistOfSlope <- function( num.trials=1000, samp.size=10, slowSim=F )
{

	slopes1 <- NULL

	x <- 1:100 
	z <- x + rnorm(100, 0, 100)

	for( i in 1:num.trials )
	{

		samp.id <-sample( x, samp.size )
		
		x2 <- x[samp.id]
		
		z2 <- z[samp.id]
		
		r1 <- lm( z2 ~ x2 )		
		
		slopes1[i] <- r1$coefficients[2]
		
		par( mfrow=c(1,2) )
		
		if( slowSim==T ) { par(ask=TRUE) }   # HAVE TO CLICK ON GRAPH FOR NEXT ONE
		
		if( slowSim==F ) { par(ask=FALSE) }

		
		plot( x, z, xlim= c(0,100), ylim=c(-300, 300 ),
		      main="Regression Simulation", xlab="Class Size", ylab="Test Performance" )

		points( x2, z2, pch=8, cex=2, col="blue" )

		abline( a=0, b=1 )

		abline( a= r1$coefficients[1], b= r1$coefficients[2], col="red", lwd=2 )
		
		hist( slopes1, col="red", xlim=c(-5, 6), ylim=c(0,num.trials/4), breaks=25, main="True Slope = 1" )

	
	}
	
	return( slopes1 )


}


# USE:
#
# sampDistOfSlope( num.trials=1000, samp.size=10, slowSim=F )
