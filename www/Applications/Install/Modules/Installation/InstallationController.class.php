<?php
namespace Applications\Install\Modules\Installation;

class InstallationController extends \Library\BackController
{
	public function executeIndex(\Library\HTTPRequest $request)
	{
		if($request->getExists('lost')) {
			$this->app->httpresponse()->redirect('/');
		}
		$this->page->addVar('title', 'myLearn - Première installation');
	}
	
	public function executeInit1(\Library\HTTPRequest $request)
	{
		if($request->postExists('previous')) {
			$this->app->httpresponse()->redirect('/');
		}
		$this->page->addVar('title', 'myLearn - Vérifications');
		$erreur = array();
		
		$php = phpversion();
		$php = explode('.', $php);
		if ($php[0] >= 5 && $php[1] >= 2) {
			$php = '<span class="label label-success"><i class="fa fa-check"></i> </span>';
		} else {
			$php = '<span class="label label-danger"><i class="fa fa-times"></i> </span>';
			$erreur[] = "php";
		}
		
		if (in_array ("mod_rewrite", apache_get_modules())) {
			$mod = '<span class="label label-success"><i class="fa fa-check"></i> </span>';
		} else {
			$mod = '<span class="label label-danger"><i class="fa fa-times"></i> </span>';
			$erreur[] = "rewrite";
		}
		
		if(extension_loaded("mcrypt")) {
			$mcrypt = '<span class="label label-success"><i class="fa fa-check"></i> </span>';
		} else {
			$mcrypt = '<span class="label label-danger"><i class="fa fa-times"></i> </span>';
			$erreur[] = "mcrypt";
		}
		
		$conf = array();
		$conf['admin'] = is_writable("../Applications/Admin/Config/");
		if ($conf['admin']) {
			$conf['admin'] = '<span class="label label-success"><i class="fa fa-check"></i> </span>';
		} else {
			$conf['admin'] = '<span class="label label-danger"><i class="fa fa-times"></i> </span>';
			$erreur[] = "admin";
		}
		$conf['frontend'] = is_writable("../Applications/Frontend/Config/");
		if ($conf['frontend']) {
			$conf['frontend'] = '<span class="label label-success"><i class="fa fa-check"></i> </span>';
		} else {
			$conf['frontend'] = '<span class="label label-danger"><i class="fa fa-times"></i> </span>';
			$erreur[] = "frontend";
		}
		$conf['json'] = is_writable("../Applications/Json/Config/");
		if ($conf['json']) {
			$conf['json'] = '<span class="label label-success"><i class="fa fa-check"></i> </span>';
		} else {
			$conf['json'] = '<span class="label label-danger"><i class="fa fa-times"></i> </span>';
			$erreur[] = "json";
		}
		$conf['prof'] = is_writable("../Applications/Prof/Config/");
		if ($conf['prof']) {
			$conf['prof'] = '<span class="label label-success"><i class="fa fa-check"></i> </span>';
		} else {
			$conf['prof'] = '<span class="label label-danger"><i class="fa fa-times"></i> </span>';
			$erreur[] = "prof";
		}
		
		$app = array();
		$app['admin'] = is_writable("../Applications/Admin/AdminApplication.back.class.php");
		if ($app['admin']) {
			$app['admin'] = '<span class="label label-success"><i class="fa fa-check"></i> </span>';
		} else {
			$app['admin'] = '<span class="label label-danger"><i class="fa fa-times"></i> </span>';
			$erreur[] = "admin";
		}
		$app['frontend'] = is_writable("../Applications/Frontend/FrontendApplication.back.class.php");
		if ($app['frontend']) {
			$app['frontend'] = '<span class="label label-success"><i class="fa fa-check"></i> </span>';
		} else {
			$app['frontend'] = '<span class="label label-danger"><i class="fa fa-times"></i> </span>';
			$erreur[] = "frontend";
		}
		$app['json'] = is_writable("../Applications/Json/JsonApplication.back.class.php");
		if ($app['json']) {
			$app['json'] = '<span class="label label-success"><i class="fa fa-check"></i> </span>';
		} else {
			$app['json'] = '<span class="label label-danger"><i class="fa fa-times"></i> </span>';
			$erreur[] = "json";
		}
		$app['prof'] = is_writable("../Applications/Prof/ProfApplication.back.class.php");
		if ($app['prof']) {
			$app['prof'] = '<span class="label label-success"><i class="fa fa-check"></i> </span>';
		} else {
			$app['prof'] = '<span class="label label-danger"><i class="fa fa-times"></i> </span>';
			$erreur[] = "prof";
		}
		
		$dir = array();
		$dir['admin'] = is_writable("../Applications/Admin/");
		if ($dir['admin']) {
			$dir['admin'] = '<span class="label label-success"><i class="fa fa-check"></i> </span>';
		} else {
			$dir['admin'] = '<span class="label label-danger"><i class="fa fa-times"></i> </span>';
			$erreur[] = "admin";
		}
		$dir['frontend'] = is_writable("../Applications/Frontend/");
		if ($dir['frontend']) {
			$dir['frontend'] = '<span class="label label-success"><i class="fa fa-check"></i> </span>';
		} else {
			$dir['frontend'] = '<span class="label label-danger"><i class="fa fa-times"></i> </span>';
			$erreur[] = "frontend";
		}
		$dir['json'] = is_writable("../Applications/Json/");
		if ($dir['json']) {
			$dir['json'] = '<span class="label label-success"><i class="fa fa-check"></i> </span>';
		} else {
			$dir['json'] = '<span class="label label-danger"><i class="fa fa-times"></i> </span>';
			$erreur[] = "json";
		}
		$dir['prof'] = is_writable("../Applications/Prof/");
		if ($dir['prof']) {
			$dir['prof'] = '<span class="label label-success"><i class="fa fa-check"></i> </span>';
		} else {
			$dir['prof'] = '<span class="label label-danger"><i class="fa fa-times"></i> </span>';
			$erreur[] = "prof";
		}
		
		if (empty($erreur)) {
			$this->page->addVar('next', '');
			if($request->postExists('next')) {
				$this->app->user()->setAttribute('step1', 'ok');
				$this->app->httpresponse()->redirect('/install-2');
			}
		} else {
			$this->page->addVar('next', 'disabled');
			$this->app->user()->setAttribute('step1', 'error');
		}
		
		
		
		$message = !empty($erreur) ? "<p><span class='text-danger'>Veuillez corriger les erreurs et recharger cette page</span></p>" : "";
		
		$this->page->addVar('php', $php);
		$this->page->addVar('conf', $conf);
		$this->page->addVar('app', $app);
		$this->page->addVar('dir', $dir);
		$this->page->addVar('message', $message);
		$this->page->addVar('mod', $mod);
		$this->page->addVar('mcrypt',$mcrypt);
	}
	
	public function executeInit2(\Library\HTTPRequest $request)
	{
		if($this->app->user()->getAttribute('step1') != 'ok') {
			$this->app->httpresponse()->redirect('/install-1');
		} else {
			//echo '<pre>';print_r($_SESSION);echo '</pre>';
			//echo '<pre>';print_r(unserialize(base64_decode($this->app->user()->getAttribute('bdd'))));echo '</pre>';
			if($this->app->user()->getAttribute('step2') == 'ok') {
				$this->page->addVar('bdd', unserialize(base64_decode($this->app->user()->getAttribute('bdd'))));
				$this->page->addVar('message', '<p><span class="text-success">Connexion réussie</span></p>');
				$this->page->addVar('next', '');
			} else {
				$this->page->addVar('next', 'disabled');
			}
			
			if($request->postExists('previous')) {
				$this->app->httpresponse()->redirect('/install-1');
			}
			
			if($request->postExists('next')) {
				$this->app->httpresponse()->redirect('/install-3');
			}
			
			if($request->postExists('connexion')) {
				$bdd = array(
					"hote" => $request->postData('hote'),
					"base" => $request->postData('base'),
					"user" => $request->postData('user'),
					"password" => $request->postData('password')
				);
				$erreur = array();
				foreach ($bdd as $donnee => $value) {
					if(empty($value)) {
						$erreur[] = $donnee;
						$this->app->user()->setAttribute('step2', 'error');
					}
				}
				if(empty($erreur)) {
					try {
						$dbh = new \PDO('mysql:host='.$bdd['hote'].';dbname='.$bdd['base'], $bdd['user'], $bdd['password']);
						$dbh->setAttribute(\PDO::ATTR_ERRMODE, \PDO::ERRMODE_WARNING);
					} catch (\PDOException $e) {
						$erreur[] = "bdd";
						$this->app->user()->setAttribute('step2', 'error');
						$this->page->addVar('message', '<p><span class="text-danger">Connexion échouée, veuillez vérifier les informations</span></p>');
						$this->app->user()->setAttribute('bdd', NULL);
					}
					if(empty($erreur)) {
						$this->app->user()->setAttribute('step2', 'ok');
						$this->app->user()->setAttribute('bdd', base64_encode(serialize($bdd)));
						$this->page->addVar('next', '');
						$this->page->addVar('message', '<p><span class="text-success">Connexion réussie</span></p>');
					} else {
						$this->page->addVar('next', 'disabled');
						$this->page->addVar('erreur', $erreur);
					}
				} else {
					$this->page->addVar('next', 'disabled');
					$this->page->addVar('erreur', $erreur);
				}
				$this->page->addVar('bdd', $bdd);
			}
		}
				
		$this->page->addVar('title', 'myLearn - Informations BDD');		
	}
	
	public function executeInit3(\Library\HTTPRequest $request)
	{
		if($this->app->user()->getAttribute('step1') == 'ok') {
			if($this->app->user()->getAttribute('step2') == 'ok') {
				if($this->app->user()->getAttribute('step3') == 'ok') {
					$this->page->addVar('infos', unserialize(base64_decode($this->app->user()->getAttribute('infos'))));
					//echo '<pre>';print_r(unserialize(base64_decode($this->app->user()->getAttribute('infos'))));echo '</pre>';
				}
				if($request->postExists('previous')) {
					$this->app->httpresponse()->redirect('/install-2');
				}
			
				if($request->postExists('next')) {
					$infos = array(
						"nom" => $request->postData('nom'),
						"description" => $request->postData('description'),
						"contact" => $request->postData('contact')
					);
					$erreur = array();
					foreach ($infos as $donnee => $value) {
						if(empty($value)) {
							$erreur[] = $donnee;
							$this->app->user()->setAttribute('step3', 'error');
							$this->app->user()->setAttribute('infos', NULL);
						}
					}
					if(empty($erreur)) {
						$this->app->user()->setAttribute('step3', 'ok');
						$this->app->user()->setAttribute('infos', base64_encode(serialize($infos)));
						$this->app->httpresponse()->redirect('/install-4');
					} else {
						$this->page->addVar('infos', $infos);
						$this->page->addVar('erreur', $erreur);
					}
				}
				
			} else {
				$this->app->httpresponse()->redirect('/install-2');
			}
		} else {
			$this->app->httpresponse()->redirect('/install-1');
		}
		$this->page->addVar('title', 'myLearn - Informations');
	}
	
	public function executeInit4(\Library\HTTPRequest $request)
	{
		if($this->app->user()->getAttribute('step1') == 'ok') {
			if($this->app->user()->getAttribute('step2') == 'ok') {
				if($this->app->user()->getAttribute('step3') == 'ok') {
					if($this->app->user()->getAttribute('step4') == 'ok') {
						$this->page->addVar('smtp', unserialize(base64_decode($this->app->user()->getAttribute('smtp'))));
						$this->page->addVar('message', '<p><span class="text-success">Connexion réussie</span></p>');
						$this->page->addVar('next', '');
					} else {
						$this->page->addVar('next', 'disabled');
					}
					
					if($request->postExists('previous')) {
						$this->app->httpresponse()->redirect('/install-3');
					}
					
					if($request->postExists('next')) {
						$this->app->httpresponse()->redirect('/install-5');
					}
					
					if($request->postExists('connexion')) {
						$smtp = array(
							"host" => $request->postData('host'),
							"port" => $request->postData('port'),
							"user" => $request->postData('user'),
							"password" => $request->postData('password'),
							"envoi" => $request->postData('envoi')
						);
						$erreur = array();
						foreach ($smtp as $donnee => $value) {
							if(empty($value)) {
								$erreur[] = $donnee;
								$this->app->user()->setAttribute('step4', 'error');
							}
						}
						if(empty($erreur)) {
							$sujet = 'Test de configuration STMP myLearn';
							$mail = 'Test de configuration SMTP de l\'établissement'.unserialize(base64_decode($this->app->user()->getAttribute('infos')))['nom'];
							$this->app->mail()->setMail("mikael.popowicz@gmail.com");
							$this->app->mail()->setMessage($sujet, $mail);
							$this->app->mail()->setSujet($sujet);
							$this->app->mail()->setHost($smtp['host']);
							$this->app->mail()->setPort($smtp['port']);
							$this->app->mail()->setUsername($smtp['user']);
							$this->app->mail()->setPassword($smtp['password']);
							$this->app->mail()->setSender($smtp['envoi']);
							$envoi = $this->app->mail()->send();
							if($envoi != 1)
							{
								$erreur[] = "smtp";
								$this->app->user()->setAttribute('step4', 'error');
								$this->page->addVar('message', '<p><span class="text-danger">'.$envoi.'</span></p>');
							}
							if(empty($erreur)) {
								$this->app->user()->setAttribute('step4', 'ok');
								$this->app->user()->setAttribute('smtp', base64_encode(serialize($smtp)));
								$this->page->addVar('next', '');
								$this->page->addVar('message', '<p><span class="text-success">Connexion réussie</span></p>');
							} else {
								$this->page->addVar('next', 'disabled');
								$this->page->addVar('erreur', $erreur);
							}
						} else {
							$this->page->addVar('next', 'disabled');
							$this->page->addVar('erreur', $erreur);
						}
						$this->page->addVar('smtp', $smtp);
					}
					
				} else {
					$this->app->httpresponse()->redirect('/install-3');
				}
			} else {
				$this->app->httpresponse()->redirect('/install-2');
			}
		} else {
			$this->app->httpresponse()->redirect('/install-1');
		}
		$this->page->addVar('title', 'myLearn - Configuration email');
	}
	
	public function executeInit5(\Library\HTTPRequest $request)
	{
		if($this->app->user()->getAttribute('step1') == 'ok') {
			if($this->app->user()->getAttribute('step2') == 'ok') {
				if($this->app->user()->getAttribute('step3') == 'ok') {
					if($this->app->user()->getAttribute('step4') == 'ok') {
					
						if($request->postExists('finish')) {
							$this->app->user()->delUser();
							$this->app->user()->setFlash('<script>noty({type: "success", layout: "top", text: "<strong>Installation terminée !</strong>"});</script>');
							$this->app->httpresponse()->redirect('/');
						}
					
						$this->page->addVar('finish', 'disabled');
						$erreur = array();
						$date = new \DateTime(date('Y-m-d'));					
						$bdd = unserialize(base64_decode($this->app->user()->getAttribute('bdd')));
						$infos = unserialize(base64_decode($this->app->user()->getAttribute('infos')));
						$smtp = unserialize(base64_decode($this->app->user()->getAttribute('smtp')));
						$cle_taille = mcrypt_module_get_algo_key_size(MCRYPT_3DES);
						$iv_taille = mcrypt_get_iv_size(MCRYPT_3DES, MCRYPT_MODE_NOFB);
						$iv = mcrypt_create_iv($iv_taille, MCRYPT_RAND);
					
						// Génération de la configuration
						$this->app->config()->setVar('db_host', $this->app->key()->encode($bdd['hote'], $this->app->key()->key())['crypted']);
						$this->app->config()->setVar('db_name', $this->app->key()->encode($bdd['base'], $this->app->key()->key())['crypted']);
						$this->app->config()->setVar('db_user', $this->app->key()->encode($bdd['user'], $this->app->key()->key())['crypted']);
						$this->app->config()->setVar('db_user_pass', $this->app->key()->encode($bdd['password'], $this->app->key()->key())['crypted']);
						$this->app->config()->setVar('conf_nom', $infos['nom']);
						$this->app->config()->setVar('conf_description', $infos['description']);
						$this->app->config()->setVar('conf_email', $smtp['envoi']);
						$this->app->config()->setVar('conf_contact', $infos['contact']);
						$this->app->config()->setVar('conf_date', $date->format('d/m/Y'));
						$this->app->config()->setVar('cryp_iv', base64_encode($this->app->key()->iv()));
						$this->app->config()->setVar('cryp_key', base64_encode($this->app->key()->key()));
						$this->app->config()->setVar('smtp_host', $this->app->key()->encode($smtp['host'], $this->app->key()->key())['crypted']);
						$this->app->config()->setVar('smtp_port', $this->app->key()->encode($smtp['port'], $this->app->key()->key())['crypted']);
						$this->app->config()->setVar('smtp_user', $this->app->key()->encode($smtp['user'], $this->app->key()->key())['crypted']);
						$this->app->config()->setVar('smtp_pass', $this->app->key()->encode($smtp['password'], $this->app->key()->key())['crypted']);
						$this->app->config()->setVar('cours_page', "5");
						$this->app->config()->setVar('installed', 'true');
						$write = $this->app->config()->save();
						if($write == false)
						{
							$erreur[] = "infos";
						}
						$dir = array('Frontend', 'Admin', 'Prof','Json');
						foreach ($dir as $key) {
							rename("../Applications/".$key."/".$key."Application.back.class.php", "../Applications/".$key."/".$key."Application.class.php");
						}
					
						$sql = "";
						$pdo1 = fopen('../Applications/Install/Modules/Installation/mylearn.sql', 'r');
						while (!feof($pdo1)) {
							$sql .= fgets($pdo1, 12040);
						}
						fclose($pdo1);
						/*
						$dba = new \PDO('mysql:host='.$bdd['hote'].';dbname=information_schema', $bdd['user'], $bdd['password']);
						$dba->setAttribute(\PDO::ATTR_ERRMODE, \PDO::ERRMODE_WARNING);
						$query = $dba->query("DELETE FROM TABLES WHERE TABLE_NAME = 'mylearn'");
						*/
						$dbh = new \PDO('mysql:host='.$bdd['hote'].';dbname='.$bdd['base'], $bdd['user'], $bdd['password']);
						$dbh->setAttribute(\PDO::ATTR_ERRMODE, \PDO::ERRMODE_WARNING);
						$query = $dbh->exec($sql);
						if(!isset($query)) {
							$erreur[] = "bdd";
						}
						//echo '<pre>';print_r($str2);echo '</pre>';
						$conf = !in_array('infos', $erreur) ? '<span class="label label-success"><i class="fa fa-check"></i> </span>' : '<span class="label label-danger"><i class="fa fa-times"></i> </span>';
						$db = !in_array('bdd', $erreur) ? '<span class="label label-success"><i class="fa fa-check"></i> </span>' : '<span class="label label-danger"><i class="fa fa-times"></i> </span>';
					
						if(empty($erreur)) {
							$this->page->addVar('finish', '');
							$message = "<p><span class='text-success'>Installation réussie</span></p><p>Pour votre première connexion veuillez utiliser le login <strong><span class='text-info'>admin</span></strong> et le mot de passe <strong><span class='text-info'>admin</span></strong></p>";
						} else {
							$message = "<p><span class='text-danger'>L'installation à échouée. Veuillez supprimer la BDD et recommencer !</span></p>";
						}
					
						$this->page->addVar('conf', $conf);
						$this->page->addVar('db', $db);
						$this->page->addVar('message', $message);
					
						if($request->postExists('previous')) {
							$this->app->httpresponse()->redirect('/install-3');
						}
					} else {
						$this->app->httpresponse()->redirect('/install-4');
					}					
				} else {
					$this->app->httpresponse()->redirect('/install-3');
				}
			} else {
				$this->app->httpresponse()->redirect('/install-2');
			}
		} else {
			$this->app->httpresponse()->redirect('/install-1');
		}
		$this->page->addVar('title', 'myLearn - Installation terminée');
	}
}
?>