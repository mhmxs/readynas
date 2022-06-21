<?php

#ini_set('display_errors', 1);
#ini_set('display_startup_errors', 1);
#error_reporting(E_ALL);

$errors = 0;

foreach (array("/media/wd/data" => 3, "/home/carawonga/backup" => 2) as $d => $c) {
	$backups = exec("find " . $d . " -name *.ok -mtime -1 | wc -l");
	echo "backups " . $d . ": " . $backups . "\n";
	if ($backups != $c) {
        	echo "backups not completed\n";
        	$errors++;
	}
}

echo "Total errors: ".$errors;

?>
