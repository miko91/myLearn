<div class="row">
	<div class="col-lg-12">
		<ol class="breadcrumb">
			<li><a href="/admin">Accueil</a></li>
			<li class="active">Liste des sessions</li>
		</ol>
	</div>
</div>
<div class="row">
	<div class="col-lg-12">
		<form method="post" class="form-horizontal">
			<div class="well">
				<span class="text-success"><strong><i class="fa fa-share fa-lg"></i> Actions sur la sélection :</strong></span>
				<button type="submit" name="modifier"class="btn btn-primary">
					<i class="fa fa-edit fa-fw"></i> Modifier
				</button>
				<button type="submit" name="supprimer"class="btn btn-warning">
					<i class="fa fa-trash-o fa-fw"></i> Supprimer
				</button>
				<div class="pull-right">
					<a href="/admin/sessions/nouvelle-session" class="btn btn-success">
						<i class="fa fa-plus-square-o"></i> Ajouter
					</a>
				</div>
			</div>
			
			<table class="table table-striped table-hover table-bordered datatable" id="planTab">
				<thead>
					<tr>
						<th width="50 px"><input name="check_all" id="check_all" type="checkbox"></th>
						<th>Session</th>
						<th>Statut</th>
					</tr>
				</thead>
				<tbody id='tabs'>
					<?php
					if (isset($listeSession) && is_array($listeSession)) {
						foreach($listeSession as $session) {
							$en_cours = "";
							if($control->enCours() == $session['id'])
							{
								$en_cours = "<span class='label label-info'>En cours</span>";
							}
							echo "<tr>";
							echo "\n\t\t\t\t\t\t\t<td>";
							echo "\n\t\t\t\t\t\t\t\t<input name='check[]' type='checkbox' value=".$session['id'].">";
							echo "\n\t\t\t\t\t\t\t</td>";
							echo "\n\t\t\t\t\t\t\t<td>\n\t\t\t\t\t\t\t\t";
							echo "<a href='/admin/sessions/".$session['id']."'>".$session->session();
							echo "\n\t\t\t\t\t\t\t</td>";
							echo "\n\t\t\t\t\t\t\t<td>\n\t\t\t\t\t\t\t\t".$en_cours."\n\t\t\t\t\t\t\t</td>";
							echo "\n\t\t\t\t\t\t</tr>\n";
						}
					}
					?>
				</tbody>
			</table>
			
		</form>
	</div>
</div>