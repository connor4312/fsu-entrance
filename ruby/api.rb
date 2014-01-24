require 'rubygems'
require 'json'

case ARGV[0]
when 'list'
	data = JSON.parse(IO.read('../source.json'))

	for item in data
		if item['country'] != ARGV[1]
			next
		end

		parts = item['first_ip'].split('.')
		nscore1 = (16777216 * parts[0].to_i) + (65536 * parts[1].to_i) + (256 * parts[2].to_i) + parts[3].to_i
		parts = item['last_ip'].split('.')
		nscore2 = (16777216 * parts[0].to_i) + (65536 * parts[1].to_i) + (256 * parts[2].to_i) + parts[3].to_i

		while nscore1 < nscore2
			o1 = (nscore1 / 16777216 ) % 256
			o2 = (nscore1 / 65536    ) % 256
			o3 = (nscore1 / 256      ) % 256
			o4 = (nscore1            ) % 256

			address = [o1, o2, o3, o4].join('.') # This is algorithim from the MaxMind docs
			STDOUT.puts address 

			nscore1 += 1
		end
	end

when 'locate'
	data = JSON.parse(IO.read('../source.json'))

	parts = ARGV[1].split('.')
	score = (16777216 * parts[0].to_i) + (65536 * parts[1].to_i) + (256 * parts[2].to_i) + parts[3].to_i # This is algorithim from the MaxMind docs

	for item in data
		parts = item['first_ip'].split('.')
		nscore1 = (16777216 * parts[0].to_i) + (65536 * parts[1].to_i) + (256 * parts[2].to_i) + parts[3].to_i
		parts = item['last_ip'].split('.')
		nscore2 = (16777216 * parts[0].to_i) + (65536 * parts[1].to_i) + (256 * parts[2].to_i) + parts[3].to_i

		if score >= nscore1 and score <= nscore2
			STDOUT.puts item 
			abort('')
		end
	end

	STDOUT.puts 'No matches found :S '

	

when 'entries'
	data = JSON.parse(IO.read('../source.json'))
	STDOUT.puts data
	

else
	STDOUT.puts 'Commands: entries, locate [ip], list [country]' 
end
