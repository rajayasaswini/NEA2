-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Aug 25, 2021 at 05:36 PM
-- Server version: 8.0.21
-- PHP Version: 7.3.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `raja8450_timeme`
--

-- --------------------------------------------------------

--
-- Table structure for table `class`
--

CREATE TABLE `class` (
  `classID` int NOT NULL,
  `classCode` varchar(6) NOT NULL,
  `classAdmin` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `events`
--

CREATE TABLE `events` (
  `eventID` int NOT NULL,
  `eventType` varchar(100) NOT NULL,
  `eventDistance` varchar(100) DEFAULT NULL,
  `eventTime` time DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `logs`
--

CREATE TABLE `logs` (
  `userID` int NOT NULL,
  `logID` int NOT NULL,
  `logContent` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `postphotos`
--

CREATE TABLE `postphotos` (
  `userID` int NOT NULL,
  `postID` int NOT NULL,
  `postPhotoID` int NOT NULL,
  `postPhoto` blob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `userID` int NOT NULL,
  `postID` int NOT NULL,
  `postContent` varchar(500) NOT NULL,
  `isPosted` tinyint NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `scheduledassignments`
--

CREATE TABLE `scheduledassignments` (
  `assignmentID` int NOT NULL,
  `eventID` int NOT NULL,
  `scheduledDateTime` datetime NOT NULL,
  `returnDateTime` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `userdst`
--

CREATE TABLE `userdst` (
  `userID` int NOT NULL,
  `eventID` int NOT NULL,
  `userDSTID` int NOT NULL,
  `datetime` datetime NOT NULL,
  `userDistance` int DEFAULT NULL,
  `userTime` time DEFAULT NULL,
  `userSpeed` int DEFAULT NULL,
  `isAssignment` tinyint NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(4096) NOT NULL,
  `firstname` varchar(50) NOT NULL,
  `lastname` varchar(50) NOT NULL,
  `email` varchar(255) NOT NULL,
  `about` varchar(1000) DEFAULT NULL,
  `photo` blob,
  `isAdmin` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `firstname`, `lastname`, `email`, `about`, `photo`, `isAdmin`) VALUES
(0, 'rajayasaswini', 'Raja8450!', 'Raja Yasaswini', 'Sriramoju', 'raja8450@dubaicollege.org', NULL, NULL, 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `class`
--
ALTER TABLE `class`
  ADD KEY `FKclassAdmin` (`classAdmin`);

--
-- Indexes for table `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`eventID`);

--
-- Indexes for table `logs`
--
ALTER TABLE `logs`
  ADD PRIMARY KEY (`logID`),
  ADD KEY `UserID` (`userID`);

--
-- Indexes for table `postphotos`
--
ALTER TABLE `postphotos`
  ADD PRIMARY KEY (`postPhotoID`),
  ADD KEY `UserID` (`userID`),
  ADD KEY `PostID` (`postID`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`postID`),
  ADD KEY `UserID` (`userID`);

--
-- Indexes for table `scheduledassignments`
--
ALTER TABLE `scheduledassignments`
  ADD PRIMARY KEY (`assignmentID`),
  ADD KEY `EventID` (`eventID`);

--
-- Indexes for table `userdst`
--
ALTER TABLE `userdst`
  ADD PRIMARY KEY (`userDSTID`),
  ADD KEY `UserID` (`userID`,`eventID`),
  ADD KEY `FKEventID2` (`eventID`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `class`
--
ALTER TABLE `class`
  ADD CONSTRAINT `FKclassAdmin` FOREIGN KEY (`classAdmin`) REFERENCES `users` (`id`);

--
-- Constraints for table `logs`
--
ALTER TABLE `logs`
  ADD CONSTRAINT `FKUserID5` FOREIGN KEY (`userID`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `postphotos`
--
ALTER TABLE `postphotos`
  ADD CONSTRAINT `FKPostID` FOREIGN KEY (`postID`) REFERENCES `posts` (`postID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FKUserID3` FOREIGN KEY (`userID`) REFERENCES `users` (`id`);

--
-- Constraints for table `posts`
--
ALTER TABLE `posts`
  ADD CONSTRAINT `FKUserID` FOREIGN KEY (`userID`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `scheduledassignments`
--
ALTER TABLE `scheduledassignments`
  ADD CONSTRAINT `FKEventID` FOREIGN KEY (`eventID`) REFERENCES `events` (`eventID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `userdst`
--
ALTER TABLE `userdst`
  ADD CONSTRAINT `FKEventID2` FOREIGN KEY (`eventID`) REFERENCES `events` (`eventID`),
  ADD CONSTRAINT `FKUserID2` FOREIGN KEY (`userID`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
