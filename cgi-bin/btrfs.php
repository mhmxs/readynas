<?php

#ini_set('display_errors', 1);
#ini_set('display_startup_errors', 1);
#error_reporting(E_ALL);

function execute($command) {
    $out = "";
    if (!($p = popen("($command)2>&1", "r"))) { 
        return "command.error 1\n";
    }

    while (!feof($p)) {
        $line = fgets($p, 1000);
        $out .= $line;
    }
    pclose($p);
    return $out; 
}

$errors = execute("sudo /usr/bin/btrfs device stats /");
$lines = explode("\n", $errors);
$sum = array_sum(array_map(function($value) {
    return intval(preg_replace("/[^0-9]/", "", $value));
}, $lines));

echo "Total errors: ".$sum;
?>
