# regression-simulations

Simulations of standard errors, confidence intervals, statistical significance, and omitted variable bias in regression analysis. Scripts are written in R.


## Source the Regression Simulation Code



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

