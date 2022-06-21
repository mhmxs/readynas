<?php

#ini_set('display_errors', 1);
#ini_set('display_startup_errors', 1);
#error_reporting(E_ALL);

$errors = 0;

foreach (["wphu1"] as $name) {
	$success = exec('tail -10 $(find /home/carawonga/backup -name '.$name.'* -mtime -1 | tail -1) | grep "Dump completed"  | wc -l');
	if ($success != "1") {
		echo "dumps not completed\n";
		$errors++;
	}
}

echo "Total errors: ".$errors;

?>
