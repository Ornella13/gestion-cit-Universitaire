-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 17, 2026 at 06:42 PM
-- Server version: 10.4.17-MariaDB
-- PHP Version: 8.0.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `gestion_questionnaires`
--

-- --------------------------------------------------------

--
-- Table structure for table `details_reponses`
--

CREATE TABLE `details_reponses` (
  `num_exam` int(11) NOT NULL,
  `num_quest` int(11) NOT NULL,
  `reponse_etudiant_index` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `etudiant`
--

CREATE TABLE `etudiant` (
  `num_etudiant` varchar(50) NOT NULL,
  `nom` varchar(100) NOT NULL,
  `prenoms` varchar(100) NOT NULL,
  `niveau` varchar(2) DEFAULT NULL CHECK (`niveau` in ('L1','L2','L3','M1','M2')),
  `adr_email` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `etudiant`
--

INSERT INTO `etudiant` (`num_etudiant`, `nom`, `prenoms`, `niveau`, `adr_email`) VALUES
('100H-Tol', 'Claudia', 'Rataveasy', 'M1', 'claudiaRataveasy@gmail.com'),
('300H-Tol', 'Marie Nomena', 'Frandela', 'M2', 'frandela@gmail.com'),
('500H-Tol', 'claudia', 'ornella', 'L3', 'ornellaclaudia0@gmail.com'),
('502H-Tol', 'Bella', 'Pageot', 'L3', 'bellapageot@gmail.com'),
('700H-Tol', 'Michela', 'Miriam', 'L2', 'michelamiriam@gmail.com'),
('901H-Tol', 'Marianah', 'Tiavina', 'L1', 'marianah@gmail.com'),
('902H-Tol', 'Albert', 'Camus', 'L1', 'camus@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `examen`
--

CREATE TABLE `examen` (
  `num_exam` int(11) NOT NULL,
  `num_etudiant` varchar(50) DEFAULT NULL,
  `annee_univ` varchar(9) NOT NULL,
  `note` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `examen`
--

INSERT INTO `examen` (`num_exam`, `num_etudiant`, `annee_univ`, `note`) VALUES
(20, '500H-Tol', '2023-2024', 1),
(21, '500H-Tol', '2023-2024', 2),
(23, '500H-Tol', '2023-2024', 4),
(31, '500H-Tol', '2023-2024', 3),
(32, '500H-Tol', '2023-2024', 5),
(33, '500H-Tol', '2023-2024', 8),
(34, '500H-Tol', '2023-2024', 3),
(36, '500H-Tol', '2023-2024', 6),
(37, '500H-Tol', '2023-2024', 7),
(38, '901H-Tol', '2023-2024', 0),
(39, '500H-Tol', '2023-2024', 9);

-- --------------------------------------------------------

--
-- Table structure for table `qcm`
--

CREATE TABLE `qcm` (
  `num_quest` int(11) NOT NULL,
  `question` text NOT NULL,
  `reponse1` text NOT NULL,
  `reponse2` text NOT NULL,
  `reponse3` text DEFAULT NULL,
  `reponse4` text DEFAULT NULL,
  `bonne_reponse_index` int(11) DEFAULT NULL CHECK (`bonne_reponse_index` between 1 and 4),
  `module` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `qcm`
--

INSERT INTO `qcm` (`num_quest`, `question`, `reponse1`, `reponse2`, `reponse3`, `reponse4`, `bonne_reponse_index`, `module`) VALUES
(9, 'Que signifie JSP ?\r\n', 'A. Java System Page', 'B. Java Server Pages', 'C. Java Script Program', 'D. Java Source Page', 2, 'L3'),
(10, 'JSP est utilisé pour :', 'A. Créer des applications mobiles', 'B. Gérer la base de données uniquement', 'C. Générer des pages web dynamiques', 'D. Compiler du code Java', 3, 'L3'),
(11, 'Quel langage est principalement utilisé dans JSP ?', 'A. Python', 'B. Java ', 'C. C#', 'D. PHP', 2, 'L3'),
(12, 'Quelle balise permet d’insérer du code Java dans une page JSP ?', 'A. <script>', 'B. <php>', 'C. <% %> ', 'D. <java>', 3, 'L3'),
(13, 'Quelle extension a un fichier JSP ?', 'A. .html', 'B. .php', 'C. .jsp', 'D. .js', 3, 'L3'),
(14, 'JSP est exécuté côté :', 'A. Client', 'B. Serveur ', 'C. Navigateur', 'D. Mobile', 2, 'L3'),
(15, 'Quel serveur est souvent utilisé pour exécuter JSP ?', 'A. Apache Tomcat', 'B. XAMPP', 'C. Node.js', 'D. Django', 1, 'L3'),
(16, 'Que fait JSP lors de son exécution ?', 'A. Il devient du HTML uniquement', 'B. Il est converti en Servlet Java', 'C. Il devient du CSS', 'D. Il est supprimé', 2, 'L3'),
(20, 'Linux est :', 'A. Un logiciel de traitement de texte', 'B. Un système d’exploitation', 'C. Un antivirus', 'D. Un navigateur', 2, 'L1'),
(21, 'Linux est basé sur :', 'A. Windows', 'B. macOS', 'C. Unix', 'D. Android', 3, 'L3'),
(22, 'Quelle commande permet d’afficher le contenu d’un dossier ?', 'A. show', 'B. list', 'C. ls', 'D. dir', 3, 'L1'),
(23, 'Quelle commande permet de changer de répertoire ?\r\n\r\n\r\n', 'A. move', 'B. cd ', 'C. chdir', 'D. dir', 2, 'L2'),
(24, 'Quelle commande permet d’installer un paquet sur Ubuntu ?', 'A. install', 'B. apt install ', 'C. get install', 'D. pkg add', 2, 'L1'),
(25, 'quel couleur est le soleil', 'rouge', 'jaune', 'violet', 'vert', 2, 'L3'),
(26, 'quel est le couleur du ciel', 'verte', 'rouge', 'jaune', 'bleu', 4, 'L1'),
(27, 'quel est le couleur du cheveux en generale', 'noire', 'rouge', 'blanc', 'verte', 1, 'L2'),
(28, 'la forme de la terre', 'ronde', 'ovale', 'triangle', 'carreé', 1, 'M2'),
(29, 'quel est le couleur de la mer', 'rouge', 'bleu', 'marron', 'vert', 2, 'L3'),
(30, 'quel est le couleur de cheveux', 'blanc', 'noire', 'marron', 'violet', 2, 'L1');

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` int(11) NOT NULL,
  `title` varchar(200) NOT NULL,
  `level` varchar(50) NOT NULL,
  `date` varchar(50) NOT NULL,
  `time` varchar(50) NOT NULL,
  `duration` int(11) DEFAULT 30,
  `students` varchar(100) NOT NULL,
  `status` varchar(50) DEFAULT 'Pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `title`, `level`, `date`, `time`, `duration`, `students`, `status`) VALUES
(5, 'Examen JSP', 'L3', '2026-05-17', '15:30', 5, 'examen rattrapage', 'Pending');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `details_reponses`
--
ALTER TABLE `details_reponses`
  ADD PRIMARY KEY (`num_exam`,`num_quest`),
  ADD KEY `fk_question` (`num_quest`);

--
-- Indexes for table `etudiant`
--
ALTER TABLE `etudiant`
  ADD PRIMARY KEY (`num_etudiant`),
  ADD UNIQUE KEY `adr_email` (`adr_email`);

--
-- Indexes for table `examen`
--
ALTER TABLE `examen`
  ADD PRIMARY KEY (`num_exam`),
  ADD KEY `fk_etudiant` (`num_etudiant`);

--
-- Indexes for table `qcm`
--
ALTER TABLE `qcm`
  ADD PRIMARY KEY (`num_quest`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `examen`
--
ALTER TABLE `examen`
  MODIFY `num_exam` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT for table `qcm`
--
ALTER TABLE `qcm`
  MODIFY `num_quest` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `sessions`
--
ALTER TABLE `sessions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `details_reponses`
--
ALTER TABLE `details_reponses`
  ADD CONSTRAINT `fk_examen` FOREIGN KEY (`num_exam`) REFERENCES `examen` (`num_exam`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_question` FOREIGN KEY (`num_quest`) REFERENCES `qcm` (`num_quest`);

--
-- Constraints for table `examen`
--
ALTER TABLE `examen`
  ADD CONSTRAINT `fk_etudiant` FOREIGN KEY (`num_etudiant`) REFERENCES `etudiant` (`num_etudiant`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
