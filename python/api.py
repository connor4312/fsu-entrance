import sys
import json

sys.argv.pop(0)

if not len(sys.argv): sys.argv = ['']

if sys.argv[0] == 'list':
	json_data=open('../source.json')
	data = json.load(json_data)

	for item in data:
		if (item['country'] != sys.argv[1]):
			continue;

		parts = [int(i) for i in item['first_ip'].split('.')]
		nscore1 = (16777216 * parts[0]) + (65536 * parts[1]) + (256 * parts[2]) + parts[3]
		parts = [int(i) for i in item['last_ip'].split('.')]
		nscore2 = (16777216 * parts[0]) + (65536 * parts[1]) + (256 * parts[2]) + parts[3]

		while nscore1 < nscore2:
			o1 = (nscore1 / 16777216 ) % 256
			o2 = (nscore1 / 65536    ) % 256
			o3 = (nscore1 / 256      ) % 256
			o4 = (nscore1            ) % 256

			address = '.'.join([str(i) for i in [o1, o2, o3, o4]]) # This is algorithim from the MaxMind docs
			print(address)

			nscore1 += 1
	

elif sys.argv[0] == 'locate':
	json_data = open('../source.json')
	data = json.load(json_data)

	parts = [int(i) for i in sys.argv[1].split('.')]
	score = (16777216 * parts[0]) + (65536 * parts[1]) + (256 * parts[2]) + parts[3] # This is algorithim from the MaxMind docs

	for item in data:
		parts = [int(i) for i in item['first_ip'].split('.')]
		nscore1 = (16777216 * parts[0]) + (65536 * parts[1]) + (256 * parts[2]) + parts[3]
		parts = [int(i) for i in item['last_ip'].split('.')]
		nscore2 = (16777216 * parts[0]) + (65536 * parts[1]) + (256 * parts[2]) + parts[3]

		if score >= nscore1 and score <= nscore2:
			print(item);
			sys.exit(0)

	print('No matches found :S')

	

elif sys.argv[0] == 'entries':
	json_data = open('../source.json')
	data = json.load(json_data)
	print(data)
	

else:
	print('Commands: entries, locate [ip], list [country]');
	


print("\n");