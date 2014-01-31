trained

very args is plz process.argv.splice with 2

rly args[0] is 'list'
	very data is so '../source.json'
	much very i as 0 next i smaller data.length next i more 1
		very item is data[i];

		rly item.country not args[1] continue

		very parts is plz item.first_ip.split with '.'
		very nscore1 is (16777216 * (plz parseInt with parts[0], 10)) + (65536 * (plz parseInt with parts[1], 10)) + (256 * (plz parseInt with parts[2], 10)) + (plz parseInt with parts[3], 10);
		very parts is plz item.last_ip.split with'.'
		very nscore2 is (16777216 * (plz parseInt with parts[0], 10)) + (65536 * (plz parseInt with parts[1], 10)) + (256 * (plz parseInt with parts[2], 10)) + (plz parseInt with parts[3], 10);

		many nscore1 smaller nscore2

			very o1 is (plz Math.floor with (nscore1 / 16777216 )) % 256
			very o2 is (plz Math.floor with (nscore1 / 65536    )) % 256
			very o3 is (plz Math.floor with (nscore1 / 256      )) % 256
			very o4 is (plz Math.floor with (nscore1            )) % 256

			very address is plz [o1, o2, o3, o4].join with '.'
			plz console.log with address

			nscore1 more 1
		wow
	wow
but rly args[0] is 'locate'
		very data is so '../source.json'
		very parts is plz args[1].split with '.'
		very score is (16777216 * (plz parseInt with parts[0], 10)) + (65536 * (plz parseInt with parts[1], 10)) + (256 * (plz parseInt with parts[2], 10)) + (plz parseInt with parts[3], 10)

		much very i as 0 next i smaller data.length next i more 1
			very item is data[i]
			very parts is plz item.first_ip.split with '.'
			very nscore1 is (16777216 * (plz parseInt with parts[0], 10)) + (65536 * (plz parseInt with parts[1], 10)) + (256 * (plz parseInt with parts[2], 10)) + (plz parseInt with parts[3], 10)
			very parts is plz item.last_ip.split with '.'
			very nscore2 is (16777216 * (plz parseInt with parts[0], 10)) + (65536 * (plz parseInt with parts[1], 10)) + (256 * (plz parseInt with parts[2], 10)) + (plz parseInt with parts[3], 10

			rly score biggerish nscore1 and score smallerish nscore2
				plz console.log with item
				plz process.exit with 1
			wow
		wow
but rly args[0] is 'entries'
	plz console.log with so '../source.json'
but
	plz console.log with 'Commands: entries, locate [ip], list [country]'
wow