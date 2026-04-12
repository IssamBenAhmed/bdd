-- Q1-Créer les tables VIN et INSPECTEUR de la base de données BDVins :
-- (Créer d'abord la BDVins.)
CREATE TABLE VIN(
  VNUM INT CONSTRAINT PK_VIN PRIMARY KEY,
  VNOM VARCHAR(30) NOT NULL,
  CEPAGE VARCHAR(30));

CREATE TABLE INSPECTEUR(
  INUM INT PRIMARY KEY,
  INOM VARCHAR(30) NOT NULL);

-- Q2-Créer maintenant la table TEST, vous nommerez les contraintes de clés étrangères :
CREATE TABLE TEST (
  VNUM INT CONSTRAINT FK_VNUM REFERENCES VIN(VNUM) ON DELETE CASCADE,
  INUM INT CONSTRAINT FK_INUM REFERENCES INSPECTEUR(INUM) ON DELETE CASCADE,
  NOTE INT NOT NULL,
  TDATE DATE,
  CONSTRAINT PK_TEST PRIMARY KEY (VNUM,INUM));

-- Q3-Ajouter (avec ALTER TABLE) une contrainte dans la table TEST pour indiquer que la note doit être comprise entre 0 et 10.
-- Nommer la contrainte.
ALTER TABLE TEST
  ADD CONSTRAINT NOTEBT1ET10 CHECK(NOTE>=1 AND NOTE<=10);


-- Q4-Insérer les données des tables VIN, INSPECTEUR puis TEST.
INSERT INTO VIN(VNUM,VNOM,CEPAGE)
VALUES(1,'Cave de Macon','Chardonnay'),
(2,'Merlot','Cabernet Sauvignon'),
(3,'Pinot Noir','Pinot Noir');

INSERT INTO INSPECTEUR(INUM,INOM)
VALUES(1,'Magouille'),(2,'Intransigeant'),
(3,'Sympa'),(4,'Cool');

INSERT INTO TEST(VNUM,INUM,NOTE,TDATE)
VALUES(1,1,7,'2019-04-10'),
(2,1,8,'2019-05-15'),
(2,2,4,'2019-05-20');


-- Q5-Vérifier le contenu des tables.

SELECT * FROM TEST;
SELECT * FROM VIN;
SELECT * FROM INSPECTEUR;

-- Q6-Insérer le tuple (2, Rigolo) dans la table INSPECTEUR.
-- Que se passe-t-il ? Pourquoi ?

INSERT INTO INSPECTEUR(INUM,INOM)
VALUES(2,'Rigolo');

-- LE INUM 2 EXISTE DEJA , VIOLATION DE LA CONDITION D'UNICITÉE


-- Q7-Insérer le tuple (5, 2, 8, '2020-01-01') dans la table TEST.
-- Que se passe-t-il ? Pourquoi ?
INSERT INTO TEST(VNUM,INUM,NOTE,TDATE)
VALUES(5, 2, 8, '2020-01-01');

--Erreur dans la requête (7): ERROR: insert or update on table "test" violates foreign key constraint "fk_vnum"
--DETAIL: Key (vnum)=(5) is not present in table "vin".



-- Q8-Insérer un nouvel inspecteur dans la table INSPECTEUR,
-- à savoir l’inspecteur de numéro 5 et dont on a égaré le nom.
-- Que se passe-t-il ? Pourquoi ?

INSERT INTO INSPECTEUR(INUM,INOM)
VALUES(5,null);

--Erreur dans la requête (7): ERROR: null value in column "inom" of relation "inspecteur" violates not-null constraint
--DETAIL: Failing row contains (5, null). 

-- Q9-Supprimer le vin n°2. Que se passe-t-il ?  Pourquoi ?  

DELETE FROM VIN WHERE VNUM = 2;

-- Le vin est supprimé dans la table vin et par cascade dans la table test



-- Q10-Modifier les contraintes d’intégrité définies sur la table TEST pour
-- obtenir la suppression des tests d’un vin lorsque celui-ci est supprimé de la table VIN.

--DEJA FAIT

-- (Pour modifier une contrainte, il faut la supprimer puis la recréer).

-- Q11-Supprimer à nouveau le vin n°2 et vérifier la suppression de ses tests.

--DEJA FAIT

-- Q12-Réinsérer le vin 2 ainsi que ses tests dans les tables associées.

INSERT INTO VIN(VNUM,VNOM,CEPAGE)
VALUES(2,'Merlot','Cabernet Sauvignon');
INSERT INTO TEST(VNUM,INUM,NOTE,TDATE)
VALUES(2,1,8,'2019-05-15'),
(2,2,4,'2019-05-20');


-- Q13-Faire les modifications de structure pour permettre l’insertion du numéro
-- de téléphone '03-85-44-12-09' pour l’inspecteur n°3.
-- Que se passe t-il pour les autres inspecteurs ?

ALTER TABLE INSPECTEUR
ADD COLUMN TELEPHONE VARCHAR(16);
UPDATE INSPECTEUR
SET TELEPHONE = '03-85-44-12-09'
WHERE INUM = 3;


-- Q14-Faire les modifications de structure pour réduire la longueur de INOM à 6 caractères.
-- Prévoir la récupération des valeurs de cette colonne en les tronquant à 6 caractères.
-- Utiliser la fonction SUBSTR ou la fonction LEFT.

UPDATE INSPECTEUR
SET INOM = LEFT(INOM, 6);
ALTER TABLE INSPECTEUR
ALTER COLUMN INOM TYPE VARCHAR(6);




-- Vues
-- Q15-Créer la vue SYNTHESE19 regroupant les attributs CEPAGE, VNUM, VNOM, INOM, NOTE et TDATE pour tous les tests effectués en 2019.

CREATE VIEW SYNTHESE19 AS
SELECT V.CEPAGE, V.VNUM, V.VNOM, I.INOM, T.NOTE, T.TDATE
FROM VIN V
JOIN TEST T ON V.VNUM = T.VNUM
JOIN INSPECTEUR I ON I.INUM = T.INUM
WHERE T.TDATE >= '2019-01-01' AND T.TDATE < '2020-01-01';

SELECT * FROM SYNTHESE19;



-- Q16-Donner la note moyenne de chaque vin en 2019. On précisera le nom du vin.



SELECT AVG(NOTE), VNUM , VNOM
FROM SYNTHESE19 
GROUP BY VNUM;

*
-- Transactions
-- Q17-Commencer une transaction avec BEGIN; (syntaxe PostgreSQL, MySQL)
-- Insérer les trois tuples (10, Relax), (11, Pointu) et (12, Odieux) dans la table INSPECTEUR.
-- Vérifier que tout s’est bien passé.
-- Annuler la dernière transaction et vérifier à nouveau le contenu de la table INSPECTEUR.


BEGIN;
INSERT INTO INSPECTEUR(INUM, INOM) VALUES (10, 'Relax');
INSERT INTO INSPECTEUR(INUM, INOM) VALUES (11, 'Pointu');
INSERT INTO INSPECTEUR(INUM, INOM) VALUES (12, 'Odieux');

SELECT * FROM INSPECTEUR;
ROLLBACK;
SELECT * FROM INSPECTEUR;



-- Q18-Modifier les instructions de Q17 de manière à ce que la table INSPECTEUR
-- contienne les inspecteurs Pointu et Relax suite à l’annulation de la dernière transaction.
-- Vous devez conserver les 3 ordres INSERT. 





-- Suppressions
-- Q19-Supprimer la table INSPECTEUR. Que se passe-t'il ? Pourquoi ?

-- Q20-Supprimer la table TEST.
-- Que se passe-t'il ? Faites-le nécessaire pour supprimer la table.

-- Q21-Vider la table VIN. Vérifier que tout s’est bien passé.

-- Q22-Supprimer les tables VIN et INSPECTEUR. Vérifier que tout s’est bien passé.

