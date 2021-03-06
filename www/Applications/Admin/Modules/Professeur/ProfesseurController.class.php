<?php
namespace Applications\Admin\Modules\Professeur;

class ProfesseurController extends \Library\BackController
{
	public function executeIndex(\Library\HTTPRequest $request)
	{
		$this->page->addVar('title', 'myAdmin - Liste des professeurs');
		$this->page->addVar('class_user', "active");
		$this->page->addVar('class_prof', "active");
		$this->page->addVar('listeProfesseur', $this->managers->getManagerOf('Professeur')->getList());
		$this->page->addVar('matiere', $this->managers->getManagerOf('Matiere'));
	

		// Cas de modification
		if ($request->postExists('modifier')) {
			if ($request->postExists('check')) {
				$check = $request->postData('check');
				if (count($check) > 1) {
					$this->app->user()->setFlash('<script>noty({timeout: 4000,type: "warning", layout: "top", text: "<strong>Attention !</strong> Vous ne pouvez modifier qu\'un professeur à la fois"});</script>');
				} else {
					$this->app->httpResponse()->redirect('/admin/professeurs/modifier-'.$check[0]);
				}
			} else {
				$this->app->user()->setFlash('<script>noty({timeout: 4000,timeout: 10000,type: "warning", layout: "top", text: "<strong>Attention !</strong> Vous devez sélectionner au moins un professeur pour le modifier"});</script>');
			}
			
		// Cas de suppression
		} else if ($request->postExists('supprimer')) {
			if ($request->postExists('check')) {
				$check = $request->postData('check');
				$delete = array();
				for ($i = 0; $i < count($check); $i++) {
					$delete[$i] = $this->managers->getManagerOf('Professeur')->getUnique($check[$i]);
				}
				$this->page->addVar('delete', $delete);
				$this->page->updateVar('includes',  __DIR__.'/Views/modal_delete.php');
				$this->page->updateVar('js', "<script>$('#modalDeleteProf').modal('show');</script>");
			} else {
				$this->app->user()->setFlash('<script>noty({timeout: 4000,type: "warning", layout: "top", text: "<strong>Attention !</strong> Vous devez sélectionner au moins un professeur pour le supprimer"});</script>');
			}
		}
	}

	public function executeAjout(\Library\HTTPRequest $request)
	{
		$this->page->addVar('title', 'myAdmin - Nouveau professeur');
		$this->page->addVar('class_user', "active");
		$this->page->addVar('class_prof', "active");
		$this->page->addVar('listeMatiere', $this->managers->getManagerOf('Matiere')->getList());

		if($request->postExists('annuler')) {
			$this->app->httpResponse()->redirect('/admin/professeurs');
		}
		
		if($request->postExists('ajouter')) {
			$mdp = $this->app->key()->getNewSalt(8);
			$salt = $this->app->key()->getNewSalt(40);
			
			$username = strtolower(substr($request->postData('prenom'),0,1).$request->postData('nom'));
			
			$professeur = new \Library\Entities\Professeur(array(
				"username" => $username,
				"nom" => $request->postData('nom'),
				"prenom" => $request->postData('prenom'),
				"email" => $request->postData('email'),
				"salt" => $salt,
				"password" => sha1(md5(sha1(md5($salt)).sha1(md5($mdp)).sha1(md5($salt)))),
				"token" => $this->app->key()->getNewSalt(40),
				"matiere" => unserialize(base64_decode($request->postData('matiere')))
			));
			
			if($professeur->isValid()) {
				$record = $this->managers->getManagerOf('Professeur')->save($professeur);
				$http = $_SERVER['HTTPS'] == 'on' ? 'https' : 'http';
				if($record == false)
				{
					$message = '<h3>Bonjour, '.$professeur->nom().' '.$professeur->prenom().'</h3>
									<p class="lead">Nous vous souhaitons la bienvenue sur myLearn</p>
									<p>Votre compte a été créé, vous pouvez maintenant activer votre compte en suivant le lien ci-dessous, pour pourrez vous connecter avec les identifiants suivants :
									<ul><li><strong>Username :</strong> '.$professeur->username().'</li>
									<li><strong>Mot de passe :</strong> '.$mdp.'</li></ul>
									</p>
									<p class="callout">
										Pour activer votre compte  <a href="'.$http.'://'.$_SERVER['HTTP_HOST'].'/connexion/'.$professeur->token().'"> cliquez ici!</a>
									</p>';
				
					$encoded = $this->app->key()->encode($message);
					$crypt = new \Library\Entities\Crypt(array(
						"id" => $professeur->token(),
						"message" => $encoded['crypted'],
						"cle" => $encoded['key']
						));
					$this->managers->getManagerOf('Crypt')->add($crypt);
				
					$sujet = 'Activation de votre compte';
					$this->app->mail()->setMail($professeur->email());
					$this->app->mail()->setMessage($sujet, $message);
					$this->app->mail()->setSujet($sujet);
				
				
					$envoi = $this->app->mail()->send();
					if($envoi == 1)
					{
						$this->app->user()->setFlash('<script>noty({timeout: 4000,type: "success", layout: "topCenter", text: "Enregistrement du professeur réussi"});</script>');
					}
					else
					{
						$this->app->user()->setFlash('<script>noty({timeout: 4000,type: "error", layout: "topCenter", text: "'.$envoi.'"});</script>');
					}
				
					$this->app->httpresponse()->redirect('/admin/professeurs');
				}
				else
				{
					$this->app->user()->setFlash('<script>noty({timeout: 4000,type: "'.$record->type().'", layout: "topCenter", text: "'.$record->message().'"});</script>');
					$this->page->addVar('professeur', $professeur);
				}
				
			} else {
				$this->page->addVar('erreurs', $professeur['erreurs']);
				$this->page->addVar('professeur', $professeur);
			}
		}
	}

	public function executeModif(\Library\HTTPRequest $request)
	{
		$professeur = $this->managers->getManagerOf('Professeur')->getUnique($request->getData('id'));
		if($professeur != NULL) {
			$this->page->addVar('title', 'myAdmin - Modifier '.$professeur['nom']);
			$this->page->addVar('class_user', "active");
			$this->page->addVar('class_prof', "active");
			$this->page->addVar('professeur', $professeur);
			$this->page->addVar('listeMatiere', $this->managers->getManagerOf('Matiere')->getList());

			if($request->postExists('annuler')) {
				$this->app->httpResponse()->redirect('/admin/professeurs');
			}

			if($request->postExists('modifier')) {
			
				$prof = new \Library\Entities\Professeur(array(
					"id" => $professeur['id'],
					"username" => strtolower($request->postData('username')),
					"nom" => $request->postData('nom'),
					"prenom" => $request->postData('prenom'),
					"email" => $request->postData('email'),
					"password" => $professeur['password'],
					"salt" => $professeur['salt'],
					"token" => $professeur['token'],
					"active" => $professeur['active'],
					"matiere" => unserialize(base64_decode($request->postData('matiere')))
				));
			
				if($prof->isValid()) {
					$this->managers->getManagerOf('Professeur')->save($prof);
					$this->app->user()->setFlash('<script>noty({timeout: 4000,type: "success", layout: "topCenter", text: "Modification réussie"});</script>');
					$this->app->httpresponse()->redirect('/admin/professeurs');
				} else {
					$this->page->addVar('erreurs', $prof['erreurs']);
					$this->page->addVar('professeur', $prof);
				}
			}

		} else {
			$this->app->httpresponse()->redirect('/admin/professeurs');
		}
	}

	public function executeDelete(\Library\HTTPRequest $request)
	{
		for ($i=0; $i < $request->postData('count'); $i++) {
			$suppr = unserialize(base64_decode($request->postData('suppr_'.$i)));
				$this->managers->getManagerOf('Professeur')->delete($suppr);
			}
		$this->app->user()->setFlash('<script>noty({timeout: 4000,type: "success", layout: "topCenter", text: "<strong>Suppression réussie !</strong>"});</script>');
		$this->app->httpResponse()->redirect('/admin/professeurs');
	}
}
?>