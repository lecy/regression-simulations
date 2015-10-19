# UNDERSTANDING OMITTED VARIABLE BIAS
#
# True Model:  Z = 2*X - 2*Y + e
#
# Vary cor( x,y ) from -1 to +1


sizeOfBias <- function( num.trials=100, samp.size=50, corr.strength=10, confInt=F )
{

	slopes <- NULL
	
	stan.error <- NULL
	
	ci.lower <- NULL
	
	ci.upper <- NULL
	
	
	
	
	slopes2 <- NULL
	
	stan.error2 <- NULL
	
	ci.lower2 <- NULL
	
	ci.upper2 <- NULL
	
	
	
	cor.xy <- NULL

	x <- 1:100 
	

	

	for( i in 1:num.trials )
	{

		y <- corr.strength*( 2*i/num.trials - 1 )*x + rnorm(100,0,50)
		
		z <- 2*x - 2*y + rnorm(100, 0, 100)
		
		cor.xy[i] <- cor( x, y )
		
		samp.id <- sample( x, samp.size )
		
		x2 <- x[samp.id]
		
		y2 <- y[samp.id]
		
		z2 <- z[samp.id]
		
		r1 <- lm( z2 ~ x2 )
		
		r2 <- lm( z2 ~ x2 + y2 )
		

		
		# r2 <- lm( pr2$residuals ~ pr1$residuals )
		
		
		
		slopes[i] <- r1$coefficients[2]
		
		slopes2[i] <- r2$coefficients[2]
		
		if( confInt==F ) { par( mfrow=c(1,2) ) }
		
                if( confInt==T ) { par( mfrow=c(2,2) ) }
		



	
		plot( x, (z+2*y), xlim= c(0,100), ylim=c(-2000,2000),
		      main="Full Model: Y = X1 + X2", xlab="Class Size", ylab="Test Performance" )

		# points( x2, z2, pch=8, cex=2, col="blue" )

		abline( a=0, b=2 )

		abline( a= r2$coefficients[1], b= r2$coefficients[2], col="red", lwd=2 )
		
		
		
		
		plot( x, z, xlim= c(0,100), ylim=c(-2000,2000),
		      main="Naive Model: Y = X1", xlab="Class Size", ylab="Test Performance" )

		# points( x2, z2, pch=8, cex=2, col="blue" )

		abline( a=0, b=2 )

		abline( a= r1$coefficients[1], b= r1$coefficients[2], col="red", lwd=2 )
		
		
		


                if( confInt==T )
                {
                
                

                # Confidence intervals for the FULL model

		stan.error2[i] <- sqrt( sum( r2$residuals^2 ) / samp.size-2 ) / sqrt( (samp.size-1)*var(x2) )
		
		ci.lower2[i] <- slopes2[i] + qt(0.025, samp.size )*stan.error2[i]
		
		ci.upper2[i] <- slopes2[i] + qt(0.975, samp.size )*stan.error2[i]
		

		
		plot( x=0, y=0, ylim=c(0,num.trials), xlim=c(2-2*corr.strength, 2+2*corr.strength), col="white", xlab="Slope Estimate", ylab="" )
		
		points( slopes2, 1:i, pch=20, col="red"  )
		
             	segments( x0=ci.lower2, y0=1:i, x1 = ci.upper2, col="dark green" )
             	
             	abline( v=2, col="blue" )
             	
             	abline( v=0, lty=2 )
             	
             	
             	
             	
             	
             	
             	# Confidence intervals for the NAIVE model
		
		stan.error[i] <- sqrt( sum( r1$residuals^2 ) / samp.size-2 ) / sqrt( (samp.size-1)*var(x2) )
		
		ci.lower[i] <- slopes[i] + qt(0.025, samp.size )*stan.error[i]
		
		ci.upper[i] <- slopes[i] + qt(0.975, samp.size )*stan.error[i]
		

		
		plot( x=0, y=0, ylim=c(0,num.trials), xlim=c(2-2*corr.strength, 2+2*corr.strength), col="white", xlab="Slope Estimate", ylab="" )
		
		points( slopes, 1:i, pch=20, col="red"  )
		
             	segments( x0=ci.lower, y0=1:i, x1 = ci.upper, col="dark green" )
             	
             	abline( v=2, col="blue" )
             	
             	abline( v=0, lty=2 )
             	
             	
             	}
             	
             	
             	
             	
             	
             	
	
	}
	
	return( )


}


# USE:
#
# sizeOfBias( num.trials=500, samp.size=25, corr.strength=10, confInt=F )



