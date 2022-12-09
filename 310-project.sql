-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:8889
-- Generation Time: Dec 09, 2022 at 11:05 PM
-- Server version: 5.7.34
-- PHP Version: 8.0.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `310-project`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `admin_id` int(11) NOT NULL,
  `user_rm_num` int(11) NOT NULL,
  `user_office_phone` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`admin_id`, `user_rm_num`, `user_office_phone`) VALUES
(4, 1, '3213213214'),
(5, 2, '3213213215'),
(6, 3, '3213213216'),
(7, 4, '3213213217');

-- --------------------------------------------------------

--
-- Table structure for table `appointment`
--

CREATE TABLE `appointment` (
  `apt_id` int(11) NOT NULL,
  `apt_date` date NOT NULL,
  `apt_start_time` time NOT NULL,
  `apt_end_time` time NOT NULL,
  `apt_price` float NOT NULL,
  `service_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `admin_id` int(11) NOT NULL,
  `comment_id` int(11) DEFAULT NULL,
  `review_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `appointment`
--

INSERT INTO `appointment` (`apt_id`, `apt_date`, `apt_start_time`, `apt_end_time`, `apt_price`, `service_id`, `user_id`, `admin_id`, `comment_id`, `review_id`) VALUES
(1, '2022-12-06', '12:30:40', '13:00:40', 50, 1, 8, 4, NULL, NULL),
(2, '2022-12-18', '12:00:12', '23:48:55', 100, 3, 8, 6, NULL, NULL),
(3, '2022-12-06', '23:36:36', '00:36:41', 200, 4, 8, 7, NULL, NULL),
(4, '2022-12-09', '14:56:53', '15:26:54', 50, 1, 9, 4, NULL, 6),
(8, '2022-12-09', '16:38:25', '17:23:30', 80, 2, 9, 5, 4, 4),
(9, '2022-12-09', '16:38:32', '17:38:35', 200, 4, 9, 5, 5, 5);

-- --------------------------------------------------------

--
-- Table structure for table `comment`
--

CREATE TABLE `comment` (
  `comment_id` int(11) NOT NULL,
  `comment_date` datetime NOT NULL,
  `comment_value` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  `admin_id` int(11) NOT NULL,
  `apt_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `comment`
--

INSERT INTO `comment` (`comment_id`, `comment_date`, `comment_value`, `user_id`, `admin_id`, `apt_id`) VALUES
(4, '2022-12-09 22:42:47', 'nothing to note. business as usual', 9, 5, 8),
(5, '2022-12-09 22:43:10', 'patient complained but everything went fine. follow up at next appt.', 9, 5, 9);

-- --------------------------------------------------------

--
-- Stand-in structure for view `gage_info`
-- (See below for the actual view)
--
CREATE TABLE `gage_info` (
`username` varchar(255)
,`user_fname` varchar(255)
,`user_lname` varchar(255)
,`user_phone` varchar(255)
,`is_admin` tinyint(1)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `jackson_info`
-- (See below for the actual view)
--
CREATE TABLE `jackson_info` (
`username` varchar(255)
,`user_fname` varchar(255)
,`user_lname` varchar(255)
,`user_phone` varchar(255)
,`is_admin` tinyint(1)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `kieran_info`
-- (See below for the actual view)
--
CREATE TABLE `kieran_info` (
`username` varchar(255)
,`user_fname` varchar(255)
,`user_lname` varchar(255)
,`user_phone` varchar(255)
,`is_admin` tinyint(1)
);

-- --------------------------------------------------------

--
-- Table structure for table `profile`
--

CREATE TABLE `profile` (
  `profile_id` int(10) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `user_fname` varchar(255) NOT NULL,
  `user_lname` varchar(255) NOT NULL,
  `user_phone` varchar(255) NOT NULL,
  `date_created` date NOT NULL,
  `is_admin` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='table for user and admin profiles';

--
-- Dumping data for table `profile`
--

INSERT INTO `profile` (`profile_id`, `username`, `password`, `user_fname`, `user_lname`, `user_phone`, `date_created`, `is_admin`) VALUES
(4, 'gagebroberg', 'gage123', 'Gage', 'Broberg', '1231231234', '2022-12-06', 1),
(5, 'jacksonwright', 'jackson123', 'Jackson', 'Wright', '1231231235', '2022-12-06', 1),
(6, 'kieranbierne', 'kieran123', 'Kieran', 'Bierne', '1231231236', '2022-12-06', 1),
(7, 'shanebrown', 'shane123', 'Shane', 'Brown', '1231231237', '2022-12-06', 1),
(8, 'gagebroberg', '1Jsprocket', 'Gage', 'Broberg', '123213213', '2022-12-06', 0),
(9, 'jacksonp', 'jackson123', 'Jackson', 'Patient', '1231231123', '2022-12-09', 0),
(10, 'testpatient', 'test123', 'Test', 'Patient', '5129702321', '2022-12-09', 0);

-- --------------------------------------------------------

--
-- Table structure for table `review`
--

CREATE TABLE `review` (
  `review_id` int(11) NOT NULL,
  `review_date` datetime NOT NULL,
  `review_value` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  `admin_id` int(11) NOT NULL,
  `apt_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `review`
--

INSERT INTO `review` (`review_id`, `review_date`, `review_value`, `user_id`, `admin_id`, `apt_id`) VALUES
(4, '2022-12-09 22:38:49', 'great teeth cleaning!', 9, 5, 8),
(5, '2022-12-09 22:39:08', 'tooth extraction sucks', 9, 5, 9),
(6, '2022-12-09 22:41:18', 'gage was very kind during the consultation!', 9, 4, 4);

-- --------------------------------------------------------

--
-- Table structure for table `service`
--

CREATE TABLE `service` (
  `service_id` int(11) NOT NULL,
  `service_est_time` int(11) NOT NULL,
  `service_name` varchar(255) NOT NULL,
  `service_price` float NOT NULL,
  `service_description` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `service`
--

INSERT INTO `service` (`service_id`, `service_est_time`, `service_name`, `service_price`, `service_description`) VALUES
(1, 30, 'Consultation', 50, 'Non-invasive visit with your dentist where you can discuss any issues that you are experiencing, concerns and treatment options.'),
(2, 45, 'Teeth Cleaning', 80, 'Dental hygienist will use teeth cleaning instruments to remove plaque and tartar. The more plaque and tartar you have, the longer this step will take.'),
(3, 45, 'Teeth Whitening', 100, 'A rubber dam is put over your teeth to protect the gums, and a bleaching product is painted onto your teeth. Then a light or laser is shone on the teeth to activate the chemical.'),
(4, 60, 'Tooth Extraction', 200, 'You will get a local anesthetic to numb the area around the tooth so you do not feel pain. Your dentist will then place forceps around the tooth and pull the tooth out from the gum.'),
(5, 120, 'Root Canal', 300, 'A treatment to repair and save a badly damaged or infected tooth instead of removing it.');

-- --------------------------------------------------------

--
-- Stand-in structure for view `shane_info`
-- (See below for the actual view)
--
CREATE TABLE `shane_info` (
`username` varchar(255)
,`user_fname` varchar(255)
,`user_lname` varchar(255)
,`user_phone` varchar(255)
,`is_admin` tinyint(1)
);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `user_id` int(11) NOT NULL,
  `user_age` int(11) NOT NULL,
  `user_state` varchar(11) NOT NULL,
  `user_zip` int(11) NOT NULL,
  `user_street` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`user_id`, `user_age`, `user_state`, `user_zip`, `user_street`) VALUES
(8, 22, 'TX', 75214, 'Test street'),
(9, 22, 'TX', 77840, 'no'),
(10, 22, 'TX', 77840, '601 Luther St W');

-- --------------------------------------------------------

--
-- Structure for view `gage_info`
--
DROP TABLE IF EXISTS `gage_info`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `gage_info`  AS SELECT `profile`.`username` AS `username`, `profile`.`user_fname` AS `user_fname`, `profile`.`user_lname` AS `user_lname`, `profile`.`user_phone` AS `user_phone`, `profile`.`is_admin` AS `is_admin` FROM `profile` WHERE (`profile`.`profile_id` = 4) ;

-- --------------------------------------------------------

--
-- Structure for view `jackson_info`
--
DROP TABLE IF EXISTS `jackson_info`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `jackson_info`  AS SELECT `profile`.`username` AS `username`, `profile`.`user_fname` AS `user_fname`, `profile`.`user_lname` AS `user_lname`, `profile`.`user_phone` AS `user_phone`, `profile`.`is_admin` AS `is_admin` FROM `profile` WHERE (`profile`.`profile_id` = 5) ;

-- --------------------------------------------------------

--
-- Structure for view `kieran_info`
--
DROP TABLE IF EXISTS `kieran_info`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `kieran_info`  AS SELECT `profile`.`username` AS `username`, `profile`.`user_fname` AS `user_fname`, `profile`.`user_lname` AS `user_lname`, `profile`.`user_phone` AS `user_phone`, `profile`.`is_admin` AS `is_admin` FROM `profile` WHERE (`profile`.`profile_id` = 6) ;

-- --------------------------------------------------------

--
-- Structure for view `shane_info`
--
DROP TABLE IF EXISTS `shane_info`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `shane_info`  AS SELECT `profile`.`username` AS `username`, `profile`.`user_fname` AS `user_fname`, `profile`.`user_lname` AS `user_lname`, `profile`.`user_phone` AS `user_phone`, `profile`.`is_admin` AS `is_admin` FROM `profile` WHERE (`profile`.`profile_id` = 7) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`admin_id`);

--
-- Indexes for table `appointment`
--
ALTER TABLE `appointment`
  ADD PRIMARY KEY (`apt_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `service_id` (`service_id`),
  ADD KEY `review_id` (`review_id`),
  ADD KEY `comment_id` (`comment_id`),
  ADD KEY `admin_id` (`admin_id`);

--
-- Indexes for table `comment`
--
ALTER TABLE `comment`
  ADD PRIMARY KEY (`comment_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `apt_id` (`apt_id`),
  ADD KEY `admin_id` (`admin_id`);

--
-- Indexes for table `profile`
--
ALTER TABLE `profile`
  ADD PRIMARY KEY (`profile_id`);

--
-- Indexes for table `review`
--
ALTER TABLE `review`
  ADD PRIMARY KEY (`review_id`),
  ADD KEY `apt_id` (`apt_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `admin_id` (`admin_id`);

--
-- Indexes for table `service`
--
ALTER TABLE `service`
  ADD PRIMARY KEY (`service_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `appointment`
--
ALTER TABLE `appointment`
  MODIFY `apt_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `comment`
--
ALTER TABLE `comment`
  MODIFY `comment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `profile`
--
ALTER TABLE `profile`
  MODIFY `profile_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `review`
--
ALTER TABLE `review`
  MODIFY `review_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `service`
--
ALTER TABLE `service`
  MODIFY `service_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `admin`
--
ALTER TABLE `admin`
  ADD CONSTRAINT `admin_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `profile` (`profile_id`);

--
-- Constraints for table `appointment`
--
ALTER TABLE `appointment`
  ADD CONSTRAINT `appointment_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`),
  ADD CONSTRAINT `appointment_ibfk_2` FOREIGN KEY (`service_id`) REFERENCES `service` (`service_id`),
  ADD CONSTRAINT `appointment_ibfk_3` FOREIGN KEY (`review_id`) REFERENCES `review` (`review_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `appointment_ibfk_4` FOREIGN KEY (`comment_id`) REFERENCES `comment` (`comment_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `appointment_ibfk_5` FOREIGN KEY (`admin_id`) REFERENCES `admin` (`admin_id`);

--
-- Constraints for table `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `user_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `profile` (`profile_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
