Zfsstats.filter 'convertByteToUnit', ->
	return (bytes) ->
		index = 0
		units = ['Bytes', 'Kilobyte', 'Megabyte', 'Gigabyte', 'Terabyte', 'Petabyte', 'Zettabyte']
		while (bytes / 1024) >= 1 && index <  7
			index++
			bytes = bytes / 1024
		if index > 2 
			return (Math.round(bytes * 10) / 10) + ' ' + units[index]
		else
			return Math.round(bytes) + ' ' + units[index]