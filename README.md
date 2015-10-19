# regression-simulations

Simulations of standard errors, confidence intervals, statistical significance, and omitted variable bias in regression analysis. Scripts are written in R.


## Source the Regression Simulation Code

~~~r

# Load required packages 
library( RCurl )

# confidenceIntervalOfSlope function:

# Create an object for the function URL
url.01 <- "https://raw.githubusercontent.com/lecy/regression-simulations/master/confIntervalOfSlope.R"

# Use getURL from RCurl to source the code
my.script <- getURL( url.01, ssl.verifypeer = FALSE )

# Evaluate the code to initiate the function in R
eval( parse( text=my.script  ) )



# createSample function

url.02 <- "https://raw.githubusercontent.com/lecy/regression-simulations/master/createSample.R"
create.sample <- getURL( url.02, ssl.verifypeer = FALSE )
eval( parse( text=create.sample  ) )

rm( url.02 )
rm( create.sample )

# sampling distribution of the slope function

url.03 <- "https://raw.githubusercontent.com/lecy/regression-simulations/master/sampDistOfSlope.R"
samp.distritution.of.slope <- getURL( url.03, ssl.verifypeer = FALSE )
eval( parse( text=samp.distritution.of.slope  ) )

rm( url.03 )
rm( samp.distritution.of.slope )


# size of bias function

url.04 <- "https://raw.githubusercontent.com/lecy/regression-simulations/master/sizeOfBias.R"
size.of.bias <- getURL( url.04, ssl.verifypeer = FALSE )
eval( parse( text=samp.size.of.bias  ) )

rm( url.04 )
rm( size.of.bias )



~~~


## FUNCTION createSample

Demonstrates drawing a sample of given size from the population (works up to 100). 

~~~r
	createSample( 10 )

	createSample( 25 )
~~~





## SAMPLING DISTRIBUTION OF SLOPE



~~~r
	sampDistOfSlope( num.trials=1000, samp.size=10, slowSim=F )


	sampDistOfSlope( num.trials=1000, samp.size=50, slowSim=F )


	sampDistOfSlope( num.trials=1000, samp.size=75, slowSim=F )
~~~






## CONFIDENCE INTERVALS

~~~r
	confIntervalOfSlope( num.trials=100, samp.size=10, effect.size=3, slowSim=T )
	
	
	# One way to ensure statistical significance - increase sample size

	confIntervalOfSlope( num.trials=100, samp.size=75, effect.size=3, slowSim=F )
	
	
	# Another way - increase effect size

	confIntervalOfSlope( num.trials=100, samp.size=10, effect.size=7, slowSim=F )

~~~



## OMITTED VARIABLE BIAS

~~~r

	# First show the bias in the slopes

	sizeOfBias( num.trials=500, samp.size=25, corr.strength=10, confInt=F )

	# Then show what the confidence intervals would look like

	sizeOfBias( num.trials=500, samp.size=25, corr.strength=10, confInt=T )

	# Does increasing the sample size fix bias?

	sizeOfBias( num.trials=500, samp.size=75, corr.strength=10, confInt=T )

~~~




## RANDOM MEASUREMENT ERROR


### Measurement Error added to the DV

Measurement error in the dependent variable increases the amount of variance there is to explain, but does not impact the correlation between the DV and IVs, therefore does not change the slope (on average). 

The result is to increase the standard error of all regression coefficients without introducing bias into the model.

~~~r

# Visual representation of add measurement error to the DV

slopes1 <- NULL

x <- 1:100 

for( i in 1:1000 )
{

	z <- x + rnorm(100, 0, i/10)
	plot( x, z, xlim= c(0,100), ylim=c(-300, 300 ), pch=19, col="gray" )
	abline( a=0, b=1 )
	r1 <- lm( z ~ x )
	abline( a= r1$coefficients[1], b= r1$coefficients[2], col="red", lwd=2 )

	slopes1[i] <- r1$coefficients[2]

}

~~~




### Measurement Error Added to the IV

Measurement error added to the independent variable X does bias the slope, but in a very specific way. It increases the variance of X, but does not change the correlation between X and Y, and therefore moves the slope closer to zero since the slope is defined as ~ cov(x,y) / var(x).

This is called attenuation bias.

Since the variance of X increases, this also decreases the standard error of the slope coefficient.

~~~r

## POSITIVE SLOPE
   
slopes2 <- NULL

for( i in 1:1000 )
{

	x <- 1:100 
	z <- x + rnorm(100, 0, i/10)
	y <- 2*x + 10*rnorm(100)

	r2 <- lm( y ~ z )

	plot( z, y, xlim= c(-300,300), ylim=c(-500, 500 ), pch=19, col="gray"  )
	abline( a=0, b=2 )
	abline( a= r2$coefficients[1], b= r2$coefficients[2], col="red", lwd=2 )

	# slopes2[i] <- r2$coefficients[2]

}

~~~


~~~r

## NEGATIVE SLOPE

slopes2 <- NULL

for( i in 1:1000 )
{

	x <- 1:100 
	z <- x + rnorm(100, 0, i/10)
	y <- -2*x + 10*rnorm(100)

	r2 <- lm( y ~ z )

	plot( z, y, xlim= c(-300,300), ylim=c(-500, 500 ), pch=19, col="gray"  )
	abline( a=0, b=-2 )
	abline( a= r2$coefficients[1], b= r2$coefficients[2], col="red", lwd=2 )

	# slopes2[i] <- r2$coefficients[2]

}

~~~


## Create Animated GIF of Simulations

The package 'animation' provides a nice way to create animated GIFs from the simulation functions. These can be embedded in power points or used on websites.

The program ImageMagick must be installed on your machine.

http://www.imagemagick.org/script/index.php

~~~r

# install.packages( "animation" )

library( animation )

# copy the path to the convert.exe file in your programs folder
ani.options( convert = 'C:/Program Files/ImageMagick-6.9.2-Q16/convert.exe' )

saveGIF( expr={ confIntervalOfSlope( num.trials=100, samp.size=10, effect.size=3, slowSim=F ) }, 
         movie.name = "brownian_motion.gif", 
         interval = 0.1, 
         nmax = 100, 
         ani.width = 1200,
         ani.height = 600
       )

~~~

Alternatively, you can create a bunch of .png image files, then use a website like this to create the animation for you:

http://gifmaker.me/


