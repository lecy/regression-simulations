# CONFIDENCE INTERVAL AROUND THE SLOPE


confIntervalOfSlope <- function( num.trials=100, samp.size=10, effect.size=1, slowSim=F )
{

	slopes <- NULL
	
	stan.error <- NULL
	
	ci.lower <- NULL
	
	ci.upper <- NULL

	x <- 1:100 
	z <- effect.size*x + rnorm(100, 0, 100)

      min.z <- min(z)
      max.z <- max(z)

      col.point.estimate <- rep( "gray40", num.trials )
      col.point.est.border <- rep( "gray40", num.trials )
      cex.point.estimate <- rep( 0.8, num.trials )
      col.ci <- rep( "gray40", num.trials )
      alpha.ci <- rep( 0.6, num.trials )
      lwd.ci <- rep( 1, num.trials )

      par( mar=c(5,1,4,1) )
	

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
		
		
		
		
		plot( x, z, xlim= c(0,100), bty="n", yaxt="n", xaxt="n",
		      main="Regression Simulation", xlab="", ylab="" )

		points( x2, z2, pch=8, cex=2, col="blue" )

		abline( a=0, b=effect.size, col="darkorange", lwd=2 )

		abline( a= r1$coefficients[1], b= r1$coefficients[2], col="blue", lwd=2.5, lty=3 )


            text( 80, min.z + 0.25*(max.z-min.z), "TRUE SLOPE", col="darkorange", cex=0.9, pos=4 )
            segments( x0=70, x1=78, y0=min.z + 0.25*(max.z-min.z), col="darkorange", lwd=2 )

            text( 80, min.z + 0.20*(max.z-min.z), "BEST GUESS", col="blue", cex=0.9, pos=4 )
            segments( x0=70, x1=78, y0= min.z + 0.20*(max.z-min.z), col="blue", lty=3, lwd=2 )

	

		
		stan.error[i] <- sqrt( sum( r1$residuals^2 ) / samp.size-2 ) / sqrt( (samp.size-1)*var(x2) )
		
		ci.lower[i] <- slopes[i] + qt(0.025, samp.size )*stan.error[i]
		
		ci.upper[i] <- slopes[i] + qt(0.975, samp.size )*stan.error[i]
		
		
		plot( x=0, y=0, ylim=c(0,num.trials), xlim=c(effect.size-10, 
		      effect.size+10), col="white", xlab="Slope", ylab="Trial #",
		      main="95% Confidence Interval",
                  bty="n", yaxt="n" )


		
            falls.outside.ci <- ci.upper[i] < effect.size | ci.lower[i] > effect.size


            if( falls.outside.ci )
            { 
                col.point.estimate[i] <- "steelblue" 
                col.point.est.border[i] <- "navy"
                col.ci[i] <- "steelblue"
                alpha.ci[i] <- 0.9
                lwd.ci[i] <- 2
                cex.point.estimate[i] <- 1.5
            }

            # darkorchid4
             segments( x0=ci.lower, y0=1:i, x1 = ci.upper, lwd=lwd.ci,
                       col=adjustcolor( col.ci, alpha.f = 0.7 )  )
             	
             points( slopes, 1:i, pch=21, cex=cex.point.estimate,
                     bg=adjustcolor( col.point.estimate , alpha.f = 0.7 ),
                     col=col.point.est.border )

             abline( v=effect.size, col="darkorange", lwd=2 )
             	
             abline( v=0, lty=2 )
                
	
	}
	
	return( )


}


# confIntervalOfSlope( num.trials=100, samp.size=10, effect.size=3, slowSim=F )







