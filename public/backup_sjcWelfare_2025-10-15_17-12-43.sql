-- MariaDB dump 10.19  Distrib 10.4.32-MariaDB, for Win64 (AMD64)
--
-- Host: 127.0.0.1    Database: sjcWelfare
-- ------------------------------------------------------
-- Server version	10.4.32-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `backup_logs`
--

DROP TABLE IF EXISTS `backup_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `backup_logs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `backup_date` datetime NOT NULL,
  `filename` varchar(255) NOT NULL,
  `performed_by_user_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `backup_logs_performed_by_user_id_foreign` (`performed_by_user_id`),
  CONSTRAINT `backup_logs_performed_by_user_id_foreign` FOREIGN KEY (`performed_by_user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `backup_logs`
--

LOCK TABLES `backup_logs` WRITE;
/*!40000 ALTER TABLE `backup_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `backup_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache`
--

DROP TABLE IF EXISTS `cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache`
--

LOCK TABLES `cache` WRITE;
/*!40000 ALTER TABLE `cache` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache_locks`
--

DROP TABLE IF EXISTS `cache_locks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_locks`
--

LOCK TABLES `cache_locks` WRITE;
/*!40000 ALTER TABLE `cache_locks` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache_locks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_jobs`
--

LOCK TABLES `failed_jobs` WRITE;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fee_assignments`
--

DROP TABLE IF EXISTS `fee_assignments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fee_assignments` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `student_id` bigint(20) unsigned NOT NULL,
  `academic_year` varchar(255) NOT NULL,
  `assigned_fee` decimal(10,2) NOT NULL,
  `adjusted_fee` decimal(10,2) NOT NULL,
  `adjustment_reason` text DEFAULT NULL,
  `status` enum('Unpaid','Partially Paid','Paid') NOT NULL DEFAULT 'Unpaid',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fee_assignments_student_id_foreign` (`student_id`),
  CONSTRAINT `fee_assignments_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fee_assignments`
--

LOCK TABLES `fee_assignments` WRITE;
/*!40000 ALTER TABLE `fee_assignments` DISABLE KEYS */;
INSERT INTO `fee_assignments` VALUES (8,5,'2025',3000.00,2000.00,NULL,'Paid','2025-09-18 02:26:47','2025-09-23 04:55:53'),(9,8,'2025',3000.00,1500.00,'Fr Rector decide','Paid','2025-09-18 02:26:47','2025-09-21 08:50:04'),(10,9,'2025',4000.00,4000.00,NULL,'Paid','2025-09-21 08:25:34','2025-09-21 08:26:28'),(11,7,'2025',4000.00,4000.00,NULL,'Paid','2025-09-21 08:46:19','2025-09-23 03:59:36'),(12,10,'2025',4000.00,2000.00,'Brother in school','Unpaid','2025-09-21 08:46:19','2025-09-21 08:47:27'),(13,11,'2024',3000.00,3000.00,NULL,'Paid','2025-09-21 09:04:06','2025-09-21 09:17:17'),(14,11,'2023',2500.00,2500.00,NULL,'Paid','2025-09-21 09:04:23','2025-09-21 09:17:17'),(15,11,'2025',3500.00,3500.00,NULL,'Paid','2025-09-21 09:04:38','2025-10-02 00:48:17'),(16,11,'2026',4000.00,4000.00,NULL,'Partially Paid','2025-09-21 09:05:04','2025-10-02 00:48:17'),(17,6,'2025',3000.00,3000.00,NULL,'Unpaid','2025-09-23 03:46:34','2025-09-23 03:46:34'),(18,13,'2025',3000.00,3000.00,NULL,'Paid','2025-09-23 03:46:34','2025-09-23 03:49:24'),(19,14,'2025',3000.00,3000.00,NULL,'Partially Paid','2025-09-23 04:30:39','2025-09-23 05:08:45'),(20,15,'2025',3000.00,3000.00,NULL,'Paid','2025-09-23 04:30:39','2025-09-23 04:37:02'),(21,12,'2025',2000.00,2000.00,NULL,'Paid','2025-09-23 04:58:03','2025-10-06 05:33:29'),(22,16,'2025',2000.00,2000.00,NULL,'Paid','2025-09-23 04:58:03','2025-09-23 04:58:54'),(23,17,'2025',3000.00,3000.00,NULL,'Paid','2025-09-23 05:03:34','2025-09-23 05:03:52'),(24,18,'2025',3000.00,3000.00,NULL,'Paid','2025-09-23 09:34:13','2025-09-23 10:07:12'),(25,19,'2025',3000.00,3000.00,NULL,'Paid','2025-09-23 10:08:29','2025-09-23 10:18:49'),(26,20,'2025',3000.00,3000.00,NULL,'Paid','2025-09-23 10:24:42','2025-09-23 10:56:34'),(27,21,'2025',3000.00,3000.00,NULL,'Paid','2025-09-23 10:58:15','2025-09-23 11:41:58'),(28,22,'2025',3000.00,3000.00,NULL,'Paid','2025-09-23 11:43:19','2025-10-06 05:44:30'),(29,23,'2025',3000.00,3000.00,NULL,'Partially Paid','2025-09-24 11:49:12','2025-09-24 12:03:34'),(30,24,'2025',3000.00,3000.00,NULL,'Paid','2025-09-25 11:15:30','2025-09-25 11:20:14'),(31,14,'2024',3000.00,3000.00,NULL,'Unpaid','2025-09-25 11:18:00','2025-09-25 11:18:00'),(32,15,'2024',3000.00,3000.00,NULL,'Unpaid','2025-09-25 11:18:00','2025-09-25 11:18:00'),(33,17,'2024',3000.00,3000.00,NULL,'Unpaid','2025-09-25 11:18:00','2025-09-25 11:18:00'),(34,18,'2024',3000.00,3000.00,NULL,'Unpaid','2025-09-25 11:18:00','2025-09-25 11:18:00'),(35,19,'2024',3000.00,3000.00,NULL,'Unpaid','2025-09-25 11:18:00','2025-09-25 11:18:00'),(36,20,'2024',3000.00,3000.00,NULL,'Unpaid','2025-09-25 11:18:00','2025-09-25 11:18:00'),(37,24,'2024',3000.00,3000.00,NULL,'Paid','2025-09-25 11:19:09','2025-09-26 11:58:12'),(38,25,'2025',3000.00,3000.00,NULL,'Paid','2025-10-06 05:00:40','2025-10-06 05:03:54'),(39,9,'2026',3000.00,3000.00,NULL,'Unpaid','2025-10-06 05:01:28','2025-10-06 05:01:28'),(40,23,'2026',3000.00,3000.00,NULL,'Unpaid','2025-10-06 05:01:28','2025-10-06 05:01:28'),(41,7,'2024',3000.00,3000.00,NULL,'Unpaid','2025-10-06 05:02:50','2025-10-06 05:02:50'),(42,10,'2024',3000.00,3000.00,NULL,'Unpaid','2025-10-06 05:02:50','2025-10-06 05:02:50'),(43,21,'2024',3000.00,3000.00,NULL,'Paid','2025-10-06 05:02:50','2025-10-06 05:42:26'),(44,22,'2024',3000.00,3000.00,NULL,'Partially Paid','2025-10-06 05:02:50','2025-10-06 05:44:30'),(45,25,'2024',3000.00,3000.00,NULL,'Paid','2025-10-06 05:02:50','2025-10-06 05:28:46'),(46,7,'2026',3000.00,3000.00,NULL,'Unpaid','2025-10-06 05:28:20','2025-10-06 05:28:20'),(47,10,'2026',3000.00,3000.00,NULL,'Unpaid','2025-10-06 05:28:20','2025-10-06 05:28:20'),(48,21,'2026',3000.00,3000.00,NULL,'Partially Paid','2025-10-06 05:28:20','2025-10-06 05:42:26'),(49,22,'2026',3000.00,3000.00,NULL,'Unpaid','2025-10-06 05:28:20','2025-10-06 05:28:20'),(50,25,'2026',3000.00,3000.00,NULL,'Partially Paid','2025-10-06 05:28:20','2025-10-06 05:28:46'),(51,5,'2026',2000.00,2000.00,NULL,'Unpaid','2025-10-06 05:33:08','2025-10-06 05:33:08'),(52,8,'2026',2000.00,2000.00,NULL,'Unpaid','2025-10-06 05:33:08','2025-10-06 05:33:08'),(53,12,'2026',2000.00,2000.00,NULL,'Partially Paid','2025-10-06 05:33:08','2025-10-06 05:33:29'),(54,16,'2026',2000.00,2000.00,NULL,'Unpaid','2025-10-06 05:33:08','2025-10-06 05:33:08'),(55,4,'2025',3000.00,3000.00,NULL,'Unpaid','2025-10-06 06:03:18','2025-10-06 06:03:18'),(56,26,'2025',3000.00,3000.00,NULL,'Paid','2025-10-06 06:03:18','2025-10-06 06:03:58'),(57,4,'2026',3000.00,3000.00,NULL,'Unpaid','2025-10-06 06:03:28','2025-10-06 06:03:28'),(58,26,'2026',3000.00,3000.00,NULL,'Partially Paid','2025-10-06 06:03:28','2025-10-06 06:03:58');
/*!40000 ALTER TABLE `fee_assignments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job_batches`
--

DROP TABLE IF EXISTS `job_batches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
  `finished_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job_batches`
--

LOCK TABLES `job_batches` WRITE;
/*!40000 ALTER TABLE `job_batches` DISABLE KEYS */;
/*!40000 ALTER TABLE `job_batches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) unsigned NOT NULL,
  `reserved_at` int(10) unsigned DEFAULT NULL,
  `available_at` int(10) unsigned NOT NULL,
  `created_at` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobs`
--

LOCK TABLES `jobs` WRITE;
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'0001_01_01_000000_create_users_table',1),(2,'0001_01_01_000001_create_cache_table',1),(3,'0001_01_01_000002_create_jobs_table',1),(4,'2025_09_12_143429_create_student_table',1),(5,'2025_09_13_031731_create_fee_assignments_table',1),(6,'2025_09_13_031817_create_payments_table',1),(7,'2025_09_13_031926_create_backup_logs_table',1),(8,'2025_09_20_014412_add_cancellation_reason_to_payments_table',2),(9,'2025_09_24_164039_add_sibling_admission_no_to_students_table',3),(10,'2025_10_03_000000_remove_unique_from_payments_receipt_number',4),(11,'2025_10_02_000000_drop_deposit_date_from_payments_table',5),(12,'2025_10_02_000002_add_direct_deposit_and_deposit_date_to_payments_table',5),(13,'2025_10_14_144804_create_permission_tables',6);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `model_has_permissions`
--

DROP TABLE IF EXISTS `model_has_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `model_has_permissions` (
  `permission_id` bigint(20) unsigned NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`),
  CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `model_has_permissions`
--

LOCK TABLES `model_has_permissions` WRITE;
/*!40000 ALTER TABLE `model_has_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `model_has_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `model_has_roles`
--

DROP TABLE IF EXISTS `model_has_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `model_has_roles` (
  `role_id` bigint(20) unsigned NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`),
  CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `model_has_roles`
--

LOCK TABLES `model_has_roles` WRITE;
/*!40000 ALTER TABLE `model_has_roles` DISABLE KEYS */;
/*!40000 ALTER TABLE `model_has_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_reset_tokens`
--

LOCK TABLES `password_reset_tokens` WRITE;
/*!40000 ALTER TABLE `password_reset_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_reset_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payments` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `fee_assignment_id` bigint(20) unsigned NOT NULL,
  `receipt_number` varchar(255) NOT NULL,
  `payment_date` date NOT NULL,
  `amount_paid` decimal(10,2) NOT NULL,
  `payment_method` enum('Cash','Online','Cheque') NOT NULL,
  `reference_number` varchar(255) DEFAULT NULL,
  `deposit_date` date DEFAULT NULL,
  `cheque_no` int(11) DEFAULT NULL,
  `bank_name` varchar(255) DEFAULT NULL,
  `is_realized` tinyint(1) NOT NULL DEFAULT 0,
  `cancelled` tinyint(1) NOT NULL DEFAULT 0,
  `cancellation_date` datetime DEFAULT NULL,
  `cancellation_reason` text DEFAULT NULL,
  `cancelled_by_user_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `payments_fee_assignment_id_foreign` (`fee_assignment_id`),
  KEY `payments_cancelled_by_user_id_foreign` (`cancelled_by_user_id`),
  KEY `payments_receipt_number_index` (`receipt_number`),
  KEY `receipt_number` (`receipt_number`) USING BTREE,
  CONSTRAINT `payments_cancelled_by_user_id_foreign` FOREIGN KEY (`cancelled_by_user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `payments_fee_assignment_id_foreign` FOREIGN KEY (`fee_assignment_id`) REFERENCES `fee_assignments` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
INSERT INTO `payments` VALUES (1,10,'20250921-0001','2025-09-21',4000.00,'Cash',NULL,NULL,NULL,NULL,1,0,NULL,NULL,NULL,'2025-09-21 08:26:28','2025-09-21 08:26:28'),(2,9,'20250921-0002','2025-09-21',1500.00,'Cash',NULL,NULL,NULL,NULL,1,0,NULL,NULL,NULL,'2025-09-21 08:50:04','2025-09-21 08:50:04'),(3,13,'20250921-0003-1','2025-09-21',3000.00,'Cash',NULL,NULL,NULL,NULL,1,0,NULL,NULL,NULL,'2025-09-21 09:17:17','2025-09-21 09:17:17'),(4,14,'20250921-0003-2','2025-09-21',2500.00,'Cash',NULL,NULL,NULL,NULL,1,0,NULL,NULL,NULL,'2025-09-21 09:17:17','2025-09-21 09:17:17'),(5,15,'20250921-0003-3','2025-09-21',1500.00,'Cash',NULL,NULL,NULL,NULL,1,0,NULL,NULL,NULL,'2025-09-21 09:17:17','2025-09-21 09:17:17'),(6,18,'20250923-0001','2025-09-23',2000.00,'Cash',NULL,NULL,NULL,NULL,1,0,NULL,NULL,NULL,'2025-09-23 03:46:57','2025-09-23 03:46:57'),(7,18,'20250923-0002','2025-09-23',500.00,'Cash',NULL,NULL,NULL,NULL,1,0,NULL,NULL,NULL,'2025-09-23 03:47:51','2025-09-23 03:47:51'),(8,18,'20250923-0003','2025-09-23',500.00,'Cash',NULL,NULL,NULL,NULL,1,0,NULL,NULL,NULL,'2025-09-23 03:49:24','2025-09-23 03:49:24'),(9,11,'20250923-0004','2025-09-23',2000.00,'Cash',NULL,NULL,NULL,NULL,1,0,NULL,NULL,NULL,'2025-09-23 03:50:30','2025-09-23 03:50:30'),(10,11,'20250923-0005','2025-09-23',1000.00,'Cash',NULL,NULL,NULL,NULL,1,0,NULL,NULL,NULL,'2025-09-23 03:51:20','2025-09-23 03:51:20'),(11,11,'20250923-0006','2025-09-23',500.00,'Cash',NULL,NULL,NULL,NULL,1,0,NULL,NULL,NULL,'2025-09-23 03:52:31','2025-09-23 03:52:31'),(12,11,'20250923-0007','2025-09-23',500.00,'Cash',NULL,NULL,NULL,NULL,1,0,NULL,NULL,NULL,'2025-09-23 03:59:36','2025-09-23 03:59:36'),(13,20,'20250923-0008','2025-09-23',2000.00,'Cash',NULL,NULL,NULL,NULL,1,0,NULL,NULL,NULL,'2025-09-23 04:30:59','2025-09-23 04:30:59'),(14,20,'20250923-0009','2025-09-23',500.00,'Cash',NULL,NULL,NULL,NULL,1,0,NULL,NULL,NULL,'2025-09-23 04:35:25','2025-09-23 04:35:25'),(15,20,'20250923-0010','2025-09-23',200.00,'Cash',NULL,NULL,NULL,NULL,1,0,NULL,NULL,NULL,'2025-09-23 04:36:04','2025-09-23 04:36:04'),(16,20,'20250923-0011','2025-09-23',300.00,'Cash',NULL,NULL,NULL,NULL,1,0,NULL,NULL,NULL,'2025-09-23 04:37:02','2025-09-23 04:37:02'),(17,8,'20250923-0012','2025-09-23',1000.00,'Cash',NULL,NULL,NULL,NULL,1,0,NULL,NULL,NULL,'2025-09-23 04:55:32','2025-09-23 04:55:32'),(18,8,'20250923-0013','2025-09-23',1000.00,'Cash',NULL,NULL,NULL,NULL,1,0,NULL,NULL,NULL,'2025-09-23 04:55:53','2025-09-23 04:55:53'),(19,22,'20250923-0014','2025-09-23',2000.00,'Cash',NULL,NULL,NULL,NULL,1,0,NULL,NULL,NULL,'2025-09-23 04:58:54','2025-09-23 04:58:54'),(20,23,'20250923-0015','2025-09-23',3000.00,'Cash',NULL,NULL,NULL,NULL,1,0,NULL,NULL,NULL,'2025-09-23 05:03:52','2025-09-23 05:03:52'),(21,19,'20250923-0016','2025-09-23',999.97,'Cash',NULL,NULL,NULL,NULL,1,0,NULL,NULL,NULL,'2025-09-23 05:08:45','2025-09-23 05:08:45'),(22,24,'20250923-0017','2025-09-23',1000.00,'Cash',NULL,NULL,NULL,NULL,1,0,NULL,NULL,NULL,'2025-09-23 09:34:38','2025-09-23 09:34:38'),(23,24,'20250923-0018','2025-09-23',1000.00,'Cash',NULL,NULL,NULL,NULL,1,0,NULL,NULL,NULL,'2025-09-23 09:37:14','2025-09-23 09:37:14'),(24,24,'20250923-0019','2025-09-23',500.00,'Cash',NULL,NULL,NULL,NULL,1,0,NULL,NULL,NULL,'2025-09-23 09:37:40','2025-09-23 09:37:40'),(25,24,'20250923-0020','2025-09-23',200.00,'Cash',NULL,NULL,NULL,NULL,1,0,NULL,NULL,NULL,'2025-09-23 09:55:19','2025-09-23 09:55:19'),(26,24,'20250923-0021','2025-09-23',100.00,'Cash',NULL,NULL,NULL,NULL,1,0,NULL,NULL,NULL,'2025-09-23 10:03:22','2025-09-23 10:03:22'),(27,24,'20250923-0022','2025-09-23',100.00,'Cash',NULL,NULL,NULL,NULL,1,0,NULL,NULL,NULL,'2025-09-23 10:04:10','2025-09-23 10:04:10'),(28,24,'20250923-0023','2025-09-23',100.00,'Cash',NULL,NULL,NULL,NULL,1,0,NULL,NULL,NULL,'2025-09-23 10:07:12','2025-09-23 10:07:12'),(29,25,'20250923-0024','2025-09-23',500.00,'Cash',NULL,NULL,NULL,NULL,1,0,NULL,NULL,NULL,'2025-09-23 10:08:55','2025-09-23 10:08:55'),(30,25,'20250923-0025','2025-09-23',500.00,'Cash',NULL,NULL,NULL,NULL,1,0,NULL,NULL,NULL,'2025-09-23 10:11:03','2025-09-23 10:11:03'),(31,25,'20250923-0026','2025-09-23',500.00,'Cash',NULL,NULL,NULL,NULL,1,0,NULL,NULL,NULL,'2025-09-23 10:12:21','2025-09-23 10:12:21'),(32,25,'20250923-0027','2025-09-23',500.00,'Cash',NULL,NULL,NULL,NULL,1,0,NULL,NULL,NULL,'2025-09-23 10:15:31','2025-09-23 10:15:31'),(33,25,'20250923-0028','2025-09-23',500.00,'Cash',NULL,NULL,NULL,NULL,1,0,NULL,NULL,NULL,'2025-09-23 10:16:46','2025-09-23 10:16:46'),(34,25,'20250923-0029','2025-09-23',500.00,'Cash',NULL,NULL,NULL,NULL,1,0,NULL,NULL,NULL,'2025-09-23 10:18:49','2025-09-23 10:18:49'),(35,26,'20250923-0030','2025-09-23',1000.00,'Cash',NULL,NULL,NULL,NULL,1,0,NULL,NULL,NULL,'2025-09-23 10:25:07','2025-09-23 10:25:07'),(36,26,'20250923-0031','2025-09-23',500.00,'Cash',NULL,NULL,NULL,NULL,1,0,NULL,NULL,NULL,'2025-09-23 10:31:02','2025-09-23 10:31:02'),(37,26,'20250923-0032','2025-09-23',500.00,'Cash',NULL,NULL,NULL,NULL,1,0,NULL,NULL,NULL,'2025-09-23 10:40:50','2025-09-23 10:40:50'),(38,26,'20250923-0033','2025-09-23',500.00,'Cash',NULL,NULL,NULL,NULL,1,0,NULL,NULL,NULL,'2025-09-23 10:42:05','2025-09-23 10:42:05'),(39,26,'20250923-0034','2025-09-23',200.00,'Cash',NULL,NULL,NULL,NULL,1,0,NULL,NULL,NULL,'2025-09-23 10:43:06','2025-09-23 10:43:06'),(40,26,'20250923-0035','2025-09-23',100.00,'Cash',NULL,NULL,NULL,NULL,1,0,NULL,NULL,NULL,'2025-09-23 10:48:31','2025-09-23 10:48:31'),(41,26,'20250923-0036','2025-09-23',100.00,'Cash',NULL,NULL,NULL,NULL,1,0,NULL,NULL,NULL,'2025-09-23 10:50:07','2025-09-23 10:50:07'),(42,26,'20250923-0037','2025-09-23',100.00,'Cash',NULL,NULL,NULL,NULL,1,0,NULL,NULL,NULL,'2025-09-23 10:56:34','2025-09-23 10:56:34'),(43,27,'20250923-0038','2025-09-23',500.00,'Cash',NULL,NULL,NULL,NULL,1,0,NULL,NULL,NULL,'2025-09-23 10:58:38','2025-09-23 10:58:38'),(44,27,'20250923-0039','2025-09-23',500.00,'Cash',NULL,NULL,NULL,NULL,1,0,NULL,NULL,NULL,'2025-09-23 10:59:29','2025-09-23 10:59:29'),(45,27,'20250923-0040','2025-09-23',500.00,'Cash',NULL,NULL,NULL,NULL,1,0,NULL,NULL,NULL,'2025-09-23 11:04:42','2025-09-23 11:04:42'),(46,27,'20250923-0041','2025-09-23',500.00,'Cash',NULL,NULL,NULL,NULL,1,0,NULL,NULL,NULL,'2025-09-23 11:18:49','2025-09-23 11:18:49'),(47,27,'20250923-0042','2025-09-23',500.00,'Cash',NULL,NULL,NULL,NULL,1,0,NULL,NULL,NULL,'2025-09-23 11:20:27','2025-09-23 11:20:27'),(48,27,'20250923-0043','2025-09-23',200.00,'Cash',NULL,NULL,NULL,NULL,1,0,NULL,NULL,NULL,'2025-09-23 11:22:34','2025-09-23 11:22:34'),(49,27,'20250923-0044','2025-09-23',100.00,'Cash',NULL,NULL,NULL,NULL,1,0,NULL,NULL,NULL,'2025-09-23 11:24:52','2025-09-23 11:24:52'),(50,27,'20250923-0045','2025-09-23',100.00,'Cash',NULL,NULL,NULL,NULL,1,0,NULL,NULL,NULL,'2025-09-23 11:25:55','2025-09-23 11:25:55'),(51,27,'20250923-0046','2025-09-23',50.00,'Cash',NULL,NULL,NULL,NULL,1,0,NULL,NULL,NULL,'2025-09-23 11:31:56','2025-09-23 11:31:56'),(52,27,'20250923-0047','2025-09-23',50.00,'Cash',NULL,NULL,NULL,NULL,1,0,NULL,NULL,NULL,'2025-09-23 11:41:58','2025-09-23 11:41:58'),(53,28,'20250923-0048','2025-09-23',500.00,'Cash',NULL,NULL,NULL,NULL,1,0,NULL,NULL,NULL,'2025-09-23 11:44:00','2025-09-23 11:44:00'),(54,28,'20250923-0049','2025-09-23',100.00,'Cash',NULL,NULL,NULL,NULL,1,0,NULL,NULL,NULL,'2025-09-23 11:45:50','2025-09-23 11:45:50'),(55,28,'20250923-0050','2025-09-23',100.00,'Cash',NULL,NULL,NULL,NULL,1,0,NULL,NULL,NULL,'2025-09-23 11:50:15','2025-09-23 11:50:15'),(56,28,'20250923-0051','2025-09-23',100.00,'Cash',NULL,NULL,NULL,NULL,1,0,NULL,NULL,NULL,'2025-09-23 11:53:25','2025-09-23 11:53:25'),(57,29,'20250924-0001','2025-09-24',500.00,'Cash',NULL,NULL,NULL,NULL,1,0,NULL,NULL,NULL,'2025-09-24 12:03:34','2025-09-24 12:03:34'),(58,29,'20250925-0001','2025-09-25',499.98,'Cash',NULL,NULL,NULL,NULL,1,0,NULL,NULL,NULL,'2025-09-24 22:17:05','2025-09-24 22:17:05'),(59,29,'20250925-0002','2025-09-25',500.00,'Cash',NULL,NULL,NULL,NULL,1,0,NULL,NULL,NULL,'2025-09-24 23:19:36','2025-09-24 23:19:36'),(60,29,'20250925-0003','2025-09-25',100.00,'Cash',NULL,NULL,NULL,NULL,1,0,NULL,NULL,NULL,'2025-09-24 23:21:52','2025-09-24 23:21:52'),(61,29,'20250925-0004','2025-09-25',100.00,'Cash',NULL,NULL,NULL,NULL,1,0,NULL,NULL,NULL,'2025-09-24 23:26:37','2025-09-24 23:26:37'),(62,30,'20250925-0005-1','2025-09-25',3000.00,'Cash',NULL,NULL,NULL,NULL,1,0,NULL,NULL,NULL,'2025-09-25 11:20:14','2025-09-25 11:20:14'),(63,37,'20250925-0005-2','2025-09-25',2000.00,'Cash',NULL,NULL,NULL,NULL,1,0,NULL,NULL,NULL,'2025-09-25 11:20:14','2025-09-25 11:20:14'),(64,37,'F0000001','2025-09-26',500.00,'Cash',NULL,NULL,NULL,NULL,1,0,NULL,NULL,NULL,'2025-09-25 19:56:02','2025-09-25 19:56:02'),(65,37,'F0000002','2025-09-26',500.00,'Cash',NULL,NULL,NULL,NULL,1,0,NULL,NULL,NULL,'2025-09-26 11:58:12','2025-09-26 11:58:12'),(66,15,'F0000003-1','2025-10-02',2000.00,'Cheque',NULL,NULL,NULL,'Sampath',1,0,NULL,NULL,NULL,'2025-10-02 00:48:17','2025-10-02 00:48:17'),(67,16,'F0000003-2','2025-10-02',1000.00,'Cheque',NULL,NULL,NULL,'Sampath',1,0,NULL,NULL,NULL,'2025-10-02 00:48:17','2025-10-02 00:48:17'),(68,16,'F0000004','2025-10-02',1000.00,'Cheque',NULL,NULL,123456,'Sampath',1,0,NULL,NULL,NULL,'2025-10-02 09:15:44','2025-10-02 09:15:44'),(69,21,'F0000005','2025-10-02',100.00,'Online','1258',NULL,NULL,'ss',1,0,NULL,NULL,NULL,'2025-10-02 10:26:05','2025-10-02 10:26:05'),(70,21,'F0000006','2025-10-02',500.00,'Cheque',NULL,NULL,258963,'Sampath',0,0,NULL,NULL,NULL,'2025-10-02 10:40:06','2025-10-02 10:40:06'),(71,21,'F0000007','2025-10-02',400.00,'Online','Deposited',NULL,NULL,'sss',0,0,NULL,NULL,NULL,'2025-10-02 10:41:51','2025-10-02 10:41:51'),(72,21,'F0000008','2025-10-02',500.00,'Cash',NULL,NULL,NULL,NULL,1,0,NULL,NULL,NULL,'2025-10-02 10:49:51','2025-10-02 10:49:51'),(73,38,'F0000009','2025-10-06',3000.00,'Cheque',NULL,NULL,147258,'Sampath',1,0,NULL,NULL,NULL,'2025-10-06 05:03:54','2025-10-06 05:03:54'),(75,45,'F0000010','2025-10-06',3000.00,'Cash',NULL,NULL,NULL,NULL,1,0,NULL,NULL,NULL,'2025-10-06 05:28:46','2025-10-06 05:28:46'),(76,50,'F0000010','2025-10-06',1000.00,'Cash',NULL,NULL,NULL,NULL,1,0,NULL,NULL,NULL,'2025-10-06 05:28:46','2025-10-06 05:28:46'),(77,21,'F0000011','2025-10-06',500.00,'Cash',NULL,NULL,NULL,NULL,1,0,NULL,NULL,NULL,'2025-10-06 05:33:29','2025-10-06 05:33:29'),(78,53,'F0000011','2025-10-06',1000.00,'Cash',NULL,NULL,NULL,NULL,1,0,NULL,NULL,NULL,'2025-10-06 05:33:29','2025-10-06 05:33:29'),(79,43,'F0000012','2025-10-06',3000.00,'Cash',NULL,NULL,NULL,NULL,1,0,NULL,NULL,NULL,'2025-10-06 05:42:26','2025-10-06 05:42:26'),(80,48,'F0000012','2025-10-06',1000.00,'Cash',NULL,NULL,NULL,NULL,1,0,NULL,NULL,NULL,'2025-10-06 05:42:26','2025-10-06 05:42:26'),(81,28,'F0000013','2025-10-06',2200.00,'Cash',NULL,NULL,NULL,NULL,1,0,NULL,NULL,NULL,'2025-10-06 05:44:30','2025-10-06 05:44:30'),(82,44,'F0000013','2025-10-06',2800.00,'Cash',NULL,NULL,NULL,NULL,1,0,NULL,NULL,NULL,'2025-10-06 05:44:30','2025-10-06 05:44:30'),(83,56,'F0000014','2025-10-06',3000.00,'Cash',NULL,NULL,NULL,NULL,1,0,NULL,NULL,NULL,'2025-10-06 06:03:58','2025-10-06 06:03:58'),(84,58,'F0000014','2025-10-06',1000.00,'Cash',NULL,NULL,NULL,NULL,1,0,NULL,NULL,NULL,'2025-10-06 06:03:58','2025-10-06 06:03:58');
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permissions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissions`
--

LOCK TABLES `permissions` WRITE;
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_has_permissions`
--

DROP TABLE IF EXISTS `role_has_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role_has_permissions` (
  `permission_id` bigint(20) unsigned NOT NULL,
  `role_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`role_id`),
  KEY `role_has_permissions_role_id_foreign` (`role_id`),
  CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_has_permissions`
--

LOCK TABLES `role_has_permissions` WRITE;
/*!40000 ALTER TABLE `role_has_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `role_has_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` VALUES ('1LmXfx31Fopq8M9M8aNbSVRSaE1nXZXOYHud5brC',1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36','YTo1OntzOjY6Il90b2tlbiI7czo0MDoid2E0ZWtnQTlVNEhQdk5wNVplOHFrQWVIR2lEV3Y4REtnWnp5bkJHOSI7czozOiJ1cmwiO2E6MDp7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjM3OiJodHRwOi8vbG9jYWxob3N0OjgwMDAvYmFja3VwLWRhdGFiYXNlIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MTt9',1760452315),('g4D1GJkFx0hHBICL5oHB7a180CczeNU5UKrbefzG',1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36','YTo0OntzOjY6Il90b2tlbiI7czo0MDoiOXlKU2NSQzFIRDhLTHJJbUN0cEh3clNxcGYwMHJ4ZkRUamFkQ3A1ZyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC91cGxvYWQtY3N2Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MTt9',1760377252),('KZaLNtERmTY55BSFVR8Y0bHQcY8NBuFI0SVgVFNC',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36','YTo0OntzOjY6Il90b2tlbiI7czo0MDoia2RUcm5mUlBaV2RkN3VhbDdGaVlQOXh2V1R6UENCRWhSM0pDZkg1RSI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozMjoiaHR0cDovL2xvY2FsaG9zdDo4MDAwL3VwbG9hZC1jc3YiO31zOjk6Il9wcmV2aW91cyI7YToxOntzOjM6InVybCI7czoyNzoiaHR0cDovL2xvY2FsaG9zdDo4MDAwL2xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1760504634),('RdSJRLXDiUM8FS4HcqkIuoz92nua9Ui81AdIk97q',1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36','YTo0OntzOjY6Il90b2tlbiI7czo0MDoidE5jWUt1SE1VUmdub1RGUU82R005NWVhUENueWxxaTlITkZiRmVTUyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjc6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9sb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjE7fQ==',1760548359),('sO7QTn6I7KQ40Z1hgEVoiFsBVLOaP7PLNeaqYmuz',1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36','YTo0OntzOjY6Il90b2tlbiI7czo0MDoicjVQbEQybUYzTzFiNDNPVG1Pc0dudVpjVUJRSzVwaU92cjVqQ054UCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC91cGxvYWQtY3N2Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MTt9',1760436114);
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `students`
--

DROP TABLE IF EXISTS `students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `students` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `admission_number` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `whatsapp_number` varchar(255) DEFAULT NULL,
  `current_grade` varchar(255) NOT NULL,
  `current_class` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `sibling_admission_no` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `students_admission_number_unique` (`admission_number`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `students`
--

LOCK TABLES `students` WRITE;
/*!40000 ALTER TABLE `students` DISABLE KEYS */;
INSERT INTO `students` VALUES (4,'12222','ecde','1111111111','7','ece',1,NULL,'2025-09-15 10:52:36','2025-09-15 10:52:36'),(5,'11111111','dddddddddddd','1111111111','10','2',1,NULL,'2025-09-17 05:34:27','2025-09-17 05:34:35'),(6,'455','gg','4444444444','1','g',1,NULL,'2025-09-17 05:40:31','2025-09-17 05:40:31'),(7,'333','fvv','4444444444','4','r',1,NULL,'2025-09-17 05:45:55','2025-09-17 05:46:09'),(8,'1254','Shaluka','0773857751','10','s1',1,NULL,'2025-09-18 02:25:27','2025-09-18 02:25:27'),(9,'1256','Malintha','0777258369','5','5s2',1,NULL,'2025-09-21 08:25:09','2025-09-21 08:25:09'),(10,'2589','Shiran','0715689232','4','4s3',1,NULL,'2025-09-21 08:45:34','2025-09-21 08:45:34'),(11,'12345','s m pathirana','0718544544','9','9s5',1,NULL,'2025-09-21 09:03:35','2025-09-21 09:03:35'),(12,'235731','shiran malintha pathirana','0773855733','10','10s5',1,NULL,'2025-09-21 09:23:44','2025-09-21 09:23:44'),(13,'123669','test','0771234567','1','1s1',1,NULL,'2025-09-23 03:45:24','2025-09-23 03:45:24'),(14,'147258','sss','0178259665','2','2s4',1,NULL,'2025-09-23 04:20:47','2025-09-23 04:20:47'),(15,'123457','testtt','0258369875','2','2s3',1,NULL,'2025-09-23 04:30:10','2025-09-23 04:30:10'),(16,'125478','tesdtt','0174567896','10','10s3',1,NULL,'2025-09-23 04:54:21','2025-09-23 04:54:21'),(17,'258369','ddd','1472583696','2','2s3',1,NULL,'2025-09-23 05:02:56','2025-09-23 05:02:56'),(18,'147963','rock','0172583698','2','2s2',1,NULL,'2025-09-23 09:33:47','2025-09-23 09:33:47'),(19,'145632','dert','0258978963','2','2s4',1,NULL,'2025-09-23 10:08:05','2025-09-23 10:08:05'),(20,'7789445','ddd','1487852369','2','2s2',1,NULL,'2025-09-23 10:24:33','2025-09-23 10:24:33'),(21,'4587996','ggg','0178956442','4','4s3',1,NULL,'2025-09-23 10:58:03','2025-09-23 10:58:03'),(22,'125698','fff','0712589630','4','4s2',1,NULL,'2025-09-23 11:42:57','2025-09-23 11:42:57'),(23,'12556','dddd','1755866696','5','5s3',1,NULL,'2025-09-24 11:47:56','2025-09-24 11:47:56'),(24,'147589','old student','0715689231','3','3s3',1,NULL,'2025-09-25 11:14:28','2025-09-25 11:17:14'),(25,'1472563','banuka','0715289963','4','4s3',1,NULL,'2025-10-06 05:00:01','2025-10-06 05:00:01'),(26,'125896','test2','0778596965','7','7s3',1,NULL,'2025-10-06 06:03:04','2025-10-06 06:03:04');
/*!40000 ALTER TABLE `students` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','accountant','viewer') NOT NULL DEFAULT 'accountant',
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'shaluka','shaluka@gmail.com',NULL,'$2y$12$hD3e.5Xg1KdaNpSyP3fWje9pJUHq1GNutxcHkC.qdksm577aQNiGi','accountant',NULL,'2025-09-14 01:03:53','2025-09-14 01:03:53');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-10-15 22:42:43
