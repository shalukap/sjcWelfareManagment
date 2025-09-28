-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 28, 2025 at 07:21 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sjcwelfare`
--

-- --------------------------------------------------------

--
-- Table structure for table `backup_logs`
--

CREATE TABLE `backup_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `backup_date` datetime NOT NULL,
  `filename` varchar(255) NOT NULL,
  `performed_by_user_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cache`
--

INSERT INTO `cache` (`key`, `value`, `expiration`) VALUES
('sjc_welfare_cache_admin@gmail.com|127.0.0.1', 'i:1;', 1758034685),
('sjc_welfare_cache_admin@gmail.com|127.0.0.1:timer', 'i:1758034685;', 1758034685);

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fee_assignments`
--

CREATE TABLE `fee_assignments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `student_id` bigint(20) UNSIGNED NOT NULL,
  `academic_year` varchar(255) NOT NULL,
  `assigned_fee` decimal(10,2) NOT NULL,
  `adjusted_fee` decimal(10,2) NOT NULL,
  `adjustment_reason` text DEFAULT NULL,
  `status` enum('Unpaid','Partially Paid','Paid') NOT NULL DEFAULT 'Unpaid',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `fee_assignments`
--

INSERT INTO `fee_assignments` (`id`, `student_id`, `academic_year`, `assigned_fee`, `adjusted_fee`, `adjustment_reason`, `status`, `created_at`, `updated_at`) VALUES
(8, 5, '2025', 3000.00, 2000.00, NULL, 'Paid', '2025-09-18 02:26:47', '2025-09-23 04:55:53'),
(9, 8, '2025', 3000.00, 1500.00, 'Fr Rector decide', 'Paid', '2025-09-18 02:26:47', '2025-09-21 08:50:04'),
(10, 9, '2025', 4000.00, 4000.00, NULL, 'Paid', '2025-09-21 08:25:34', '2025-09-21 08:26:28'),
(11, 7, '2025', 4000.00, 4000.00, NULL, 'Paid', '2025-09-21 08:46:19', '2025-09-23 03:59:36'),
(12, 10, '2025', 4000.00, 2000.00, 'Brother in school', 'Unpaid', '2025-09-21 08:46:19', '2025-09-21 08:47:27'),
(13, 11, '2024', 3000.00, 3000.00, NULL, 'Paid', '2025-09-21 09:04:06', '2025-09-21 09:17:17'),
(14, 11, '2023', 2500.00, 2500.00, NULL, 'Paid', '2025-09-21 09:04:23', '2025-09-21 09:17:17'),
(15, 11, '2025', 3500.00, 3500.00, NULL, 'Partially Paid', '2025-09-21 09:04:38', '2025-09-21 09:17:17'),
(16, 11, '2026', 4000.00, 4000.00, NULL, 'Unpaid', '2025-09-21 09:05:04', '2025-09-21 09:05:04'),
(17, 6, '2025', 3000.00, 3000.00, NULL, 'Unpaid', '2025-09-23 03:46:34', '2025-09-23 03:46:34'),
(18, 13, '2025', 3000.00, 3000.00, NULL, 'Paid', '2025-09-23 03:46:34', '2025-09-23 03:49:24'),
(19, 14, '2025', 3000.00, 3000.00, NULL, 'Partially Paid', '2025-09-23 04:30:39', '2025-09-23 05:08:45'),
(20, 15, '2025', 3000.00, 3000.00, NULL, 'Paid', '2025-09-23 04:30:39', '2025-09-23 04:37:02'),
(21, 12, '2025', 2000.00, 2000.00, NULL, 'Unpaid', '2025-09-23 04:58:03', '2025-09-23 04:58:03'),
(22, 16, '2025', 2000.00, 2000.00, NULL, 'Paid', '2025-09-23 04:58:03', '2025-09-23 04:58:54'),
(23, 17, '2025', 3000.00, 3000.00, NULL, 'Paid', '2025-09-23 05:03:34', '2025-09-23 05:03:52'),
(24, 18, '2025', 3000.00, 3000.00, NULL, 'Paid', '2025-09-23 09:34:13', '2025-09-23 10:07:12'),
(25, 19, '2025', 3000.00, 3000.00, NULL, 'Paid', '2025-09-23 10:08:29', '2025-09-23 10:18:49'),
(26, 20, '2025', 3000.00, 3000.00, NULL, 'Paid', '2025-09-23 10:24:42', '2025-09-23 10:56:34'),
(27, 21, '2025', 3000.00, 3000.00, NULL, 'Paid', '2025-09-23 10:58:15', '2025-09-23 11:41:58'),
(28, 22, '2025', 3000.00, 3000.00, NULL, 'Partially Paid', '2025-09-23 11:43:19', '2025-09-23 11:44:00'),
(29, 23, '2025', 3000.00, 3000.00, NULL, 'Partially Paid', '2025-09-24 11:49:12', '2025-09-24 12:03:34'),
(30, 24, '2025', 3000.00, 3000.00, NULL, 'Paid', '2025-09-25 11:15:30', '2025-09-25 11:20:14'),
(31, 14, '2024', 3000.00, 3000.00, NULL, 'Unpaid', '2025-09-25 11:18:00', '2025-09-25 11:18:00'),
(32, 15, '2024', 3000.00, 3000.00, NULL, 'Unpaid', '2025-09-25 11:18:00', '2025-09-25 11:18:00'),
(33, 17, '2024', 3000.00, 3000.00, NULL, 'Unpaid', '2025-09-25 11:18:00', '2025-09-25 11:18:00'),
(34, 18, '2024', 3000.00, 3000.00, NULL, 'Unpaid', '2025-09-25 11:18:00', '2025-09-25 11:18:00'),
(35, 19, '2024', 3000.00, 3000.00, NULL, 'Unpaid', '2025-09-25 11:18:00', '2025-09-25 11:18:00'),
(36, 20, '2024', 3000.00, 3000.00, NULL, 'Unpaid', '2025-09-25 11:18:00', '2025-09-25 11:18:00'),
(37, 24, '2024', 3000.00, 3000.00, NULL, 'Paid', '2025-09-25 11:19:09', '2025-09-26 11:58:12');

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2025_09_12_143429_create_student_table', 1),
(5, '2025_09_13_031731_create_fee_assignments_table', 1),
(6, '2025_09_13_031817_create_payments_table', 1),
(7, '2025_09_13_031926_create_backup_logs_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `fee_assignment_id` bigint(20) UNSIGNED NOT NULL,
  `receipt_number` varchar(255) NOT NULL,
  `payment_date` date NOT NULL,
  `amount_paid` decimal(10,2) NOT NULL,
  `payment_method` enum('Cash','Online','Cheque') NOT NULL,
  `reference_number` varchar(255) DEFAULT NULL,
  `deposit_date` date DEFAULT NULL,
  `bank_name` varchar(255) DEFAULT NULL,
  `is_realized` tinyint(1) NOT NULL DEFAULT 0,
  `cancelled` tinyint(1) NOT NULL DEFAULT 0,
  `cancellation_date` datetime DEFAULT NULL,
  `cancelled_by_user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`id`, `fee_assignment_id`, `receipt_number`, `payment_date`, `amount_paid`, `payment_method`, `reference_number`, `deposit_date`, `bank_name`, `is_realized`, `cancelled`, `cancellation_date`, `cancelled_by_user_id`, `created_at`, `updated_at`) VALUES
(1, 10, '20250921-0001', '2025-09-21', 4000.00, 'Cash', NULL, NULL, NULL, 1, 0, NULL, NULL, '2025-09-21 08:26:28', '2025-09-21 08:26:28'),
(2, 9, '20250921-0002', '2025-09-21', 1500.00, 'Cash', NULL, NULL, NULL, 1, 0, NULL, NULL, '2025-09-21 08:50:04', '2025-09-21 08:50:04'),
(3, 13, '20250921-0003-1', '2025-09-21', 3000.00, 'Cash', NULL, NULL, NULL, 1, 0, NULL, NULL, '2025-09-21 09:17:17', '2025-09-21 09:17:17'),
(4, 14, '20250921-0003-2', '2025-09-21', 2500.00, 'Cash', NULL, NULL, NULL, 1, 0, NULL, NULL, '2025-09-21 09:17:17', '2025-09-21 09:17:17'),
(5, 15, '20250921-0003-3', '2025-09-21', 1500.00, 'Cash', NULL, NULL, NULL, 1, 0, NULL, NULL, '2025-09-21 09:17:17', '2025-09-21 09:17:17'),
(6, 18, '20250923-0001', '2025-09-23', 2000.00, 'Cash', NULL, NULL, NULL, 1, 0, NULL, NULL, '2025-09-23 03:46:57', '2025-09-23 03:46:57'),
(7, 18, '20250923-0002', '2025-09-23', 500.00, 'Cash', NULL, NULL, NULL, 1, 0, NULL, NULL, '2025-09-23 03:47:51', '2025-09-23 03:47:51'),
(8, 18, '20250923-0003', '2025-09-23', 500.00, 'Cash', NULL, NULL, NULL, 1, 0, NULL, NULL, '2025-09-23 03:49:24', '2025-09-23 03:49:24'),
(9, 11, '20250923-0004', '2025-09-23', 2000.00, 'Cash', NULL, NULL, NULL, 1, 0, NULL, NULL, '2025-09-23 03:50:30', '2025-09-23 03:50:30'),
(10, 11, '20250923-0005', '2025-09-23', 1000.00, 'Cash', NULL, NULL, NULL, 1, 0, NULL, NULL, '2025-09-23 03:51:20', '2025-09-23 03:51:20'),
(11, 11, '20250923-0006', '2025-09-23', 500.00, 'Cash', NULL, NULL, NULL, 1, 0, NULL, NULL, '2025-09-23 03:52:31', '2025-09-23 03:52:31'),
(12, 11, '20250923-0007', '2025-09-23', 500.00, 'Cash', NULL, NULL, NULL, 1, 0, NULL, NULL, '2025-09-23 03:59:36', '2025-09-23 03:59:36'),
(13, 20, '20250923-0008', '2025-09-23', 2000.00, 'Cash', NULL, NULL, NULL, 1, 0, NULL, NULL, '2025-09-23 04:30:59', '2025-09-23 04:30:59'),
(14, 20, '20250923-0009', '2025-09-23', 500.00, 'Cash', NULL, NULL, NULL, 1, 0, NULL, NULL, '2025-09-23 04:35:25', '2025-09-23 04:35:25'),
(15, 20, '20250923-0010', '2025-09-23', 200.00, 'Cash', NULL, NULL, NULL, 1, 0, NULL, NULL, '2025-09-23 04:36:04', '2025-09-23 04:36:04'),
(16, 20, '20250923-0011', '2025-09-23', 300.00, 'Cash', NULL, NULL, NULL, 1, 0, NULL, NULL, '2025-09-23 04:37:02', '2025-09-23 04:37:02'),
(17, 8, '20250923-0012', '2025-09-23', 1000.00, 'Cash', NULL, NULL, NULL, 1, 0, NULL, NULL, '2025-09-23 04:55:32', '2025-09-23 04:55:32'),
(18, 8, '20250923-0013', '2025-09-23', 1000.00, 'Cash', NULL, NULL, NULL, 1, 0, NULL, NULL, '2025-09-23 04:55:53', '2025-09-23 04:55:53'),
(19, 22, '20250923-0014', '2025-09-23', 2000.00, 'Cash', NULL, NULL, NULL, 1, 0, NULL, NULL, '2025-09-23 04:58:54', '2025-09-23 04:58:54'),
(20, 23, '20250923-0015', '2025-09-23', 3000.00, 'Cash', NULL, NULL, NULL, 1, 0, NULL, NULL, '2025-09-23 05:03:52', '2025-09-23 05:03:52'),
(21, 19, '20250923-0016', '2025-09-23', 999.97, 'Cash', NULL, NULL, NULL, 1, 0, NULL, NULL, '2025-09-23 05:08:45', '2025-09-23 05:08:45'),
(22, 24, '20250923-0017', '2025-09-23', 1000.00, 'Cash', NULL, NULL, NULL, 1, 0, NULL, NULL, '2025-09-23 09:34:38', '2025-09-23 09:34:38'),
(23, 24, '20250923-0018', '2025-09-23', 1000.00, 'Cash', NULL, NULL, NULL, 1, 0, NULL, NULL, '2025-09-23 09:37:14', '2025-09-23 09:37:14'),
(24, 24, '20250923-0019', '2025-09-23', 500.00, 'Cash', NULL, NULL, NULL, 1, 0, NULL, NULL, '2025-09-23 09:37:40', '2025-09-23 09:37:40'),
(25, 24, '20250923-0020', '2025-09-23', 200.00, 'Cash', NULL, NULL, NULL, 1, 0, NULL, NULL, '2025-09-23 09:55:19', '2025-09-23 09:55:19'),
(26, 24, '20250923-0021', '2025-09-23', 100.00, 'Cash', NULL, NULL, NULL, 1, 0, NULL, NULL, '2025-09-23 10:03:22', '2025-09-23 10:03:22'),
(27, 24, '20250923-0022', '2025-09-23', 100.00, 'Cash', NULL, NULL, NULL, 1, 0, NULL, NULL, '2025-09-23 10:04:10', '2025-09-23 10:04:10'),
(28, 24, '20250923-0023', '2025-09-23', 100.00, 'Cash', NULL, NULL, NULL, 1, 0, NULL, NULL, '2025-09-23 10:07:12', '2025-09-23 10:07:12'),
(29, 25, '20250923-0024', '2025-09-23', 500.00, 'Cash', NULL, NULL, NULL, 1, 0, NULL, NULL, '2025-09-23 10:08:55', '2025-09-23 10:08:55'),
(30, 25, '20250923-0025', '2025-09-23', 500.00, 'Cash', NULL, NULL, NULL, 1, 0, NULL, NULL, '2025-09-23 10:11:03', '2025-09-23 10:11:03'),
(31, 25, '20250923-0026', '2025-09-23', 500.00, 'Cash', NULL, NULL, NULL, 1, 0, NULL, NULL, '2025-09-23 10:12:21', '2025-09-23 10:12:21'),
(32, 25, '20250923-0027', '2025-09-23', 500.00, 'Cash', NULL, NULL, NULL, 1, 0, NULL, NULL, '2025-09-23 10:15:31', '2025-09-23 10:15:31'),
(33, 25, '20250923-0028', '2025-09-23', 500.00, 'Cash', NULL, NULL, NULL, 1, 0, NULL, NULL, '2025-09-23 10:16:46', '2025-09-23 10:16:46'),
(34, 25, '20250923-0029', '2025-09-23', 500.00, 'Cash', NULL, NULL, NULL, 1, 0, NULL, NULL, '2025-09-23 10:18:49', '2025-09-23 10:18:49'),
(35, 26, '20250923-0030', '2025-09-23', 1000.00, 'Cash', NULL, NULL, NULL, 1, 0, NULL, NULL, '2025-09-23 10:25:07', '2025-09-23 10:25:07'),
(36, 26, '20250923-0031', '2025-09-23', 500.00, 'Cash', NULL, NULL, NULL, 1, 0, NULL, NULL, '2025-09-23 10:31:02', '2025-09-23 10:31:02'),
(37, 26, '20250923-0032', '2025-09-23', 500.00, 'Cash', NULL, NULL, NULL, 1, 0, NULL, NULL, '2025-09-23 10:40:50', '2025-09-23 10:40:50'),
(38, 26, '20250923-0033', '2025-09-23', 500.00, 'Cash', NULL, NULL, NULL, 1, 0, NULL, NULL, '2025-09-23 10:42:05', '2025-09-23 10:42:05'),
(39, 26, '20250923-0034', '2025-09-23', 200.00, 'Cash', NULL, NULL, NULL, 1, 0, NULL, NULL, '2025-09-23 10:43:06', '2025-09-23 10:43:06'),
(40, 26, '20250923-0035', '2025-09-23', 100.00, 'Cash', NULL, NULL, NULL, 1, 0, NULL, NULL, '2025-09-23 10:48:31', '2025-09-23 10:48:31'),
(41, 26, '20250923-0036', '2025-09-23', 100.00, 'Cash', NULL, NULL, NULL, 1, 0, NULL, NULL, '2025-09-23 10:50:07', '2025-09-23 10:50:07'),
(42, 26, '20250923-0037', '2025-09-23', 100.00, 'Cash', NULL, NULL, NULL, 1, 0, NULL, NULL, '2025-09-23 10:56:34', '2025-09-23 10:56:34'),
(43, 27, '20250923-0038', '2025-09-23', 500.00, 'Cash', NULL, NULL, NULL, 1, 0, NULL, NULL, '2025-09-23 10:58:38', '2025-09-23 10:58:38'),
(44, 27, '20250923-0039', '2025-09-23', 500.00, 'Cash', NULL, NULL, NULL, 1, 0, NULL, NULL, '2025-09-23 10:59:29', '2025-09-23 10:59:29'),
(45, 27, '20250923-0040', '2025-09-23', 500.00, 'Cash', NULL, NULL, NULL, 1, 0, NULL, NULL, '2025-09-23 11:04:42', '2025-09-23 11:04:42'),
(46, 27, '20250923-0041', '2025-09-23', 500.00, 'Cash', NULL, NULL, NULL, 1, 0, NULL, NULL, '2025-09-23 11:18:49', '2025-09-23 11:18:49'),
(47, 27, '20250923-0042', '2025-09-23', 500.00, 'Cash', NULL, NULL, NULL, 1, 0, NULL, NULL, '2025-09-23 11:20:27', '2025-09-23 11:20:27'),
(48, 27, '20250923-0043', '2025-09-23', 200.00, 'Cash', NULL, NULL, NULL, 1, 0, NULL, NULL, '2025-09-23 11:22:34', '2025-09-23 11:22:34'),
(49, 27, '20250923-0044', '2025-09-23', 100.00, 'Cash', NULL, NULL, NULL, 1, 0, NULL, NULL, '2025-09-23 11:24:52', '2025-09-23 11:24:52'),
(50, 27, '20250923-0045', '2025-09-23', 100.00, 'Cash', NULL, NULL, NULL, 1, 0, NULL, NULL, '2025-09-23 11:25:55', '2025-09-23 11:25:55'),
(51, 27, '20250923-0046', '2025-09-23', 50.00, 'Cash', NULL, NULL, NULL, 1, 0, NULL, NULL, '2025-09-23 11:31:56', '2025-09-23 11:31:56'),
(52, 27, '20250923-0047', '2025-09-23', 50.00, 'Cash', NULL, NULL, NULL, 1, 0, NULL, NULL, '2025-09-23 11:41:58', '2025-09-23 11:41:58'),
(53, 28, '20250923-0048', '2025-09-23', 500.00, 'Cash', NULL, NULL, NULL, 1, 0, NULL, NULL, '2025-09-23 11:44:00', '2025-09-23 11:44:00'),
(54, 28, '20250923-0049', '2025-09-23', 100.00, 'Cash', NULL, NULL, NULL, 1, 0, NULL, NULL, '2025-09-23 11:45:50', '2025-09-23 11:45:50'),
(55, 28, '20250923-0050', '2025-09-23', 100.00, 'Cash', NULL, NULL, NULL, 1, 0, NULL, NULL, '2025-09-23 11:50:15', '2025-09-23 11:50:15'),
(56, 28, '20250923-0051', '2025-09-23', 100.00, 'Cash', NULL, NULL, NULL, 1, 0, NULL, NULL, '2025-09-23 11:53:25', '2025-09-23 11:53:25'),
(57, 29, '20250924-0001', '2025-09-24', 500.00, 'Cash', NULL, NULL, NULL, 1, 0, NULL, NULL, '2025-09-24 12:03:34', '2025-09-24 12:03:34'),
(58, 29, '20250925-0001', '2025-09-25', 499.98, 'Cash', NULL, NULL, NULL, 1, 0, NULL, NULL, '2025-09-24 22:17:05', '2025-09-24 22:17:05'),
(59, 29, '20250925-0002', '2025-09-25', 500.00, 'Cash', NULL, NULL, NULL, 1, 0, NULL, NULL, '2025-09-24 23:19:36', '2025-09-24 23:19:36'),
(60, 29, '20250925-0003', '2025-09-25', 100.00, 'Cash', NULL, NULL, NULL, 1, 0, NULL, NULL, '2025-09-24 23:21:52', '2025-09-24 23:21:52'),
(61, 29, '20250925-0004', '2025-09-25', 100.00, 'Cash', NULL, NULL, NULL, 1, 0, NULL, NULL, '2025-09-24 23:26:37', '2025-09-24 23:26:37'),
(62, 30, '20250925-0005-1', '2025-09-25', 3000.00, 'Cash', NULL, NULL, NULL, 1, 0, NULL, NULL, '2025-09-25 11:20:14', '2025-09-25 11:20:14'),
(63, 37, '20250925-0005-2', '2025-09-25', 2000.00, 'Cash', NULL, NULL, NULL, 1, 0, NULL, NULL, '2025-09-25 11:20:14', '2025-09-25 11:20:14'),
(64, 37, 'F0000001', '2025-09-26', 500.00, 'Cash', NULL, NULL, NULL, 1, 0, NULL, NULL, '2025-09-25 19:56:02', '2025-09-25 19:56:02'),
(65, 37, 'F0000002', '2025-09-26', 500.00, 'Cash', NULL, NULL, NULL, 1, 0, NULL, NULL, '2025-09-26 11:58:12', '2025-09-26 11:58:12');

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('LUhTXqEEHxd7XhcZJ2YxKqOc0dRMHXdgom6u4swo', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiTE5BMlFWYlVzd3FQODB5YnpkNEcwNzV6bU5OZWtCdlFTTjB4aUF2OSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzc6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9nZW5lcmF0ZS1yZWNpcHQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToxO30=', 1758907701);

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `admission_number` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `whatsapp_number` varchar(255) DEFAULT NULL,
  `current_grade` varchar(255) NOT NULL,
  `current_class` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`id`, `admission_number`, `name`, `whatsapp_number`, `current_grade`, `current_class`, `is_active`, `created_at`, `updated_at`) VALUES
(4, '12222', 'ecde', '1111111111', '7', 'ece', 1, '2025-09-15 10:52:36', '2025-09-15 10:52:36'),
(5, '11111111', 'dddddddddddd', '1111111111', '10', '2', 1, '2025-09-17 05:34:27', '2025-09-17 05:34:35'),
(6, '455', 'gg', '4444444444', '1', 'g', 1, '2025-09-17 05:40:31', '2025-09-17 05:40:31'),
(7, '333', 'fvv', '4444444444', '4', 'r', 1, '2025-09-17 05:45:55', '2025-09-17 05:46:09'),
(8, '1254', 'Shaluka', '0773857751', '10', 's1', 1, '2025-09-18 02:25:27', '2025-09-18 02:25:27'),
(9, '1256', 'Malintha', '0777258369', '5', '5s2', 1, '2025-09-21 08:25:09', '2025-09-21 08:25:09'),
(10, '2589', 'Shiran', '0715689232', '4', '4s3', 1, '2025-09-21 08:45:34', '2025-09-21 08:45:34'),
(11, '12345', 's m pathirana', '0718544544', '9', '9s5', 1, '2025-09-21 09:03:35', '2025-09-21 09:03:35'),
(12, '235731', 'shiran malintha pathirana', '0773855733', '10', '10s5', 1, '2025-09-21 09:23:44', '2025-09-21 09:23:44'),
(13, '123669', 'test', '0771234567', '1', '1s1', 1, '2025-09-23 03:45:24', '2025-09-23 03:45:24'),
(14, '147258', 'sss', '0178259665', '2', '2s4', 1, '2025-09-23 04:20:47', '2025-09-23 04:20:47'),
(15, '123457', 'testtt', '0258369875', '2', '2s3', 1, '2025-09-23 04:30:10', '2025-09-23 04:30:10'),
(16, '125478', 'tesdtt', '0174567896', '10', '10s3', 1, '2025-09-23 04:54:21', '2025-09-23 04:54:21'),
(17, '258369', 'ddd', '1472583696', '2', '2s3', 1, '2025-09-23 05:02:56', '2025-09-23 05:02:56'),
(18, '147963', 'rock', '0172583698', '2', '2s2', 1, '2025-09-23 09:33:47', '2025-09-23 09:33:47'),
(19, '145632', 'dert', '0258978963', '2', '2s4', 1, '2025-09-23 10:08:05', '2025-09-23 10:08:05'),
(20, '7789445', 'ddd', '1487852369', '2', '2s2', 1, '2025-09-23 10:24:33', '2025-09-23 10:24:33'),
(21, '4587996', 'ggg', '0178956442', '4', '4s3', 1, '2025-09-23 10:58:03', '2025-09-23 10:58:03'),
(22, '125698', 'fff', '0712589630', '4', '4s2', 1, '2025-09-23 11:42:57', '2025-09-23 11:42:57'),
(23, '12556', 'dddd', '1755866696', '5', '5s3', 1, '2025-09-24 11:47:56', '2025-09-24 11:47:56'),
(24, '147589', 'old student', '0715689231', '3', '3s3', 1, '2025-09-25 11:14:28', '2025-09-25 11:17:14');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','accountant','viewer') NOT NULL DEFAULT 'accountant',
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `role`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'shaluka', 'shaluka@gmail.com', NULL, '$2y$12$hD3e.5Xg1KdaNpSyP3fWje9pJUHq1GNutxcHkC.qdksm577aQNiGi', 'accountant', NULL, '2025-09-14 01:03:53', '2025-09-14 01:03:53');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `backup_logs`
--
ALTER TABLE `backup_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `backup_logs_performed_by_user_id_foreign` (`performed_by_user_id`);

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `fee_assignments`
--
ALTER TABLE `fee_assignments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fee_assignments_student_id_foreign` (`student_id`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `payments_receipt_number_unique` (`receipt_number`),
  ADD KEY `payments_fee_assignment_id_foreign` (`fee_assignment_id`),
  ADD KEY `payments_cancelled_by_user_id_foreign` (`cancelled_by_user_id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `students_admission_number_unique` (`admission_number`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `backup_logs`
--
ALTER TABLE `backup_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fee_assignments`
--
ALTER TABLE `fee_assignments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=66;

--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `backup_logs`
--
ALTER TABLE `backup_logs`
  ADD CONSTRAINT `backup_logs_performed_by_user_id_foreign` FOREIGN KEY (`performed_by_user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `fee_assignments`
--
ALTER TABLE `fee_assignments`
  ADD CONSTRAINT `fee_assignments_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_cancelled_by_user_id_foreign` FOREIGN KEY (`cancelled_by_user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `payments_fee_assignment_id_foreign` FOREIGN KEY (`fee_assignment_id`) REFERENCES `fee_assignments` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
