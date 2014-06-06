Zfsstats.filter 'seconds', ->
	return (seconds) ->
		index = 0
		units = ['s', 'm', 'h']
		while (seconds / 60) >= 1 && index < 2
			index++
			seconds = seconds / 60
		return Math.round(seconds) + units[index]