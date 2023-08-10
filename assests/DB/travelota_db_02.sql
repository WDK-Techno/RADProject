-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Aug 10, 2023 at 06:26 AM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `travelota_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `agency`
--

CREATE TABLE `agency` (
  `agency_id` int(11) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` text NOT NULL,
  `name` varchar(20) NOT NULL,
  `country` varchar(30) NOT NULL,
  `logo` varchar(30) NOT NULL DEFAULT 'logo_default.png',
  `cover_img` varchar(30) NOT NULL DEFAULT 'cover_default.pg',
  `profile_img` varchar(30) NOT NULL DEFAULT 'profile_default.jpg',
  `status` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `agency_feedback`
--

CREATE TABLE `agency_feedback` (
  `comment_id` int(11) NOT NULL,
  `rate` int(11) DEFAULT NULL,
  `comment` text NOT NULL,
  `comment_type` int(11) NOT NULL DEFAULT 0,
  `agency_id` int(11) NOT NULL,
  `traveler_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `inquiry`
--

CREATE TABLE `inquiry` (
  `inquiry_id` int(11) NOT NULL,
  `inquiry` text NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp(),
  `type` int(11) NOT NULL DEFAULT 0,
  `status` int(11) NOT NULL DEFAULT 0,
  `booking_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `package`
--

CREATE TABLE `package` (
  `package_id` int(11) NOT NULL,
  `package_no` int(11) NOT NULL,
  `package_name` varchar(20) NOT NULL,
  `day_count` int(11) NOT NULL,
  `unit_price` int(11) NOT NULL,
  `status` int(11) NOT NULL DEFAULT 0,
  `agency_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `package_places`
--

CREATE TABLE `package_places` (
  `package_id` int(11) NOT NULL,
  `day_no` int(11) NOT NULL,
  `location` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `reserve`
--

CREATE TABLE `reserve` (
  `booking_id` int(11) NOT NULL,
  `reserved_date` date NOT NULL DEFAULT current_timestamp(),
  `traveler_count` int(11) NOT NULL,
  `start_date` date NOT NULL,
  `status` int(11) NOT NULL DEFAULT 0,
  `package_id` int(11) NOT NULL,
  `traveler_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `traveler`
--

CREATE TABLE `traveler` (
  `traveler_id` int(11) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` text NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `contact_no` varchar(20) NOT NULL,
  `country` varchar(30) NOT NULL,
  `user_img` varchar(50) NOT NULL DEFAULT 'user_default.png',
  `status` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `agency`
--
ALTER TABLE `agency`
  ADD PRIMARY KEY (`agency_id`),
  ADD UNIQUE KEY `unique` (`email`);

--
-- Indexes for table `agency_feedback`
--
ALTER TABLE `agency_feedback`
  ADD PRIMARY KEY (`comment_id`),
  ADD KEY `agency_id` (`agency_id`),
  ADD KEY `traveler_id` (`traveler_id`);

--
-- Indexes for table `inquiry`
--
ALTER TABLE `inquiry`
  ADD PRIMARY KEY (`inquiry_id`),
  ADD KEY `booking_id` (`booking_id`);

--
-- Indexes for table `package`
--
ALTER TABLE `package`
  ADD PRIMARY KEY (`package_id`),
  ADD KEY `agency_id` (`agency_id`);

--
-- Indexes for table `package_places`
--
ALTER TABLE `package_places`
  ADD PRIMARY KEY (`package_id`,`day_no`);

--
-- Indexes for table `reserve`
--
ALTER TABLE `reserve`
  ADD PRIMARY KEY (`booking_id`),
  ADD KEY `package_id` (`package_id`),
  ADD KEY `traveler_id` (`traveler_id`);

--
-- Indexes for table `traveler`
--
ALTER TABLE `traveler`
  ADD PRIMARY KEY (`traveler_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `agency`
--
ALTER TABLE `agency`
  MODIFY `agency_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `agency_feedback`
--
ALTER TABLE `agency_feedback`
  MODIFY `comment_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `inquiry`
--
ALTER TABLE `inquiry`
  MODIFY `inquiry_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `package`
--
ALTER TABLE `package`
  MODIFY `package_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `reserve`
--
ALTER TABLE `reserve`
  MODIFY `booking_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `traveler`
--
ALTER TABLE `traveler`
  MODIFY `traveler_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `agency_feedback`
--
ALTER TABLE `agency_feedback`
  ADD CONSTRAINT `agency_feedback_ibfk_1` FOREIGN KEY (`agency_id`) REFERENCES `agency` (`agency_id`),
  ADD CONSTRAINT `agency_feedback_ibfk_2` FOREIGN KEY (`traveler_id`) REFERENCES `traveler` (`traveler_id`);

--
-- Constraints for table `inquiry`
--
ALTER TABLE `inquiry`
  ADD CONSTRAINT `inquiry_ibfk_1` FOREIGN KEY (`booking_id`) REFERENCES `reserve` (`booking_id`);

--
-- Constraints for table `package`
--
ALTER TABLE `package`
  ADD CONSTRAINT `package_ibfk_1` FOREIGN KEY (`agency_id`) REFERENCES `agency` (`agency_id`);

--
-- Constraints for table `package_places`
--
ALTER TABLE `package_places`
  ADD CONSTRAINT `package_places_ibfk_1` FOREIGN KEY (`package_id`) REFERENCES `package` (`package_id`);

--
-- Constraints for table `reserve`
--
ALTER TABLE `reserve`
  ADD CONSTRAINT `reserve_ibfk_1` FOREIGN KEY (`package_id`) REFERENCES `package` (`package_id`),
  ADD CONSTRAINT `reserve_ibfk_2` FOREIGN KEY (`traveler_id`) REFERENCES `traveler` (`traveler_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
