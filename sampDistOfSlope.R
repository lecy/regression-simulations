


sampDistOfSlope <- function( num.trials=1000, samp.size=10, slowSim=F )
{

    slopes1 <- NULL

    x <- 1:100 
    z <- 400 + x + rnorm(100, 0, 100)

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


        plot( x, z, xlim= c(0,100), ylim=c(200, 750 ), xaxt="n", bty="n", pch=19, col=gray(0.5,0.5),
              main="Repeated Samples", xlab="", ylab="Test Performance" )

            title( xlab="Class Size", line=2 )

        points( x2, z2, pch=8, cex=2, lwd=2, col="darkorange3" )

        abline( a=400, b=1 )

        abline( a= r1$coefficients[1], b= r1$coefficients[2], col="darkorange3", lwd=2 )

        hist( slopes1, col="darkorange3", border="lightgray",
                  xlim=c(-5, 6), ylim=c(0,num.trials/5), breaks=seq(-10,10,0.5), 
                  xlab="True Slope = 1", main="Sampling Distribution", yaxt="n", ylab="" )


    }

    return( slopes1 )


}


#  USE:
#  
#  num.trials controls how many times sampling is repeated
#  samp.size determines how many points are selected in each draw
#  slowSim=T activates par( ask=T )
#  If slowSim=T then you have to click on the graph to advance it each time.
#
#  sampDistOfSlope( num.trials=1000, samp.size=10, slowSim=F )


library( animation )

saveGIF({

  sampDistOfSlope( num.trials=100, samp.size=50, slowSim=F )

}, 

movie.name = "samp-dist-of-slope-50.gif",   # name of your gif
interval = 0.1,                    # controls the animation speed
ani.width = 800,                   # size of the gif in pixels
ani.height = 400 )                 # size of the git in pixels

