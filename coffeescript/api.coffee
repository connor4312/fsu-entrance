args = process.argv.splice 2
switch args[0]
	when "list"
		data = require "../source.json"

		for item in data
			continue unless item.country is args[1]

			parts = item.first_ip.split "."
			nscore1 = (16777216 * parseInt(parts[0], 10)) + (65536 * parseInt(parts[1], 10)) + (256 * parseInt(parts[2], 10)) + parseInt(parts[3], 10)
			parts = item.last_ip.split "."
			nscore2 = (16777216 * parseInt(parts[0], 10)) + (65536 * parseInt(parts[1], 10)) + (256 * parseInt(parts[2], 10)) + parseInt(parts[3], 10)
			
			while nscore1 < nscore2

				o1 = Math.floor (nscore1 / 16777216) % 256
				o2 = Math.floor (nscore1 / 65536) % 256
				o3 = Math.floor (nscore1 / 256) % 256
				o4 = Math.floor (nscore1) % 256

				address = [o1, o2, o3, o4].join "." # This is algorithim from the MaxMind docs
				console.log address
				nscore1 += 1

	when "locate"
		data = require "../source.json"
		parts = args[1].split "."
		score = (16777216 * parseInt(parts[0], 10)) + (65536 * parseInt(parts[1], 10)) + (256 * parseInt(parts[2], 10)) + parseInt(parts[3], 10) # This is algorithim from the MaxMind docs

		for item in data
			parts = item.first_ip.split "."
			nscore1 = (16777216 * parseInt(parts[0], 10)) + (65536 * parseInt(parts[1], 10)) + (256 * parseInt(parts[2], 10)) + parseInt(parts[3], 10)
			parts = item.last_ip.split "."
			nscore2 = (16777216 * parseInt(parts[0], 10)) + (65536 * parseInt(parts[1], 10)) + (256 * parseInt(parts[2], 10)) + parseInt(parts[3], 10)
			
			if score >= nscore1 and score <= nscore2
				console.log item
				process.exit 1

		console.log "No matches found :S"

	when "entries"
		console.log require("../source.json")

	else
		console.log "Commands: entries, locate [ip], list [country]"