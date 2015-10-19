# SAMPLING FROM THE POPULATION OF 100


createSample <- function( samp.size=10 )
{

        
	par(ask=TRUE)
	
	x <- 1:100 
	z <- x + rnorm(100, 0, 100)
	
	samp.id <- sample( x, samp.size )
	
	x2 <- x[samp.id]
			
	z2 <- z[samp.id]
	
	
	plot( x, z, xlim= c(0,100), ylim=c(-300, 300 ),
	main="Regression Simulation", xlab="Class Size", ylab="Test Performance" )

	plot( x, z, xlim= c(0,100), ylim=c(-300, 300 ),
	main="Regression Simulation", xlab="Class Size", ylab="Test Performance" )
	
	par(ask=FALSE)
	


	for( i in 1:samp.size )
	{
	
	
	   for( j in 100:2 )
	   {   
	      
	      plot( x, z, xlim= c(0,100), ylim=c(-300, 300 ),
	        main="Regression Simulation", xlab="Class Size", ylab="Test Performance" )
	        
	      if( i > 1 )
	      {  points( x2[1:(i-1)], z2[1:(i-1)], pch=8, cex=2, col="blue" )  }
	      
	      points( x2[i], z2[i], pch=8, cex=j, col="blue" )
	         
	   }
	   
	   
	}
	
	
	par(ask=TRUE)
	
	
	plot( x, z, xlim= c(0,100), ylim=c(-300, 300 ),
	      main="Regression Simulation", xlab="Class Size", ylab="Test Performance" )
		        
		      
	points( x2, z2, pch=8, cex=j, col="blue" )
	
	abline( a=0, b=1 )
	
	
	
	
	
		
	plot( x, z, xlim= c(0,100), ylim=c(-300, 300 ),
		main="Regression Simulation", xlab="Class Size", ylab="Test Performance" )
			        
			      
	points( x2, z2, pch=8, cex=j, col="blue" )
		
	abline( a=0, b=1 )
	
	text( 80, -200, "True Slope" ) 
	
	r1 <- lm( z2 ~ x2 )
	
	abline( a= r1$coefficients[1], b= r1$coefficients[2], col="blue", lwd=2 )
	
	text( 80, -220, "Best Guess", col="blue" )

        par(ask=FALSE)
        

}

# USE
# 
# createSample( samp.size=10 )

		
