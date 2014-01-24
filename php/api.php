<?php

array_shift($argv);

switch ($argv[0]) {

	case 'list':
		$data = json_decode(file_get_contents('../source.json'), true);
		foreach ($data as $item) {
			if ($item['country'] != $argv[1]) continue;

			$parts = explode('.', $item['first_ip']);
			$nscore1 = (16777216 * $parts[0]) + (65536 * $parts[1]) + (256 * $parts[2]) + $parts[3];
			$parts = explode('.', $item['last_ip']);
			$nscore2 = (16777216 * $parts[0]) + (65536 * $parts[1]) + (256 * $parts[2]) + $parts[3];

			while ($nscore1 < $nscore2) {
				$o1 = ($nscore1 / 16777216 ) % 256;
				$o2 = ($nscore1 / 65536    ) % 256;
				$o3 = ($nscore1 / 256      ) % 256;
				$o4 = ($nscore1            ) % 256;

				$address = implode('.', array($o1, $o2, $o3, $o4)); // This is algorithim from the MaxMind docs
				echo "$address\n";

				$nscore1 += 1;
			}
		}

		echo 'No matches found :S';
		break;

	case 'locate':
		$data = json_decode(file_get_contents('../source.json'), true);
		$parts = explode('.', $argv[1]);
		$score = (16777216 * $parts[0]) + (65536 * $parts[1]) + (256 * $parts[2]) + $parts[3]; // This is algorithim from the MaxMind docs

		foreach ($data as $item) {
			$parts = explode('.', $item['first_ip']);
			$nscore1 = (16777216 * $parts[0]) + (65536 * $parts[1]) + (256 * $parts[2]) + $parts[3];
			$parts = explode('.', $item['last_ip']);
			$nscore2 = (16777216 * $parts[0]) + (65536 * $parts[1]) + (256 * $parts[2]) + $parts[3];

			if ($score >= $nscore1 && $score <= $nscore2) {
				print_r($item);
				die();
			}
		}

		echo 'No matches found :S';

		break;

	case 'entries':
		print_r(json_decode(file_get_contents('../source.json'), true));
		break;

	case 'help':
	default:
		echo 'Commands: entries, locate [ip], list [country]';
		break;
}

echo "\n";