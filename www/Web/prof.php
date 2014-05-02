<?php
require '../Library/autoload.php';
if(file_exists('../Applications/Prof/ProfApplication.class.php')) {
	$app = new Applications\Prof\ProfApplication($start);
	$app->run();
} else {
	$app = new Applications\Install\InstallApplication($start);
	$app->run();
}
?>