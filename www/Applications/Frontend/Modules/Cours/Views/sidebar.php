<section class="span3 sidebar secondary-column"> 
	<aside class="widget clearfix">
		<h5 class="short_headline"><span>Matières</span></h5>
		<ul class="navigation">
			<?php
			if(isset($matieres)) {
				foreach($matieres as $cat) {
					echo "<li><a href='/cours/".$cat['libelle']."'>".$cat['libelle']."</a>";
				}
			}
			?>
		</ul>
	</aside>

	<aside class="widget">
		<h5 class="short_headline"><span>Cours</span></h5>
		<div class="tab-pane">
			<div class="tabbable">
				<ul class="nav nav-pills">
					<li class="active"><a href="#latest" data-toggle="tab">Derniers</a></li>
					<li><a href="#popular" data-toggle="tab">Populaires</a></li>
				</ul>
				<div class="tab-content">
					<div id="latest" class="tab-pane active">
						<ul class="blogposts clearfix">
							<?php
							if(is_array($coursLast) && !empty($coursLast)) {
								foreach($coursLast as $last) {
									
							?>
							<!--required class-->
							<li>
								<a href="/cours/<?php echo $matController->getUnique($last['matiere'])['libelle']."/".$last['id']?>">
									<span class="date">
										<span class="month"><?php echo $last['dateAjout']->format('M');?></span>
										<span class="day"><?php echo $last['dateAjout']->format('d');?></span>
										<span class="year"><?php echo $last['dateAjout']->format('Y');?></span>
									</span>
									<h3><?php echo $last['titre'];?></h3>
									<p><?php echo $last['description'];?></p>
								</a>
							</li>
							<?php
								}
							} else {
								echo "<li><p class='text-info'>Il n'y a encore aucun cours</p></li>";
							}
							?>
						</ul>
					</div>
					<div id="popular" class="tab-pane">
						<ul class="blogposts clearfix">
							<?php
							if(is_array($coursPop) && !empty($coursPop)) {
								foreach($coursPop as $pop) {
							?>
							<!--required class-->
							<li>
								<a href="/cours/<?php echo $matController->getUnique($pop['matiere'])['libelle']."/".$pop['id']?>">
									<span class="date">
										<span class="month"><?php echo $pop['dateAjout']->format('M');?></span>
										<span class="day"><?php echo $pop['dateAjout']->format('d');?></span>
										<span class="year"><?php echo $pop['dateAjout']->format('Y');?></span>
									</span>
									<h3><?php echo $pop['titre'];?></h3>
									<p><?php echo $pop['description'];?></p>
								</a>
							</li>
							<?php
								}
							} else {
								echo "<li><p class='text-info'>Il n'y a encore aucun cours</p></li>";
							}
							?>
						</ul>
					</div>
					<!--close #popular -->								
				</div>
				<!-- /.tab-content -->
			</div>
			<!-- /.tabbable -->
		</div>
		<!-- /.tab-pane --> 
	</aside>
	<!-- close .widget containing blog tabs-->
</section>
<!--close section sidebar span3-->