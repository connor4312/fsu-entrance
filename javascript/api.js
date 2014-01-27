args = process.argv.splice(2);


switch (args[0]) {

	case 'list':
		data = require('../source.json');
		for (i = 0, j = data.length; i < j; i+= 1) {
			var item = data[i];

			if (item.country != args[1]) continue;

			var parts = item.first_ip.split('.');
			var nscore1 = (16777216 * parseInt(parts[0], 10)) + (65536 * parseInt(parts[1], 10)) + (256 * parseInt(parts[2], 10)) + parseInt(parts[3], 10);
			var parts = item.last_ip.split('.');
			var nscore2 = (16777216 * parseInt(parts[0], 10)) + (65536 * parseInt(parts[1], 10)) + (256 * parseInt(parts[2], 10)) + parseInt(parts[3], 10);

			while (nscore1 < nscore2) {

				var o1 = Math.floor((nscore1 / 16777216 ) % 256);
				var o2 = Math.floor((nscore1 / 65536    ) % 256);
				var o3 = Math.floor((nscore1 / 256      ) % 256);
				var o4 = Math.floor((nscore1            ) % 256);

				var address = [o1, o2, o3, o4].join('.'); // This is algorithim from the MaxMind docs
				console.log(address);

				nscore1 += 1;
			}
		}

		break;

	case 'locate':
		var data = require('../source.json');
		var parts = args[1].split('.');
		var score = (16777216 * parseInt(parts[0], 10)) + (65536 * parseInt(parts[1], 10)) + (256 * parseInt(parts[2], 10)) + parseInt(parts[3], 10); // This is algorithim from the MaxMind docs

		for (i = 0, j = data.length; i < j; i+= 1) {
			var item = data[i];
			var parts = item.first_ip.split('.');
			var nscore1 = (16777216 * parseInt(parts[0], 10)) + (65536 * parseInt(parts[1], 10)) + (256 * parseInt(parts[2], 10)) + parseInt(parts[3], 10);
			var parts = item.last_ip.split('.');
			var nscore2 = (16777216 * parseInt(parts[0], 10)) + (65536 * parseInt(parts[1], 10)) + (256 * parseInt(parts[2], 10)) + parseInt(parts[3], 10);

			if (score >= nscore1 && score <= nscore2) {
				console.log(item);
				process.exit(1);
			}
		}

		console.log('No matches found :S');

		break;

	case 'entries':
		console.log(require('../source.json'));
		break;

	default:
		console.log('Commands: entries, locate [ip], list [country]');
		break;
}
