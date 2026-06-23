# 🎓 CampusLogis : Système de Gestion Numérique de Cité Universitaire

CampusLogis est une application web full-stack moderne conçue pour automatiser et simplifier la gestion des résidences universitaires. Ce projet propose une double interface utilisateur : un **Portail Étudiant** dynamique pour gérer l'inscription, téléverser des documents et soumettre des tickets de maintenance, ainsi qu'un **Tableau de Bord Administrateur** pour contrôler le descriptif du parc, l'attribution des chambres et valider les paiements.

Ce guide est spécialement conçu pour vous aider à installer, configurer et exécuter ce projet directement depuis votre espace de développement ou votre dépôt **GitHub**.

---

## 🛠️ Outils & Technologies Utilisés dans le Projet

Le projet a été développé en utilisant des outils de pointe pour le frontend et une architecture simple et robuste pour le backend.

### 💻 Frontend (Interface Utilisateur)
*   **React 18 & Vite** : Framework web performant caractérisé par un rechargement instantané lors du développement et une compilation optimisée pour la mise en ligne.
*   **TypeScript** : Version typée de JavaScript assurant la robustesse du code, l'auto-complétion et limitant la présence de bugs en cours d'exécution.
*   **Tailwind CSS** : Cadre de style CSS moderne permettant d'édifier des designs originaux rapidement avec des classes utilitaires fluides et réactives.
*   **Motion (React)** : Librairie d'animation haut de gamme permettant d'orchestrer des transitions douces et interactives lors des changements d'onglets ou d'ouverture de boîtes.
*   **Lucide React** : Ensemble d'icônes vectorielles épurées harmonisant visuellement chaque action (boutons, statuts, alertes).
*   **Recharts** : Bibliothèque de data-visualisation pour dessiner les statistiques d'occupation et la situation financière côté administrateur.

### 🛰️ Backend (Moteur Applicatif & Fichiers)
*   **PHP (PHP 8+)** : Environnement serveur utilisé pour concevoir l’ensemble des API d'accès à la base de données.
*   **XAMPP (Apache Server)** : Kit d'hébergement local utilisé pour propulser le serveur PHP et gérer le trafic d'API en local.
*   **API REST JSON** : Norme de communication. React envoie des requêtes réseaux via l’API native de navigation de fichiers binaires `FormData` et le protocole standardisé `fetch()` de JavaScript, et le backend PHP répond sous forme de structures JSON encodées en UTF-8.

### 🗄️ Base de Données (Stockage Durable)
*   **MySQL / MariaDB** : Système de gestion de base de données relationnelle (SGBDR) utilisé pour enregistrer les profils civils des résidents, l’état des bâtiments/chambres et les requêtes logistiques.
*   **phpMyAdmin** : Interface d'administration web fournie avec XAMPP pour gérer les tables de données graphiquement, importer des scripts SQL et contrôler les données.

---

## 📦 Structure Principale des Fichiers de l'Application

Voici l'organisation du projet pour vous repérer rapidement dans le dépôt GitHub :

```text
├── /public/                 # Actifs graphiques de l'application
├── /src/
│   ├── /components/         # Composants isolés réutilisables (Cartes, Formulaires, etc.)
│   ├── /pages/              # Vues majeures de l'application :
│   │   ├── Login.tsx                 # Formulaire d'accès avec distinction Admin/Étudiant
│   │   ├── PortailEtudiant.tsx       # Espace de l'étudiant (Dossier, Paiements, Maintenance)
│   │   ├── TableauBordAdmin.tsx      # Dashboard statistique et console de contrôle Admin
│   │   ├── RoomInventory.tsx         # Module d'inspection graphique du parc
│   │   ├── MaintenanceRequests.tsx   # Liste des tickets d'interventions ouverts
│   │   └── StudentRegistration.tsx   # Workflow d'inscription et saisie initiale
│   ├── /services/           # Fichiers de raccordement réseau API :
│   │   ├── api.ts                    # Fonctions d'abstraction HTTP fetch réutilisables
│   │   └── serviceApi.ts             # Routages et points d'accès vers le serveur PHP
│   ├── main.tsx             # Fichier racine d'initialisation de l'application
│   └── index.css            # Styles généraux et configuration du thème Tailwind CSS
├── GUIDE_XAMPP_PHP.md       # 📜 CONTIENT TOUS LES CODES SOURCES DES API PHP À COPIER !
├── package.json             # Dépendances NPM du projet frontend
└── tsconfig.json            # Configuration du compilateur TypeScript
```

---

## ⚙️ Guide d'Installation de A à Z (Usage GitHub)

Suivez ces instructions pour mettre en marche le projet localement sur votre ordinateur après l'avoir récupéré depuis GitHub.

### 📋 Prérequis Généraux
*   **Node.js** (Version 18 ou supérieure recommandée) avec son gestionnaire de paquet **NPM** installé.
*   **XAMPP** installé sur votre machine d'hébergement.

---

### Étape 1 : Récupérer le Projet depuis GitHub
Ouvrez votre terminal favori et clonez le projet sur votre espace de travail :
```bash
git clone https://github.com/votre-nom-utilisateur/votre-depot-campuslogis.git
cd votre-depot-campuslogis
```

---

### Étape 2 : Configurer le Serveur PHP et la Base de Données (XAMPP)

1.  **Démarrer XAMPP** : Lancez le **XAMPP Control Panel** et cliquez sur le bouton **Start** à côté d’**Apache** et de **MySQL**.
2.  **Créer la Base de Données** :
    *   Rendez-vous sur **phpMyAdmin** en ouvrant l'adresse suivante dans votre navigateur : `http://localhost/phpmyadmin/`.
    *   Créez une nouvelle base de données appelée précisément `gestion_cite_universitaire`.
3.  **Importer les Tables (Modèle Relationnel)** :
    *   Sélectionnez votre base de données `gestion_cite_universitaire` dans la colonne de gauche.
    *   Cliquez sur l'onglet **SQL** situé dans le menu supérieur.
    *   Copiez-collez l'ensemble des instructions de création de tables ci-dessous, puis cliquez sur **Exécuter** :

```sql
-- Table des comptes pour l'authentification sécurisée
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role ENUM('admin', 'student') NOT NULL
);

-- Table des infrastructures physiques
CREATE TABLE buildings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- Table des chambres hébergées dans un bâtiment particulier
CREATE TABLE rooms (
    id INT AUTO_INCREMENT PRIMARY KEY,
    building_id INT NOT NULL,
    room_number VARCHAR(20) NOT NULL,
    capacity INT DEFAULT 4,
    maintenance_status ENUM('ok', 'urgent', 'pending') DEFAULT 'ok',
    FOREIGN KEY (building_id) REFERENCES buildings(id) ON DELETE CASCADE
);

-- Table des étudiants (profils civils, statut d'inscription et clé de chambre assignée)
CREATE TABLE students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    major VARCHAR(100),
    level ENUM('L1', 'L2', 'L3', 'M1', 'M2') DEFAULT 'L1',
    repetition_count INT DEFAULT 0,
    photo_url VARCHAR(255),
    cin_url VARCHAR(255),
    attestation_url VARCHAR(255),
    payment_slip_url VARCHAR(255),
    status ENUM('incomplete', 'pending', 'accepted', 'rejected', 'enrolled', 'expelled') DEFAULT 'incomplete',
    room_id INT,
    registration_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (room_id) REFERENCES rooms(id) ON DELETE SET NULL
);

-- Table des transactions financières scolaires/locatives
CREATE TABLE payments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_type ENUM('monthly', 'caution', 'annual') DEFAULT 'monthly',
    payment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    slip_url VARCHAR(255),
    status ENUM('pending', 'verified', 'rejected') DEFAULT 'pending',
    month VARCHAR(20),
    year INT,
    FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE
);

-- Table de requêtes de signalement technique ou logistique
CREATE TABLE maintenance_requests (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    title VARCHAR(150) NOT NULL,
    description TEXT NOT NULL,
    urgency ENUM('low', 'medium', 'high') DEFAULT 'medium',
    status ENUM('pending', 'in_progress', 'resolved', 'canceled') DEFAULT 'pending',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE
);
```

4.  **Installer les API PHP sur le Serveur** :
    *   Créez un dossier appelé `api-cité` à la racine de votre répertoire de diffusion de fichiers de XAMPP (généralement : `C:\xampp\htdocs\api-cité\`).
    *   Ouvrez le fichier `GUIDE_XAMPP_PHP.md` présent à la racine du projet cloné. Ce fichier contient l'ensemble complet des scripts PHP requis.
    *   Créez chacun des scripts PHP listés dans le dossier `api-cité` en insérant leur code source correspondant.
    *   **⚠️ IMPORTANT : Créez impérativement un sous-dossier nommé `uploads` à cette même adresse (`C:\xampp\htdocs\api-cité\uploads\`) et assurez-vous qu'il possède de pleins droits de lecture et d'écriture pour qu'Apache puisse y stocker les images déversées.**

---

### Étape 3 : Démarrer et Lancer le Client React (Frontend)

1.  Placez-vous dans le répertoire racine du projet cloné (où se situe le fichier `package.json`).
2.  Installez l'ensemble des modules node et dépendances indispensables via votre gestionnaire de paquets :
    ```bash
    npm install
    ```
3.  Lancez le serveur de développement local :
    ```bash
    npm run dev
    ```
4.  Votre terminal vous retournera l'adresse d'exécution locale. Ouvrez votre navigateur web pour accéder à l'application. (Exemple d'adresse standard : `http://localhost:3000`).

---

## 🧪 zoom sur la Fonctionnalité Phare : L'Upload d'Images & Documents

Si vous devez présenter ce projet à un examen, la gestion d'upload de fichiers (reçus, attestations, carte d'identité, photo) est souvent un point très apprécié. C'est un excellent exemple d'interopérabilité technologique (liaison React `<->` PHP) :

1.  **D'un point de vue JavaScript (Frontend)** :
    L'application React n'utilise aucune dépendance externe lourde. Tout se fait via l'API standard JavaScript utilisant l'objet binaire `FormData` associé avec un appel asynchrone `fetch()`. Envoi d’un header multipart brut, automatique.
2.  **D'un point de vue PHP (Backend) (`upload.php`)** :
    Intercepte le fichier sous l'emplacement temporaire `$_FILES['file']`, vérifie que son extension fait bien partie des formats admissibles (ex: `.jpg`, `.png`, `.pdf`), renomme le fichier à l'aide d'un identifiant temporel unique (`time()`) pour prévenir d'un éventuel conflit de noms, et le sauvegarde dans `uploads/` avant de répondre à React en lui renvoyant l'URL absolue correspondante (par exemple, `http://localhost/api-cité/uploads/17491823_mon_justificatif.jpg`).

---

## ♿ Les Principes d'Ergonomie Respectés (Norme IHM)

Ce projet a été conçu selon les exigences d'utilisabilité de référence du standard des **8 Critères de Bastien & Scapin** en ergonomie interactive :
1.  **Guidage** (statut du dossier clairement marqué de couleur rouge/vert/orange, bouton chargeant montrant l'état `PATIENTER...` pour guider le chargement).
2.  **Charge Mentale Réduite** (regroupement des KPIs clés de l'administrateur dans des cartes bento intuitives pour lecture immédiate).
3.  **Contrôle Explicite** (permettre d'annuler ou valider explicitement chaque demande, modales de confirmation).
4.  **Adaptabilité / Responsive Design** (grille d'interface fluide s'adaptant à toutes les résolutions tactiles de téléphones portables et tablettes d'agents d'entretien).
5.  **Gestion Protectrice des Erreurs** (utilisation de structures préventives `try/catch` de sécurité évitant à l'application de crasher en cas d'absence ou défaillance du serveur local XAMPP).
6.  **Homogénéité visuelle** (cohérence sémantique des boutons et icônes, utilisation d’une charte de couleur stable construite sur des teintes ardoise/graphite).
7.  **Signifiance des dénominations** (boutons accompagnés de textes d'explication clairs au lieu d'icônes ambiguës isolées).
8.  **Compatibilité standard** (respect de la conformité HTML5 standard, utilisation des composants d'entrée de saisie natifs et compatibilité de transmission AJAX vers tous les navigateurs récents du marché).
