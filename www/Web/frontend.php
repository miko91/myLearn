<?php
$start = microtime(true);
require '../Library/autoload.php';
require '../Library/PHPMailer/class.phpmailer.php';
if(file_exists('../Applications/Frontend/FrontendApplication.class.php') && file_exists('../Applications/Frontend/Config/app.xml')) {
	$app = new Applications\Frontend\FrontendApplication($start);
	$app->run();
} else {
	$app = new Applications\Install\InstallApplication($start);
	$app->run();
}
?>