-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 23, 2026 at 12:17 PM
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
(1, 'Block1'),
(2, 'Block2'),
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
(6, 1, '006', NULL, 4, 'ok'),
(7, 1, '007', NULL, 4, 'ok'),
(8, 1, '008', NULL, 4, 'ok'),
(9, 1, '009', NULL, 4, 'ok'),
(10, 1, '010', NULL, 4, 'ok'),
(11, 2, '001', NULL, 4, 'ok'),
(12, 2, '002', NULL, 4, 'ok'),
(13, 2, '003', NULL, 4, 'ok'),
(14, 2, '004', NULL, 4, 'ok'),
(15, 2, '005', NULL, 4, 'ok'),
(16, 2, '006', NULL, 4, 'ok'),
(17, 2, '007', NULL, 4, 'ok'),
(18, 2, '008', NULL, 4, 'ok'),
(19, 2, '009', NULL, 4, 'ok'),
(20, 2, '010', NULL, 4, 'ok'),
(21, 3, '001', NULL, 4, 'ok'),
(22, 3, '002', NULL, 4, 'ok'),
(23, 3, '003', NULL, 4, 'ok'),
(24, 3, '004', NULL, 4, 'ok'),
(25, 3, '005', NULL, 4, 'ok'),
(26, 3, '006', NULL, 4, 'ok'),
(27, 3, '007', NULL, 4, 'ok'),
(28, 3, '008', NULL, 4, 'ok'),
(29, 3, '009', NULL, 4, 'ok'),
(30, 3, '010', NULL, 4, 'ok');

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
(1, 'admincite@gmail.com', 'admin123', 'admin', '2026-05-18 18:34:35');

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `rooms`
--
ALTER TABLE `rooms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

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
