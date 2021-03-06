/**
*	Suppression des droits, de l'utilisateur et de la base si ils existent
*/
REVOKE ALL PRIVILEGES, GRANT OPTION FROM 'mylearn'@'localhost';
DROP USER 'mylearn'@'localhost';
DROP DATABASE IF EXISTS mylearn;
/**
*	Création de l'utilisateur, la base et affection des droits
*/
CREATE USER 'mylearn'@'localhost' IDENTIFIED BY  'mylearn';
CREATE DATABASE IF NOT EXISTS mylearn;
GRANT ALL PRIVILEGES ON  `mylearn` . * TO  'mylearn'@'localhost';

USE mylearn;



# /////////////////////////////////////////////////////////////////////////////
# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
# /////////////////////////////////////////////////////////////////////////////
# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
#
#       CREATION DES TABLES
#
# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
# /////////////////////////////////////////////////////////////////////////////
# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
# /////////////////////////////////////////////////////////////////////////////

# -----------------------------------------------------------------------------
#       TABLE : devoir
# -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS devoir
 (
   id_d INTEGER(2) NOT NULL  ,
   id_u INTEGER(2) NOT NULL  ,
   id_classe INTEGER(2) NOT NULL  ,
   dateDevoir DATE NULL  ,
   enonce VARCHAR(128) NULL  ,
   dateMax DATE NULL  
   , PRIMARY KEY (id_d) 
 ) 
 comment = "";
# -----------------------------------------------------------------------------
#       TABLE : user
# -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS user
 (
   id_u INTEGER(2) NOT NULL  ,
   username VARCHAR(128) NULL  ,
   nom VARCHAR(128) NULL  ,
   prenom VARCHAR(128) NULL  ,
   email VARCHAR(128) NULL  ,
   password VARCHAR(128) NULL  ,
   active BOOL NULL  ,
   salt VARCHAR(40) NULL  ,
   token VARCHAR(40) NULL ,
   dateUser DATE
   , PRIMARY KEY (id_u) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       TABLE : crypt
# -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS crypt
 (
   token VARCHAR(40) NOT NULL  ,
   message VARCHAR(1024) NULL  ,
   cle VARCHAR(32) NULL  ,
   PRIMARY KEY (token)
 )
 comment = "";

# -----------------------------------------------------------------------------
#       TABLE : administrateur
# -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS administrateur
 (
   id_u INTEGER(2) NOT NULL  ,
   poste VARCHAR(80)
   , PRIMARY KEY (id_u) 
 ) 
 comment = "";
# -----------------------------------------------------------------------------
#       TABLE : matiere
# -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS matiere
 (
   id_m INTEGER(2) NOT NULL AUTO_INCREMENT ,
   libelle VARCHAR(128) NULL  ,
   icon VARCHAR(32)
   , PRIMARY KEY (id_m) 
 ) 
 comment = "";
# -----------------------------------------------------------------------------
#       TABLE : professeur
# -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS professeur
 (
   id_u INTEGER(2) NOT NULL  ,
   id_m INTEGER(2) NOT NULL
   , PRIMARY KEY (id_u) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       TABLE : charger
# -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS charger
 (
   id_classe INTEGER NOT NULL  ,
   id_u INTEGER NOT NULL  ,
   PRIMARY KEY (id_classe,id_u)
 )
 comment = "";

# -----------------------------------------------------------------------------
#       TABLE : eleve
# -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS eleve
 (
   id_u INTEGER(2) NOT NULL  ,
   dateNaissance DATE NOT NULL
   , PRIMARY KEY (id_u) 
 ) 
 comment = "";
# -----------------------------------------------------------------------------
#       TABLE : etre
# -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS etre
 (
   id_u INTEGER(2) NOT NULL  ,
   id_classe INTEGER(2) NOT NULL
   , PRIMARY KEY (id_u,id_classe) 
 ) 
comment = "";
# -----------------------------------------------------------------------------
#       TABLE : session
# -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS session
 (
   id_session INTEGER NOT NULL AUTO_INCREMENT  ,
   session VARCHAR(128) NOT NULL  
   , PRIMARY KEY (id_session) 
 ) 
 comment = "";
# -----------------------------------------------------------------------------
#       TABLE : section
# -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS section
 (
   id_section INTEGER(2) NOT NULL AUTO_INCREMENT ,
   id_u INTEGER(2) NOT NULL  ,
   libelle VARCHAR(128) NOT NULL  
   , PRIMARY KEY (id_section) 
 ) 
 comment = "";
# -----------------------------------------------------------------------------
#       TABLE : gestionnaire
# -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS gestionnaire
 (
   id_u INTEGER(2) NOT NULL
   , PRIMARY KEY (id_u) 
 ) 
 comment = "";
# -----------------------------------------------------------------------------
#       TABLE : gerer
# -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS gerer
 (
   id_u INTEGER(2) NOT NULL  ,
   id_classe INTEGER(2) NOT NULL
   , PRIMARY KEY (id_u) 
 ) 
comment = "";
# -----------------------------------------------------------------------------
#       TABLE : classe
# -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS classe
 (
   id_classe INTEGER(2) NOT NULL AUTO_INCREMENT ,
   id_session INTEGER NOT NULL  ,
   id_section INTEGER(2) NOT NULL  ,
   libelle VARCHAR(128) NOT NULL  
   , PRIMARY KEY (id_classe) 
 ) 
 comment = "";
# -----------------------------------------------------------------------------
#       TABLE : cours
# -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS cours
 (
   id_cours INTEGER(2) NOT NULL  ,
   id_m INTEGER(2) NOT NULL  ,
   id_classe INTEGER(2) NOT NULL  ,
   id_u INTEGER(2) NOT NULL  ,
   titre VARCHAR(128) NULL  ,
   description VARCHAR(128) NULL  ,
   contenu TEXT NULL  ,
   dateAjout DATETIME NULL  ,
   dateModif DATETIME NULL  
   , PRIMARY KEY (id_cours) 
 ) 
 comment = "";
# -----------------------------------------------------------------------------
#       TABLE : vers_cours
# -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS vers_cours
 (
   id_cours INTEGER(2) NOT NULL  ,
   titre VARCHAR(128) NULL  ,
   description VARCHAR(128) NULL  ,
   contenu TEXT NULL  ,
   dateModif DATETIME NULL  
   , PRIMARY KEY (id_cours,dateModif) 
 ) 
comment = "";
# -----------------------------------------------------------------------------
#       TABLE : histo_cours
# -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS histo_cours
 (
   id_cours INTEGER(2) NOT NULL  ,
   id_m INTEGER(2) NOT NULL  ,
   id_classe INTEGER(2) NOT NULL  ,
   id_u INTEGER(2) NOT NULL  ,
   titre VARCHAR(128) NULL  ,
   description VARCHAR(128) NULL  ,
   contenu TEXT NULL  ,
   dateAjout DATETIME NULL  ,
   dateModif DATETIME NULL  ,
   dateHisto DATETIME NULL
   , PRIMARY KEY (id_cours) 
 ) 
comment = "";
# -----------------------------------------------------------------------------
#       TABLE : assigner
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS assigner
 (
   id_m INTEGER(2) NOT NULL  ,
   id_classe INTEGER(2) NOT NULL  
   , PRIMARY KEY (id_m,id_classe) 
 ) 
 comment = "";
# -----------------------------------------------------------------------------
#       TABLE : commenter
# -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS commenter
 (
   id_u INTEGER(2) NOT NULL  ,
   id_cours INTEGER(2) NOT NULL  ,
   dateCommentaire DATETIME NOT NULL  ,
   commentaire TEXT NOT NULL  
   , PRIMARY KEY (id_u,id_cours,dateCommentaire) 
 ) 
 comment = "";
# -----------------------------------------------------------------------------
#       TABLE : avoir
# -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS avoir
 (
   id_d INTEGER(2) NOT NULL  ,
   id_u INTEGER(2) NOT NULL  ,
   dateRendu DATE NULL  ,
   note DECIMAL(10,2) NULL  
   , PRIMARY KEY (id_d,id_u) 
 ) 
 comment = "";




# /////////////////////////////////////////////////////////////////////////////
# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
# /////////////////////////////////////////////////////////////////////////////
# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
#
#       REFERENCES DES TABLES
#
# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
# /////////////////////////////////////////////////////////////////////////////
# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
# /////////////////////////////////////////////////////////////////////////////

ALTER TABLE devoir 
  ADD FOREIGN KEY FK_devoir_professeur (id_u)
      REFERENCES professeur (id_u)
         ON DELETE CASCADE ;
ALTER TABLE devoir 
  ADD FOREIGN KEY FK_devoir_classe (id_classe)
      REFERENCES classe (id_classe)
         ON DELETE CASCADE ;
ALTER TABLE administrateur 
  ADD FOREIGN KEY FK_administrateur_user (id_u)
      REFERENCES user (id_u) ;
ALTER TABLE professeur 
  ADD FOREIGN KEY FK_professeur_matiere (id_m)
      REFERENCES matiere (id_m) ;
ALTER TABLE professeur 
  ADD FOREIGN KEY FK_professeur_user (id_u)
      REFERENCES user (id_u)
         ON DELETE CASCADE ;
ALTER TABLE eleve 
  ADD FOREIGN KEY FK_eleve_user (id_u)
      REFERENCES user (id_u)
         ON DELETE CASCADE ;
ALTER TABLE etre 
 ADD FOREIGN KEY FK_etre_eleve (id_u)
     REFERENCES eleve (id_u)
        ON DELETE CASCADE ;
ALTER TABLE etre 
ADD FOREIGN KEY FK_etre_classe (id_classe)
    REFERENCES classe (id_classe)
       ON DELETE CASCADE ;
ALTER TABLE gestionnaire 
  ADD FOREIGN KEY FK_gestionnaire_user (id_u)
      REFERENCES user (id_u)
         ON DELETE CASCADE ;
ALTER TABLE gerer 
  ADD FOREIGN KEY FK_gerer_gestionnaire (id_u)
      REFERENCES gestionnaire (id_u)
         ON DELETE CASCADE ;
ALTER TABLE gerer 
  ADD FOREIGN KEY FK_gerer_classe (id_classe)
      REFERENCES classe (id_classe)
         ON DELETE CASCADE ;
ALTER TABLE classe 
  ADD FOREIGN KEY FK_classe_session (id_session)
      REFERENCES session (id_session)
         ON DELETE CASCADE ;
ALTER TABLE classe 
  ADD FOREIGN KEY FK_classe_section (id_section)
      REFERENCES section (id_section)
         ON DELETE CASCADE ;
ALTER TABLE cours 
  ADD FOREIGN KEY FK_cours_matiere (id_m)
      REFERENCES matiere (id_m) ;
ALTER TABLE cours 
  ADD FOREIGN KEY FK_cours_classe (id_classe)
      REFERENCES classe (id_classe)
         ON DELETE CASCADE ;
ALTER TABLE cours 
  ADD FOREIGN KEY FK_cours_user (id_u)
      REFERENCES user (id_u)
         ON DELETE CASCADE ;
ALTER TABLE vers_cours 
   ADD FOREIGN KEY FK_vers_cours_cours (id_cours)
       REFERENCES cours (id_cours)
          ON DELETE CASCADE ;
ALTER TABLE assigner 
  ADD FOREIGN KEY FK_assigner_matiere (id_m)
      REFERENCES matiere (id_m)
         ON DELETE CASCADE ;
ALTER TABLE assigner 
  ADD FOREIGN KEY FK_assigner_classe (id_classe)
      REFERENCES classe (id_classe)
         ON DELETE CASCADE ;
ALTER TABLE commenter 
  ADD FOREIGN KEY FK_commenter_user (id_u)
      REFERENCES user (id_u)
         ON DELETE CASCADE ;
ALTER TABLE commenter 
  ADD FOREIGN KEY FK_commenter_cours (id_cours)
      REFERENCES cours (id_cours)
         ON DELETE CASCADE ;
ALTER TABLE avoir 
  ADD FOREIGN KEY FK_avoir_devoir (id_d)
      REFERENCES devoir (id_d)
         ON DELETE CASCADE ;
ALTER TABLE avoir 
  ADD FOREIGN KEY FK_avoir_eleve (id_u)
      REFERENCES eleve (id_u)
         ON DELETE CASCADE ;
ALTER TABLE charger 
  ADD FOREIGN KEY FK_charger_classe (id_classe)
      REFERENCES classe (id_classe)
         ON DELETE CASCADE ;
ALTER TABLE charger 
  ADD FOREIGN KEY FK_charger_professeur (id_u)
      REFERENCES professeur (id_u)
         ON DELETE CASCADE ;




# /////////////////////////////////////////////////////////////////////////////
# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
# /////////////////////////////////////////////////////////////////////////////
# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
#
#       REFERENCES DES TABLES
#
# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
# /////////////////////////////////////////////////////////////////////////////
# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
# /////////////////////////////////////////////////////////////////////////////

Delimiter @@

# -----------------------------------------------------------------------------
#       PROCEDURE : archiver_cours()
# -----------------------------------------------------------------------------

CREATE PROCEDURE archiver_cours(sess INTEGER)
BEGIN
Declare fini int default 0;
Declare cours, matiere, classe, user INTEGER(2);
Declare titre, description VARCHAR(128);
Declare contenu TEXT;
Declare dateAjout, dateModif DATETIME;
Declare curc CURSOR
  FOR SELECT co.id_cours, co.id_m, co.id_classe, co.id_u, co.titre, co.description, co.contenu, co.dateAjout, co.dateModif
    FROM cours co
    INNER JOIN classe cl ON co.id_classe = cl.id_classe
    INNER JOIN session s ON cl.id_session = s.id_session
    WHERE s.id_session = sess;
Declare continue HANDLER
  FOR NOT FOUND SET fini = 1;
Open curc;
FETCH curc INTO cours, matiere, classe, user, titre, description, contenu, dateAjout, dateModif;

While fini != 1
  DO
  INSERT INTO histo_cours VALUES(cours, matiere, classe, user, titre, description, contenu, dateAjout, dateModif, sysdate());
  DELETE FROM vers_cours WHERE id_cours = cours;
  DELETE FROM cours WHERE id_cours = cours;
  FETCH curc INTO cours, matiere, classe, user, titre, contenu, description, dateAjout, dateModif;
END While;
Close curc;
END @@

# -----------------------------------------------------------------------------
#       TRIGGER : version_cours (Versionning de cours)
# -----------------------------------------------------------------------------

CREATE TRIGGER version_cours
BEFORE UPDATE ON cours
FOR EACH ROW
BEGIN
  # Compter le nombre de versions existantes
  Declare versions int;
  SELECT COUNT(*) INTO versions
  FROM vers_cours
  WHERE id_cours = new.id_cours;
  # Suppression de la plus vielle version si il y en déjà 5
  IF versions > 4
  THEN
    # /!\ ATTENTION /!\ pour trouver le dateModif le plus petit, il faut utiliser une sous-requête avec un alias, car l'on cherche dans la table ou l'on veut supprimer cela bloque la table en question !!
    DELETE FROM vers_cours
    WHERE id_cours = new.id_cours
    AND dateModif in (
      SELECT * FROM (
        SELECT MIN(dateModif)
        FROM vers_cours
        WHERE id_cours = new.id_cours
      ) AS t
    );
  END IF;
  INSERT INTO vers_cours VALUES(new.id_cours,old.titre,old.description,old.contenu,sysdate());
  SET new.dateModif = sysdate();
END @@

# -----------------------------------------------------------------------------
#       PROCEDURE : restaurer_cours() (Restaurer un cours)
# -----------------------------------------------------------------------------

CREATE PROCEDURE restaurer_cours(id int, version DATETIME)
BEGIN
  # Déclaration
  Declare v_titre, v_desc VARCHAR(128);
  Declare v_contenu TEXT;
  # Récupération du titre, description et contenu de la version choisie
  SELECT titre, description, contenu INTO v_titre, v_desc, v_contenu
  FROM vers_cours 
  WHERE id_cours=id
  AND dateModif=version;
  # Insertion des informations récupérés dans le cours choisi
  UPDATE cours 
  SET titre = v_titre, 
  description = v_desc,
  contenu = v_contenu
  WHERE id_cours=id;
END @@

# -----------------------------------------------------------------------------
#       FUNCTION : autoincrement() (Auto incrémentation des utilisateurs)
# -----------------------------------------------------------------------------

Create function autoincrement()
returns INTEGER(2)
  Deterministic
Begin
  Declare nbi int;
  SELECT MAX(id_u) INTO nbi
  FROM user;
  IF nbi IS NULL
  THEN
    SET nbi = 0;
  END IF;
  SET nbi = nbi+1;
  return nbi;
END @@

# -----------------------------------------------------------------------------
#       PROCEDURE : ajouter_eleve()
# -----------------------------------------------------------------------------

CREATE PROCEDURE ajouter_eleve(a_username VARCHAR(128), a_nom VARCHAR(128), a_prenom VARCHAR(128), a_email VARCHAR(128), a_pass VARCHAR(128), a_salt VARCHAR(40), a_token VARCHAR(40), a_dateNaissance DATE)
BEGIN
  # Récupération du nouvel id
  Declare id int;
  SET id = (SELECT autoincrement());
  
  # Vérifions que l'admin n'est pas bête au point de faire des doublons
  IF (SELECT COUNT(*) FROM user u INNER JOIN eleve e ON u.id_u = e.id_u WHERE u.nom = a_nom AND u.prenom = a_prenom AND e.dateNaissance = a_dateNaissance) < 1
  THEN
    # Insertion de l'élève dans la table USER
    INSERT INTO user VALUES(id, a_username, a_nom, a_prenom, a_email, a_pass, 0, a_salt, a_token, CURDATE());
    INSERT INTO eleve VALUES(id, a_dateNaissance);
  END IF;
END @@

# -----------------------------------------------------------------------------
#       PROCEDURE : up_eleve()
# -----------------------------------------------------------------------------

CREATE PROCEDURE up_eleve(id INTEGER, a_username VARCHAR(128), a_nom VARCHAR(128), a_prenom VARCHAR(128), a_email VARCHAR(128), a_pass VARCHAR(128), a_active BOOLEAN, a_salt VARCHAR(40), a_token VARCHAR(40), a_dateNaissance DATE)
BEGIN
  UPDATE user SET
  username = a_username,
  nom = a_nom,
  prenom = a_prenom,
  email = a_email,
  password = a_pass,
  active = a_active,
  salt = a_salt,
  token = a_token
  WHERE id_u = id;

  UPDATE eleve SET
  dateNaissance = a_dateNaissance
  WHERE id_u = id;
END @@

# -----------------------------------------------------------------------------
#       TRIGGER : del_el
# -----------------------------------------------------------------------------

CREATE TRIGGER del_el
AFTER DELETE ON eleve
FOR EACH ROW
BEGIN
  DELETE FROM user
  WHERE id_u = old.id_u;
END @@

# -----------------------------------------------------------------------------
#       PROCEDURE : ajouter_gest()
# -----------------------------------------------------------------------------

CREATE PROCEDURE ajouter_gest(id INTEGER(2))
BEGIN
  # Vérifier qu'il s'agit d'un élève
  # Vérifions que l'admin n'est pas bête au point de faire des doublons
  IF (SELECT COUNT(*) FROM user u INNER JOIN eleve e ON e.id_u = u.id_u WHERE u.id_u = id) = 1 AND (SELECT COUNT(*) FROM gestionnaire WHERE id_u = id) < 1
  THEN
    # Insertion de l'élève dans la table USER
    INSERT INTO gestionnaire VALUES(id);
  END IF;
END @@

# -----------------------------------------------------------------------------
#       PROCEDURE : ajouter_prof()
# -----------------------------------------------------------------------------

CREATE PROCEDURE ajouter_prof(a_username VARCHAR(128), a_nom VARCHAR(128), a_prenom VARCHAR(128), a_email VARCHAR(128), a_pass VARCHAR(128), a_salt VARCHAR(40), a_token VARCHAR(40), matiere INTEGER(2))
BEGIN
  # Récupération du nouvel id
  Declare id int;
  SET id = (SELECT autoincrement());
  # Vérifions que l'admin n'est pas bête au point de faire des doublons
  IF (SELECT COUNT(*) FROM user u INNER JOIN professeur p ON p.id_u = u.id_u WHERE u.nom = a_nom AND u.prenom = a_prenom AND p.id_m = matiere) < 1
  THEN
    # Insertion du professeur dans la table USER
    INSERT INTO user VALUES(id, a_username, a_nom, a_prenom, a_email, a_pass, 0, a_salt, a_token, CURDATE());
    INSERT INTO professeur VALUES(id, matiere);
  END IF;
END @@

# -----------------------------------------------------------------------------
#       PROCEDURE : up_prof()
# -----------------------------------------------------------------------------

CREATE PROCEDURE up_prof(id INTEGER, a_username VARCHAR(128), a_nom VARCHAR(128), a_prenom VARCHAR(128), a_email VARCHAR(128), a_pass VARCHAR(128), a_active BOOLEAN, a_salt VARCHAR(40), a_token VARCHAR(40), matiere INTEGER(2))
BEGIN
  UPDATE user SET
	username = a_username,
	nom = a_nom,
	prenom = a_prenom,
	email = a_email,
	password = a_pass,
	active = a_active,
  salt = a_salt,
  token = a_token
  WHERE id_u = id;

  UPDATE professeur SET
  id_m = matiere
  WHERE id_u = id;
END @@

# -----------------------------------------------------------------------------
#       TRIGGER : del_prof
# -----------------------------------------------------------------------------

CREATE TRIGGER del_prof
AFTER DELETE ON professeur
FOR EACH ROW
BEGIN
  DELETE FROM user
  WHERE id_u = old.id_u;
END @@

# -----------------------------------------------------------------------------
#       PROCEDURE : ajouter_admin()
# -----------------------------------------------------------------------------

CREATE PROCEDURE ajouter_admin(a_username VARCHAR(128), a_nom VARCHAR(128), a_prenom VARCHAR(128), a_email VARCHAR(128), a_pass VARCHAR(128), a_salt VARCHAR(40), a_token VARCHAR(40), a_poste VARCHAR(80))
BEGIN
  # Récupération du nouvel id
  Declare id int;
  SET id = (SELECT autoincrement());
  # Vérifions que l'admin n'est pas bête au point de faire des doublons
  IF (SELECT COUNT(*) FROM user u INNER JOIN administrateur a ON a.id_u = u.id_u WHERE u.nom = a_nom AND u.prenom = a_prenom AND a.poste = a_poste) < 1
  THEN
    # Insertion du professeur dans la table USER
    INSERT INTO user VALUES(id, a_username, a_nom, a_prenom, a_email, a_pass, 1, a_salt, a_token, CURDATE());
    INSERT INTO administrateur VALUES(id, a_poste);
  END IF;
END @@

# -----------------------------------------------------------------------------
#       PROCEDURE : up_padmin()
# -----------------------------------------------------------------------------

CREATE PROCEDURE up_admin(id INTEGER, a_username VARCHAR(128), a_nom VARCHAR(128), a_prenom VARCHAR(128), a_email VARCHAR(128), a_pass VARCHAR(128), a_active BOOLEAN, a_salt VARCHAR(40), a_token VARCHAR(40), a_poste VARCHAR(80))
BEGIN
  UPDATE user SET
  username = a_username,
  nom = a_nom,
  prenom = a_prenom,
  email = a_email,
  password = a_pass,
  active = a_active,
  salt = a_salt,
  token = a_token
  WHERE id_u = id;

  UPDATE administrateur SET
  poste = a_poste
  WHERE id_u = id;
END @@

# -----------------------------------------------------------------------------
#       TRIGGER : del_admin
# -----------------------------------------------------------------------------

CREATE TRIGGER del_admin
AFTER DELETE ON administrateur
FOR EACH ROW
BEGIN
  DELETE FROM user
  WHERE id_u = old.id_u;
END @@

# -----------------------------------------------------------------------------
#       TRIGGER : up_user
# -----------------------------------------------------------------------------

CREATE TRIGGER up_user
BEFORE UPDATE ON user
FOR EACH ROW
BEGIN
  IF old.token != new.token AND old.active = 0 AND new.active = 1
  THEN
    DELETE FROM crypt WHERE token = old.token;
  END IF;
END @@

# -----------------------------------------------------------------------------
#       TRIGGER : del_user
# -----------------------------------------------------------------------------

CREATE TRIGGER del_user
BEFORE DELETE ON user
FOR EACH ROW
BEGIN
  IF old.active = 0 AND (SELECT COUNT(*) FROM crypt WHERE token = old.token) > 0
  THEN
    DELETE FROM crypt WHERE token = old.token;
  END IF;
END ;

# -----------------------------------------------------------------------------
#       FUNCTION : trouver_session() (Trouver la session en cours)
# -----------------------------------------------------------------------------

CREATE FUNCTION trouver_session()
returns VARCHAR(10)
	Deterministic
Begin
	Declare sess INTEGER;
	IF MONTH(CURDATE()) < 8
	THEN
		SELECT id_session INTO sess
		FROM session
		WHERE session like CONCAT("%/",YEAR(CURDATE()));
	ELSE
		SELECT id_session INTO sess
		FROM session
		WHERE session like CONCAT(YEAR(CURDATE()),"/%");
	END IF;
	IF sess IS NULL
	THEN
		SET sess = "NOT FOUND";
	END IF;
	return sess;
END @@

# -----------------------------------------------------------------------------
#       PROCEDURE : ajouter_session()
# -----------------------------------------------------------------------------

CREATE PROCEDURE ajouter_session(sess VARCHAR(10))
BEGIN
	Declare prev, next INTEGER;
	IF sess = "FIRST"
		THEN
			IF MONTH(CURDATE()) < 7
			THEN
				INSERT INTO session VALUES('',CONCAT(YEAR(CURDATE())-1,'/',YEAR(CURDATE())));
			ELSE
				INSERT INTO session VALUES('',CONCAT(YEAR(CURDATE()),"/",YEAR(CURDATE())+1));
			END IF;
		ELSE
		    INSERT INTO session VALUES('',sess);
		    SELECT id_session INTO prev
		    FROM session
		    WHERE session like CONCAT("%/",SUBSTR(sess,1,4));
		    IF prev IS NOT NULL
		    THEN
				  SELECT id_session INTO next
				  FROM session
				  WHERE session LIKE sess;
          CALL auto_class(prev, next);
   		END IF;
	END IF;
END @@

# -----------------------------------------------------------------------------
#       PROCEDURE : auto_class() (Création auto des classes pour une session)
# -----------------------------------------------------------------------------

CREATE PROCEDURE auto_class(prev INTEGER, next INTEGER)
BEGIN
	Declare fini int default 0;
	Declare c_section INTEGER(2);
	Declare c_libelle VARCHAR(128); 
	Declare curc CURSOR
	FOR SELECT id_section, libelle
		FROM classe c
		INNER JOIN session s ON c.id_session = s.id_session
		WHERE s.id_session = prev;
	Declare continue HANDLER
		FOR NOT FOUND SET fini = 1;
	Open curc;
	FETCH curc INTO c_section, c_libelle;
	While fini != 1
		DO
			INSERT INTO classe VALUES("", next, c_section, c_libelle);
			FETCH curc INTO c_section, c_libelle;
	END While;
	Close curc;
END @@

# -----------------------------------------------------------------------------
#       PROCEDURE : connexion()
# -----------------------------------------------------------------------------
Delimiter @@

CREATE PROCEDURE connexion(login VARCHAR(128), pass VARCHAR(128))
BEGIN
	DECLARE id INTEGER(2);
	DECLARE user VARCHAR(128);
	DECLARE name VARCHAR(128);
	DECLARE last VARCHAR(128);
	DECLARE mail VARCHAR(128);
	DECLARE passwd VARCHAR(128);
	DECLARE actif BOOLEAN;
	DECLARE sel VARCHAR(40);
	DECLARE tok VARCHAR(40);
	DECLARE dateU DATE;
	DECLARE no_user_for_login CONDITION FOR 1329;
	
	DECLARE EXIT HANDLER FOR no_user_for_login
	BEGIN
		SELECT true AS "erreur";
		SELECT "Erreur de saisie identidiant/mot de passe" AS "Message", "danger" AS "Type";
	END;
	
	SELECT salt INTO sel
	FROM user
	WHERE username = login;

	SET passwd = SHA1(MD5(CONCAT(SHA1(MD5(sel)),SHA1(pass),SHA1(MD5(sel)))));
	
	IF (SELECT COUNT(*) FROM user WHERE username = login AND password = passwd) > 0 THEN
		SELECT id_u,username,nom,prenom,email,password,active,salt,token,dateUser INTO id,user,name,last,mail,passwd,actif,sel,tok,dateU
		FROM user
		WHERE username = login AND password = passwd;
		IF actif THEN
			SELECT false AS "erreur";
			SELECT id, user AS username, name AS nom, last AS prenom, mail AS email, passwd AS password, actif AS active, sel AS salt, tok AS token, dateU AS dateUser;
			IF (SELECT COUNT(*) FROM administrateur WHERE id_u = id) > 0 THEN
				SELECT "Admin" AS "Statut";
			ELSEIF (SELECT COUNT(*) FROM professeur WHERE id_u = id) > 0 THEN
				SELECT "Prof" AS "Statut";
			ELSEIF (SELECT COUNT(*) FROM eleve WHERE id_u = id) > 0 THEN
				SELECT "Eleve" AS "Statut";
				CALL select_classes(id);
			END IF;
		ELSE
			SELECT true AS "erreur";
			SELECT "Votre compte n'est pas encore activÃ©" AS "Message", "warning" AS "Type";
		END IF;
	ELSE
		SELECT true AS "erreur";
		SELECT "Erreur de saisie identidiant/mot de passe" AS "Message", "danger" AS "Type";
	END IF;
END @@

# -----------------------------------------------------------------------------
#       PROCEDURE : select_classes()
# -----------------------------------------------------------------------------

CREATE PROCEDURE select_classes(user INTEGER)
BEGIN
	# Déclaration
	Declare fini int default 0;
	Declare id INTEGER;
	
	# Premier curseur
	Declare cur1 CURSOR
	FOR SELECT id_classe
		FROM classe;
		
	# Deuxième curseur
	Declare cur2 CURSOR
	FOR SELECT c.id_classe
		FROM classe c
		INNER JOIN etre e ON c.id_classe = e.id_classe
		INNER JOIN session s ON s.id_session = c.id_session
		WHERE e.id_u = user
		AND s.id_session IN (
			SELECT id_session
			FROM session
			GROUP BY id_session
			HAVING SUBSTR(session,6) <= YEAR(CURDATE())
		)
		ORDER BY s.session DESC;
		
	# Gestionnaire d'erreur
	Declare continue HANDLER
		FOR NOT FOUND SET fini = 1;
		
	# Nombre de classes trouvée
	IF user IS NULL OR user = 0 THEN
		SELECT COUNT(*) AS "Classes" FROM classe;
		Open cur1;
		FETCH cur1 INTO id;
		WHILE fini != 1	DO
			CALL select_class(id);
			FETCH cur1 INTO id;
		END WHILE;
		Close cur1;
	ELSE
		SELECT COUNT(*) AS "Classes"
		FROM classe c
		INNER JOIN etre e ON c.id_classe = e.id_classe
		INNER JOIN session s ON s.id_session = c.id_session
		WHERE e.id_u = user
		AND s.id_session IN (
			SELECT id_session
			FROM session
			GROUP BY id_session
			HAVING SUBSTR(session,6) <= YEAR(CURDATE())
		);
		Open cur2;
		FETCH cur2 INTO id;
		WHILE fini != 1 DO
			CALL select_class(id);
			FETCH cur2 INTO id;
		END WHILE;
		Close cur2;
	END IF;
END @@

# -----------------------------------------------------------------------------
#       PROCEDURE : select_class()
# -----------------------------------------------------------------------------

CREATE PROCEDURE select_class(classe INTEGER)
BEGIN
	SELECT id_classe AS id, libelle
	FROM classe
	WHERE id_classe = classe;
	
	SELECT s.id_session AS id, s.session
	FROM session s
	INNER JOIN classe c ON s.id_session = c.id_session
	WHERE c.id_classe = classe;
	
	SELECT s.id_section AS id, s.id_u AS admin, s.libelle
	FROM section s
	INNER JOIN classe c ON s.id_section = c.id_section
	WHERE c.id_classe = classe;
	
	SELECT m.id_m AS id, m.libelle, m.icon
	FROM matiere m
	INNER JOIN assigner a ON m.id_m = a.id_m
	WHERE a.id_classe = classe;
	
	SELECT u.id_u AS id, u.nom, u.prenom
	FROM user u
	INNER JOIN charger c ON u.id_u = c.id_u
	INNER JOIN professeur p ON u.id_u = p.id_u
	WHERE c.id_classe = classe;
	
	SELECT u.id_u AS id, u.nom, u.prenom
	FROM user u
	INNER JOIN etre e ON u.id_u = e.id_u
	INNER JOIN eleve p ON u.id_u = p.id_u
	WHERE e.id_classe = classe;
END @@

# -----------------------------------------------------------------------------
#       PROCEDURE : select_class_session_user()
# -----------------------------------------------------------------------------
DELIMITER @@

CREATE PROCEDURE select_class_session_user(classe VARCHAR(128), session VARCHAR(128), user INTEGER)
BEGIN
	Declare id INTEGER;
	Declare lib VARCHAR(128);
	DECLARE no_class CONDITION FOR 1329;
	DECLARE EXIT HANDLER FOR no_class
	BEGIN
		SELECT true AS "erreur";
		SELECT "Cette classe n'existe pas" AS "Message";
	END;
	SELECT c.id_classe AS id, c.libelle INTO id,lib
	FROM classe c
	INNER JOIN session s ON c.id_session = s.id_session
	WHERE c.libelle = classe
	AND s.session = session;
	IF (SELECT COUNT(*)
		FROM classe c
		INNER JOIN etre e ON e.id_classe = c.id_classe
		WHERE c.id_classe = id
		AND e.id_u = user) > 0 THEN	
		IF (MONTH(CURDATE()) < 8 AND SUBSTR(session,1,4) < YEAR(CURDATE())) OR (MONTH(CURDATE()) > 8 AND SUBSTR(session,1,4) <= YEAR(CURDATE())) THEN
			SELECT false AS "erreur";
			CALL select_class(id);
		ELSE
			SELECT true AS "erreur";
			SELECT "On ne peut prÃ©dire l'avenir" AS "Message";
		END IF;
	ELSE
		SELECT true AS "erreur";
		SELECT "Vous ne pouvez accÃ©der Ã cette classe" AS "Message";
	END IF;
END @@

Delimiter ;




# /////////////////////////////////////////////////////////////////////////////
# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
# /////////////////////////////////////////////////////////////////////////////
# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
#
#       INSERTION DE DONNEES
#
# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
# /////////////////////////////////////////////////////////////////////////////
# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
# /////////////////////////////////////////////////////////////////////////////

CALL ajouter_admin("admin", "admin", "admin", "admin@domain.tld","7a53be99a2d39e90884249a0260f753e24033947", "8262216f0c53cd1ebc83e1bb6b84ddce84fe7738", sha1(md5('tokenadministrateur')), "administrateur");
/*
INSERT INTO matiere VALUES("", "MatiÃ¨re", "fa fa-cog");
CALL ajouter_prof("prof", "prof", "prof", "prof@domain.tld", "0a9f3ec3809e9162ba1219bfe03970b6a0e10068", "8262216f0c53cd1ebc83e1bb6b84ddce84fe7738", sha1(md5('tokenprofesseur')), 1);
CALL ajouter_eleve("eleve", "eleve", "eleve", "eleve@domain.tld", "59cee2a6f0ff147433684a69020158e115a40f41", "8262216f0c53cd1ebc83e1bb6b84ddce84fe7738", sha1(md5('tokeneleve')), "1989-10-2");
CALL ajouter_session("FIRST");
INSERT INTO section VALUES("",1,"BTS SIO");
INSERT INTO section VALUES("",1,"BAC SEN");
INSERT INTO classe VALUES("", 1, 1, "SIO1"),
("", 1, 1, "SIO2"),
("", 1, 1, "SIO1 LM"),
("", 1, 1, "SIO2 LM"),
("", 1, 1, "SIO1 MV"),
("", 1, 1, "SIO2 MV");
INSERT INTO cours VALUES(1, 1, 1, 1, "Titre","Description","Contenu", sysdate(), NULL);
UPDATE cours SET titre = "Titre 2";
SELECT SLEEP(1);
UPDATE cours SET titre = "Titre 3";
SELECT SLEEP(1);
UPDATE cours SET titre = "Titre 4";
SELECT SLEEP(1);
UPDATE cours SET titre = "Titre 5";
SELECT SLEEP(1);
UPDATE cours SET titre = "Titre 6";
*/