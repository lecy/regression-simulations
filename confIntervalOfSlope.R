# CONFIDENCE INTERVAL AROUND THE SLOPE


confIntervalOfSlope <- function( num.trials=100, samp.size=10, effect.size=1, slowSim=F )
{

	slopes <- NULL
	
	stan.error <- NULL
	
	ci.lower <- NULL
	
	ci.upper <- NULL

	x <- 1:100 
	z <- effect.size*x + rnorm(100, 0, 100)
	

	for( i in 1:num.trials )
	{

		samp.id <-sample( x, samp.size )
		
		x2 <- x[samp.id]
		
		z2 <- z[samp.id]
		
		r1 <- lm( z2 ~ x2 )		
		
		slopes[i] <- r1$coefficients[2]
		
		par( mfrow=c(1,2) )
		
		if( slowSim==T ) { par(ask=TRUE) }   # HAVE TO CLICK ON GRAPH FOR NEXT ONE
				
		if( slowSim==F ) { par(ask=FALSE) }
		
		
		
		
		plot( x, z, xlim= c(0,100),
		      main="Regression Simulation", xlab="Class Size", ylab="Test Performance" )

		points( x2, z2, pch=8, cex=2, col="blue" )

		abline( a=0, b=effect.size )

		abline( a= r1$coefficients[1], b= r1$coefficients[2], col="red", lwd=2 )
	
		
		stan.error[i] <- sqrt( sum( r1$residuals^2 ) / samp.size-2 ) / sqrt( (samp.size-1)*var(x2) )
		
		ci.lower[i] <- slopes[i] + qt(0.025, samp.size )*stan.error[i]
		
		ci.upper[i] <- slopes[i] + qt(0.975, samp.size )*stan.error[i]
		

		
		plot( x=0, y=0, ylim=c(0,num.trials), xlim=c(effect.size-10, 
		      effect.size+10), col="white", xlab="Slope", ylab="Trial #",
		      main="95% Confidence Interval" )
		
		points( slopes, 1:i, pch=20, col="red"  )
		
             	segments( x0=ci.lower, y0=1:i, x1 = ci.upper, col="dark green" )
             	
             	abline( v=effect.size, col="blue" )
             	
             	abline( v=0, lty=2 )
                
	
	}
	
	return( )


}




