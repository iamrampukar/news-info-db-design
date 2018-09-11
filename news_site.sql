-- phpMyAdmin SQL Dump
-- version 4.8.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 11, 2018 at 09:20 AM
-- Server version: 10.1.32-MariaDB
-- PHP Version: 5.6.36

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `news_site`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `px_exists` (IN `in_id` INT)  BEGIN
	DECLARE is_exists INT;
	DECLARE reply VARCHAR(100);
	SET is_exists = 0;
	SELECT COUNT(*) INTO is_exists FROM news_info WHERE news_id = in_id;
	IF is_exists > 0 THEN
	SET reply = "Exist";
ELSE
SET reply = "Not Exists";
END IF;
SELECT reply;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `px_get_all` (IN `in_id` INT)  BEGIN
DECLARE result VARCHAR(50);
DECLARE get_id INT;
SET get_id = in_id;
IF (SELECT EXISTS(SELECT news_id FROM news_info WHERE news_id = get_id)) THEN
	SET result = 'Exist';
ELSE
	SET result =  'Not EXISTS';
END IF;
SELECT result;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `px_loop` ()  BEGIN
	DECLARE x  INT;
  DECLARE str  VARCHAR(255);
  SET x = 1;
  SET str =  '';
        
 loop_label:  LOOP
 IF  x > 10 THEN 
 LEAVE  loop_label;
 END  IF;
            
 SET  x = x + 1;
 IF  (x mod 2) THEN
 ITERATE  loop_label;
 ELSE
SET  str = CONCAT(str,x,',');
 END  IF;
END LOOP;    
SELECT str;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `px_repeat` ()  BEGIN
 DECLARE x INT;
 DECLARE str VARCHAR(255);
 SET x = 1;
 SET str =  '';
	REPEAT
	SET  str = CONCAT(str,x,',');
	 SET  x = x + 1;
  UNTIL x  > 5 END REPEAT;
SELECT str;
END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `fx_get_title` (`in_age` INT) RETURNS VARCHAR(10) CHARSET utf8 BEGIN
	DECLARE title VARCHAR(10);
	IF in_age<5 THEN
	SET title = 'Child';
	ELSEIF in_age <10 THEN
	SET title ='Teen';
ELSE
	SET title = 'Young';
END IF;
RETURN(title);
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `category_id` int(10) UNSIGNED NOT NULL,
  `category_name` varchar(100) NOT NULL,
  `created_at` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`category_id`, `category_name`, `created_at`) VALUES
(1, 'National', '2018-09-07'),
(2, 'World', '2018-09-07'),
(3, 'Crime', '2018-09-07'),
(4, 'Entertainment', '2018-09-07'),
(5, 'Hollywood', '2018-09-07'),
(6, 'Sport', '2018-09-07');

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `comment_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(11) UNSIGNED NOT NULL,
  `news_id` int(11) UNSIGNED NOT NULL,
  `comment_content` text,
  `is_veryfied` tinyint(4) DEFAULT '0',
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `comments`
--

INSERT INTO `comments` (`comment_id`, `user_id`, `news_id`, `comment_content`, `is_veryfied`, `created_at`) VALUES
(1, 1, 4, 'This is very good ', 1, '2018-09-07 20:49:51'),
(2, 2, 5, 'This is no good', 1, '2018-09-07 20:50:12'),
(3, 1, 1, 'This app', 1, '2018-09-07 20:50:37'),
(4, 2, 4, 'Excellent', 1, '2018-09-07 21:03:21');

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
  `employee_id` int(10) UNSIGNED NOT NULL,
  `first_name` varchar(20) NOT NULL,
  `last_name` varchar(20) NOT NULL,
  `email` varchar(50) NOT NULL,
  `report_to` int(11) DEFAULT NULL,
  `job_id` int(11) UNSIGNED DEFAULT NULL,
  `office_id` int(11) UNSIGNED DEFAULT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `employees`
--

INSERT INTO `employees` (`employee_id`, `first_name`, `last_name`, `email`, `report_to`, `job_id`, `office_id`, `created_at`) VALUES
(1, 'Ram', 'Pukar', 'ram@bbc.com', NULL, 1, 4, '2018-09-07 18:00:51'),
(2, 'Niral', 'Shakya', 'niral@bbc.com', 1, 2, 3, '2018-09-07 18:07:59'),
(3, 'Saroj', 'Rai', 'saroj@bbc.com', 1, 4, 2, '2018-09-07 18:08:02'),
(4, 'Dhirendra', 'Yadav', 'dhirendra@bbc.com', 2, 6, 1, '2018-09-07 18:08:05'),
(5, 'Mahesh', 'Sah', 'mahesh@bbc.com', 1, 2, 4, '2018-09-07 18:09:04');

-- --------------------------------------------------------

--
-- Stand-in structure for view `employees_info`
-- (See below for the actual view)
--
CREATE TABLE `employees_info` (
`employee_id` int(10) unsigned
,`first_name` varchar(20)
,`last_name` varchar(20)
,`job_title` varchar(50)
,`address` text
,`phone` varchar(20)
);

-- --------------------------------------------------------

--
-- Table structure for table `job_title`
--

CREATE TABLE `job_title` (
  `job_id` int(10) UNSIGNED NOT NULL,
  `job_title` varchar(50) NOT NULL,
  `job_description` text,
  `created_at` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `job_title`
--

INSERT INTO `job_title` (`job_id`, `job_title`, `job_description`, `created_at`) VALUES
(1, 'CEO', 'About CEO', '2018-09-07'),
(2, 'President', 'About  President', '2018-09-07'),
(3, 'Sr. Journal', 'About Journal', '2018-09-07'),
(4, 'Crime Journal', 'Crime', '2018-09-07'),
(5, 'Jr. Journal', 'About Journal', '2018-09-07'),
(6, 'Journal', 'Journal', '2018-09-07');

-- --------------------------------------------------------

--
-- Table structure for table `log`
--

CREATE TABLE `log` (
  `id` int(11) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Stand-in structure for view `news_detail`
-- (See below for the actual view)
--
CREATE TABLE `news_detail` (
`news_id` int(10) unsigned
,`category_id` int(11) unsigned
,`news_title` varchar(255)
,`news_short_content` varchar(255)
,`news_full_content` text
,`employee_id` int(11) unsigned
,`published_on` datetime
,`created_at` datetime
,`category_name` varchar(100)
,`full_name` varchar(41)
);

-- --------------------------------------------------------

--
-- Table structure for table `news_image`
--

CREATE TABLE `news_image` (
  `image_id` int(10) UNSIGNED NOT NULL,
  `news_id` int(10) UNSIGNED NOT NULL,
  `image_name` varchar(100) DEFAULT NULL,
  `image_link` varchar(200) DEFAULT NULL,
  `image_like` int(11) DEFAULT NULL,
  `image_dislike` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `news_info`
--

CREATE TABLE `news_info` (
  `news_id` int(10) UNSIGNED NOT NULL,
  `category_id` int(11) UNSIGNED NOT NULL,
  `news_title` varchar(255) DEFAULT NULL,
  `news_short_content` varchar(255) DEFAULT NULL,
  `news_full_content` text,
  `employee_id` int(11) UNSIGNED DEFAULT NULL,
  `published_on` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `news_info`
--

INSERT INTO `news_info` (`news_id`, `category_id`, `news_title`, `news_short_content`, `news_full_content`, `employee_id`, `published_on`, `created_at`) VALUES
(1, 1, 'Update', 'Apple Data', 'There are fears of a humanitarian disaster if, as expected, a large-scale battle breaks out in Idlib.\r\n\r\nEarlier, the new US envoy for Syria said there was \"evidence\" that Syrian government forces were preparing to use chemical weapons.\r\n\r\nFresh air strikes on rebel positions were reported on Friday morning.\r\n\r\nIran, Russia and Turkey have played central roles in the Syrian conflict.\r\n\r\nTurkey - which has long backed rebel groups - fears an all-out assault will trigger another huge refugee crisis on its southern border.\r\n\r\nRussia and Iran - which have provided vital support for Syrian President Bashar al-Assad - believe the rebels in Idlib must be wiped out.', 5, '2018-09-07 18:36:46', '2018-09-07 18:36:52'),
(3, 6, 'US Open 2018: Serena Williams final \'a dream\' - Naomi Osaka', 'Venue: Flushing Meadows, New York Dates: 27 August-9 September Coverage: Live radio coverage on BBC Radio 5 live sports extra; live text commentaries on the BBC Sport website', 'Naomi Osaka says she \"always dreamed\" she would play her idol Serena Williams in a Grand Slam final after both reached this year\'s US Open decider.\r\n\r\nThe 20-year-old became Japan\'s first female Grand Slam finalist by defeating last year\'s runner up Madison Keys 6-2 6-4 at Flushing Meadows in New York.\r\n\r\nSix-time winner Williams is looking to match the record 24 Grand Slam titles won by Australian Margaret Court.\r\n\r\n\"I shouldn\'t think of her as my idol, just as an opponent,\" said Osaka.\r\n\r\n\"When I was a little kid I always dreamed I would play Serena in a Grand Slam final. At the same time I feel like even though I should enjoy this moment, I should still think of it as another match.\"', 2, '2018-09-07 18:40:30', '2018-09-07 18:40:33'),
(4, 2, 'Burt Reynolds turned down James Bond - and 10 other stars who rejected great roles', 'Hollywood legend Burt Reynolds, who died on Thursday, had a long list of impressive films to his name, including Smokey and the Bandit, Deliverance and Boogie Nights.', 'But he could have had even more. During his 60-year career, he claimed to have turned down several huge roles, including James Bond and Han Solo.\r\n\r\nObituary: Burt Reynolds\r\nReynolds was eyed up as the replacement for Sean Connery\'s Bond, but told USA Today in 2015 that he turned down the part because he thought the public wouldn\'t accept an American 007.\r\n\r\n\"It was a stupid thing to say, I could\'ve done it and I could\'ve done it well,\" he said.\r\n\r\nHe could have also been Han Solo in Star Wars, a part that was eventually played by Harrison Ford. Reynolds said in hindsight he regretted turning it down.\r\n\r\nHe told Business Insider in 2016: \"I just didn\'t want to play that kind of role at the time.\"', 3, '2018-09-07 18:41:21', '2018-09-07 18:41:23'),
(5, 5, 'Princess Alice disaster: The Thames\' 650 forgotten dead', 'The Princess Alice sank in the River Thames on 3 September 1878, killing hundreds of ordinary Londoners returning home from a day trip to the seaside. The tragedy, now largely forgotten, dominated newspaper headlines and led to changes to the shipping ind', 'A boatman hooks another body out of the foul-smelling Thames, a grisly prize that will earn him five shillings.\r\n\r\nA few days before, the Princess Alice had been smashed in two as it returned to London packed with men, women and children who had been on a trip to Kent.\r\n\r\nAbout 650 lives were lost and for weeks bodies decayed in the polluted water or washed up on the riverbank.', 4, '2018-09-07 18:42:36', '2018-09-07 18:42:38');

-- --------------------------------------------------------

--
-- Table structure for table `office`
--

CREATE TABLE `office` (
  `office_id` int(10) UNSIGNED NOT NULL,
  `address` text NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `state` varchar(100) DEFAULT NULL,
  `district` varchar(50) DEFAULT NULL,
  `zone` varchar(50) DEFAULT NULL,
  `country` varchar(10) DEFAULT NULL,
  `map_link` varchar(100) DEFAULT NULL,
  `created_at` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `office`
--

INSERT INTO `office` (`office_id`, `address`, `phone`, `state`, `district`, `zone`, `country`, `map_link`, `created_at`) VALUES
(1, 'Biratnagar', '021-123456', '1', 'Morange', 'Koshi', 'NP', NULL, '2018-09-07'),
(2, 'Bharatpur', '023-123456', '4', 'Chitwan', 'Narayani', 'NP', NULL, '2018-09-07'),
(3, 'Nepalgunj', '024-123456', '6', NULL, NULL, 'NP', NULL, '2018-09-07'),
(4, 'Kathmandu', '01-123456', '3', 'Kathmandu', 'Bagmati', 'NP', NULL, '2018-09-07'),
(5, 'Lahan', NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(10) UNSIGNED NOT NULL,
  `username` varchar(20) NOT NULL,
  `userpassword` varchar(50) NOT NULL,
  `email` varchar(50) DEFAULT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `username`, `userpassword`, `email`, `first_name`, `last_name`, `created_at`) VALUES
(1, 'nishant', 'nishant', 'nishant@gmail.com', 'Nishant', 'Thapa', '2018-09-07 18:43:29'),
(2, 'manoj', 'manoj', 'manoj@gmail.com', 'Manoj', 'Sah', '2018-09-07 18:43:54');

-- --------------------------------------------------------

--
-- Structure for view `employees_info`
--
DROP TABLE IF EXISTS `employees_info`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `employees_info`  AS  select `emp`.`employee_id` AS `employee_id`,`emp`.`first_name` AS `first_name`,`emp`.`last_name` AS `last_name`,`job`.`job_title` AS `job_title`,`office`.`address` AS `address`,`office`.`phone` AS `phone` from ((`employees` `emp` join `job_title` `job` on((`emp`.`job_id` = `job`.`job_id`))) join `office` on((`office`.`office_id` = `emp`.`office_id`))) order by `emp`.`employee_id` ;

-- --------------------------------------------------------

--
-- Structure for view `news_detail`
--
DROP TABLE IF EXISTS `news_detail`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `news_detail`  AS  select `news`.`news_id` AS `news_id`,`news`.`category_id` AS `category_id`,`news`.`news_title` AS `news_title`,`news`.`news_short_content` AS `news_short_content`,`news`.`news_full_content` AS `news_full_content`,`news`.`employee_id` AS `employee_id`,`news`.`published_on` AS `published_on`,`news`.`created_at` AS `created_at`,`category`.`category_name` AS `category_name`,concat(`emp`.`first_name`,' ',`emp`.`last_name`) AS `full_name` from ((`news_info` `news` join `category` on((`news`.`category_id` = `category`.`category_id`))) join `employees` `emp` on((`emp`.`employee_id` = `news`.`employee_id`))) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`category_id`);

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`comment_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `news_id` (`news_id`);

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`employee_id`),
  ADD KEY `job_id` (`job_id`),
  ADD KEY `office_id` (`office_id`);

--
-- Indexes for table `job_title`
--
ALTER TABLE `job_title`
  ADD PRIMARY KEY (`job_id`);

--
-- Indexes for table `log`
--
ALTER TABLE `log`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `news_image`
--
ALTER TABLE `news_image`
  ADD PRIMARY KEY (`image_id`),
  ADD KEY `news_id` (`news_id`);

--
-- Indexes for table `news_info`
--
ALTER TABLE `news_info`
  ADD PRIMARY KEY (`news_id`),
  ADD KEY `employee_id` (`employee_id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `office`
--
ALTER TABLE `office`
  ADD PRIMARY KEY (`office_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `category_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `comment_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `employees`
--
ALTER TABLE `employees`
  MODIFY `employee_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `job_title`
--
ALTER TABLE `job_title`
  MODIFY `job_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `log`
--
ALTER TABLE `log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `news_image`
--
ALTER TABLE `news_image`
  MODIFY `image_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `news_info`
--
ALTER TABLE `news_info`
  MODIFY `news_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `office`
--
ALTER TABLE `office`
  MODIFY `office_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`news_id`) REFERENCES `news_info` (`news_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `employees`
--
ALTER TABLE `employees`
  ADD CONSTRAINT `employees_ibfk_1` FOREIGN KEY (`job_id`) REFERENCES `job_title` (`job_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `employees_ibfk_2` FOREIGN KEY (`office_id`) REFERENCES `office` (`office_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `news_image`
--
ALTER TABLE `news_image`
  ADD CONSTRAINT `news_image_ibfk_1` FOREIGN KEY (`news_id`) REFERENCES `news_info` (`news_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `news_info`
--
ALTER TABLE `news_info`
  ADD CONSTRAINT `news_info_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`employee_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `news_info_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
