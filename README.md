# Modélisation & Administration de Bases de Données (SQL / Docker)

> Travaux pratiques de conception relationnelle, conteneurisation et requêtage SQL avancé — **ISIMA (Clermont Auvergne INP)**.

Ce dépôt rassemble les travaux de modélisation, d'administration et d'interrogation de bases de données relationnelles réalisés dans le cadre du cursus d'ingénieur en informatique à l'ISIMA.

---

## 🎯 Compétences Techniques Démontrées

- **Conception & Normalisation :** Modélisation conceptuelle (MCD) et passage au schéma relationnel (3NF) avec respect strict des contraintes d'intégrité (clés primaires, clés étrangères, contraintes d'unicité et de domaine).
- **Conteneurisation (Docker & Docker Compose) :** Déploiement reproductible et isolé des instances de bases de données et des outils d'administration web légers :
  - **PostgreSQL** couplé à **Adminer** (`postgres-adminer`).
  - **MySQL** couplé à **phpMyAdmin** (`mysql-phpmyadmin`).
- **Requêtage SQL Avancé :** Écriture et optimisation de requêtes complexes :
  - Jointures internes, externes et auto-jointures.
  - Agrégations, groupements (`GROUP BY`, `HAVING`) et calculs statistiques.
  - Sous-requêtes imbriquées et corrélées.

---

## 📂 Contenu du Répertoire

- `tp1/` :
  - **BD Facturation** : Modélisation et requêtage d'un système commercial de facturation (clients, articles, commandes, lignes de factures).
  - Configuration `docker-compose.yml` pour le démarrage immédiat de l'environnement PostgreSQL.
- `tp2/` :
  - **BD Vins** : Schéma relationnel modélisant l'écosystème viticole (vignerons, appellations, cépages, récoltes et millésimes).
  - `BDVins_queries.sql` : Série de requêtes d'analyses croisées et d'extractions ciblées.
  - Configuration `docker-compose.yml` dédiée.

---

## 🚀 Déploiement Rapide d'un Environnement (Exemple TP2)

```bash
cd tp2
docker compose up -d
```
L'interface d'administration web devient immédiatement accessible sur `http://localhost:8080`.
