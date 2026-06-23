-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 18, 2026 at 06:44 PM
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
-- Database: `gestion_cite_universitaire`
--

-- --------------------------------------------------------

--
-- Table structure for table `buildings`
--

CREATE TABLE `buildings` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `buildings`
--

INSERT INTO `buildings` (`id`, `name`) VALUES
(1, 'block1'),
(2, 'block2'),
(3, 'block3');

-- --------------------------------------------------------

--
-- Table structure for table `housing_requests`
--

CREATE TABLE `housing_requests` (
  `id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `request_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` enum('pending','approved','rejected') DEFAULT 'pending',
  `payment_slip_url` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `maintenance_tickets`
--

CREATE TABLE `maintenance_tickets` (
  `id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `description` text NOT NULL,
  `status` enum('pending','in_progress','resolved','validated') DEFAULT 'pending',
  `created_at` datetime DEFAULT current_timestamp(),
  `room_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `maintenance_tickets`
--

INSERT INTO `maintenance_tickets` (`id`, `student_id`, `description`, `status`, `created_at`, `room_id`) VALUES
(1, 8, 'panne d\'electricité', 'validated', '2026-05-14 11:55:04', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `message` text NOT NULL,
  `type` enum('info','success','warning','error') DEFAULT 'info',
  `is_read` tinyint(1) DEFAULT 0,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `student_id`, `message`, `type`, `is_read`, `created_at`) VALUES
(1, 1, 'Votre chambre a été attribuée avec succès.', 'success', 0, '2026-05-11 20:14:36'),
(2, 1, 'Votre paiement de 25000.00 Ar a été validé par l\'administration.', 'success', 0, '2026-05-11 20:18:40'),
(3, 2, 'Votre chambre a été attribuée avec succès.', 'success', 0, '2026-05-11 20:23:54'),
(4, 2, 'Votre paiement de 25000.00 Ar a été validé par l\'administration.', 'success', 0, '2026-05-11 20:26:02'),
(5, 1, 'RAPPEL : Votre cotisation pour le mois de June 2026 est toujours en attente. Veuillez régulariser votre situation au plus vite.', 'warning', 0, '2026-06-11 20:32:58'),
(6, 2, 'RAPPEL : Votre cotisation pour le mois de June 2026 est toujours en attente. Veuillez régulariser votre situation au plus vite.', 'warning', 0, '2026-06-11 20:32:58'),
(7, 3, 'Votre chambre a été attribuée avec succès.', 'success', 0, '2026-06-11 20:39:56'),
(8, 2, 'Votre paiement de 25000.00 Ar a été validé par l\'administration.', 'success', 0, '2026-06-11 20:40:30'),
(9, 1, 'RAPPEL : Votre cotisation pour le mois de June 2026 est toujours en attente. Veuillez régulariser votre situation au plus vite.', 'warning', 0, '2026-06-11 21:00:52'),
(10, 3, 'RAPPEL : Votre cotisation pour le mois de June 2026 est toujours en attente. Veuillez régulariser votre situation au plus vite.', 'warning', 0, '2026-06-11 21:00:56'),
(11, 5, 'Votre chambre a été attribuée avec succès.', 'success', 0, '2026-06-11 21:42:28'),
(12, 6, 'Votre chambre a été attribuée avec succès.', 'success', 0, '2026-06-11 21:54:07'),
(13, 7, 'Votre chambre a été attribuée avec succès.', 'success', 0, '2026-06-11 21:57:04'),
(14, 6, 'RAPPEL : Votre cotisation pour le mois de June 2026 est toujours en attente. Veuillez régulariser votre situation au plus vite.', 'warning', 0, '2026-06-11 21:57:45'),
(15, 7, 'RAPPEL : Votre cotisation pour le mois de June 2026 est toujours en attente. Veuillez régulariser votre situation au plus vite.', 'warning', 0, '2026-06-11 21:57:48'),
(16, 1, 'RAPPEL : Votre cotisation pour le mois de June 2026 est toujours en attente. Veuillez régulariser votre situation au plus vite.', 'warning', 0, '2026-06-11 21:57:52'),
(17, 3, 'RAPPEL : Votre cotisation pour le mois de June 2026 est toujours en attente. Veuillez régulariser votre situation au plus vite.', 'warning', 0, '2026-06-11 21:57:52'),
(18, 5, 'RAPPEL : Votre cotisation pour le mois de June 2026 est toujours en attente. Veuillez régulariser votre situation au plus vite.', 'warning', 0, '2026-06-11 21:57:52'),
(19, 6, 'RAPPEL : Votre cotisation pour le mois de June 2026 est toujours en attente. Veuillez régulariser votre situation au plus vite.', 'warning', 0, '2026-06-11 21:57:52'),
(20, 7, 'RAPPEL : Votre cotisation pour le mois de June 2026 est toujours en attente. Veuillez régulariser votre situation au plus vite.', 'warning', 0, '2026-06-11 21:57:52'),
(21, 5, 'Votre paiement de 25000.00 Ar a été validé par l\'administration.', 'success', 0, '2026-06-11 22:17:35'),
(22, 6, 'Votre paiement de 25000.00 Ar a été validé par l\'administration.', 'success', 0, '2026-06-11 22:17:42'),
(23, 8, 'Votre chambre a été attribuée avec succès.', 'success', 0, '2026-05-14 11:51:07'),
(24, 8, 'Votre paiement de 25000.00 Ar a été validé par l\'administration.', 'success', 0, '2026-05-14 11:54:26'),
(25, 8, 'Maintenance : Votre demande \'panne d\'electricité...\' est en cours.', 'info', 0, '2026-05-14 11:55:40'),
(26, 8, 'Maintenance : Votre demande \'panne d\'electricité...\' est traité (en attente de votre validation).', 'info', 0, '2026-05-14 12:20:30'),
(27, 1, 'RAPPEL : Votre cotisation pour le mois de June 2026 est toujours en attente. Veuillez régulariser votre situation au plus vite.', 'warning', 0, '2026-06-16 11:49:01'),
(28, 3, 'RAPPEL : Votre cotisation pour le mois de June 2026 est toujours en attente. Veuillez régulariser votre situation au plus vite.', 'warning', 0, '2026-06-16 11:49:01'),
(29, 7, 'RAPPEL : Votre cotisation pour le mois de June 2026 est toujours en attente. Veuillez régulariser votre situation au plus vite.', 'warning', 0, '2026-06-16 11:49:01'),
(30, 8, 'RAPPEL : Votre cotisation pour le mois de June 2026 est toujours en attente. Veuillez régulariser votre situation au plus vite.', 'warning', 0, '2026-06-16 11:49:01'),
(31, 1, 'RAPPEL : Votre cotisation pour le mois de July 2026 est toujours en attente. Veuillez régulariser votre situation au plus vite.', 'warning', 0, '2026-07-16 12:01:04'),
(32, 2, 'RAPPEL : Votre cotisation pour le mois de July 2026 est toujours en attente. Veuillez régulariser votre situation au plus vite.', 'warning', 0, '2026-07-16 12:01:04'),
(33, 3, 'RAPPEL : Votre cotisation pour le mois de July 2026 est toujours en attente. Veuillez régulariser votre situation au plus vite.', 'warning', 0, '2026-07-16 12:01:04'),
(34, 5, 'RAPPEL : Votre cotisation pour le mois de July 2026 est toujours en attente. Veuillez régulariser votre situation au plus vite.', 'warning', 0, '2026-07-16 12:01:04'),
(35, 6, 'RAPPEL : Votre cotisation pour le mois de July 2026 est toujours en attente. Veuillez régulariser votre situation au plus vite.', 'warning', 0, '2026-07-16 12:01:04'),
(36, 7, 'RAPPEL : Votre cotisation pour le mois de July 2026 est toujours en attente. Veuillez régulariser votre situation au plus vite.', 'warning', 0, '2026-07-16 12:01:04'),
(37, 8, 'RAPPEL : Votre cotisation pour le mois de July 2026 est toujours en attente. Veuillez régulariser votre situation au plus vite.', 'warning', 0, '2026-07-16 12:01:04'),
(38, 1, 'RAPPEL : Votre cotisation pour le mois de July 2026 est toujours en attente. Veuillez régulariser votre situation au plus vite.', 'warning', 0, '2026-07-16 12:02:11'),
(39, 1, 'Votre contrat de résidence a été résilié pour non-paiement prolongé. Veuillez libérer les lieux immédiatement.', 'error', 0, '2026-07-16 12:02:21'),
(40, 3, 'RAPPEL : Votre cotisation pour le mois de July 2026 est toujours en attente. Veuillez régulariser votre situation au plus vite.', 'warning', 0, '2026-07-16 12:02:27'),
(41, 8, 'Votre contrat de résidence a été résilié pour non-paiement prolongé. Veuillez libérer les lieux immédiatement.', 'error', 0, '2026-07-16 12:02:36'),
(42, 7, 'Votre contrat de résidence a été résilié pour non-paiement prolongé. Veuillez libérer les lieux immédiatement.', 'error', 0, '2026-07-16 12:02:40'),
(43, 2, 'Votre paiement de 25000.00 Ar a été validé par l\'administration.', 'success', 0, '2026-07-16 12:42:13'),
(44, 3, 'Votre contrat de résidence a été résilié pour non-paiement prolongé. Veuillez libérer les lieux immédiatement.', 'error', 0, '2026-07-16 12:42:47'),
(45, 5, 'Votre contrat de résidence a été résilié pour non-paiement prolongé. Veuillez libérer les lieux immédiatement.', 'error', 0, '2026-08-16 14:13:12'),
(46, 6, 'Votre contrat de résidence a été résilié pour non-paiement prolongé. Veuillez libérer les lieux immédiatement.', 'error', 0, '2026-08-16 14:13:15'),
(47, 2, 'RAPPEL : Votre cotisation pour le mois de September 2026 est toujours en attente. Veuillez régulariser votre situation au plus vite.', 'warning', 0, '2026-09-16 14:43:27');

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `payment_type` enum('monthly','annual') NOT NULL,
  `payment_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `slip_url` varchar(255) DEFAULT NULL,
  `status` enum('attent','verifié') DEFAULT 'attent'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`id`, `student_id`, `amount`, `payment_type`, `payment_date`, `slip_url`, `status`) VALUES
(1, 1, '25000.00', 'monthly', '2026-05-11 17:16:43', 'http://localhost/api-cit%C3%A9/uploads/payment_slip_1778519784_ornellaclaudiagmailcom.jpg', 'verifié'),
(2, 2, '25000.00', 'monthly', '2026-05-11 17:24:54', 'http://localhost/api-cit%C3%A9/uploads/payment_slip_1778520290_claudiarataveasygmailcom.jpg', 'verifié'),
(3, 2, '25000.00', 'monthly', '2026-06-11 17:34:09', 'http://localhost/api-cit%C3%A9/uploads/payment_slip_1781199245_claudiarataveasygmailcom.jpg', 'verifié'),
(4, 5, '25000.00', 'monthly', '2026-06-11 18:43:51', 'http://localhost/api-cit%C3%A9/uploads/payment_slip_1781203428_harinagmailcom.jpg', 'verifié'),
(5, 6, '25000.00', 'monthly', '2026-06-11 19:11:08', 'http://localhost/api-cit%C3%A9/uploads/payment_slip_1781205064_Tirisoagmailcom.jpg', 'verifié'),
(6, 8, '25000.00', 'monthly', '2026-05-14 08:53:12', 'http://localhost/api-cit%C3%A9/uploads/payment_slip_1778748788_mariagmailcom.sql', 'verifié'),
(7, 2, '25000.00', 'monthly', '2026-07-16 09:41:31', 'http://localhost/api-cit%C3%A9/uploads/payment_slip_1784194888_claudiarataveasygmailcom.html', 'verifié'),
(8, 2, '25000.00', 'monthly', '2026-08-16 11:14:33', 'http://localhost/api-cit%C3%A9/uploads/payment_slip_1786878870_claudiarataveasygmailcom.html', 'attent'),
(9, 2, '25000.00', 'monthly', '2026-09-16 11:32:41', 'http://localhost/api-cit%C3%A9/uploads/payment_slip_1789558356_claudiarataveasygmailcom.html', 'attent');

-- --------------------------------------------------------

--
-- Table structure for table `rooms`
--

CREATE TABLE `rooms` (
  `id` int(11) NOT NULL,
  `building_id` int(11) NOT NULL,
  `room_number` varchar(10) NOT NULL,
  `floor` varchar(20) DEFAULT NULL,
  `capacity` int(11) DEFAULT 4,
  `maintenance_status` enum('ok','urgent','pending') DEFAULT 'ok'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `rooms`
--

INSERT INTO `rooms` (`id`, `building_id`, `room_number`, `floor`, `capacity`, `maintenance_status`) VALUES
(1, 1, '001', NULL, 4, 'ok'),
(2, 1, '002', NULL, 4, 'ok'),
(3, 1, '003', NULL, 4, 'ok'),
(4, 1, '004', NULL, 4, 'ok'),
(5, 1, '005', NULL, 4, 'ok'),
(6, 2, '001', NULL, 4, 'ok'),
(7, 2, '002', NULL, 4, 'ok'),
(8, 2, '003', NULL, 4, 'ok'),
(9, 2, '004', NULL, 4, 'ok'),
(10, 2, '005', NULL, 4, 'ok'),
(11, 3, '001', NULL, 4, 'ok'),
(12, 3, '002', NULL, 4, 'ok'),
(13, 3, '003', NULL, 4, 'ok'),
(14, 3, '004', NULL, 4, 'ok'),
(15, 3, '005', NULL, 4, 'ok');

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `id` int(11) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `major` varchar(100) DEFAULT NULL,
  `photo_url` varchar(255) DEFAULT NULL,
  `cin_url` varchar(255) DEFAULT NULL,
  `attestation_url` varchar(255) DEFAULT NULL,
  `is_repeating` tinyint(1) DEFAULT 0,
  `status` enum('pending','accepted','rejected','enrolled','expelled') DEFAULT 'pending',
  `room_id` int(11) DEFAULT NULL,
  `annual_renewal_complete` tinyint(1) DEFAULT 0,
  `registration_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `payment_slip_url` varchar(255) DEFAULT NULL,
  `level` enum('L1','L2','L3','M1','M2') DEFAULT 'L1',
  `repetition_count` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`id`, `first_name`, `last_name`, `email`, `password`, `major`, `photo_url`, `cin_url`, `attestation_url`, `is_repeating`, `status`, `room_id`, `annual_renewal_complete`, `registration_date`, `payment_slip_url`, `level`, `repetition_count`) VALUES
(1, 'ORNELLA', 'Claudia', 'ornellaclaudia@gmail.com', NULL, 'Sciences', 'http://localhost/api-cit%C3%A9/uploads/photo_url_1778519467_ornellaclaudiagmailcom.jpg', 'http://localhost/api-cit%C3%A9/uploads/cin_url_1778519502_ornellaclaudiagmailcom.jpg', 'http://localhost/api-cit%C3%A9/uploads/attestation_url_1778519491_ornellaclaudiagmailcom.jpg', 0, 'expelled', NULL, 0, '2026-05-11 16:52:07', 'http://localhost/api-cit%C3%A9/uploads/payment_slip_url_1778519512_ornellaclaudiagmailcom.jpg', 'L3', 0),
(2, 'CLAUDIA', 'Rataveasy', 'claudiarataveasy@gmail.com', NULL, 'Droit', 'http://localhost/api-cit%C3%A9/uploads/photo_url_1778520077_claudiarataveasygmailcom.jpg', 'http://localhost/api-cit%C3%A9/uploads/cin_url_1778520122_claudiarataveasygmailcom.jpg', 'http://localhost/api-cit%C3%A9/uploads/attestation_url_1778520105_claudiarataveasygmailcom.jpg', 0, 'enrolled', 1, 0, '2026-05-11 17:20:33', 'http://localhost/api-cit%C3%A9/uploads/payment_slip_url_1778520134_claudiarataveasygmailcom.jpg', 'M1', 0),
(3, 'RATAVEASY ', 'Albert', 'Albert@gmail.com', NULL, 'Droit', 'http://localhost/api-cit%C3%A9/uploads/photo_url_1781199451_Albertgmailcom.jpg', 'http://localhost/api-cit%C3%A9/uploads/cin_url_1781199510_Albertgmailcom.jpg', 'http://localhost/api-cit%C3%A9/uploads/attestation_url_1781199479_Albertgmailcom.jpg', 0, 'expelled', NULL, 0, '2026-06-11 17:35:50', 'http://localhost/api-cit%C3%A9/uploads/payment_slip_url_1781199521_Albertgmailcom.jpg', 'M2', 0),
(4, 'SAMISIA', 'Tirisoa', 'samsia@gmail.com', NULL, 'Droit', 'http://localhost/api-cit%C3%A9/uploads/photo_url_1781201745_samsiagmailcom.jpg', 'http://localhost/api-cit%C3%A9/uploads/cin_url_1781201777_samsiagmailcom.jpg', 'http://localhost/api-cit%C3%A9/uploads/attestation_url_1781201764_samsiagmailcom.jpg', 0, 'rejected', NULL, 0, '2026-06-11 18:15:08', 'http://localhost/api-cit%C3%A9/uploads/payment_slip_url_1781201783_samsiagmailcom.jpg', 'L3', 0),
(5, 'Harina', 'TINASOA', 'harina@gmail.com', NULL, 'Médecine', 'http://localhost/api-cit%C3%A9/uploads/photo_url_1781203267_harinagmailcom.heic', 'http://localhost/api-cit%C3%A9/uploads/cin_url_1781203293_harinagmailcom.jpg', 'http://localhost/api-cit%C3%A9/uploads/attestation_url_1781203283_harinagmailcom.jpg', 0, 'expelled', NULL, 0, '2026-06-11 18:40:47', 'http://localhost/api-cit%C3%A9/uploads/payment_slip_url_1781203303_harinagmailcom.jpg', 'L1', 0),
(6, 'Tirisoa', 'Ibrahim', 'Tirisoa@gmail.com', NULL, 'Sciences', 'http://localhost/api-cit%C3%A9/uploads/photo_url_1781203960_Tirisoagmailcom.jpg', 'http://localhost/api-cit%C3%A9/uploads/cin_url_1781203988_Tirisoagmailcom.jpg', 'http://localhost/api-cit%C3%A9/uploads/attestation_url_1781203978_Tirisoagmailcom.jpg', 0, 'expelled', NULL, 0, '2026-06-11 18:52:14', 'http://localhost/api-cit%C3%A9/uploads/payment_slip_url_1781203995_Tirisoagmailcom.jpg', 'L3', 0),
(7, 'Tatiana', 'Florentine', 'tatiana@gmail.com', NULL, 'Sciences', 'http://localhost/api-cit%C3%A9/uploads/photo_url_1781204144_tatianagmailcom.heic', 'http://localhost/api-cit%C3%A9/uploads/cin_url_1781204171_tatianagmailcom.heic', 'http://localhost/api-cit%C3%A9/uploads/attestation_url_1781204160_tatianagmailcom.jpg', 0, 'expelled', NULL, 0, '2026-06-11 18:55:15', 'http://localhost/api-cit%C3%A9/uploads/payment_slip_url_1781204177_tatianagmailcom.jpg', 'L2', 0),
(8, 'Maria', 'TOLIHO', 'maria@gmail.com', NULL, 'Droit', 'http://localhost/api-cit%C3%A9/uploads/photo_url_1778748436_mariagmailcom.jpg', 'http://localhost/api-cit%C3%A9/uploads/cin_url_1778748507_mariagmailcom.sql', 'http://localhost/api-cit%C3%A9/uploads/attestation_url_1778748477_mariagmailcom.sql', 0, 'expelled', NULL, 0, '2026-05-14 08:46:45', 'http://localhost/api-cit%C3%A9/uploads/payment_slip_url_1778748517_mariagmailcom.sql', 'L2', 0);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','student') NOT NULL DEFAULT 'student',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `email`, `password`, `role`, `created_at`) VALUES
(1, 'admincite@gmail.com', 'admin123', 'admin', '2026-05-11 16:36:38'),
(2, 'ornellaclaudia@gmail.com', 'ornella', 'student', '2026-05-11 16:52:07'),
(3, 'claudiarataveasy@gmail.com', 'claudia', 'student', '2026-05-11 17:20:33'),
(4, 'Albert@gmail.com', 'albert', 'student', '2026-06-11 17:35:50'),
(5, 'samsia@gmail.com', 'samsia', 'student', '2026-06-11 18:15:08'),
(6, 'harina@gmail.com', 'harina', 'student', '2026-06-11 18:40:47'),
(7, 'Tirisoa@gmail.com', 'tirisoa', 'student', '2026-06-11 18:52:14'),
(8, 'tatiana@gmail.com', 'tatiana', 'student', '2026-06-11 18:55:15'),
(9, 'maria@gmail.com', 'maria123', 'student', '2026-05-14 08:46:45');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `buildings`
--
ALTER TABLE `buildings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `housing_requests`
--
ALTER TABLE `housing_requests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `student_id` (`student_id`);

--
-- Indexes for table `maintenance_tickets`
--
ALTER TABLE `maintenance_tickets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `student_id` (`student_id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `student_id` (`student_id`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `student_id` (`student_id`);

--
-- Indexes for table `rooms`
--
ALTER TABLE `rooms`
  ADD PRIMARY KEY (`id`),
  ADD KEY `building_id` (`building_id`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `room_id` (`room_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `buildings`
--
ALTER TABLE `buildings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `housing_requests`
--
ALTER TABLE `housing_requests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `maintenance_tickets`
--
ALTER TABLE `maintenance_tickets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `rooms`
--
ALTER TABLE `rooms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `housing_requests`
--
ALTER TABLE `housing_requests`
  ADD CONSTRAINT `housing_requests_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `maintenance_tickets`
--
ALTER TABLE `maintenance_tickets`
  ADD CONSTRAINT `maintenance_tickets_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `rooms`
--
ALTER TABLE `rooms`
  ADD CONSTRAINT `rooms_ibfk_1` FOREIGN KEY (`building_id`) REFERENCES `buildings` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `students`
--
ALTER TABLE `students`
  ADD CONSTRAINT `students_ibfk_1` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
