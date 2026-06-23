-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 11, 2026 at 06:20 PM
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
(1, 'bloc1'),
(2, 'Bloc2'),
(3, 'Bloc3');

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
(1, 16, 'panne d\'electricité', 'validated', '2026-05-08 23:38:50', NULL);

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
(1, 22, 'Votre paiement de 25000.00 Ar a été validé par l\'administration.', 'success', 0, '2026-05-01 15:53:59'),
(2, 23, 'Votre paiement de 25000.00 Ar a été validé par l\'administration.', 'success', 0, '2026-05-01 16:31:33'),
(3, 23, 'Votre paiement de 25000.00 Ar a été validé par l\'administration.', 'success', 0, '2026-05-01 17:04:11'),
(4, 23, 'Votre paiement de 25000.00 Ar a été validé par l\'administration.', 'success', 0, '2026-05-01 17:07:17'),
(5, 21, 'Félicitations ! Vous avez été promu au niveau supérieur. Veuillez renouveler votre dossier.', 'success', 0, '2026-05-03 14:17:21'),
(6, 16, 'Maintenance : Votre demande \'panne d\'electricité...\' est en cours.', 'info', 0, '2026-05-08 23:39:25'),
(7, 16, 'Maintenance : Votre demande \'panne d\'electricité...\' est traité (en attente de votre validation).', 'info', 0, '2026-05-08 23:41:13');

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
(1, 15, '25000.00', '', '2026-05-01 10:23:49', 'http://localhost/api-cit%C3%A9/uploads/payment_slip_1777631027_albert1gmailcom.jpg', 'verifié'),
(2, 15, '25000.00', 'monthly', '2026-05-01 10:26:12', 'http://localhost/api-cit%C3%A9/uploads/payment_slip_1777631170_albert1gmailcom.jpg', 'verifié'),
(3, 15, '25000.00', '', '2026-05-01 10:27:29', 'http://localhost/api-cit%C3%A9/uploads/payment_slip_1777631247_albert1gmailcom.jpg', 'verifié'),
(4, 15, '25000.00', '', '2026-05-01 10:48:59', 'http://localhost/api-cit%C3%A9/uploads/payment_slip_1777632537_albert1gmailcom.jpg', 'verifié'),
(5, 16, '25000.00', 'monthly', '2026-05-01 11:12:12', 'http://localhost/api-cit%C3%A9/uploads/payment_slip_1777633929_claudia13gmailcom.jpg', 'verifié'),
(6, 20, '25000.00', '', '2026-05-01 12:02:36', 'http://localhost/api-cit%C3%A9/uploads/payment_slip_1777636952_luciagmailcom.jpg', 'verifié'),
(7, 21, '25000.00', '', '2026-05-01 12:28:44', 'http://localhost/api-cit%C3%A9/uploads/payment_slip_1777638522_Samsia00gmailcom.jpg', 'verifié'),
(8, 22, '25000.00', '', '2026-05-01 12:53:38', 'http://localhost/api-cit%C3%A9/uploads/payment_slip_1777640013_julianahgmailcom.jpg', 'verifié'),
(9, 23, '25000.00', '', '2026-05-01 13:31:10', 'http://localhost/api-cit%C3%A9/uploads/payment_slip_1777642266_larisagmailcom.jpg', 'verifié'),
(10, 23, '25000.00', 'monthly', '2026-05-01 13:55:15', 'http://localhost/api-cit%C3%A9/uploads/payment_slip_1777643707_larisagmailcom.jpg', 'verifié'),
(11, 23, '25000.00', 'monthly', '2026-05-01 14:05:43', 'http://localhost/api-cit%C3%A9/uploads/payment_slip_1777644338_larisagmailcom.jpg', 'verifié');

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
(5, 1, '001', NULL, 4, 'ok'),
(6, 1, '002', NULL, 4, 'ok'),
(7, 1, '003', NULL, 4, 'ok'),
(8, 1, '004', NULL, 4, 'ok'),
(9, 1, '005', NULL, 4, 'ok'),
(10, 1, '006', NULL, 4, 'ok'),
(11, 1, '007', NULL, 4, 'ok'),
(12, 1, '008', NULL, 4, 'ok'),
(13, 1, '009', NULL, 4, 'ok'),
(14, 1, '010', NULL, 4, 'ok'),
(15, 2, '001', NULL, 4, 'ok'),
(16, 2, '002', NULL, 4, 'ok'),
(17, 2, '003', NULL, 4, 'ok'),
(18, 2, '004', NULL, 4, 'ok'),
(19, 2, '005', NULL, 4, 'ok'),
(20, 2, '006', NULL, 4, 'ok'),
(21, 2, '007', NULL, 4, 'ok'),
(22, 2, '008', NULL, 4, 'ok'),
(23, 2, '009', NULL, 4, 'ok'),
(24, 2, '010', NULL, 4, 'ok'),
(25, 3, '001', NULL, 4, 'ok'),
(26, 3, '002', NULL, 4, 'ok'),
(27, 3, '003', NULL, 4, 'ok'),
(28, 3, '004', NULL, 4, 'ok'),
(29, 3, '005', NULL, 4, 'ok'),
(30, 3, '006', NULL, 4, 'ok'),
(31, 3, '007', NULL, 4, 'ok'),
(32, 3, '008', NULL, 4, 'ok'),
(33, 3, '009', NULL, 4, 'ok'),
(34, 3, '010', NULL, 4, 'ok');

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
(14, 'Claudia', 'Ornella', 'ornellaclaudia13@gmail.com', NULL, 'Médecine', 'http://localhost/api-cit%C3%A9/uploads/photo_url_1777619058_ornellaclaudia13gmailcom.jpg', 'http://localhost/api-cit%C3%A9/uploads/cin_url_1777619112_ornellaclaudia13gmailcom.jpg', 'http://localhost/api-cit%C3%A9/uploads/attestation_url_1777619088_ornellaclaudia13gmailcom.jpg', 0, 'accepted', 5, 0, '2026-04-29 21:15:36', 'http://localhost/api-cit%C3%A9/uploads/payment_slip_url_1777619117_ornellaclaudia13gmailcom.heic', 'L1', 0),
(15, 'Albert', 'Rataveasy', 'albert1@gmail.com', NULL, 'Droit', 'http://localhost/api-cit%C3%A9/uploads/photo_url_1777619601_albert1gmailcom.jpg', 'http://localhost/api-cit%C3%A9/uploads/cin_url_1777619621_albert1gmailcom.jpg', '', 0, 'enrolled', 5, 0, '2026-05-01 07:10:50', 'http://localhost/api-cit%C3%A9/uploads/payment_slip_url_1777619630_albert1gmailcom.jpg', 'L1', 0),
(16, 'Claudia', 'Rataveasy', 'claudia13@gmail.com', NULL, 'Médecine', 'http://localhost/api-cit%C3%A9/uploads/photo_url_1777622657_claudia13gmailcom.jpg', 'http://localhost/api-cit%C3%A9/uploads/cin_url_1777622709_claudia13gmailcom.jpg', '', 0, 'enrolled', 5, 0, '2026-05-01 08:03:42', 'http://localhost/api-cit%C3%A9/uploads/payment_slip_url_1777622720_claudia13gmailcom.jpg', 'L1', 0),
(17, 'Harina', 'Rataveasy', 'harinarataveasy@gmail.com', NULL, 'Médecine', 'http://localhost/api-cit%C3%A9/uploads/photo_url_1777623823_harinarataveasygmailcom.jpg', 'http://localhost/api-cit%C3%A9/uploads/cin_url_1777623852_harinarataveasygmailcom.jpg', 'http://localhost/api-cit%C3%A9/uploads/attestation_url_1777623841_harinarataveasygmailcom.sql', 0, 'enrolled', 5, 0, '2026-05-01 08:23:01', 'http://localhost/api-cit%C3%A9/uploads/payment_slip_url_1777623861_harinarataveasygmailcom.jpg', 'L1', 0),
(18, 'Tinasoa', 'Harina', 'harinatinasoa@gmail.com', NULL, 'Droit', 'http://localhost/api-cit%C3%A9/uploads/photo_url_1777624268_harinatinasoagmailcom.jpg', 'http://localhost/api-cit%C3%A9/uploads/cin_url_1777624299_harinatinasoagmailcom.jpg', 'http://localhost/api-cit%C3%A9/uploads/attestation_url_1777624287_harinatinasoagmailcom.jpg', 0, 'enrolled', 6, 0, '2026-05-01 08:30:31', 'http://localhost/api-cit%C3%A9/uploads/payment_slip_url_1777624305_harinatinasoagmailcom.jpg', 'L1', 0),
(19, 'Niovasoa', 'tiriky', 'niovasoa@gmail.com', NULL, 'Sciences', 'http://localhost/api-cit%C3%A9/uploads/photo_url_1777625987_niovasoagmailcom.jpg', 'http://localhost/api-cit%C3%A9/uploads/cin_url_1777626011_niovasoagmailcom.jpg', 'http://localhost/api-cit%C3%A9/uploads/attestation_url_1777625996_niovasoagmailcom.jpg', 0, 'accepted', 6, 0, '2026-05-01 08:59:09', 'http://localhost/api-cit%C3%A9/uploads/payment_slip_url_1777626017_niovasoagmailcom.jpg', 'L1', 0),
(20, 'Lucia', 'Raharimalala Jean', 'lucia@gmail.com', NULL, 'Médecine', 'http://localhost/api-cit%C3%A9/uploads/photo_url_1777636714_luciagmailcom.jpg', 'http://localhost/api-cit%C3%A9/uploads/cin_url_1777636782_luciagmailcom.jpg', 'http://localhost/api-cit%C3%A9/uploads/attestation_url_1777636754_luciagmailcom.jpg', 0, 'enrolled', 6, 0, '2026-05-01 11:57:38', 'http://localhost/api-cit%C3%A9/uploads/payment_slip_url_1777636814_luciagmailcom.jpg', 'L1', 0),
(21, 'Samsia', 'Mary', 'Samsia00@gmail.com', NULL, 'Droit', 'http://localhost/api-cit%C3%A9/uploads/photo_url_1777638331_Samsia00gmailcom.jpg', 'http://localhost/api-cit%C3%A9/uploads/cin_url_1777638362_Samsia00gmailcom.jpg', 'http://localhost/api-cit%C3%A9/uploads/attestation_url_1777638351_Samsia00gmailcom.jpg', 0, 'pending', 6, 0, '2026-05-01 12:24:45', 'http://localhost/api-cit%C3%A9/uploads/payment_slip_url_1777638370_Samsia00gmailcom.jpg', 'L2', 0),
(22, 'julianah', 'Raharisoa', 'julianah@gmail.com', NULL, 'Sciences', 'http://localhost/api-cit%C3%A9/uploads/photo_url_1777639758_julianahgmailcom.jpg', 'http://localhost/api-cit%C3%A9/uploads/cin_url_1777639782_julianahgmailcom.heic', 'http://localhost/api-cit%C3%A9/uploads/attestation_url_1777639774_julianahgmailcom.jpg', 0, 'pending', 7, 0, '2026-05-01 12:48:39', 'http://localhost/api-cit%C3%A9/uploads/payment_slip_url_1777639790_julianahgmailcom.jpg', 'L1', 1),
(23, 'Larisa', 'Maro', 'larisa@gmail.com', NULL, 'Médecine', 'http://localhost/api-cit%C3%A9/uploads/photo_url_1777642124_larisagmailcom.jpg', 'http://localhost/api-cit%C3%A9/uploads/cin_url_1777642152_larisagmailcom.jpg', 'http://localhost/api-cit%C3%A9/uploads/attestation_url_1777642142_larisagmailcom.jpg', 0, 'pending', 7, 0, '2026-05-01 13:28:10', 'http://localhost/api-cit%C3%A9/uploads/payment_slip_url_1777642159_larisagmailcom.jpg', 'L2', 1);

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
(1, 'ornellaclaudia@gmail.com', 'ornellla123', 'student', '2026-04-24 19:14:23'),
(2, 'admincite@gmail.com', 'admin123', 'admin', '2026-04-24 19:28:56'),
(3, 'claudiarataveasy@gmail.com', 'rataveasy', 'student', '2026-04-24 19:56:49'),
(4, 'albert@gmail.com', 'albert', 'student', '2026-04-24 20:30:54'),
(5, 'harinah@gmail.com', 'harina123', 'student', '2026-04-25 06:53:26'),
(6, 'samsia@gmail.com', 'samsia123', 'student', '2026-04-25 07:11:54'),
(7, 'marysamtil@gmail.com', 'mary123', 'student', '2026-04-28 11:01:20'),
(8, 'harina@gmail.com', 'harina', 'student', '2026-04-29 14:16:45'),
(10, 'ornellaclaudia0@gmail.com', 'ornella', 'student', '2026-04-29 18:58:48'),
(12, 'marysam@gmail.com', 'mary123', 'student', '2026-04-29 19:47:32'),
(13, 'bella@gmail.com', 'bella123', 'student', '2026-04-29 19:48:20'),
(15, 'albert13@gmail.com', 'albert123', 'student', '2026-04-29 19:56:14'),
(16, 'fabiolat@gmail.com', 'fabiolat123', 'student', '2026-04-29 20:02:58'),
(18, 'harina13@gmail.com', 'harina13', 'student', '2026-04-29 20:20:04'),
(21, 'ornellaclaudia13@gmail.com', 'ornella123', 'student', '2026-04-29 21:15:36'),
(25, 'albert1@gmail.com', 'albert', 'student', '2026-05-01 07:10:50'),
(26, 'claudia13@gmail.com', 'claudia', 'student', '2026-05-01 08:03:42'),
(27, 'harinarataveasy@gmail.com', 'harina123', 'student', '2026-05-01 08:23:01'),
(30, 'harinatinasoa@gmail.com', 'harina', 'student', '2026-05-01 08:30:31'),
(31, 'niovasoa@gmail.com', 'niovasoa123', 'student', '2026-05-01 08:59:09'),
(32, 'lucia@gmail.com', 'lucia123', 'student', '2026-05-01 11:57:38'),
(35, 'Samsia00@gmail.com', 'samsia123', 'student', '2026-05-01 12:24:45'),
(36, 'julianah@gmail.com', 'julianah123', 'student', '2026-05-01 12:48:39'),
(37, 'larisa@gmail.com', 'larisa123', 'student', '2026-05-01 13:28:10');

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `rooms`
--
ALTER TABLE `rooms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

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
