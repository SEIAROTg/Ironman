###

adjusted random

LPART: sin(π / (optimum - minimum) * (x - minimum) - π/2) + 1, minimum <= x <= optimum
RPART: sin(π / (maximum - optimum) * (maximum - x) - π/2) + 1, optimum <= x <= maximum

###

_adjusted_random = (minimum, optimum, maximum) ->

	calc_area = (x) ->
		left_integrate = (x) ->
			x - ((optimum - minimum) * Math.sin(Math.PI * (x - minimum) / (optimum - minimum))) / Math.PI
		right_integrate = (x) ->
			x + ((maximum - optimum) * Math.sin(Math.PI * (maximum - x) / (maximum - optimum))) / Math.PI

		if (x <= optimum)
			left_integrate(x) - left_integrate(minimum)
		else
			right_integrate(x) - right_integrate(optimum) + left_integrate(optimum) - left_integrate(minimum)

	areas = Array.apply(null, new Array(maximum - minimum + 1)).map (currentValue, index, array) ->
		calc_area(index + minimum)

	random = Math.random() * areas[maximum - minimum]

	for area, index in areas when area > random
		return index + minimum
	maximum


adjusted_random = (minimum, optimum, maximum) ->
	_adjusted_random(minimum - 1, optimum - 0.5, maximum)

module.exports = adjusted_random
