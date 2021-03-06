<?php
namespace Library;

class HTTPResponse
{
	protected $page;
	protected $app;
	
	public function __construct(Application $app) {
		$this->app = $app;
	}
	

	public function addHeader($header)
	{
		header($header);
	}

	public function redirect($location)
	{
		header('Location: '.$location);
		exit;
	}

	public function redirect404($page = array())
	{
		$this->page = new Page($this->app);
		if ($page instanceof \Library\Page)
		{
			$vars = $page->getVars();
			if(is_array($vars))
			{
				foreach ($vars as $var => $value) {
					$this->page->addVar($var,$value);
				}
			}
		}
		$this->page->setContentFile(__DIR__.'/../Errors/404.html');
		$this->page->addVar('title', '404 Page non trouvée');
		$this->addHeader('HTTP/1.0 404 Not Found');
     
		$this->send();
	}
	
	public function redirect503()
	{
		$this->page = new Page($this->app);
		$this->page->setContentFile(__DIR__.'/../Errors/503.html');
		$this->page->addVar('title', '503 Service temporairement indisponible');
		$this->addHeader('HTTP/1.1 503 Service Temporarily Unavailable');
		$this->addHeader('Status: 503 Service Temporarily Unavailable');;
     
		$this->send();
	}

	public function send()
	{
		// Actuellement, cette ligne a peu de sens dans votre esprit.
		// Promis, vous saurez vraiment ce qu'elle fait d'ici la fin du chapitre
		// (bien que je suis sûr que les noms choisis sont assez explicites !).
		exit($this->page->getGeneratedPage());
	}

	public function setPage(Page $page)
	{
		$this->page = $page;
	}

	// Changement par rapport à la fonction setcookie() : le dernier argument est par défaut à true.
	public function setCookie($name, $value = '', $expire = 0, $path = null, $domain = null, $secure = false, $httpOnly = true)
	{
		setcookie($name, $value, $expire, $path, $domain, $secure, $httpOnly);
	}
}