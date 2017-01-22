


createSample <- function( samp.size=10 )
{


      # CREATE A DATASET WITH 100 POINTS
      #
      # z = b0 + b1*x  where b0=800, b1=-2

      x <- seq( 20, 40, length.out=100 )
    z <- 800 - 10*x + rnorm(100, 0, 100)

    # DRAW A SAMPLE

      samp.id <- sample( 1:100, samp.size )

    x2 <- x[samp.id]

    z2 <- z[samp.id]    

    plot( x, z, xlim= c(40,20), ylim=c(200,800), 
            bty="n", pch=19, col=gray(0.5,0.5), cex=1.2,
          main="Sampling Process in Regression", 
            xlab="Class Size", ylab="Test Performance" )

     text( 30, 700, 
           paste("SAMPLE SIZE \nOF", samp.size), col="darkred", cex=3 )

     Sys.sleep( 3 ) 


    for( i in 1:samp.size )
    {


       for( j in 100:2 )
       {   

            plot( x, z, xlim= c(40,20), ylim=c(200,800), 
                    bty="n", pch=19, col=gray(0.5,0.5), cex=1.2,
                  main="Sampling Process in Regression", 
                    xlab="Class Size", ylab="Test Performance" )

          if( i > 1 )
          {  points( x2[1:(i-1)], z2[1:(i-1)], pch=8, cex=2, col="darkred", lwd=2 )  }

          points( x2[i], z2[i], pch=8, cex=j, col="darkred", lwd=2 )

       }


    }


    plot( x, z, xlim= c(40,20), ylim=c(200,800), 
            bty="n", pch=19, col=gray(0.5,0.5), cex=1.2,
          main="Sampling Process to Estimate the Slope", 
            xlab="Class Size", ylab="Test Performance" )            

    points( x2, z2, pch=8, cex=j, col="darkred", lwd=2 )

    Sys.sleep( 2 )

    abline( a=800, b=-10, lwd=2 )

    text( 28, 300, "True Slope", cex=2, pos=4 )

    Sys.sleep( 2 )

    r1 <- lm( z2 ~ x2 )

    abline( a= r1$coefficients[1], b= r1$coefficients[2], col="darkred", lwd=2 )

    text( 28, 250, "Best Guess", col="darkred", cex=2, pos=4 )


}



# USE
# 
#  createSample( samp.size=10 )
