-- phpMyAdmin SQL Dump
-- version 4.5.2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jun 25, 2017 at 03:28 AM
-- Server version: 10.1.19-MariaDB
-- PHP Version: 5.6.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bank`
--

-- --------------------------------------------------------

--
-- Table structure for table `accounts`
--

CREATE TABLE `accounts` (
  `id` int(11) NOT NULL,
  `account_number` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `account_type` smallint(3) NOT NULL COMMENT '1 = saving, 2 = corporate',
  `holder_type` smallint(3) NOT NULL COMMENT 'Single, Joint',
  `balance` varchar(255) NOT NULL,
  `status` tinyint(4) NOT NULL COMMENT '1 = enabled, 2 = disabled, -1 = soft delete',
  `created_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `accounts`
--

INSERT INTO `accounts` (`id`, `account_number`, `name`, `account_type`, `holder_type`, `balance`, `status`, `created_at`, `updated_at`) VALUES
(1, 43553535, 'raj', 1, 1, '234234', 1, '2017-06-22 07:14:08', '0000-00-00 00:00:00'),
(7, 342423, 'Ravi', 1, 1, '12114', 1, '2017-06-23 15:22:51', '2017-06-23 11:52:51'),
(9, 34, 'Ravi', 1, 1, '66300', 1, '2017-06-24 16:50:43', '2017-06-24 13:20:43'),
(11, 33, 'Ravi', 1, 1, '69600', -1, '2017-06-24 08:03:03', '2017-06-24 04:33:03'),
(12, 36, 'Sohita', 1, 1, '1001400', 1, '2017-06-24 16:45:18', '2017-06-24 13:15:18'),
(14, 37, 'krishna', 1, 1, '1000000', -1, '2017-06-24 07:26:38', '2017-06-24 03:56:38'),
(16, 38, 'Raj', 1, 1, '100', 1, '2017-06-24 16:49:33', '2017-06-24 13:19:33'),
(17, 39, 'kamad', 1, 1, '100', 1, '2017-06-24 16:50:43', '2017-06-24 13:20:43');

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id` int(11) NOT NULL,
  `account_number` int(11) NOT NULL,
  `transaction_type` varchar(250) NOT NULL,
  `source_type` varchar(20) NOT NULL,
  `amount` int(11) NOT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`id`, `account_number`, `transaction_type`, `source_type`, `amount`, `remarks`, `created_at`, `updated_at`) VALUES
(36, 33, '1', '3', 10000, 'via neft', '2017-06-23 23:30:52', '2017-06-23 23:30:52'),
(35, 34, '1', '3', 10000, 'via neft', '2017-06-23 23:28:58', '2017-06-23 23:28:58'),
(34, 33, '1', '3', 10000, 'via neft', '2017-06-23 23:28:58', '2017-06-23 23:28:58'),
(33, 34, '1', '3', 10000, 'via neft', '2017-06-22 23:20:30', '2017-06-23 23:20:30'),
(32, 33, '1', '3', 10000, 'via neft', '2017-06-23 23:20:30', '2017-06-23 23:20:30'),
(31, 34, '2', '3', 10000, 'via neft', '2017-06-23 13:01:33', '2017-06-23 13:01:33'),
(30, 33, '1', '3', 10000, 'via neft', '2017-06-23 13:01:33', '2017-06-23 13:01:33'),
(29, 34, '2', '3', 10000, 'via neft', '2017-06-23 12:55:28', '2017-06-23 12:55:28'),
(28, 33, '1', '3', 10000, 'via neft', '2017-06-23 12:55:28', '2017-06-23 12:55:28'),
(37, 34, '2', '3', 10000, 'via neft', '2017-06-23 23:30:52', '2017-06-23 23:30:52'),
(38, 34, '1', '3', 10000, 'via neft', '2017-06-24 01:15:48', '2017-06-24 01:15:48'),
(39, 33, '2', '3', 10000, 'via neft', '2017-06-24 01:15:48', '2017-06-24 01:15:48'),
(40, 34, '1', '3', 10000, 'via neft', '2017-06-24 01:18:57', '2017-06-24 01:18:57'),
(41, 33, '2', '3', 10000, 'via neft', '2017-06-24 01:18:57', '2017-06-24 01:18:57'),
(42, 34, '1', '3', 10000, 'via neft', '2017-06-24 01:19:56', '2017-06-24 01:19:56'),
(43, 33, '2', '3', 10000, 'via neft', '2017-06-24 01:19:56', '2017-06-24 01:19:56'),
(44, 34, '1', '3', 10000, 'via neft', '2017-06-24 01:20:04', '2017-06-24 01:20:04'),
(45, 33, '2', '3', 10000, 'via neft', '2017-06-24 01:20:04', '2017-06-24 01:20:04'),
(46, 33, '1', '3', 10000, 'via neft', '2017-06-24 01:22:01', '2017-06-24 01:22:01'),
(47, 34, '2', '3', 10000, 'via neft', '2017-06-24 01:22:01', '2017-06-24 01:22:01'),
(48, 33, '1', '3', 10000, 'via neft', '2017-06-24 01:23:33', '2017-06-24 01:23:33'),
(49, 34, '2', '3', 10000, 'via neft', '2017-06-24 01:23:33', '2017-06-24 01:23:33'),
(50, 33, '1', '3', 10000, 'via neft', '2017-06-24 01:25:27', '2017-06-24 01:25:27'),
(51, 34, '2', '3', 10000, 'via neft', '2017-06-24 01:25:27', '2017-06-24 01:25:27'),
(52, 33, '1', '3', 10000, 'via neft', '2017-06-24 01:27:09', '2017-06-24 01:27:09'),
(53, 34, '2', '3', 10000, 'via neft', '2017-06-24 01:27:09', '2017-06-24 01:27:09'),
(54, 33, '1', '3', 10000, 'via neft', '2017-06-24 01:27:28', '2017-06-24 01:27:28'),
(55, 34, '2', '3', 10000, 'via neft', '2017-06-24 01:27:28', '2017-06-24 01:27:28'),
(56, 33, '1', '3', 10000, 'via neft', '2017-06-24 01:30:01', '2017-06-24 01:30:01'),
(57, 34, '2', '3', 10000, 'via neft', '2017-06-24 01:30:01', '2017-06-24 01:30:01'),
(58, 33, '1', '3', 10000, 'via neft', '2017-06-24 01:30:41', '2017-06-24 01:30:41'),
(59, 34, '2', '3', 10000, 'via neft', '2017-06-24 01:30:41', '2017-06-24 01:30:41'),
(60, 33, '1', '3', 10000, 'via neft', '2017-06-25 01:31:30', '2017-06-25 01:31:30'),
(61, 34, '2', '3', 10000, 'via neft', '2017-06-25 01:31:30', '2017-06-25 01:31:30'),
(62, 34, '1', '3', 10000, 'via neft', '2017-06-24 01:38:25', '2017-06-24 01:38:25'),
(63, 33, '2', '3', 10000, 'via neft', '2017-06-24 01:38:25', '2017-06-24 01:38:25'),
(64, 34, '1', '3', 10000, 'via neft', '2017-06-24 01:39:00', '2017-06-24 01:39:00'),
(65, 33, '2', '3', 10000, 'via neft', '2017-06-24 01:39:00', '2017-06-24 01:39:00'),
(66, 33, '1', '5', 100, NULL, '2017-06-24 04:08:04', '2017-06-24 04:08:04'),
(67, 33, '2', '5', 100, NULL, '2017-06-24 04:10:59', '2017-06-24 04:10:59'),
(68, 33, '2', '5', 100, NULL, '2017-06-24 04:11:24', '2017-06-24 04:11:24'),
(69, 33, '2', '5', 100, NULL, '2017-06-24 04:11:42', '2017-06-24 04:11:42'),
(70, 33, '2', '5', 100, NULL, '2017-06-24 04:12:42', '2017-06-24 04:12:42'),
(71, 34, '1', '3', 100, 'sdfffsf', '2017-06-24 04:33:03', '2017-06-24 04:33:03'),
(72, 33, '2', '3', 100, 'sdfffsf', '2017-06-24 04:33:03', '2017-06-24 04:33:03'),
(73, 34, '1', '3', 200, 'sdfffsf', '2017-06-24 12:49:31', '2017-06-24 12:49:31'),
(74, 36, '2', '3', 100, 'sdfffsf', '2017-06-24 12:49:31', '2017-06-24 12:49:31'),
(75, 34, '1', '3', 200, 'sdfffsf', '2017-06-24 12:50:42', '2017-06-24 12:50:42'),
(76, 36, '2', '3', 100, 'sdfffsf', '2017-06-24 12:50:42', '2017-06-24 12:50:42'),
(77, 34, '1', '3', 200, 'sdfffsf', '2017-06-24 12:51:37', '2017-06-24 12:51:37'),
(78, 36, '2', '3', 100, 'sdfffsf', '2017-06-24 12:51:37', '2017-06-24 12:51:37'),
(79, 34, '1', '3', 200, 'sdfffsf', '2017-06-24 12:52:00', '2017-06-24 12:52:00'),
(80, 36, '2', '3', 100, 'sdfffsf', '2017-06-24 12:52:00', '2017-06-24 12:52:00'),
(81, 34, '1', '3', 200, 'sdfffsf', '2017-06-24 12:53:49', '2017-06-24 12:53:49'),
(82, 36, '2', '3', 100, 'sdfffsf', '2017-06-24 12:53:49', '2017-06-24 12:53:49'),
(83, 34, '1', '3', 200, 'sdfffsf', '2017-06-24 12:54:38', '2017-06-24 12:54:38'),
(84, 36, '2', '3', 100, 'sdfffsf', '2017-06-24 12:54:38', '2017-06-24 12:54:38'),
(85, 34, '1', '3', 200, 'sdfffsf', '2017-06-24 12:55:52', '2017-06-24 12:55:52'),
(86, 36, '2', '3', 100, 'sdfffsf', '2017-06-24 12:55:52', '2017-06-24 12:55:52'),
(87, 34, '1', '3', 200, 'sdfffsf', '2017-06-24 12:56:27', '2017-06-24 12:56:27'),
(88, 36, '2', '3', 100, 'sdfffsf', '2017-06-24 12:56:27', '2017-06-24 12:56:27'),
(89, 34, '1', '3', 200, 'sdfffsf', '2017-06-24 12:56:53', '2017-06-24 12:56:53'),
(90, 36, '2', '3', 100, 'sdfffsf', '2017-06-24 12:56:53', '2017-06-24 12:56:53'),
(91, 34, '1', '3', 200, 'sdfffsf', '2017-06-24 12:58:55', '2017-06-24 12:58:55'),
(92, 36, '2', '3', 100, 'sdfffsf', '2017-06-24 12:58:55', '2017-06-24 12:58:55'),
(93, 34, '1', '3', 200, 'sdfffsf', '2017-06-24 12:59:22', '2017-06-24 12:59:22'),
(94, 36, '2', '3', 100, 'sdfffsf', '2017-06-24 12:59:22', '2017-06-24 12:59:22'),
(95, 34, '1', '3', 200, 'sdfffsf', '2017-06-24 13:00:50', '2017-06-24 13:00:50'),
(96, 36, '2', '3', 100, 'sdfffsf', '2017-06-24 13:00:50', '2017-06-24 13:00:50'),
(97, 34, '1', '3', 200, 'sdfffsf', '2017-06-24 13:05:15', '2017-06-24 13:05:15'),
(98, 36, '2', '3', 100, 'sdfffsf', '2017-06-24 13:05:15', '2017-06-24 13:05:15'),
(99, 34, '1', '3', 200, 'sdfffsf', '2017-06-24 13:15:18', '2017-06-24 13:15:18'),
(100, 36, '2', '3', 100, 'sdfffsf', '2017-06-24 13:15:18', '2017-06-24 13:15:18'),
(101, 34, '1', '3', 200, 'sdfffsf', '2017-06-24 13:19:33', '2017-06-24 13:19:33'),
(102, 38, '2', '3', 100, 'sdfffsf', '2017-06-24 13:19:33', '2017-06-24 13:19:33'),
(103, 34, '1', '3', 200, 'sdfffsf', '2017-06-24 13:20:43', '2017-06-24 13:20:43'),
(104, 39, '2', '3', 100, 'sdfffsf', '2017-06-24 13:20:43', '2017-06-24 13:20:43');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `account_number` (`account_number`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accounts`
--
ALTER TABLE `accounts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;
--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=105;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;