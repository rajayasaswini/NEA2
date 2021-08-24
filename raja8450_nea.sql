-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 24, 2021 at 03:44 PM
-- Server version: 10.4.17-MariaDB
-- PHP Version: 8.0.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `raja8450_nea`
--

-- --------------------------------------------------------

--
-- Table structure for table `class`
--

CREATE TABLE `class` (
  `classID` int(11) NOT NULL,
  `classCode` varchar(6) NOT NULL,
  `classAdmin` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `events`
--

CREATE TABLE `events` (
  `eventID` int(11) NOT NULL,
  `eventType` varchar(100) NOT NULL,
  `eventDistance` varchar(100) DEFAULT NULL,
  `evenTime` time DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `logs`
--

CREATE TABLE `logs` (
  `UserID` int(11) NOT NULL,
  `LogID` int(11) NOT NULL,
  `LogContent` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `postphotos`
--

CREATE TABLE `postphotos` (
  `UserID` int(11) NOT NULL,
  `PostID` int(11) NOT NULL,
  `PostPhotoID` int(11) NOT NULL,
  `PostPhoto` blob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `UserID` int(11) NOT NULL,
  `PostID` int(11) NOT NULL,
  `PostContent` varchar(500) NOT NULL,
  `isPosted` tinyint(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `scheduledassignments`
--

CREATE TABLE `scheduledassignments` (
  `AssignmentID` int(11) NOT NULL,
  `EventID` int(11) NOT NULL,
  `ScheduledDateTime` datetime NOT NULL,
  `ReturnDateTime` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `userdst`
--

CREATE TABLE `userdst` (
  `UserID` int(11) NOT NULL,
  `EventID` int(11) NOT NULL,
  `UserDSTID` int(11) NOT NULL,
  `DateTime` datetime NOT NULL,
  `UserDistance` int(11) DEFAULT NULL,
  `UserTime` time DEFAULT NULL,
  `UserSpeed` int(11) DEFAULT NULL,
  `isAssignment` tinyint(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(4096) NOT NULL,
  `firstname` varchar(50) NOT NULL,
  `lastname` varchar(50) NOT NULL,
  `email` varchar(255) NOT NULL,
  `about` varchar(1000) DEFAULT NULL,
  `photo` blob DEFAULT NULL,
  `isAdmin` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
  ADD PRIMARY KEY (`LogID`),
  ADD KEY `UserID` (`UserID`);

--
-- Indexes for table `postphotos`
--
ALTER TABLE `postphotos`
  ADD PRIMARY KEY (`PostPhotoID`),
  ADD KEY `UserID` (`UserID`),
  ADD KEY `PostID` (`PostID`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`PostID`),
  ADD KEY `UserID` (`UserID`);

--
-- Indexes for table `scheduledassignments`
--
ALTER TABLE `scheduledassignments`
  ADD PRIMARY KEY (`AssignmentID`),
  ADD KEY `EventID` (`EventID`);

--
-- Indexes for table `userdst`
--
ALTER TABLE `userdst`
  ADD PRIMARY KEY (`UserDSTID`),
  ADD KEY `UserID` (`UserID`,`EventID`),
  ADD KEY `FKEventID2` (`EventID`);

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
-- Constraints for table `postphotos`
--
ALTER TABLE `postphotos`
  ADD CONSTRAINT `FKPostID` FOREIGN KEY (`PostID`) REFERENCES `posts` (`PostID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FKUserID3` FOREIGN KEY (`UserID`) REFERENCES `users` (`id`);

--
-- Constraints for table `posts`
--
ALTER TABLE `posts`
  ADD CONSTRAINT `FKUserID` FOREIGN KEY (`UserID`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `scheduledassignments`
--
ALTER TABLE `scheduledassignments`
  ADD CONSTRAINT `FKEventID` FOREIGN KEY (`EventID`) REFERENCES `events` (`eventID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `userdst`
--
ALTER TABLE `userdst`
  ADD CONSTRAINT `FKEventID2` FOREIGN KEY (`EventID`) REFERENCES `events` (`eventID`),
  ADD CONSTRAINT `FKUserID2` FOREIGN KEY (`UserID`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
