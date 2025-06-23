-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jun 23, 2025 at 11:35 AM
-- Server version: 10.11.10-MariaDB
-- PHP Version: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `u235540170_spmi`
--

-- --------------------------------------------------------

--
-- Table structure for table `assign_pengisians`
--

CREATE TABLE `assign_pengisians` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `unit_indikator_id` bigint(20) UNSIGNED NOT NULL,
  `periode_id` bigint(20) UNSIGNED NOT NULL,
  `start_date` datetime NOT NULL,
  `end_date` datetime NOT NULL,
  `status_pengisian` enum('pending','selesai') NOT NULL DEFAULT 'pending',
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `status` enum('pending','validated') NOT NULL DEFAULT 'pending',
  `validated_by` bigint(20) UNSIGNED DEFAULT NULL,
  `validated_time` timestamp NULL DEFAULT NULL,
  `created_by` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `assign_pengisians`
--

INSERT INTO `assign_pengisians` (`id`, `unit_indikator_id`, `periode_id`, `start_date`, `end_date`, `status_pengisian`, `is_active`, `status`, `validated_by`, `validated_time`, `created_by`, `created_at`, `updated_at`) VALUES
(2, 2, 3, '2024-06-10 00:00:00', '2024-06-17 00:00:00', 'selesai', 1, 'validated', 987654931, '2025-06-18 01:09:37', NULL, '2025-06-18 01:09:01', '2025-06-22 03:39:03');

-- --------------------------------------------------------

--
-- Table structure for table `auditor_assignments`
--

CREATE TABLE `auditor_assignments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `assign_pengisian_id` bigint(20) UNSIGNED NOT NULL,
  `auditor1` bigint(20) UNSIGNED NOT NULL,
  `auditor2` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `auditor_assignments`
--

INSERT INTO `auditor_assignments` (`id`, `assign_pengisian_id`, `auditor1`, `auditor2`, `created_at`, `updated_at`) VALUES
(2, 2, 987654977, 987654945, '2025-06-18 01:09:01', '2025-06-22 03:39:03');

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
('livewire-rate-limiter:19ebcb71b496f03fe0f9621987d6f2877d86d5cd', 'i:1;', 1750585714),
('livewire-rate-limiter:19ebcb71b496f03fe0f9621987d6f2877d86d5cd:timer', 'i:1750585714;', 1750585714),
('livewire-rate-limiter:7f98824f949c9d7384bf2a0786f8f8fbef0532f5', 'i:2;', 1750569911),
('livewire-rate-limiter:7f98824f949c9d7384bf2a0786f8f8fbef0532f5:timer', 'i:1750569911;', 1750569911),
('livewire-rate-limiter:c48cfd6df4e870eab373b483b0c23b294981dc1f', 'i:1;', 1750678317),
('livewire-rate-limiter:c48cfd6df4e870eab373b483b0c23b294981dc1f:timer', 'i:1750678317;', 1750678317),
('spatie.permission.cache', 'a:3:{s:5:\"alias\";a:4:{s:1:\"a\";s:2:\"id\";s:1:\"b\";s:4:\"name\";s:1:\"c\";s:10:\"guard_name\";s:1:\"r\";s:5:\"roles\";}s:11:\"permissions\";a:155:{i:0;a:4:{s:1:\"a\";i:1;s:1:\"b\";s:22:\"view_assign::pengisian\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:1;a:4:{s:1:\"a\";i:2;s:1:\"b\";s:26:\"view_any_assign::pengisian\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:2;a:4:{s:1:\"a\";i:3;s:1:\"b\";s:24:\"create_assign::pengisian\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:3;a:4:{s:1:\"a\";i:4;s:1:\"b\";s:24:\"update_assign::pengisian\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:4;a:4:{s:1:\"a\";i:5;s:1:\"b\";s:25:\"restore_assign::pengisian\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:5;a:4:{s:1:\"a\";i:6;s:1:\"b\";s:29:\"restore_any_assign::pengisian\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:6;a:4:{s:1:\"a\";i:7;s:1:\"b\";s:27:\"replicate_assign::pengisian\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:7;a:4:{s:1:\"a\";i:8;s:1:\"b\";s:25:\"reorder_assign::pengisian\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:8;a:4:{s:1:\"a\";i:9;s:1:\"b\";s:24:\"delete_assign::pengisian\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:9;a:4:{s:1:\"a\";i:10;s:1:\"b\";s:28:\"delete_any_assign::pengisian\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:10;a:4:{s:1:\"a\";i:11;s:1:\"b\";s:30:\"force_delete_assign::pengisian\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:11;a:4:{s:1:\"a\";i:12;s:1:\"b\";s:34:\"force_delete_any_assign::pengisian\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:12;a:4:{s:1:\"a\";i:13;s:1:\"b\";s:14:\"view_indikator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:13;a:4:{s:1:\"a\";i:14;s:1:\"b\";s:18:\"view_any_indikator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:14;a:4:{s:1:\"a\";i:15;s:1:\"b\";s:16:\"create_indikator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:15;a:4:{s:1:\"a\";i:16;s:1:\"b\";s:16:\"update_indikator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:16;a:4:{s:1:\"a\";i:17;s:1:\"b\";s:17:\"restore_indikator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:17;a:4:{s:1:\"a\";i:18;s:1:\"b\";s:21:\"restore_any_indikator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:18;a:4:{s:1:\"a\";i:19;s:1:\"b\";s:19:\"replicate_indikator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:19;a:4:{s:1:\"a\";i:20;s:1:\"b\";s:17:\"reorder_indikator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:20;a:4:{s:1:\"a\";i:21;s:1:\"b\";s:16:\"delete_indikator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:21;a:4:{s:1:\"a\";i:22;s:1:\"b\";s:20:\"delete_any_indikator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:22;a:4:{s:1:\"a\";i:23;s:1:\"b\";s:22:\"force_delete_indikator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:23;a:4:{s:1:\"a\";i:24;s:1:\"b\";s:26:\"force_delete_any_indikator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:24;a:4:{s:1:\"a\";i:25;s:1:\"b\";s:17:\"view_isi::standar\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:25;a:4:{s:1:\"a\";i:26;s:1:\"b\";s:21:\"view_any_isi::standar\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:26;a:4:{s:1:\"a\";i:27;s:1:\"b\";s:19:\"create_isi::standar\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:27;a:4:{s:1:\"a\";i:28;s:1:\"b\";s:19:\"update_isi::standar\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:28;a:4:{s:1:\"a\";i:29;s:1:\"b\";s:20:\"restore_isi::standar\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:29;a:4:{s:1:\"a\";i:30;s:1:\"b\";s:24:\"restore_any_isi::standar\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:30;a:4:{s:1:\"a\";i:31;s:1:\"b\";s:22:\"replicate_isi::standar\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:31;a:4:{s:1:\"a\";i:32;s:1:\"b\";s:20:\"reorder_isi::standar\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:32;a:4:{s:1:\"a\";i:33;s:1:\"b\";s:19:\"delete_isi::standar\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:33;a:4:{s:1:\"a\";i:34;s:1:\"b\";s:23:\"delete_any_isi::standar\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:34;a:4:{s:1:\"a\";i:35;s:1:\"b\";s:25:\"force_delete_isi::standar\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:35;a:4:{s:1:\"a\";i:36;s:1:\"b\";s:29:\"force_delete_any_isi::standar\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:36;a:4:{s:1:\"a\";i:37;s:1:\"b\";s:11:\"view_jadwal\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:5;}}i:37;a:4:{s:1:\"a\";i:38;s:1:\"b\";s:15:\"view_any_jadwal\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:5;}}i:38;a:4:{s:1:\"a\";i:39;s:1:\"b\";s:13:\"create_jadwal\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:39;a:4:{s:1:\"a\";i:40;s:1:\"b\";s:13:\"update_jadwal\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:40;a:4:{s:1:\"a\";i:41;s:1:\"b\";s:14:\"restore_jadwal\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:41;a:4:{s:1:\"a\";i:42;s:1:\"b\";s:18:\"restore_any_jadwal\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:42;a:4:{s:1:\"a\";i:43;s:1:\"b\";s:16:\"replicate_jadwal\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:43;a:4:{s:1:\"a\";i:44;s:1:\"b\";s:14:\"reorder_jadwal\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:44;a:4:{s:1:\"a\";i:45;s:1:\"b\";s:13:\"delete_jadwal\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:45;a:4:{s:1:\"a\";i:46;s:1:\"b\";s:17:\"delete_any_jadwal\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:46;a:4:{s:1:\"a\";i:47;s:1:\"b\";s:19:\"force_delete_jadwal\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:47;a:4:{s:1:\"a\";i:48;s:1:\"b\";s:23:\"force_delete_any_jadwal\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:48;a:4:{s:1:\"a\";i:49;s:1:\"b\";s:25:\"view_pengisian::indikator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:4;}}i:49;a:4:{s:1:\"a\";i:50;s:1:\"b\";s:29:\"view_any_pengisian::indikator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:4;}}i:50;a:4:{s:1:\"a\";i:51;s:1:\"b\";s:27:\"create_pengisian::indikator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:4;}}i:51;a:4:{s:1:\"a\";i:52;s:1:\"b\";s:27:\"update_pengisian::indikator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:52;a:4:{s:1:\"a\";i:53;s:1:\"b\";s:28:\"restore_pengisian::indikator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:53;a:4:{s:1:\"a\";i:54;s:1:\"b\";s:32:\"restore_any_pengisian::indikator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:54;a:4:{s:1:\"a\";i:55;s:1:\"b\";s:30:\"replicate_pengisian::indikator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:55;a:4:{s:1:\"a\";i:56;s:1:\"b\";s:28:\"reorder_pengisian::indikator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:56;a:4:{s:1:\"a\";i:57;s:1:\"b\";s:27:\"delete_pengisian::indikator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:57;a:4:{s:1:\"a\";i:58;s:1:\"b\";s:31:\"delete_any_pengisian::indikator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:58;a:4:{s:1:\"a\";i:59;s:1:\"b\";s:33:\"force_delete_pengisian::indikator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:59;a:4:{s:1:\"a\";i:60;s:1:\"b\";s:37:\"force_delete_any_pengisian::indikator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:60;a:4:{s:1:\"a\";i:61;s:1:\"b\";s:12:\"view_periode\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:61;a:4:{s:1:\"a\";i:62;s:1:\"b\";s:16:\"view_any_periode\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:62;a:4:{s:1:\"a\";i:63;s:1:\"b\";s:14:\"create_periode\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:63;a:4:{s:1:\"a\";i:64;s:1:\"b\";s:14:\"update_periode\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:64;a:4:{s:1:\"a\";i:65;s:1:\"b\";s:15:\"restore_periode\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:65;a:4:{s:1:\"a\";i:66;s:1:\"b\";s:19:\"restore_any_periode\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:66;a:4:{s:1:\"a\";i:67;s:1:\"b\";s:17:\"replicate_periode\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:67;a:4:{s:1:\"a\";i:68;s:1:\"b\";s:15:\"reorder_periode\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:68;a:4:{s:1:\"a\";i:69;s:1:\"b\";s:14:\"delete_periode\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:69;a:4:{s:1:\"a\";i:70;s:1:\"b\";s:18:\"delete_any_periode\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:70;a:4:{s:1:\"a\";i:71;s:1:\"b\";s:20:\"force_delete_periode\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:71;a:4:{s:1:\"a\";i:72;s:1:\"b\";s:24:\"force_delete_any_periode\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:72;a:4:{s:1:\"a\";i:73;s:1:\"b\";s:22:\"view_review::indikator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:3:{i:0;i:1;i:1;i:4;i:2;i:5;}}i:73;a:4:{s:1:\"a\";i:74;s:1:\"b\";s:26:\"view_any_review::indikator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:3:{i:0;i:1;i:1;i:4;i:2;i:5;}}i:74;a:4:{s:1:\"a\";i:75;s:1:\"b\";s:24:\"create_review::indikator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:5;}}i:75;a:4:{s:1:\"a\";i:76;s:1:\"b\";s:24:\"update_review::indikator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:5;}}i:76;a:4:{s:1:\"a\";i:77;s:1:\"b\";s:25:\"restore_review::indikator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:77;a:4:{s:1:\"a\";i:78;s:1:\"b\";s:29:\"restore_any_review::indikator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:78;a:4:{s:1:\"a\";i:79;s:1:\"b\";s:27:\"replicate_review::indikator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:79;a:4:{s:1:\"a\";i:80;s:1:\"b\";s:25:\"reorder_review::indikator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:80;a:4:{s:1:\"a\";i:81;s:1:\"b\";s:24:\"delete_review::indikator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:81;a:4:{s:1:\"a\";i:82;s:1:\"b\";s:28:\"delete_any_review::indikator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:82;a:4:{s:1:\"a\";i:83;s:1:\"b\";s:30:\"force_delete_review::indikator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:83;a:4:{s:1:\"a\";i:84;s:1:\"b\";s:34:\"force_delete_any_review::indikator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:84;a:4:{s:1:\"a\";i:85;s:1:\"b\";s:9:\"view_role\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:85;a:4:{s:1:\"a\";i:86;s:1:\"b\";s:13:\"view_any_role\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:86;a:4:{s:1:\"a\";i:87;s:1:\"b\";s:11:\"create_role\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:87;a:4:{s:1:\"a\";i:88;s:1:\"b\";s:11:\"update_role\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:88;a:4:{s:1:\"a\";i:89;s:1:\"b\";s:11:\"delete_role\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:89;a:4:{s:1:\"a\";i:90;s:1:\"b\";s:15:\"delete_any_role\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:90;a:4:{s:1:\"a\";i:91;s:1:\"b\";s:12:\"view_standar\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:91;a:4:{s:1:\"a\";i:92;s:1:\"b\";s:16:\"view_any_standar\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:92;a:4:{s:1:\"a\";i:93;s:1:\"b\";s:14:\"create_standar\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:93;a:4:{s:1:\"a\";i:94;s:1:\"b\";s:14:\"update_standar\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:94;a:4:{s:1:\"a\";i:95;s:1:\"b\";s:15:\"restore_standar\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:95;a:4:{s:1:\"a\";i:96;s:1:\"b\";s:19:\"restore_any_standar\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:96;a:4:{s:1:\"a\";i:97;s:1:\"b\";s:17:\"replicate_standar\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:97;a:4:{s:1:\"a\";i:98;s:1:\"b\";s:15:\"reorder_standar\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:98;a:4:{s:1:\"a\";i:99;s:1:\"b\";s:14:\"delete_standar\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:99;a:4:{s:1:\"a\";i:100;s:1:\"b\";s:18:\"delete_any_standar\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:100;a:4:{s:1:\"a\";i:101;s:1:\"b\";s:20:\"force_delete_standar\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:101;a:4:{s:1:\"a\";i:102;s:1:\"b\";s:24:\"force_delete_any_standar\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:102;a:4:{s:1:\"a\";i:103;s:1:\"b\";s:17:\"view_sub::standar\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:103;a:4:{s:1:\"a\";i:104;s:1:\"b\";s:21:\"view_any_sub::standar\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:104;a:4:{s:1:\"a\";i:105;s:1:\"b\";s:19:\"create_sub::standar\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:105;a:4:{s:1:\"a\";i:106;s:1:\"b\";s:19:\"update_sub::standar\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:106;a:4:{s:1:\"a\";i:107;s:1:\"b\";s:20:\"restore_sub::standar\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:107;a:4:{s:1:\"a\";i:108;s:1:\"b\";s:24:\"restore_any_sub::standar\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:108;a:4:{s:1:\"a\";i:109;s:1:\"b\";s:22:\"replicate_sub::standar\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:109;a:4:{s:1:\"a\";i:110;s:1:\"b\";s:20:\"reorder_sub::standar\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:110;a:4:{s:1:\"a\";i:111;s:1:\"b\";s:19:\"delete_sub::standar\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:111;a:4:{s:1:\"a\";i:112;s:1:\"b\";s:23:\"delete_any_sub::standar\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:112;a:4:{s:1:\"a\";i:113;s:1:\"b\";s:25:\"force_delete_sub::standar\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:113;a:4:{s:1:\"a\";i:114;s:1:\"b\";s:29:\"force_delete_any_sub::standar\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:114;a:4:{s:1:\"a\";i:115;s:1:\"b\";s:9:\"view_unit\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:115;a:4:{s:1:\"a\";i:116;s:1:\"b\";s:13:\"view_any_unit\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:116;a:4:{s:1:\"a\";i:117;s:1:\"b\";s:11:\"create_unit\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:117;a:4:{s:1:\"a\";i:118;s:1:\"b\";s:11:\"update_unit\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:118;a:4:{s:1:\"a\";i:119;s:1:\"b\";s:12:\"restore_unit\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:119;a:4:{s:1:\"a\";i:120;s:1:\"b\";s:16:\"restore_any_unit\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:120;a:4:{s:1:\"a\";i:121;s:1:\"b\";s:14:\"replicate_unit\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:121;a:4:{s:1:\"a\";i:122;s:1:\"b\";s:12:\"reorder_unit\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:122;a:4:{s:1:\"a\";i:123;s:1:\"b\";s:11:\"delete_unit\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:123;a:4:{s:1:\"a\";i:124;s:1:\"b\";s:15:\"delete_any_unit\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:124;a:4:{s:1:\"a\";i:125;s:1:\"b\";s:17:\"force_delete_unit\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:125;a:4:{s:1:\"a\";i:126;s:1:\"b\";s:21:\"force_delete_any_unit\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:126;a:4:{s:1:\"a\";i:127;s:1:\"b\";s:20:\"view_unit::indikator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:127;a:4:{s:1:\"a\";i:128;s:1:\"b\";s:24:\"view_any_unit::indikator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:128;a:4:{s:1:\"a\";i:129;s:1:\"b\";s:22:\"create_unit::indikator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:129;a:4:{s:1:\"a\";i:130;s:1:\"b\";s:22:\"update_unit::indikator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:130;a:4:{s:1:\"a\";i:131;s:1:\"b\";s:23:\"restore_unit::indikator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:131;a:4:{s:1:\"a\";i:132;s:1:\"b\";s:27:\"restore_any_unit::indikator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:132;a:4:{s:1:\"a\";i:133;s:1:\"b\";s:25:\"replicate_unit::indikator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:133;a:4:{s:1:\"a\";i:134;s:1:\"b\";s:23:\"reorder_unit::indikator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:134;a:4:{s:1:\"a\";i:135;s:1:\"b\";s:22:\"delete_unit::indikator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:135;a:4:{s:1:\"a\";i:136;s:1:\"b\";s:26:\"delete_any_unit::indikator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:136;a:4:{s:1:\"a\";i:137;s:1:\"b\";s:28:\"force_delete_unit::indikator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:137;a:4:{s:1:\"a\";i:138;s:1:\"b\";s:32:\"force_delete_any_unit::indikator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:138;a:4:{s:1:\"a\";i:139;s:1:\"b\";s:9:\"view_user\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:139;a:4:{s:1:\"a\";i:140;s:1:\"b\";s:13:\"view_any_user\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:140;a:4:{s:1:\"a\";i:141;s:1:\"b\";s:11:\"create_user\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:141;a:4:{s:1:\"a\";i:142;s:1:\"b\";s:11:\"update_user\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:142;a:4:{s:1:\"a\";i:143;s:1:\"b\";s:12:\"restore_user\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:143;a:4:{s:1:\"a\";i:144;s:1:\"b\";s:16:\"restore_any_user\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:144;a:4:{s:1:\"a\";i:145;s:1:\"b\";s:14:\"replicate_user\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:145;a:4:{s:1:\"a\";i:146;s:1:\"b\";s:12:\"reorder_user\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:146;a:4:{s:1:\"a\";i:147;s:1:\"b\";s:11:\"delete_user\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:147;a:4:{s:1:\"a\";i:148;s:1:\"b\";s:15:\"delete_any_user\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:148;a:4:{s:1:\"a\";i:149;s:1:\"b\";s:17:\"force_delete_user\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:149;a:4:{s:1:\"a\";i:150;s:1:\"b\";s:21:\"force_delete_any_user\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:150;a:4:{s:1:\"a\";i:151;s:1:\"b\";s:23:\"page_JadwalCalendarPage\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:5:{i:0;i:1;i:1;i:2;i:2;i:3;i:3;i:4;i:4;i:5;}}i:151;a:4:{s:1:\"a\";i:152;s:1:\"b\";s:11:\"page_Themes\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:152;a:4:{s:1:\"a\";i:153;s:1:\"b\";s:18:\"page_MyProfilePage\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:3:{i:0;i:1;i:1;i:4;i:2;i:5;}}i:153;a:4:{s:1:\"a\";i:154;s:1:\"b\";s:21:\"widget_DateTimeWidget\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:5;}}i:154;a:4:{s:1:\"a\";i:155;s:1:\"b\";s:27:\"widget_JadwalCalendarWidget\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:5:{i:0;i:1;i:1;i:2;i:2;i:3;i:3;i:4;i:4;i:5;}}}s:5:\"roles\";a:5:{i:0;a:3:{s:1:\"a\";i:1;s:1:\"b\";s:11:\"super_admin\";s:1:\"c\";s:3:\"web\";}i:1;a:3:{s:1:\"a\";i:5;s:1:\"b\";s:7:\"auditor\";s:1:\"c\";s:3:\"web\";}i:2;a:3:{s:1:\"a\";i:4;s:1:\"b\";s:7:\"auditee\";s:1:\"c\";s:3:\"web\";}i:3;a:3:{s:1:\"a\";i:2;s:1:\"b\";s:8:\"pimpinan\";s:1:\"c\";s:3:\"web\";}i:4;a:3:{s:1:\"a\";i:3;s:1:\"b\";s:5:\"p2mpp\";s:1:\"c\";s:3:\"web\";}}}', 1750764657);

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
-- Table structure for table `exports`
--

CREATE TABLE `exports` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `completed_at` timestamp NULL DEFAULT NULL,
  `file_disk` varchar(255) NOT NULL,
  `file_name` varchar(255) DEFAULT NULL,
  `exporter` varchar(255) NOT NULL,
  `processed_rows` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `total_rows` int(10) UNSIGNED NOT NULL,
  `successful_rows` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_import_rows`
--

CREATE TABLE `failed_import_rows` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`data`)),
  `import_id` bigint(20) UNSIGNED NOT NULL,
  `validation_error` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `failed_import_rows`
--

INSERT INTO `failed_import_rows` (`id`, `data`, `import_id`, `validation_error`, `created_at`, `updated_at`) VALUES
(1, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:00:26', '2025-06-15 07:00:26'),
(2, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:00:27', '2025-06-15 07:00:27'),
(3, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:00:27', '2025-06-15 07:00:27'),
(4, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:00:28', '2025-06-15 07:00:28'),
(5, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:00:28', '2025-06-15 07:00:28'),
(6, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:00:29', '2025-06-15 07:00:29'),
(7, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 3, 'The avatar url field must be a valid URL.', '2025-06-15 07:00:29', '2025-06-15 07:00:29'),
(8, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 3, 'The avatar url field must be a valid URL.', '2025-06-15 07:00:29', '2025-06-15 07:00:29'),
(9, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 3, 'The avatar url field must be a valid URL.', '2025-06-15 07:00:30', '2025-06-15 07:00:30'),
(10, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:00:30', '2025-06-15 07:00:30'),
(11, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:00:30', '2025-06-15 07:00:30'),
(12, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:00:30', '2025-06-15 07:00:30'),
(13, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:00:31', '2025-06-15 07:00:31'),
(14, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:00:31', '2025-06-15 07:00:31'),
(15, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:00:32', '2025-06-15 07:00:32'),
(16, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:00:32', '2025-06-15 07:00:32'),
(17, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:00:33', '2025-06-15 07:00:33'),
(18, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:00:34', '2025-06-15 07:00:34'),
(19, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:00:34', '2025-06-15 07:00:34'),
(20, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:00:34', '2025-06-15 07:00:34'),
(21, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:00:34', '2025-06-15 07:00:34'),
(22, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:00:35', '2025-06-15 07:00:35'),
(23, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:00:35', '2025-06-15 07:00:35'),
(24, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:00:36', '2025-06-15 07:00:36'),
(25, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:00:37', '2025-06-15 07:00:37'),
(26, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:00:37', '2025-06-15 07:00:37'),
(27, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:00:37', '2025-06-15 07:00:37'),
(28, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:00:38', '2025-06-15 07:00:38'),
(29, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:00:38', '2025-06-15 07:00:38'),
(30, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:00:38', '2025-06-15 07:00:38'),
(31, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:00:38', '2025-06-15 07:00:38'),
(32, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:00:39', '2025-06-15 07:00:39'),
(33, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:00:39', '2025-06-15 07:00:39'),
(34, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:00:40', '2025-06-15 07:00:40'),
(35, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:00:40', '2025-06-15 07:00:40'),
(36, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:00:41', '2025-06-15 07:00:41'),
(37, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:00:41', '2025-06-15 07:00:41'),
(38, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:00:41', '2025-06-15 07:00:41'),
(39, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:00:41', '2025-06-15 07:00:41'),
(40, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:00:41', '2025-06-15 07:00:41'),
(41, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:00:42', '2025-06-15 07:00:42'),
(42, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:00:43', '2025-06-15 07:00:43'),
(43, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:00:43', '2025-06-15 07:00:43'),
(44, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:00:44', '2025-06-15 07:00:44'),
(45, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:00:44', '2025-06-15 07:00:44'),
(46, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:00:44', '2025-06-15 07:00:44'),
(47, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:00:44', '2025-06-15 07:00:44'),
(48, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:00:44', '2025-06-15 07:00:44'),
(49, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:00:45', '2025-06-15 07:00:45'),
(50, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:00:46', '2025-06-15 07:00:46'),
(51, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:00:46', '2025-06-15 07:00:46'),
(52, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:00:47', '2025-06-15 07:00:47'),
(53, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:00:47', '2025-06-15 07:00:47'),
(54, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:00:48', '2025-06-15 07:00:48'),
(55, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:00:48', '2025-06-15 07:00:48'),
(56, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:00:48', '2025-06-15 07:00:48'),
(57, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:00:48', '2025-06-15 07:00:48'),
(58, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:00:49', '2025-06-15 07:00:49'),
(59, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:00:49', '2025-06-15 07:00:49'),
(60, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:00:50', '2025-06-15 07:00:50'),
(61, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:00:50', '2025-06-15 07:00:50'),
(62, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:00:51', '2025-06-15 07:00:51'),
(63, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:00:51', '2025-06-15 07:00:51'),
(64, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:00:51', '2025-06-15 07:00:51'),
(65, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:00:51', '2025-06-15 07:00:51'),
(66, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:00:51', '2025-06-15 07:00:51'),
(67, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:00:52', '2025-06-15 07:00:52'),
(68, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:00:52', '2025-06-15 07:00:52'),
(69, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:00:53', '2025-06-15 07:00:53'),
(70, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:00:53', '2025-06-15 07:00:53'),
(71, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:00:54', '2025-06-15 07:00:54'),
(72, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:00:54', '2025-06-15 07:00:54'),
(73, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:00:54', '2025-06-15 07:00:54'),
(74, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:00:54', '2025-06-15 07:00:54'),
(75, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:00:54', '2025-06-15 07:00:54'),
(76, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:00:55', '2025-06-15 07:00:55'),
(77, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:00:55', '2025-06-15 07:00:55'),
(78, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:00:56', '2025-06-15 07:00:56'),
(79, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:00:56', '2025-06-15 07:00:56'),
(80, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:00:57', '2025-06-15 07:00:57'),
(81, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:00:58', '2025-06-15 07:00:58'),
(82, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:00:58', '2025-06-15 07:00:58'),
(83, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:00:58', '2025-06-15 07:00:58'),
(84, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:00:58', '2025-06-15 07:00:58'),
(85, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:00:58', '2025-06-15 07:00:58'),
(86, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:00:59', '2025-06-15 07:00:59'),
(87, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:00:59', '2025-06-15 07:00:59'),
(88, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:01:00', '2025-06-15 07:01:00'),
(89, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:01:00', '2025-06-15 07:01:00'),
(90, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:01:01', '2025-06-15 07:01:01'),
(91, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:01:01', '2025-06-15 07:01:01'),
(92, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:01:01', '2025-06-15 07:01:01'),
(93, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:01:01', '2025-06-15 07:01:01'),
(94, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:01:02', '2025-06-15 07:01:02'),
(95, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:01:02', '2025-06-15 07:01:02'),
(96, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:01:03', '2025-06-15 07:01:03'),
(97, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:01:03', '2025-06-15 07:01:03'),
(98, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:01:04', '2025-06-15 07:01:04'),
(99, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:01:05', '2025-06-15 07:01:05'),
(100, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:01:05', '2025-06-15 07:01:05'),
(101, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:01:05', '2025-06-15 07:01:05'),
(102, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:01:05', '2025-06-15 07:01:05'),
(103, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:01:05', '2025-06-15 07:01:05'),
(104, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:01:06', '2025-06-15 07:01:06'),
(105, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:01:07', '2025-06-15 07:01:07'),
(106, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:01:07', '2025-06-15 07:01:07'),
(107, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:01:08', '2025-06-15 07:01:08'),
(108, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:01:08', '2025-06-15 07:01:08'),
(109, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:01:08', '2025-06-15 07:01:08'),
(110, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:01:08', '2025-06-15 07:01:08'),
(111, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:01:08', '2025-06-15 07:01:08'),
(112, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:01:09', '2025-06-15 07:01:09'),
(113, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:01:10', '2025-06-15 07:01:10'),
(114, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:01:10', '2025-06-15 07:01:10'),
(115, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:01:11', '2025-06-15 07:01:11'),
(116, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:01:11', '2025-06-15 07:01:11'),
(117, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:01:12', '2025-06-15 07:01:12'),
(118, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:01:12', '2025-06-15 07:01:12'),
(119, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:01:12', '2025-06-15 07:01:12'),
(120, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:01:12', '2025-06-15 07:01:12'),
(121, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:01:13', '2025-06-15 07:01:13'),
(122, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:01:13', '2025-06-15 07:01:13'),
(123, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:01:14', '2025-06-15 07:01:14'),
(124, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:01:14', '2025-06-15 07:01:14'),
(125, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:01:15', '2025-06-15 07:01:15'),
(126, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:01:16', '2025-06-15 07:01:16'),
(127, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:01:16', '2025-06-15 07:01:16'),
(128, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:01:16', '2025-06-15 07:01:16'),
(129, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:01:16', '2025-06-15 07:01:16'),
(130, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:01:16', '2025-06-15 07:01:16'),
(131, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:01:17', '2025-06-15 07:01:17'),
(132, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:01:18', '2025-06-15 07:01:18'),
(133, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:01:18', '2025-06-15 07:01:18'),
(134, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:01:19', '2025-06-15 07:01:19'),
(135, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:01:19', '2025-06-15 07:01:19'),
(136, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:01:19', '2025-06-15 07:01:19'),
(137, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:01:19', '2025-06-15 07:01:19'),
(138, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:01:19', '2025-06-15 07:01:19'),
(139, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:01:20', '2025-06-15 07:01:20'),
(140, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:01:21', '2025-06-15 07:01:21'),
(141, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:01:21', '2025-06-15 07:01:21'),
(142, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:01:22', '2025-06-15 07:01:22'),
(143, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:01:22', '2025-06-15 07:01:22'),
(144, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:01:23', '2025-06-15 07:01:23'),
(145, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:01:23', '2025-06-15 07:01:23'),
(146, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:01:23', '2025-06-15 07:01:23'),
(147, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:01:23', '2025-06-15 07:01:23'),
(148, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:01:24', '2025-06-15 07:01:24'),
(149, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:01:24', '2025-06-15 07:01:24'),
(150, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:01:25', '2025-06-15 07:01:25'),
(151, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:01:25', '2025-06-15 07:01:25'),
(152, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:01:26', '2025-06-15 07:01:26'),
(153, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:01:26', '2025-06-15 07:01:26'),
(154, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:01:26', '2025-06-15 07:01:26'),
(155, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:01:26', '2025-06-15 07:01:26'),
(156, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:01:26', '2025-06-15 07:01:26'),
(157, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:01:27', '2025-06-15 07:01:27'),
(158, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:01:28', '2025-06-15 07:01:28'),
(159, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:01:28', '2025-06-15 07:01:28'),
(160, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:01:29', '2025-06-15 07:01:29'),
(161, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:01:29', '2025-06-15 07:01:29'),
(162, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:01:30', '2025-06-15 07:01:30'),
(163, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:01:30', '2025-06-15 07:01:30'),
(164, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:01:30', '2025-06-15 07:01:30'),
(165, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:01:30', '2025-06-15 07:01:30'),
(166, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:01:31', '2025-06-15 07:01:31'),
(167, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:01:31', '2025-06-15 07:01:31'),
(168, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:01:32', '2025-06-15 07:01:32'),
(169, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:01:32', '2025-06-15 07:01:32'),
(170, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:01:33', '2025-06-15 07:01:33'),
(171, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:01:33', '2025-06-15 07:01:33'),
(172, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:01:34', '2025-06-15 07:01:34'),
(173, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:01:34', '2025-06-15 07:01:34'),
(174, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:01:34', '2025-06-15 07:01:34'),
(175, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:01:34', '2025-06-15 07:01:34'),
(176, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:01:35', '2025-06-15 07:01:35'),
(177, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:01:35', '2025-06-15 07:01:35'),
(178, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:01:36', '2025-06-15 07:01:36'),
(179, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:01:36', '2025-06-15 07:01:36'),
(180, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:01:37', '2025-06-15 07:01:37'),
(181, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:01:37', '2025-06-15 07:01:37'),
(182, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:01:37', '2025-06-15 07:01:37'),
(183, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:01:37', '2025-06-15 07:01:37'),
(184, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:01:38', '2025-06-15 07:01:38'),
(185, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:01:38', '2025-06-15 07:01:38'),
(186, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:01:39', '2025-06-15 07:01:39'),
(187, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:01:39', '2025-06-15 07:01:39'),
(188, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:01:40', '2025-06-15 07:01:40'),
(189, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:01:40', '2025-06-15 07:01:40'),
(190, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:01:40', '2025-06-15 07:01:40'),
(191, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:01:40', '2025-06-15 07:01:40'),
(192, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:01:40', '2025-06-15 07:01:40'),
(193, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:01:41', '2025-06-15 07:01:41'),
(194, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:01:42', '2025-06-15 07:01:42'),
(195, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:01:42', '2025-06-15 07:01:42'),
(196, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:01:43', '2025-06-15 07:01:43'),
(197, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:01:43', '2025-06-15 07:01:43'),
(198, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:01:44', '2025-06-15 07:01:44'),
(199, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:01:44', '2025-06-15 07:01:44'),
(200, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:01:44', '2025-06-15 07:01:44'),
(201, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:01:44', '2025-06-15 07:01:44'),
(202, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:01:45', '2025-06-15 07:01:45'),
(203, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:01:45', '2025-06-15 07:01:45'),
(204, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:01:46', '2025-06-15 07:01:46'),
(205, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:01:46', '2025-06-15 07:01:46'),
(206, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:01:47', '2025-06-15 07:01:47'),
(207, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:01:47', '2025-06-15 07:01:47'),
(208, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:01:47', '2025-06-15 07:01:47'),
(209, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:01:47', '2025-06-15 07:01:47'),
(210, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:01:47', '2025-06-15 07:01:47'),
(211, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:01:48', '2025-06-15 07:01:48'),
(212, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:01:49', '2025-06-15 07:01:49'),
(213, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:01:49', '2025-06-15 07:01:49'),
(214, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:01:50', '2025-06-15 07:01:50'),
(215, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:01:50', '2025-06-15 07:01:50'),
(216, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:01:51', '2025-06-15 07:01:51'),
(217, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:01:51', '2025-06-15 07:01:51'),
(218, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:01:51', '2025-06-15 07:01:51'),
(219, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:01:51', '2025-06-15 07:01:51'),
(220, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:01:52', '2025-06-15 07:01:52'),
(221, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:01:52', '2025-06-15 07:01:52'),
(222, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:01:53', '2025-06-15 07:01:53'),
(223, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:01:53', '2025-06-15 07:01:53'),
(224, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:01:54', '2025-06-15 07:01:54'),
(225, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:01:54', '2025-06-15 07:01:54');
INSERT INTO `failed_import_rows` (`id`, `data`, `import_id`, `validation_error`, `created_at`, `updated_at`) VALUES
(226, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:01:54', '2025-06-15 07:01:54'),
(227, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:01:54', '2025-06-15 07:01:54'),
(228, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:01:54', '2025-06-15 07:01:54'),
(229, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:01:55', '2025-06-15 07:01:55'),
(230, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:01:56', '2025-06-15 07:01:56'),
(231, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:01:56', '2025-06-15 07:01:56'),
(232, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:01:57', '2025-06-15 07:01:57'),
(233, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:01:57', '2025-06-15 07:01:57'),
(234, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:01:58', '2025-06-15 07:01:58'),
(235, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:01:58', '2025-06-15 07:01:58'),
(236, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:01:58', '2025-06-15 07:01:58'),
(237, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:01:58', '2025-06-15 07:01:58'),
(238, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:01:58', '2025-06-15 07:01:58'),
(239, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:01:59', '2025-06-15 07:01:59'),
(240, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:01:59', '2025-06-15 07:01:59'),
(241, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:02:00', '2025-06-15 07:02:00'),
(242, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:02:01', '2025-06-15 07:02:01'),
(243, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:02:01', '2025-06-15 07:02:01'),
(244, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:02:01', '2025-06-15 07:02:01'),
(245, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:02:01', '2025-06-15 07:02:01'),
(246, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:02:01', '2025-06-15 07:02:01'),
(247, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:02:02', '2025-06-15 07:02:02'),
(248, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:02:02', '2025-06-15 07:02:02'),
(249, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:02:03', '2025-06-15 07:02:03'),
(250, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:02:03', '2025-06-15 07:02:03'),
(251, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:02:04', '2025-06-15 07:02:04'),
(252, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:02:04', '2025-06-15 07:02:04'),
(253, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:02:04', '2025-06-15 07:02:04'),
(254, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:02:04', '2025-06-15 07:02:04'),
(255, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:02:04', '2025-06-15 07:02:04'),
(256, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:02:05', '2025-06-15 07:02:05'),
(257, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:02:05', '2025-06-15 07:02:05'),
(258, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:02:06', '2025-06-15 07:02:06'),
(259, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:02:07', '2025-06-15 07:02:07'),
(260, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:02:07', '2025-06-15 07:02:07'),
(261, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:02:08', '2025-06-15 07:02:08'),
(262, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:02:08', '2025-06-15 07:02:08'),
(263, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:02:08', '2025-06-15 07:02:08'),
(264, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:02:08', '2025-06-15 07:02:08'),
(265, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:02:08', '2025-06-15 07:02:08'),
(266, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:02:09', '2025-06-15 07:02:09'),
(267, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:02:10', '2025-06-15 07:02:10'),
(268, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:02:10', '2025-06-15 07:02:10'),
(269, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:02:11', '2025-06-15 07:02:11'),
(270, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:02:11', '2025-06-15 07:02:11'),
(271, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:02:11', '2025-06-15 07:02:11'),
(272, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:02:11', '2025-06-15 07:02:11'),
(273, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:02:11', '2025-06-15 07:02:11'),
(274, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:02:12', '2025-06-15 07:02:12'),
(275, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:02:12', '2025-06-15 07:02:12'),
(276, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:02:13', '2025-06-15 07:02:13'),
(277, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:02:13', '2025-06-15 07:02:13'),
(278, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:02:14', '2025-06-15 07:02:14'),
(279, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:02:14', '2025-06-15 07:02:14'),
(280, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:02:14', '2025-06-15 07:02:14'),
(281, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:02:14', '2025-06-15 07:02:14'),
(282, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:02:14', '2025-06-15 07:02:14'),
(283, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:02:15', '2025-06-15 07:02:15'),
(284, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:02:16', '2025-06-15 07:02:16'),
(285, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:02:16', '2025-06-15 07:02:16'),
(286, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:02:17', '2025-06-15 07:02:17'),
(287, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:02:17', '2025-06-15 07:02:17'),
(288, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:02:18', '2025-06-15 07:02:18'),
(289, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:02:18', '2025-06-15 07:02:18'),
(290, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:02:18', '2025-06-15 07:02:18'),
(291, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:02:18', '2025-06-15 07:02:18'),
(292, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:02:18', '2025-06-15 07:02:18'),
(293, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:02:19', '2025-06-15 07:02:19'),
(294, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:02:20', '2025-06-15 07:02:20'),
(295, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:02:20', '2025-06-15 07:02:20'),
(296, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:02:21', '2025-06-15 07:02:21'),
(297, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:02:21', '2025-06-15 07:02:21'),
(298, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:02:21', '2025-06-15 07:02:21'),
(299, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:02:21', '2025-06-15 07:02:21'),
(300, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:02:21', '2025-06-15 07:02:21'),
(301, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:02:22', '2025-06-15 07:02:22'),
(302, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:02:22', '2025-06-15 07:02:22'),
(303, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:02:23', '2025-06-15 07:02:23'),
(304, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:02:23', '2025-06-15 07:02:23'),
(305, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:02:24', '2025-06-15 07:02:24'),
(306, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:02:25', '2025-06-15 07:02:25'),
(307, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:02:25', '2025-06-15 07:02:25'),
(308, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:02:25', '2025-06-15 07:02:25'),
(309, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:02:25', '2025-06-15 07:02:25'),
(310, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:02:25', '2025-06-15 07:02:25'),
(311, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:02:26', '2025-06-15 07:02:26'),
(312, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:02:26', '2025-06-15 07:02:26'),
(313, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:02:27', '2025-06-15 07:02:27'),
(314, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:02:27', '2025-06-15 07:02:27'),
(315, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:02:28', '2025-06-15 07:02:28'),
(316, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:02:28', '2025-06-15 07:02:28'),
(317, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:02:28', '2025-06-15 07:02:28'),
(318, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:02:28', '2025-06-15 07:02:28'),
(319, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:02:28', '2025-06-15 07:02:28'),
(320, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:02:29', '2025-06-15 07:02:29'),
(321, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:02:29', '2025-06-15 07:02:29'),
(322, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:02:30', '2025-06-15 07:02:30'),
(323, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:02:31', '2025-06-15 07:02:31'),
(324, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:02:31', '2025-06-15 07:02:31'),
(325, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:02:31', '2025-06-15 07:02:31'),
(326, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:02:31', '2025-06-15 07:02:31'),
(327, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:02:31', '2025-06-15 07:02:31'),
(328, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:02:32', '2025-06-15 07:02:32'),
(329, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:02:32', '2025-06-15 07:02:32'),
(330, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:02:33', '2025-06-15 07:02:33'),
(331, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:02:33', '2025-06-15 07:02:33'),
(332, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:02:34', '2025-06-15 07:02:34'),
(333, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:02:35', '2025-06-15 07:02:35'),
(334, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:02:35', '2025-06-15 07:02:35'),
(335, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:02:35', '2025-06-15 07:02:35'),
(336, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:02:35', '2025-06-15 07:02:35'),
(337, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:02:35', '2025-06-15 07:02:35'),
(338, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:02:36', '2025-06-15 07:02:36'),
(339, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:02:36', '2025-06-15 07:02:36'),
(340, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:02:37', '2025-06-15 07:02:37'),
(341, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:02:37', '2025-06-15 07:02:37'),
(342, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:02:38', '2025-06-15 07:02:38'),
(343, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:02:38', '2025-06-15 07:02:38'),
(344, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:02:38', '2025-06-15 07:02:38'),
(345, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:02:38', '2025-06-15 07:02:38'),
(346, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:02:39', '2025-06-15 07:02:39'),
(347, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:02:39', '2025-06-15 07:02:39'),
(348, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:02:40', '2025-06-15 07:02:40'),
(349, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:02:40', '2025-06-15 07:02:40'),
(350, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:02:41', '2025-06-15 07:02:41'),
(351, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:02:41', '2025-06-15 07:02:41'),
(352, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:02:41', '2025-06-15 07:02:41'),
(353, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:02:41', '2025-06-15 07:02:41'),
(354, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:02:41', '2025-06-15 07:02:41'),
(355, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:02:42', '2025-06-15 07:02:42'),
(356, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:02:42', '2025-06-15 07:02:42'),
(357, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:02:43', '2025-06-15 07:02:43'),
(358, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:02:43', '2025-06-15 07:02:43'),
(359, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:02:44', '2025-06-15 07:02:44'),
(360, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:02:44', '2025-06-15 07:02:44'),
(361, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:02:45', '2025-06-15 07:02:45'),
(362, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:02:45', '2025-06-15 07:02:45'),
(363, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:02:45', '2025-06-15 07:02:45'),
(364, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:02:45', '2025-06-15 07:02:45'),
(365, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:02:46', '2025-06-15 07:02:46'),
(366, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:02:46', '2025-06-15 07:02:46'),
(367, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:02:47', '2025-06-15 07:02:47'),
(368, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:02:47', '2025-06-15 07:02:47'),
(369, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:02:48', '2025-06-15 07:02:48'),
(370, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:02:48', '2025-06-15 07:02:48'),
(371, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:02:48', '2025-06-15 07:02:48'),
(372, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:02:48', '2025-06-15 07:02:48'),
(373, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:02:49', '2025-06-15 07:02:49'),
(374, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:02:49', '2025-06-15 07:02:49'),
(375, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:02:50', '2025-06-15 07:02:50'),
(376, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:02:50', '2025-06-15 07:02:50'),
(377, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:02:51', '2025-06-15 07:02:51'),
(378, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:02:51', '2025-06-15 07:02:51'),
(379, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:02:51', '2025-06-15 07:02:51'),
(380, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:02:51', '2025-06-15 07:02:51'),
(381, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:02:51', '2025-06-15 07:02:51'),
(382, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:02:52', '2025-06-15 07:02:52'),
(383, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:02:53', '2025-06-15 07:02:53'),
(384, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:02:53', '2025-06-15 07:02:53'),
(385, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:02:54', '2025-06-15 07:02:54'),
(386, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:02:54', '2025-06-15 07:02:54'),
(387, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:02:55', '2025-06-15 07:02:55'),
(388, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:02:55', '2025-06-15 07:02:55'),
(389, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:02:55', '2025-06-15 07:02:55'),
(390, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:02:55', '2025-06-15 07:02:55'),
(391, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:02:55', '2025-06-15 07:02:55'),
(392, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:02:56', '2025-06-15 07:02:56'),
(393, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:02:56', '2025-06-15 07:02:56'),
(394, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:02:56', '2025-06-15 07:02:56'),
(395, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:02:57', '2025-06-15 07:02:57'),
(396, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:02:58', '2025-06-15 07:02:58'),
(397, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:02:58', '2025-06-15 07:02:58'),
(398, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:02:58', '2025-06-15 07:02:58'),
(399, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:02:58', '2025-06-15 07:02:58'),
(400, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:02:58', '2025-06-15 07:02:58'),
(401, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:02:59', '2025-06-15 07:02:59'),
(402, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:02:59', '2025-06-15 07:02:59'),
(403, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:03:00', '2025-06-15 07:03:00'),
(404, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:03:00', '2025-06-15 07:03:00'),
(405, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:03:01', '2025-06-15 07:03:01'),
(406, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:03:01', '2025-06-15 07:03:01'),
(407, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:03:01', '2025-06-15 07:03:01'),
(408, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:03:01', '2025-06-15 07:03:01'),
(409, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:03:01', '2025-06-15 07:03:01'),
(410, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:03:02', '2025-06-15 07:03:02'),
(411, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:03:02', '2025-06-15 07:03:02'),
(412, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:03:03', '2025-06-15 07:03:03'),
(413, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:03:04', '2025-06-15 07:03:04'),
(414, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:03:04', '2025-06-15 07:03:04'),
(415, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:03:04', '2025-06-15 07:03:04'),
(416, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:03:04', '2025-06-15 07:03:04'),
(417, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:03:04', '2025-06-15 07:03:04'),
(418, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:03:05', '2025-06-15 07:03:05'),
(419, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:03:05', '2025-06-15 07:03:05'),
(420, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:03:06', '2025-06-15 07:03:06'),
(421, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:03:07', '2025-06-15 07:03:07'),
(422, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:03:07', '2025-06-15 07:03:07'),
(423, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:03:08', '2025-06-15 07:03:08'),
(424, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:03:08', '2025-06-15 07:03:08'),
(425, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:03:08', '2025-06-15 07:03:08'),
(426, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:03:08', '2025-06-15 07:03:08'),
(427, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:03:08', '2025-06-15 07:03:08'),
(428, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:03:09', '2025-06-15 07:03:09'),
(429, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:03:09', '2025-06-15 07:03:09'),
(430, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:03:10', '2025-06-15 07:03:10'),
(431, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:03:10', '2025-06-15 07:03:10'),
(432, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:03:11', '2025-06-15 07:03:11'),
(433, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:03:11', '2025-06-15 07:03:11'),
(434, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:03:11', '2025-06-15 07:03:11'),
(435, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:03:11', '2025-06-15 07:03:11'),
(436, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:03:11', '2025-06-15 07:03:11'),
(437, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:03:12', '2025-06-15 07:03:12'),
(438, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:03:13', '2025-06-15 07:03:13'),
(439, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:03:13', '2025-06-15 07:03:13'),
(440, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:03:14', '2025-06-15 07:03:14'),
(441, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:03:14', '2025-06-15 07:03:14'),
(442, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:03:14', '2025-06-15 07:03:14'),
(443, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:03:14', '2025-06-15 07:03:14'),
(444, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:03:14', '2025-06-15 07:03:14'),
(445, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:03:15', '2025-06-15 07:03:15'),
(446, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:03:16', '2025-06-15 07:03:16'),
(447, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:03:16', '2025-06-15 07:03:16'),
(448, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:03:17', '2025-06-15 07:03:17'),
(449, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:03:17', '2025-06-15 07:03:17'),
(450, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:03:18', '2025-06-15 07:03:18');
INSERT INTO `failed_import_rows` (`id`, `data`, `import_id`, `validation_error`, `created_at`, `updated_at`) VALUES
(451, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:03:18', '2025-06-15 07:03:18'),
(452, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:03:18', '2025-06-15 07:03:18'),
(453, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:03:18', '2025-06-15 07:03:18'),
(454, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:03:19', '2025-06-15 07:03:19'),
(455, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:03:19', '2025-06-15 07:03:19'),
(456, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:03:20', '2025-06-15 07:03:20'),
(457, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:03:21', '2025-06-15 07:03:21'),
(458, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:03:21', '2025-06-15 07:03:21'),
(459, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:03:22', '2025-06-15 07:03:22'),
(460, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:03:22', '2025-06-15 07:03:22'),
(461, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:03:22', '2025-06-15 07:03:22'),
(462, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:03:22', '2025-06-15 07:03:22'),
(463, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:03:23', '2025-06-15 07:03:23'),
(464, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:03:23', '2025-06-15 07:03:23'),
(465, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:03:24', '2025-06-15 07:03:24'),
(466, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:03:24', '2025-06-15 07:03:24'),
(467, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:03:25', '2025-06-15 07:03:25'),
(468, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:03:26', '2025-06-15 07:03:26'),
(469, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:03:26', '2025-06-15 07:03:26'),
(470, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:03:26', '2025-06-15 07:03:26'),
(471, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:03:26', '2025-06-15 07:03:26'),
(472, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:03:26', '2025-06-15 07:03:26'),
(473, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:03:27', '2025-06-15 07:03:27'),
(474, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:03:28', '2025-06-15 07:03:28'),
(475, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:03:28', '2025-06-15 07:03:28'),
(476, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:03:29', '2025-06-15 07:03:29'),
(477, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:03:29', '2025-06-15 07:03:29'),
(478, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:03:29', '2025-06-15 07:03:29'),
(479, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:03:29', '2025-06-15 07:03:29'),
(480, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:03:29', '2025-06-15 07:03:29'),
(481, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:03:30', '2025-06-15 07:03:30'),
(482, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:03:30', '2025-06-15 07:03:30'),
(483, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:03:31', '2025-06-15 07:03:31'),
(484, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:03:32', '2025-06-15 07:03:32'),
(485, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:03:32', '2025-06-15 07:03:32'),
(486, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:03:33', '2025-06-15 07:03:33'),
(487, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:03:33', '2025-06-15 07:03:33'),
(488, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:03:33', '2025-06-15 07:03:33'),
(489, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:03:33', '2025-06-15 07:03:33'),
(490, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:03:33', '2025-06-15 07:03:33'),
(491, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:03:34', '2025-06-15 07:03:34'),
(492, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:03:34', '2025-06-15 07:03:34'),
(493, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:03:35', '2025-06-15 07:03:35'),
(494, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:03:35', '2025-06-15 07:03:35'),
(495, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:03:36', '2025-06-15 07:03:36'),
(496, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:03:36', '2025-06-15 07:03:36'),
(497, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:03:36', '2025-06-15 07:03:36'),
(498, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:03:36', '2025-06-15 07:03:36'),
(499, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:03:36', '2025-06-15 07:03:36'),
(500, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:03:37', '2025-06-15 07:03:37'),
(501, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:03:37', '2025-06-15 07:03:37'),
(502, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:03:38', '2025-06-15 07:03:38'),
(503, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:03:39', '2025-06-15 07:03:39'),
(504, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:03:39', '2025-06-15 07:03:39'),
(505, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:03:39', '2025-06-15 07:03:39'),
(506, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:03:39', '2025-06-15 07:03:39'),
(507, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:03:39', '2025-06-15 07:03:39'),
(508, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:03:40', '2025-06-15 07:03:40'),
(509, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:03:40', '2025-06-15 07:03:40'),
(510, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:03:41', '2025-06-15 07:03:41'),
(511, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:03:41', '2025-06-15 07:03:41'),
(512, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:03:42', '2025-06-15 07:03:42'),
(513, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:03:42', '2025-06-15 07:03:42'),
(514, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:03:43', '2025-06-15 07:03:43'),
(515, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:03:43', '2025-06-15 07:03:43'),
(516, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:03:43', '2025-06-15 07:03:43'),
(517, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:03:43', '2025-06-15 07:03:43'),
(518, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:03:44', '2025-06-15 07:03:44'),
(519, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:03:44', '2025-06-15 07:03:44'),
(520, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:03:45', '2025-06-15 07:03:45'),
(521, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:03:45', '2025-06-15 07:03:45'),
(522, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:03:46', '2025-06-15 07:03:46'),
(523, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:03:46', '2025-06-15 07:03:46'),
(524, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:03:46', '2025-06-15 07:03:46'),
(525, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:03:46', '2025-06-15 07:03:46'),
(526, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:03:46', '2025-06-15 07:03:46'),
(527, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:03:47', '2025-06-15 07:03:47'),
(528, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:03:48', '2025-06-15 07:03:48'),
(529, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:03:48', '2025-06-15 07:03:48'),
(530, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:03:49', '2025-06-15 07:03:49'),
(531, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:03:49', '2025-06-15 07:03:49'),
(532, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:03:49', '2025-06-15 07:03:49'),
(533, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:03:49', '2025-06-15 07:03:49'),
(534, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:03:49', '2025-06-15 07:03:49'),
(535, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:03:50', '2025-06-15 07:03:50'),
(536, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:03:51', '2025-06-15 07:03:51'),
(537, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:03:51', '2025-06-15 07:03:51'),
(538, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:03:52', '2025-06-15 07:03:52'),
(539, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:03:52', '2025-06-15 07:03:52'),
(540, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:03:53', '2025-06-15 07:03:53'),
(541, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:03:53', '2025-06-15 07:03:53'),
(542, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:03:53', '2025-06-15 07:03:53'),
(543, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:03:53', '2025-06-15 07:03:53'),
(544, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:03:53', '2025-06-15 07:03:53'),
(545, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:03:54', '2025-06-15 07:03:54'),
(546, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:03:54', '2025-06-15 07:03:54'),
(547, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:03:55', '2025-06-15 07:03:55'),
(548, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:03:56', '2025-06-15 07:03:56'),
(549, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:03:56', '2025-06-15 07:03:56'),
(550, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:03:56', '2025-06-15 07:03:56'),
(551, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:03:56', '2025-06-15 07:03:56'),
(552, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:03:56', '2025-06-15 07:03:56'),
(553, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:03:57', '2025-06-15 07:03:57'),
(554, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:03:57', '2025-06-15 07:03:57'),
(555, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:03:58', '2025-06-15 07:03:58'),
(556, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:03:58', '2025-06-15 07:03:58'),
(557, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:03:59', '2025-06-15 07:03:59'),
(558, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:03:59', '2025-06-15 07:03:59'),
(559, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:03:59', '2025-06-15 07:03:59'),
(560, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:03:59', '2025-06-15 07:03:59'),
(561, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:03:59', '2025-06-15 07:03:59'),
(562, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:04:00', '2025-06-15 07:04:00'),
(563, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:04:00', '2025-06-15 07:04:00'),
(564, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:04:01', '2025-06-15 07:04:01'),
(565, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:04:02', '2025-06-15 07:04:02'),
(566, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:04:02', '2025-06-15 07:04:02'),
(567, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:04:03', '2025-06-15 07:04:03'),
(568, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:04:03', '2025-06-15 07:04:03'),
(569, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:04:03', '2025-06-15 07:04:03'),
(570, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:04:03', '2025-06-15 07:04:03'),
(571, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:04:03', '2025-06-15 07:04:03'),
(572, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:04:04', '2025-06-15 07:04:04'),
(573, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:04:04', '2025-06-15 07:04:04'),
(574, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:04:05', '2025-06-15 07:04:05'),
(575, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:04:05', '2025-06-15 07:04:05'),
(576, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:04:06', '2025-06-15 07:04:06'),
(577, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:04:06', '2025-06-15 07:04:06'),
(578, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:04:06', '2025-06-15 07:04:06'),
(579, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:04:06', '2025-06-15 07:04:06'),
(580, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:04:07', '2025-06-15 07:04:07'),
(581, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:04:07', '2025-06-15 07:04:07'),
(582, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:04:08', '2025-06-15 07:04:08'),
(583, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:04:08', '2025-06-15 07:04:08'),
(584, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:04:09', '2025-06-15 07:04:09'),
(585, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:04:09', '2025-06-15 07:04:09'),
(586, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:04:09', '2025-06-15 07:04:09'),
(587, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:04:09', '2025-06-15 07:04:09'),
(588, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:04:09', '2025-06-15 07:04:09'),
(589, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:04:10', '2025-06-15 07:04:10'),
(590, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:04:11', '2025-06-15 07:04:11'),
(591, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:04:11', '2025-06-15 07:04:11'),
(592, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:04:12', '2025-06-15 07:04:12'),
(593, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:04:12', '2025-06-15 07:04:12'),
(594, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:04:13', '2025-06-15 07:04:13'),
(595, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:04:13', '2025-06-15 07:04:13'),
(596, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:04:13', '2025-06-15 07:04:13'),
(597, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:04:13', '2025-06-15 07:04:13'),
(598, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:04:13', '2025-06-15 07:04:13'),
(599, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:04:14', '2025-06-15 07:04:14'),
(600, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:04:15', '2025-06-15 07:04:15'),
(601, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:04:15', '2025-06-15 07:04:15'),
(602, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:04:16', '2025-06-15 07:04:16'),
(603, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:04:16', '2025-06-15 07:04:16'),
(604, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:04:16', '2025-06-15 07:04:16'),
(605, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:04:16', '2025-06-15 07:04:16'),
(606, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:04:16', '2025-06-15 07:04:16'),
(607, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:04:17', '2025-06-15 07:04:17'),
(608, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:04:18', '2025-06-15 07:04:18'),
(609, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:04:18', '2025-06-15 07:04:18'),
(610, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:04:19', '2025-06-15 07:04:19'),
(611, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:04:19', '2025-06-15 07:04:19'),
(612, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:04:20', '2025-06-15 07:04:20'),
(613, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:04:20', '2025-06-15 07:04:20'),
(614, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:04:20', '2025-06-15 07:04:20'),
(615, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:04:20', '2025-06-15 07:04:20'),
(616, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:04:20', '2025-06-15 07:04:20'),
(617, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:04:21', '2025-06-15 07:04:21'),
(618, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:04:21', '2025-06-15 07:04:21'),
(619, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:04:22', '2025-06-15 07:04:22'),
(620, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:04:22', '2025-06-15 07:04:22'),
(621, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:04:23', '2025-06-15 07:04:23'),
(622, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:04:23', '2025-06-15 07:04:23'),
(623, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:04:23', '2025-06-15 07:04:23'),
(624, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:04:23', '2025-06-15 07:04:23'),
(625, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:04:23', '2025-06-15 07:04:23'),
(626, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:04:24', '2025-06-15 07:04:24'),
(627, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:04:24', '2025-06-15 07:04:24'),
(628, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:04:25', '2025-06-15 07:04:25'),
(629, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:04:26', '2025-06-15 07:04:26'),
(630, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:04:26', '2025-06-15 07:04:26'),
(631, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:04:26', '2025-06-15 07:04:26'),
(632, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:04:26', '2025-06-15 07:04:26'),
(633, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:04:26', '2025-06-15 07:04:26'),
(634, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:04:27', '2025-06-15 07:04:27'),
(635, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:04:27', '2025-06-15 07:04:27'),
(636, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:04:28', '2025-06-15 07:04:28'),
(637, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:04:29', '2025-06-15 07:04:29'),
(638, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:04:29', '2025-06-15 07:04:29'),
(639, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:04:30', '2025-06-15 07:04:30'),
(640, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:04:30', '2025-06-15 07:04:30'),
(641, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:04:30', '2025-06-15 07:04:30'),
(642, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:04:30', '2025-06-15 07:04:30'),
(643, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:04:30', '2025-06-15 07:04:30'),
(644, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:04:31', '2025-06-15 07:04:31'),
(645, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:04:31', '2025-06-15 07:04:31'),
(646, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:04:32', '2025-06-15 07:04:32'),
(647, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:04:32', '2025-06-15 07:04:32'),
(648, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:04:33', '2025-06-15 07:04:33'),
(649, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:04:33', '2025-06-15 07:04:33'),
(650, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:04:33', '2025-06-15 07:04:33'),
(651, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:04:33', '2025-06-15 07:04:33'),
(652, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:04:33', '2025-06-15 07:04:33'),
(653, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:04:34', '2025-06-15 07:04:34'),
(654, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:04:35', '2025-06-15 07:04:35'),
(655, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:04:35', '2025-06-15 07:04:35'),
(656, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:04:36', '2025-06-15 07:04:36'),
(657, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:04:36', '2025-06-15 07:04:36'),
(658, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:04:37', '2025-06-15 07:04:37'),
(659, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:04:37', '2025-06-15 07:04:37'),
(660, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:04:37', '2025-06-15 07:04:37'),
(661, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:04:37', '2025-06-15 07:04:37'),
(662, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:04:38', '2025-06-15 07:04:38'),
(663, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:04:38', '2025-06-15 07:04:38'),
(664, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:04:39', '2025-06-15 07:04:39'),
(665, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:04:39', '2025-06-15 07:04:39'),
(666, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:04:40', '2025-06-15 07:04:40'),
(667, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:04:40', '2025-06-15 07:04:40'),
(668, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:04:40', '2025-06-15 07:04:40'),
(669, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:04:40', '2025-06-15 07:04:40'),
(670, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:04:41', '2025-06-15 07:04:41'),
(671, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:04:41', '2025-06-15 07:04:41'),
(672, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:04:42', '2025-06-15 07:04:42'),
(673, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:04:42', '2025-06-15 07:04:42'),
(674, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:04:43', '2025-06-15 07:04:43'),
(675, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:04:44', '2025-06-15 07:04:44');
INSERT INTO `failed_import_rows` (`id`, `data`, `import_id`, `validation_error`, `created_at`, `updated_at`) VALUES
(676, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:04:44', '2025-06-15 07:04:44'),
(677, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:04:44', '2025-06-15 07:04:44'),
(678, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:04:44', '2025-06-15 07:04:44'),
(679, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:04:44', '2025-06-15 07:04:44'),
(680, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:04:45', '2025-06-15 07:04:45'),
(681, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:04:45', '2025-06-15 07:04:45'),
(682, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:04:46', '2025-06-15 07:04:46'),
(683, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:04:46', '2025-06-15 07:04:46'),
(684, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:04:47', '2025-06-15 07:04:47'),
(685, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:04:47', '2025-06-15 07:04:47'),
(686, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:04:47', '2025-06-15 07:04:47'),
(687, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:04:47', '2025-06-15 07:04:47'),
(688, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:04:47', '2025-06-15 07:04:47'),
(689, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:04:48', '2025-06-15 07:04:48'),
(690, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:04:48', '2025-06-15 07:04:48'),
(691, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:04:49', '2025-06-15 07:04:49'),
(692, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:04:49', '2025-06-15 07:04:49'),
(693, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:04:50', '2025-06-15 07:04:50'),
(694, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:04:50', '2025-06-15 07:04:50'),
(695, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:04:50', '2025-06-15 07:04:50'),
(696, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:04:50', '2025-06-15 07:04:50'),
(697, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:04:51', '2025-06-15 07:04:51'),
(698, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:04:51', '2025-06-15 07:04:51'),
(699, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:04:52', '2025-06-15 07:04:52'),
(700, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:04:52', '2025-06-15 07:04:52'),
(701, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:04:53', '2025-06-15 07:04:53'),
(702, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:04:53', '2025-06-15 07:04:53'),
(703, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:04:53', '2025-06-15 07:04:53'),
(704, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:04:53', '2025-06-15 07:04:53'),
(705, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:04:53', '2025-06-15 07:04:53'),
(706, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:04:54', '2025-06-15 07:04:54'),
(707, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:04:54', '2025-06-15 07:04:54'),
(708, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:04:55', '2025-06-15 07:04:55'),
(709, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:04:56', '2025-06-15 07:04:56'),
(710, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:04:56', '2025-06-15 07:04:56'),
(711, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:04:57', '2025-06-15 07:04:57'),
(712, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:04:57', '2025-06-15 07:04:57'),
(713, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:04:57', '2025-06-15 07:04:57'),
(714, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:04:57', '2025-06-15 07:04:57'),
(715, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:04:57', '2025-06-15 07:04:57'),
(716, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:04:58', '2025-06-15 07:04:58'),
(717, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:04:58', '2025-06-15 07:04:58'),
(718, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:04:59', '2025-06-15 07:04:59'),
(719, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:04:59', '2025-06-15 07:04:59'),
(720, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:05:00', '2025-06-15 07:05:00'),
(721, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:05:01', '2025-06-15 07:05:01'),
(722, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:05:01', '2025-06-15 07:05:01'),
(723, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:05:01', '2025-06-15 07:05:01'),
(724, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:05:01', '2025-06-15 07:05:01'),
(725, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:05:02', '2025-06-15 07:05:02'),
(726, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:05:03', '2025-06-15 07:05:03'),
(727, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:05:03', '2025-06-15 07:05:03'),
(728, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:05:04', '2025-06-15 07:05:04'),
(729, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:05:04', '2025-06-15 07:05:04'),
(730, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:05:04', '2025-06-15 07:05:04'),
(731, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:05:04', '2025-06-15 07:05:04'),
(732, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:05:04', '2025-06-15 07:05:04'),
(733, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:05:05', '2025-06-15 07:05:05'),
(734, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:05:05', '2025-06-15 07:05:05'),
(735, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:05:06', '2025-06-15 07:05:06'),
(736, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:05:07', '2025-06-15 07:05:07'),
(737, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:05:07', '2025-06-15 07:05:07'),
(738, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:05:08', '2025-06-15 07:05:08'),
(739, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:05:08', '2025-06-15 07:05:08'),
(740, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:05:08', '2025-06-15 07:05:08'),
(741, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:05:08', '2025-06-15 07:05:08'),
(742, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:05:08', '2025-06-15 07:05:08'),
(743, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:05:09', '2025-06-15 07:05:09'),
(744, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:05:09', '2025-06-15 07:05:09'),
(745, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:05:10', '2025-06-15 07:05:10'),
(746, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:05:10', '2025-06-15 07:05:10'),
(747, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:05:11', '2025-06-15 07:05:11'),
(748, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:05:11', '2025-06-15 07:05:11'),
(749, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:05:11', '2025-06-15 07:05:11'),
(750, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:05:11', '2025-06-15 07:05:11'),
(751, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:05:11', '2025-06-15 07:05:11'),
(752, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:05:12', '2025-06-15 07:05:12'),
(753, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:05:12', '2025-06-15 07:05:12'),
(754, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:05:13', '2025-06-15 07:05:13'),
(755, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:05:13', '2025-06-15 07:05:13'),
(756, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:05:14', '2025-06-15 07:05:14'),
(757, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:05:14', '2025-06-15 07:05:14'),
(758, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:05:14', '2025-06-15 07:05:14'),
(759, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:05:14', '2025-06-15 07:05:14'),
(760, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:05:14', '2025-06-15 07:05:14'),
(761, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:05:15', '2025-06-15 07:05:15'),
(762, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:05:16', '2025-06-15 07:05:16'),
(763, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:05:16', '2025-06-15 07:05:16'),
(764, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:05:17', '2025-06-15 07:05:17'),
(765, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:05:17', '2025-06-15 07:05:17'),
(766, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:05:17', '2025-06-15 07:05:17'),
(767, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:05:17', '2025-06-15 07:05:17'),
(768, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:05:17', '2025-06-15 07:05:17'),
(769, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:05:18', '2025-06-15 07:05:18'),
(770, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:05:18', '2025-06-15 07:05:18'),
(771, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:05:19', '2025-06-15 07:05:19'),
(772, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:05:20', '2025-06-15 07:05:20'),
(773, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:05:20', '2025-06-15 07:05:20'),
(774, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:05:21', '2025-06-15 07:05:21'),
(775, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:05:21', '2025-06-15 07:05:21'),
(776, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:05:21', '2025-06-15 07:05:21'),
(777, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:05:21', '2025-06-15 07:05:21'),
(778, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:05:21', '2025-06-15 07:05:21'),
(779, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:05:22', '2025-06-15 07:05:22'),
(780, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:05:22', '2025-06-15 07:05:22'),
(781, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:05:23', '2025-06-15 07:05:23'),
(782, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:05:24', '2025-06-15 07:05:24'),
(783, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:05:24', '2025-06-15 07:05:24'),
(784, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:05:24', '2025-06-15 07:05:24'),
(785, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:05:24', '2025-06-15 07:05:24'),
(786, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:05:24', '2025-06-15 07:05:24'),
(787, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:05:25', '2025-06-15 07:05:25'),
(788, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:05:25', '2025-06-15 07:05:25'),
(789, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:05:26', '2025-06-15 07:05:26'),
(790, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:05:27', '2025-06-15 07:05:27'),
(791, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:05:27', '2025-06-15 07:05:27'),
(792, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:05:28', '2025-06-15 07:05:28'),
(793, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:05:28', '2025-06-15 07:05:28'),
(794, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:05:28', '2025-06-15 07:05:28'),
(795, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:05:28', '2025-06-15 07:05:28'),
(796, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:05:28', '2025-06-15 07:05:28'),
(797, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:05:29', '2025-06-15 07:05:29'),
(798, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:05:30', '2025-06-15 07:05:30'),
(799, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:05:30', '2025-06-15 07:05:30'),
(800, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:05:31', '2025-06-15 07:05:31'),
(801, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:05:31', '2025-06-15 07:05:31'),
(802, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:05:31', '2025-06-15 07:05:31'),
(803, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:05:31', '2025-06-15 07:05:31'),
(804, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:05:31', '2025-06-15 07:05:31'),
(805, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:05:32', '2025-06-15 07:05:32'),
(806, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:05:33', '2025-06-15 07:05:33'),
(807, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:05:33', '2025-06-15 07:05:33'),
(808, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:05:34', '2025-06-15 07:05:34'),
(809, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:05:34', '2025-06-15 07:05:34'),
(810, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:05:35', '2025-06-15 07:05:35'),
(811, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:05:35', '2025-06-15 07:05:35'),
(812, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:05:35', '2025-06-15 07:05:35'),
(813, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:05:35', '2025-06-15 07:05:35'),
(814, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:05:36', '2025-06-15 07:05:36'),
(815, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:05:36', '2025-06-15 07:05:36'),
(816, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:05:37', '2025-06-15 07:05:37'),
(817, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:05:37', '2025-06-15 07:05:37'),
(818, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:05:38', '2025-06-15 07:05:38'),
(819, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:05:38', '2025-06-15 07:05:38'),
(820, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:05:38', '2025-06-15 07:05:38'),
(821, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:05:38', '2025-06-15 07:05:38'),
(822, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:05:38', '2025-06-15 07:05:38'),
(823, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:05:39', '2025-06-15 07:05:39'),
(824, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:05:39', '2025-06-15 07:05:39'),
(825, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:05:40', '2025-06-15 07:05:40'),
(826, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:05:41', '2025-06-15 07:05:41'),
(827, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:05:41', '2025-06-15 07:05:41'),
(828, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:05:42', '2025-06-15 07:05:42'),
(829, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:05:42', '2025-06-15 07:05:42'),
(830, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:05:42', '2025-06-15 07:05:42'),
(831, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:05:42', '2025-06-15 07:05:42'),
(832, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:05:42', '2025-06-15 07:05:42'),
(833, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:05:43', '2025-06-15 07:05:43'),
(834, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:05:43', '2025-06-15 07:05:43'),
(835, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:05:44', '2025-06-15 07:05:44'),
(836, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:05:44', '2025-06-15 07:05:44'),
(837, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:05:45', '2025-06-15 07:05:45'),
(838, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:05:45', '2025-06-15 07:05:45'),
(839, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:05:45', '2025-06-15 07:05:45'),
(840, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:05:45', '2025-06-15 07:05:45'),
(841, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:05:45', '2025-06-15 07:05:45'),
(842, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:05:46', '2025-06-15 07:05:46'),
(843, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:05:46', '2025-06-15 07:05:46'),
(844, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:05:47', '2025-06-15 07:05:47'),
(845, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:05:47', '2025-06-15 07:05:47'),
(846, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:05:48', '2025-06-15 07:05:48'),
(847, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:05:48', '2025-06-15 07:05:48'),
(848, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:05:48', '2025-06-15 07:05:48'),
(849, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:05:48', '2025-06-15 07:05:48'),
(850, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:05:49', '2025-06-15 07:05:49'),
(851, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:05:49', '2025-06-15 07:05:49'),
(852, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:05:50', '2025-06-15 07:05:50'),
(853, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:05:50', '2025-06-15 07:05:50'),
(854, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:05:51', '2025-06-15 07:05:51'),
(855, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:05:51', '2025-06-15 07:05:51'),
(856, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:05:51', '2025-06-15 07:05:51'),
(857, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:05:51', '2025-06-15 07:05:51'),
(858, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:05:51', '2025-06-15 07:05:51'),
(859, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:05:52', '2025-06-15 07:05:52'),
(860, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:05:52', '2025-06-15 07:05:52'),
(861, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:05:53', '2025-06-15 07:05:53'),
(862, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:05:54', '2025-06-15 07:05:54'),
(863, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:05:54', '2025-06-15 07:05:54'),
(864, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:05:55', '2025-06-15 07:05:55'),
(865, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:05:55', '2025-06-15 07:05:55'),
(866, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:05:55', '2025-06-15 07:05:55'),
(867, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:05:55', '2025-06-15 07:05:55'),
(868, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:05:55', '2025-06-15 07:05:55'),
(869, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:05:56', '2025-06-15 07:05:56'),
(870, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:05:57', '2025-06-15 07:05:57'),
(871, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:05:57', '2025-06-15 07:05:57'),
(872, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:05:58', '2025-06-15 07:05:58'),
(873, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:05:58', '2025-06-15 07:05:58'),
(874, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:05:58', '2025-06-15 07:05:58'),
(875, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:05:58', '2025-06-15 07:05:58'),
(876, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:05:58', '2025-06-15 07:05:58'),
(877, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:05:59', '2025-06-15 07:05:59'),
(878, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:06:00', '2025-06-15 07:06:00'),
(879, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:06:00', '2025-06-15 07:06:00'),
(880, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:06:01', '2025-06-15 07:06:01'),
(881, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:06:02', '2025-06-15 07:06:02'),
(882, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:06:02', '2025-06-15 07:06:02'),
(883, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:06:02', '2025-06-15 07:06:02'),
(884, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:06:02', '2025-06-15 07:06:02'),
(885, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:06:02', '2025-06-15 07:06:02'),
(886, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:06:03', '2025-06-15 07:06:03'),
(887, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:06:03', '2025-06-15 07:06:03'),
(888, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:06:04', '2025-06-15 07:06:04'),
(889, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:06:04', '2025-06-15 07:06:04'),
(890, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:06:05', '2025-06-15 07:06:05'),
(891, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:06:05', '2025-06-15 07:06:05'),
(892, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:06:05', '2025-06-15 07:06:05'),
(893, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:06:05', '2025-06-15 07:06:05'),
(894, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:06:05', '2025-06-15 07:06:05'),
(895, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:06:06', '2025-06-15 07:06:06'),
(896, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:06:07', '2025-06-15 07:06:07'),
(897, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:06:07', '2025-06-15 07:06:07'),
(898, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:06:08', '2025-06-15 07:06:08'),
(899, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:06:08', '2025-06-15 07:06:08'),
(900, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:06:09', '2025-06-15 07:06:09');
INSERT INTO `failed_import_rows` (`id`, `data`, `import_id`, `validation_error`, `created_at`, `updated_at`) VALUES
(901, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:06:09', '2025-06-15 07:06:09'),
(902, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:06:09', '2025-06-15 07:06:09'),
(903, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:06:09', '2025-06-15 07:06:09'),
(904, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:06:09', '2025-06-15 07:06:09'),
(905, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:06:10', '2025-06-15 07:06:10'),
(906, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:06:10', '2025-06-15 07:06:10'),
(907, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:06:11', '2025-06-15 07:06:11'),
(908, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:06:12', '2025-06-15 07:06:12'),
(909, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:06:12', '2025-06-15 07:06:12'),
(910, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:06:12', '2025-06-15 07:06:12'),
(911, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:06:12', '2025-06-15 07:06:12'),
(912, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:06:12', '2025-06-15 07:06:12'),
(913, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:06:13', '2025-06-15 07:06:13'),
(914, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:06:13', '2025-06-15 07:06:13'),
(915, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:06:14', '2025-06-15 07:06:14'),
(916, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:06:15', '2025-06-15 07:06:15'),
(917, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:06:15', '2025-06-15 07:06:15'),
(918, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:06:16', '2025-06-15 07:06:16'),
(919, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:06:16', '2025-06-15 07:06:16'),
(920, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:06:16', '2025-06-15 07:06:16'),
(921, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:06:16', '2025-06-15 07:06:16'),
(922, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:06:16', '2025-06-15 07:06:16'),
(923, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:06:17', '2025-06-15 07:06:17'),
(924, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:06:17', '2025-06-15 07:06:17'),
(925, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:06:18', '2025-06-15 07:06:18'),
(926, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:06:19', '2025-06-15 07:06:19'),
(927, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:06:19', '2025-06-15 07:06:19'),
(928, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:06:19', '2025-06-15 07:06:19'),
(929, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:06:19', '2025-06-15 07:06:19'),
(930, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:06:19', '2025-06-15 07:06:19'),
(931, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:06:20', '2025-06-15 07:06:20'),
(932, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:06:21', '2025-06-15 07:06:21'),
(933, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:06:21', '2025-06-15 07:06:21'),
(934, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:06:22', '2025-06-15 07:06:22'),
(935, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:06:22', '2025-06-15 07:06:22'),
(936, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:06:23', '2025-06-15 07:06:23'),
(937, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:06:23', '2025-06-15 07:06:23'),
(938, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:06:23', '2025-06-15 07:06:23'),
(939, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:06:23', '2025-06-15 07:06:23'),
(940, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:06:23', '2025-06-15 07:06:23'),
(941, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:06:24', '2025-06-15 07:06:24'),
(942, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:06:25', '2025-06-15 07:06:25'),
(943, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:06:25', '2025-06-15 07:06:25'),
(944, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:06:26', '2025-06-15 07:06:26'),
(945, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:06:26', '2025-06-15 07:06:26'),
(946, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:06:26', '2025-06-15 07:06:26'),
(947, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:06:26', '2025-06-15 07:06:26'),
(948, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:06:26', '2025-06-15 07:06:26'),
(949, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:06:27', '2025-06-15 07:06:27'),
(950, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:06:28', '2025-06-15 07:06:28'),
(951, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:06:28', '2025-06-15 07:06:28'),
(952, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:06:29', '2025-06-15 07:06:29'),
(953, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:06:29', '2025-06-15 07:06:29'),
(954, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:06:30', '2025-06-15 07:06:30'),
(955, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:06:30', '2025-06-15 07:06:30'),
(956, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:06:30', '2025-06-15 07:06:30'),
(957, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:06:30', '2025-06-15 07:06:30'),
(958, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:06:30', '2025-06-15 07:06:30'),
(959, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:06:31', '2025-06-15 07:06:31'),
(960, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:06:32', '2025-06-15 07:06:32'),
(961, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:06:32', '2025-06-15 07:06:32'),
(962, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:06:33', '2025-06-15 07:06:33'),
(963, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:06:33', '2025-06-15 07:06:33'),
(964, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:06:33', '2025-06-15 07:06:33'),
(965, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:06:33', '2025-06-15 07:06:33'),
(966, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:06:33', '2025-06-15 07:06:33'),
(967, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:06:34', '2025-06-15 07:06:34'),
(968, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:06:35', '2025-06-15 07:06:35'),
(969, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:06:35', '2025-06-15 07:06:35'),
(970, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:06:36', '2025-06-15 07:06:36'),
(971, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:06:36', '2025-06-15 07:06:36'),
(972, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:06:37', '2025-06-15 07:06:37'),
(973, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:06:37', '2025-06-15 07:06:37'),
(974, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:06:37', '2025-06-15 07:06:37'),
(975, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:06:37', '2025-06-15 07:06:37'),
(976, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:06:37', '2025-06-15 07:06:37'),
(977, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:06:38', '2025-06-15 07:06:38'),
(978, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:06:39', '2025-06-15 07:06:39'),
(979, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:06:39', '2025-06-15 07:06:39'),
(980, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:06:40', '2025-06-15 07:06:40'),
(981, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:06:41', '2025-06-15 07:06:41'),
(982, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:06:41', '2025-06-15 07:06:41'),
(983, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:06:41', '2025-06-15 07:06:41'),
(984, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:06:41', '2025-06-15 07:06:41'),
(985, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:06:41', '2025-06-15 07:06:41'),
(986, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:06:42', '2025-06-15 07:06:42'),
(987, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:06:42', '2025-06-15 07:06:42'),
(988, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:06:43', '2025-06-15 07:06:43'),
(989, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:06:43', '2025-06-15 07:06:43'),
(990, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:06:44', '2025-06-15 07:06:44'),
(991, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:06:44', '2025-06-15 07:06:44'),
(992, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:06:44', '2025-06-15 07:06:44'),
(993, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:06:44', '2025-06-15 07:06:44'),
(994, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:06:45', '2025-06-15 07:06:45'),
(995, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:06:45', '2025-06-15 07:06:45'),
(996, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:06:46', '2025-06-15 07:06:46'),
(997, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:06:46', '2025-06-15 07:06:46'),
(998, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:06:47', '2025-06-15 07:06:47'),
(999, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:06:47', '2025-06-15 07:06:47'),
(1000, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:06:47', '2025-06-15 07:06:47'),
(1001, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:06:47', '2025-06-15 07:06:47'),
(1002, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:06:47', '2025-06-15 07:06:47'),
(1003, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:06:48', '2025-06-15 07:06:48'),
(1004, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:06:49', '2025-06-15 07:06:49'),
(1005, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:06:49', '2025-06-15 07:06:49'),
(1006, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:06:50', '2025-06-15 07:06:50'),
(1007, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:06:50', '2025-06-15 07:06:50'),
(1008, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:06:51', '2025-06-15 07:06:51'),
(1009, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:06:51', '2025-06-15 07:06:51'),
(1010, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:06:51', '2025-06-15 07:06:51'),
(1011, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:06:51', '2025-06-15 07:06:51'),
(1012, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:06:51', '2025-06-15 07:06:51'),
(1013, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:06:52', '2025-06-15 07:06:52'),
(1014, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:06:53', '2025-06-15 07:06:53'),
(1015, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:06:53', '2025-06-15 07:06:53'),
(1016, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:06:54', '2025-06-15 07:06:54'),
(1017, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:06:54', '2025-06-15 07:06:54'),
(1018, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:06:54', '2025-06-15 07:06:54'),
(1019, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:06:54', '2025-06-15 07:06:54'),
(1020, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:06:54', '2025-06-15 07:06:54'),
(1021, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:06:55', '2025-06-15 07:06:55'),
(1022, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:06:55', '2025-06-15 07:06:55'),
(1023, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:06:56', '2025-06-15 07:06:56'),
(1024, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:06:57', '2025-06-15 07:06:57'),
(1025, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:06:57', '2025-06-15 07:06:57'),
(1026, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:06:58', '2025-06-15 07:06:58'),
(1027, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:07:00', '2025-06-15 07:07:00'),
(1028, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:07:00', '2025-06-15 07:07:00'),
(1029, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:07:00', '2025-06-15 07:07:00'),
(1030, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:07:00', '2025-06-15 07:07:00'),
(1031, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:07:01', '2025-06-15 07:07:01'),
(1032, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:07:01', '2025-06-15 07:07:01'),
(1033, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:07:02', '2025-06-15 07:07:02'),
(1034, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:07:03', '2025-06-15 07:07:03'),
(1035, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:07:03', '2025-06-15 07:07:03'),
(1036, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:07:03', '2025-06-15 07:07:03'),
(1037, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:07:03', '2025-06-15 07:07:03'),
(1038, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:07:03', '2025-06-15 07:07:03'),
(1039, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:07:04', '2025-06-15 07:07:04'),
(1040, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:07:04', '2025-06-15 07:07:04'),
(1041, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:07:05', '2025-06-15 07:07:05'),
(1042, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:07:05', '2025-06-15 07:07:05'),
(1043, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:07:06', '2025-06-15 07:07:06'),
(1044, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:07:07', '2025-06-15 07:07:07'),
(1045, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:07:07', '2025-06-15 07:07:07'),
(1046, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:07:07', '2025-06-15 07:07:07'),
(1047, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:07:07', '2025-06-15 07:07:07'),
(1048, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:07:07', '2025-06-15 07:07:07'),
(1049, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:07:08', '2025-06-15 07:07:08'),
(1050, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:07:09', '2025-06-15 07:07:09'),
(1051, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:07:09', '2025-06-15 07:07:09'),
(1052, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:07:10', '2025-06-15 07:07:10'),
(1053, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:07:10', '2025-06-15 07:07:10'),
(1054, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:07:10', '2025-06-15 07:07:10'),
(1055, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:07:10', '2025-06-15 07:07:10'),
(1056, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:07:10', '2025-06-15 07:07:10'),
(1057, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:07:11', '2025-06-15 07:07:11'),
(1058, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:07:11', '2025-06-15 07:07:11'),
(1059, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:07:12', '2025-06-15 07:07:12'),
(1060, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:07:12', '2025-06-15 07:07:12'),
(1061, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:07:13', '2025-06-15 07:07:13'),
(1062, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:07:14', '2025-06-15 07:07:14'),
(1063, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:07:14', '2025-06-15 07:07:14'),
(1064, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:07:14', '2025-06-15 07:07:14'),
(1065, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:07:14', '2025-06-15 07:07:14'),
(1066, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:07:14', '2025-06-15 07:07:14'),
(1067, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:07:15', '2025-06-15 07:07:15'),
(1068, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:07:15', '2025-06-15 07:07:15'),
(1069, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:07:16', '2025-06-15 07:07:16'),
(1070, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:07:17', '2025-06-15 07:07:17'),
(1071, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:07:17', '2025-06-15 07:07:17'),
(1072, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:07:17', '2025-06-15 07:07:17'),
(1073, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:07:17', '2025-06-15 07:07:17'),
(1074, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:07:17', '2025-06-15 07:07:17'),
(1075, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:07:18', '2025-06-15 07:07:18'),
(1076, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:07:18', '2025-06-15 07:07:18'),
(1077, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:07:19', '2025-06-15 07:07:19'),
(1078, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:07:20', '2025-06-15 07:07:20'),
(1079, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:07:20', '2025-06-15 07:07:20'),
(1080, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:07:21', '2025-06-15 07:07:21'),
(1081, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:07:21', '2025-06-15 07:07:21'),
(1082, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:07:21', '2025-06-15 07:07:21'),
(1083, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:07:21', '2025-06-15 07:07:21'),
(1084, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:07:21', '2025-06-15 07:07:21'),
(1085, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:07:22', '2025-06-15 07:07:22'),
(1086, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:07:23', '2025-06-15 07:07:23'),
(1087, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:07:23', '2025-06-15 07:07:23'),
(1088, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:07:24', '2025-06-15 07:07:24'),
(1089, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:07:24', '2025-06-15 07:07:24'),
(1090, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:07:24', '2025-06-15 07:07:24'),
(1091, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:07:24', '2025-06-15 07:07:24'),
(1092, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:07:24', '2025-06-15 07:07:24'),
(1093, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:07:25', '2025-06-15 07:07:25'),
(1094, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:07:26', '2025-06-15 07:07:26'),
(1095, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:07:26', '2025-06-15 07:07:26'),
(1096, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:07:27', '2025-06-15 07:07:27'),
(1097, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:07:27', '2025-06-15 07:07:27'),
(1098, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:07:28', '2025-06-15 07:07:28'),
(1099, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:07:28', '2025-06-15 07:07:28'),
(1100, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:07:28', '2025-06-15 07:07:28'),
(1101, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:07:28', '2025-06-15 07:07:28'),
(1102, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:07:28', '2025-06-15 07:07:28'),
(1103, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:07:29', '2025-06-15 07:07:29'),
(1104, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:07:30', '2025-06-15 07:07:30'),
(1105, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:07:30', '2025-06-15 07:07:30'),
(1106, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:07:31', '2025-06-15 07:07:31'),
(1107, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:07:31', '2025-06-15 07:07:31'),
(1108, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:07:31', '2025-06-15 07:07:31'),
(1109, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:07:31', '2025-06-15 07:07:31'),
(1110, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:07:31', '2025-06-15 07:07:31'),
(1111, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:07:32', '2025-06-15 07:07:32'),
(1112, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:07:32', '2025-06-15 07:07:32'),
(1113, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:07:33', '2025-06-15 07:07:33'),
(1114, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:07:34', '2025-06-15 07:07:34'),
(1115, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:07:34', '2025-06-15 07:07:34'),
(1116, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:07:35', '2025-06-15 07:07:35'),
(1117, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:07:35', '2025-06-15 07:07:35'),
(1118, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:07:35', '2025-06-15 07:07:35'),
(1119, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:07:35', '2025-06-15 07:07:35'),
(1120, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:07:35', '2025-06-15 07:07:35'),
(1121, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:07:36', '2025-06-15 07:07:36'),
(1122, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:07:36', '2025-06-15 07:07:36'),
(1123, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:07:37', '2025-06-15 07:07:37'),
(1124, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:07:38', '2025-06-15 07:07:38');
INSERT INTO `failed_import_rows` (`id`, `data`, `import_id`, `validation_error`, `created_at`, `updated_at`) VALUES
(1125, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:07:38', '2025-06-15 07:07:38'),
(1126, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:07:38', '2025-06-15 07:07:38'),
(1127, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:07:38', '2025-06-15 07:07:38'),
(1128, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:07:38', '2025-06-15 07:07:38'),
(1129, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:07:39', '2025-06-15 07:07:39'),
(1130, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:07:39', '2025-06-15 07:07:39'),
(1131, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:07:40', '2025-06-15 07:07:40'),
(1132, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:07:40', '2025-06-15 07:07:40'),
(1133, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:07:41', '2025-06-15 07:07:41'),
(1134, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:07:42', '2025-06-15 07:07:42'),
(1135, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:07:42', '2025-06-15 07:07:42'),
(1136, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:07:42', '2025-06-15 07:07:42'),
(1137, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:07:42', '2025-06-15 07:07:42'),
(1138, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:07:42', '2025-06-15 07:07:42'),
(1139, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:07:43', '2025-06-15 07:07:43'),
(1140, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:07:43', '2025-06-15 07:07:43'),
(1141, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:07:44', '2025-06-15 07:07:44'),
(1142, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:07:44', '2025-06-15 07:07:44'),
(1143, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:07:45', '2025-06-15 07:07:45'),
(1144, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:07:45', '2025-06-15 07:07:45'),
(1145, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:07:45', '2025-06-15 07:07:45'),
(1146, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:07:45', '2025-06-15 07:07:45'),
(1147, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:07:46', '2025-06-15 07:07:46'),
(1148, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:07:46', '2025-06-15 07:07:46'),
(1149, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:07:47', '2025-06-15 07:07:47'),
(1150, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:07:47', '2025-06-15 07:07:47'),
(1151, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:07:48', '2025-06-15 07:07:48'),
(1152, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:07:49', '2025-06-15 07:07:49'),
(1153, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:07:49', '2025-06-15 07:07:49'),
(1154, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:07:49', '2025-06-15 07:07:49'),
(1155, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:07:49', '2025-06-15 07:07:49'),
(1156, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:07:49', '2025-06-15 07:07:49'),
(1157, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:07:50', '2025-06-15 07:07:50'),
(1158, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:07:51', '2025-06-15 07:07:51'),
(1159, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:07:51', '2025-06-15 07:07:51'),
(1160, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:07:52', '2025-06-15 07:07:52'),
(1161, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:07:53', '2025-06-15 07:07:53'),
(1162, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:07:53', '2025-06-15 07:07:53'),
(1163, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:07:53', '2025-06-15 07:07:53'),
(1164, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:07:53', '2025-06-15 07:07:53'),
(1165, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:07:53', '2025-06-15 07:07:53'),
(1166, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:07:54', '2025-06-15 07:07:54'),
(1167, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:07:54', '2025-06-15 07:07:54'),
(1168, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:07:55', '2025-06-15 07:07:55'),
(1169, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:07:56', '2025-06-15 07:07:56'),
(1170, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:07:56', '2025-06-15 07:07:56'),
(1171, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:07:56', '2025-06-15 07:07:56'),
(1172, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:07:56', '2025-06-15 07:07:56'),
(1173, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:07:56', '2025-06-15 07:07:56'),
(1174, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:07:57', '2025-06-15 07:07:57'),
(1175, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:07:58', '2025-06-15 07:07:58'),
(1176, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:07:59', '2025-06-15 07:07:59'),
(1177, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:07:59', '2025-06-15 07:07:59'),
(1178, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:08:00', '2025-06-15 07:08:00'),
(1179, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:08:01', '2025-06-15 07:08:01'),
(1180, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:08:01', '2025-06-15 07:08:01'),
(1181, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:08:01', '2025-06-15 07:08:01'),
(1182, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:08:01', '2025-06-15 07:08:01'),
(1183, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:08:01', '2025-06-15 07:08:01'),
(1184, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:08:02', '2025-06-15 07:08:02'),
(1185, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:08:02', '2025-06-15 07:08:02'),
(1186, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:08:03', '2025-06-15 07:08:03'),
(1187, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:08:04', '2025-06-15 07:08:04'),
(1188, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:08:04', '2025-06-15 07:08:04'),
(1189, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:08:04', '2025-06-15 07:08:04'),
(1190, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:08:04', '2025-06-15 07:08:04'),
(1191, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:08:04', '2025-06-15 07:08:04'),
(1192, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:08:05', '2025-06-15 07:08:05'),
(1193, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:08:05', '2025-06-15 07:08:05'),
(1194, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:08:06', '2025-06-15 07:08:06'),
(1195, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:08:07', '2025-06-15 07:08:07'),
(1196, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:08:07', '2025-06-15 07:08:07'),
(1197, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:08:08', '2025-06-15 07:08:08'),
(1198, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:08:10', '2025-06-15 07:08:10'),
(1199, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:08:10', '2025-06-15 07:08:10'),
(1200, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:08:10', '2025-06-15 07:08:10'),
(1201, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:08:10', '2025-06-15 07:08:10'),
(1202, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:08:11', '2025-06-15 07:08:11'),
(1203, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:08:12', '2025-06-15 07:08:12'),
(1204, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:08:12', '2025-06-15 07:08:12'),
(1205, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:08:13', '2025-06-15 07:08:13'),
(1206, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:08:13', '2025-06-15 07:08:13'),
(1207, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:08:13', '2025-06-15 07:08:13'),
(1208, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:08:13', '2025-06-15 07:08:13'),
(1209, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:08:13', '2025-06-15 07:08:13'),
(1210, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:08:14', '2025-06-15 07:08:14'),
(1211, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:08:14', '2025-06-15 07:08:14'),
(1212, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:08:15', '2025-06-15 07:08:15'),
(1213, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:08:16', '2025-06-15 07:08:16'),
(1214, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:08:16', '2025-06-15 07:08:16'),
(1215, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:08:17', '2025-06-15 07:08:17'),
(1216, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:08:17', '2025-06-15 07:08:17'),
(1217, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:08:17', '2025-06-15 07:08:17'),
(1218, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:08:17', '2025-06-15 07:08:17'),
(1219, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:08:18', '2025-06-15 07:08:18'),
(1220, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:08:18', '2025-06-15 07:08:18'),
(1221, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:08:19', '2025-06-15 07:08:19'),
(1222, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:08:19', '2025-06-15 07:08:19'),
(1223, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:08:20', '2025-06-15 07:08:20'),
(1224, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:08:20', '2025-06-15 07:08:20'),
(1225, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:08:20', '2025-06-15 07:08:20'),
(1226, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:08:20', '2025-06-15 07:08:20'),
(1227, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:08:20', '2025-06-15 07:08:20'),
(1228, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:08:21', '2025-06-15 07:08:21'),
(1229, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:08:22', '2025-06-15 07:08:22'),
(1230, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:08:22', '2025-06-15 07:08:22'),
(1231, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:08:23', '2025-06-15 07:08:23'),
(1232, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:08:23', '2025-06-15 07:08:23'),
(1233, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:08:24', '2025-06-15 07:08:24'),
(1234, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:08:24', '2025-06-15 07:08:24'),
(1235, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:08:24', '2025-06-15 07:08:24'),
(1236, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:08:24', '2025-06-15 07:08:24'),
(1237, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:08:24', '2025-06-15 07:08:24'),
(1238, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:08:25', '2025-06-15 07:08:25'),
(1239, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:08:26', '2025-06-15 07:08:26'),
(1240, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:08:26', '2025-06-15 07:08:26'),
(1241, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:08:27', '2025-06-15 07:08:27'),
(1242, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:08:27', '2025-06-15 07:08:27'),
(1243, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:08:27', '2025-06-15 07:08:27'),
(1244, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:08:27', '2025-06-15 07:08:27'),
(1245, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:08:27', '2025-06-15 07:08:27'),
(1246, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:08:28', '2025-06-15 07:08:28'),
(1247, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:08:29', '2025-06-15 07:08:29'),
(1248, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:08:29', '2025-06-15 07:08:29'),
(1249, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:08:30', '2025-06-15 07:08:30'),
(1250, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:08:30', '2025-06-15 07:08:30'),
(1251, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:08:31', '2025-06-15 07:08:31'),
(1252, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:08:31', '2025-06-15 07:08:31'),
(1253, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:08:31', '2025-06-15 07:08:31'),
(1254, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:08:31', '2025-06-15 07:08:31'),
(1255, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:08:31', '2025-06-15 07:08:31'),
(1256, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:08:32', '2025-06-15 07:08:32'),
(1257, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:08:32', '2025-06-15 07:08:32'),
(1258, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:08:33', '2025-06-15 07:08:33'),
(1259, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:08:34', '2025-06-15 07:08:34'),
(1260, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:08:34', '2025-06-15 07:08:34'),
(1261, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:08:34', '2025-06-15 07:08:34'),
(1262, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:08:34', '2025-06-15 07:08:34'),
(1263, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:08:34', '2025-06-15 07:08:34'),
(1264, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:08:35', '2025-06-15 07:08:35'),
(1265, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:08:35', '2025-06-15 07:08:35'),
(1266, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:08:36', '2025-06-15 07:08:36'),
(1267, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:08:36', '2025-06-15 07:08:36'),
(1268, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:08:37', '2025-06-15 07:08:37'),
(1269, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:08:37', '2025-06-15 07:08:37'),
(1270, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:08:37', '2025-06-15 07:08:37'),
(1271, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:08:37', '2025-06-15 07:08:37'),
(1272, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:08:37', '2025-06-15 07:08:37'),
(1273, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:08:38', '2025-06-15 07:08:38'),
(1274, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:08:38', '2025-06-15 07:08:38'),
(1275, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:08:39', '2025-06-15 07:08:39'),
(1276, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:08:40', '2025-06-15 07:08:40'),
(1277, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:08:40', '2025-06-15 07:08:40'),
(1278, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:08:41', '2025-06-15 07:08:41'),
(1279, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:08:41', '2025-06-15 07:08:41'),
(1280, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:08:41', '2025-06-15 07:08:41'),
(1281, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:08:41', '2025-06-15 07:08:41'),
(1282, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:08:41', '2025-06-15 07:08:41'),
(1283, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:08:42', '2025-06-15 07:08:42'),
(1284, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:08:43', '2025-06-15 07:08:43'),
(1285, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:08:43', '2025-06-15 07:08:43'),
(1286, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:08:44', '2025-06-15 07:08:44'),
(1287, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:08:44', '2025-06-15 07:08:44'),
(1288, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:08:44', '2025-06-15 07:08:44'),
(1289, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:08:44', '2025-06-15 07:08:44'),
(1290, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:08:44', '2025-06-15 07:08:44'),
(1291, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:08:45', '2025-06-15 07:08:45'),
(1292, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:08:45', '2025-06-15 07:08:45'),
(1293, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:08:46', '2025-06-15 07:08:46'),
(1294, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:08:47', '2025-06-15 07:08:47'),
(1295, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:08:47', '2025-06-15 07:08:47'),
(1296, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:08:48', '2025-06-15 07:08:48'),
(1297, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:08:48', '2025-06-15 07:08:48'),
(1298, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:08:48', '2025-06-15 07:08:48'),
(1299, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:08:48', '2025-06-15 07:08:48'),
(1300, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:08:48', '2025-06-15 07:08:48'),
(1301, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:08:49', '2025-06-15 07:08:49'),
(1302, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:08:49', '2025-06-15 07:08:49'),
(1303, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:08:50', '2025-06-15 07:08:50'),
(1304, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:08:50', '2025-06-15 07:08:50'),
(1305, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:08:51', '2025-06-15 07:08:51'),
(1306, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:08:51', '2025-06-15 07:08:51'),
(1307, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:08:51', '2025-06-15 07:08:51'),
(1308, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:08:51', '2025-06-15 07:08:51'),
(1309, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:08:52', '2025-06-15 07:08:52'),
(1310, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:08:52', '2025-06-15 07:08:52'),
(1311, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:08:53', '2025-06-15 07:08:53'),
(1312, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:08:53', '2025-06-15 07:08:53'),
(1313, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:08:54', '2025-06-15 07:08:54'),
(1314, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:08:55', '2025-06-15 07:08:55'),
(1315, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:08:55', '2025-06-15 07:08:55'),
(1316, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:08:55', '2025-06-15 07:08:55'),
(1317, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:08:55', '2025-06-15 07:08:55'),
(1318, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:08:55', '2025-06-15 07:08:55'),
(1319, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:08:56', '2025-06-15 07:08:56'),
(1320, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:08:56', '2025-06-15 07:08:56'),
(1321, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:08:57', '2025-06-15 07:08:57'),
(1322, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:08:57', '2025-06-15 07:08:57'),
(1323, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:08:58', '2025-06-15 07:08:58'),
(1324, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:08:58', '2025-06-15 07:08:58'),
(1325, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:08:58', '2025-06-15 07:08:58'),
(1326, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:08:58', '2025-06-15 07:08:58'),
(1327, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:08:59', '2025-06-15 07:08:59'),
(1328, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:08:59', '2025-06-15 07:08:59'),
(1329, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:09:00', '2025-06-15 07:09:00'),
(1330, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:09:00', '2025-06-15 07:09:00'),
(1331, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:09:01', '2025-06-15 07:09:01'),
(1332, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:09:01', '2025-06-15 07:09:01'),
(1333, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:09:01', '2025-06-15 07:09:01'),
(1334, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:09:01', '2025-06-15 07:09:01'),
(1335, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:09:01', '2025-06-15 07:09:01'),
(1336, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:09:02', '2025-06-15 07:09:02'),
(1337, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:09:03', '2025-06-15 07:09:03'),
(1338, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:09:03', '2025-06-15 07:09:03'),
(1339, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:09:04', '2025-06-15 07:09:04'),
(1340, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:09:04', '2025-06-15 07:09:04'),
(1341, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:09:05', '2025-06-15 07:09:05'),
(1342, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:09:05', '2025-06-15 07:09:05'),
(1343, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:09:05', '2025-06-15 07:09:05'),
(1344, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:09:05', '2025-06-15 07:09:05'),
(1345, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:09:06', '2025-06-15 07:09:06'),
(1346, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:09:06', '2025-06-15 07:09:06'),
(1347, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:09:07', '2025-06-15 07:09:07'),
(1348, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:09:07', '2025-06-15 07:09:07');
INSERT INTO `failed_import_rows` (`id`, `data`, `import_id`, `validation_error`, `created_at`, `updated_at`) VALUES
(1349, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:09:08', '2025-06-15 07:09:08'),
(1350, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:09:09', '2025-06-15 07:09:09'),
(1351, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:09:09', '2025-06-15 07:09:09'),
(1352, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:09:09', '2025-06-15 07:09:09'),
(1353, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:09:09', '2025-06-15 07:09:09'),
(1354, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:09:09', '2025-06-15 07:09:09'),
(1355, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:09:10', '2025-06-15 07:09:10'),
(1356, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:09:10', '2025-06-15 07:09:10'),
(1357, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:09:11', '2025-06-15 07:09:11'),
(1358, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:09:11', '2025-06-15 07:09:11'),
(1359, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:09:12', '2025-06-15 07:09:12'),
(1360, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:09:12', '2025-06-15 07:09:12'),
(1361, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:09:12', '2025-06-15 07:09:12'),
(1362, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:09:12', '2025-06-15 07:09:12'),
(1363, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:09:13', '2025-06-15 07:09:13'),
(1364, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:09:13', '2025-06-15 07:09:13'),
(1365, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:09:14', '2025-06-15 07:09:14'),
(1366, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:09:14', '2025-06-15 07:09:14'),
(1367, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:09:15', '2025-06-15 07:09:15'),
(1368, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:09:15', '2025-06-15 07:09:15'),
(1369, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:09:15', '2025-06-15 07:09:15'),
(1370, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:09:15', '2025-06-15 07:09:15'),
(1371, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:09:15', '2025-06-15 07:09:15'),
(1372, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:09:16', '2025-06-15 07:09:16'),
(1373, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:09:16', '2025-06-15 07:09:16'),
(1374, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:09:17', '2025-06-15 07:09:17'),
(1375, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:09:17', '2025-06-15 07:09:17'),
(1376, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:09:18', '2025-06-15 07:09:18'),
(1377, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:09:18', '2025-06-15 07:09:18'),
(1378, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:09:18', '2025-06-15 07:09:18'),
(1379, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:09:19', '2025-06-15 07:09:19'),
(1380, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:09:19', '2025-06-15 07:09:19'),
(1381, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:09:19', '2025-06-15 07:09:19'),
(1382, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:09:20', '2025-06-15 07:09:20'),
(1383, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:09:20', '2025-06-15 07:09:20'),
(1384, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:09:21', '2025-06-15 07:09:21'),
(1385, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:09:21', '2025-06-15 07:09:21'),
(1386, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:09:22', '2025-06-15 07:09:22'),
(1387, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:09:22', '2025-06-15 07:09:22'),
(1388, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:09:22', '2025-06-15 07:09:22'),
(1389, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:09:22', '2025-06-15 07:09:22'),
(1390, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:09:22', '2025-06-15 07:09:22'),
(1391, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:09:23', '2025-06-15 07:09:23'),
(1392, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:09:23', '2025-06-15 07:09:23'),
(1393, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:09:24', '2025-06-15 07:09:24'),
(1394, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:09:24', '2025-06-15 07:09:24'),
(1395, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:09:25', '2025-06-15 07:09:25'),
(1396, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:09:25', '2025-06-15 07:09:25'),
(1397, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:09:25', '2025-06-15 07:09:25'),
(1398, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:09:25', '2025-06-15 07:09:25'),
(1399, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:09:25', '2025-06-15 07:09:25'),
(1400, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:09:26', '2025-06-15 07:09:26'),
(1401, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:09:26', '2025-06-15 07:09:26'),
(1402, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:09:27', '2025-06-15 07:09:27'),
(1403, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:09:27', '2025-06-15 07:09:27'),
(1404, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:09:28', '2025-06-15 07:09:28'),
(1405, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:09:28', '2025-06-15 07:09:28'),
(1406, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:09:28', '2025-06-15 07:09:28'),
(1407, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:09:28', '2025-06-15 07:09:28'),
(1408, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:09:29', '2025-06-15 07:09:29'),
(1409, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:09:29', '2025-06-15 07:09:29'),
(1410, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:09:30', '2025-06-15 07:09:30'),
(1411, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:09:30', '2025-06-15 07:09:30'),
(1412, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:09:31', '2025-06-15 07:09:31'),
(1413, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:09:31', '2025-06-15 07:09:31'),
(1414, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:09:31', '2025-06-15 07:09:31'),
(1415, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:09:31', '2025-06-15 07:09:31'),
(1416, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:09:31', '2025-06-15 07:09:31'),
(1417, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:09:32', '2025-06-15 07:09:32'),
(1418, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:09:32', '2025-06-15 07:09:32'),
(1419, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:09:33', '2025-06-15 07:09:33'),
(1420, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:09:34', '2025-06-15 07:09:34'),
(1421, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:09:34', '2025-06-15 07:09:34'),
(1422, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:09:35', '2025-06-15 07:09:35'),
(1423, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:09:35', '2025-06-15 07:09:35'),
(1424, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:09:35', '2025-06-15 07:09:35'),
(1425, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:09:35', '2025-06-15 07:09:35'),
(1426, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:09:35', '2025-06-15 07:09:35'),
(1427, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:09:36', '2025-06-15 07:09:36'),
(1428, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:09:36', '2025-06-15 07:09:36'),
(1429, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:09:37', '2025-06-15 07:09:37'),
(1430, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:09:38', '2025-06-15 07:09:38'),
(1431, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:09:38', '2025-06-15 07:09:38'),
(1432, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:09:38', '2025-06-15 07:09:38'),
(1433, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:09:38', '2025-06-15 07:09:38'),
(1434, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:09:38', '2025-06-15 07:09:38'),
(1435, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:09:39', '2025-06-15 07:09:39'),
(1436, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:09:39', '2025-06-15 07:09:39'),
(1437, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:09:40', '2025-06-15 07:09:40'),
(1438, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:09:40', '2025-06-15 07:09:40'),
(1439, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:09:41', '2025-06-15 07:09:41'),
(1440, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:09:41', '2025-06-15 07:09:41'),
(1441, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:09:41', '2025-06-15 07:09:41'),
(1442, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:09:41', '2025-06-15 07:09:41'),
(1443, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:09:41', '2025-06-15 07:09:41'),
(1444, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:09:42', '2025-06-15 07:09:42'),
(1445, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:09:42', '2025-06-15 07:09:42'),
(1446, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:09:43', '2025-06-15 07:09:43'),
(1447, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:09:43', '2025-06-15 07:09:43'),
(1448, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:09:44', '2025-06-15 07:09:44'),
(1449, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:09:44', '2025-06-15 07:09:44'),
(1450, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:09:44', '2025-06-15 07:09:44'),
(1451, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:09:44', '2025-06-15 07:09:44'),
(1452, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:09:44', '2025-06-15 07:09:44'),
(1453, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:09:45', '2025-06-15 07:09:45'),
(1454, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:09:45', '2025-06-15 07:09:45'),
(1455, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:09:46', '2025-06-15 07:09:46'),
(1456, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:09:46', '2025-06-15 07:09:46'),
(1457, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:09:47', '2025-06-15 07:09:47'),
(1458, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:09:48', '2025-06-15 07:09:48'),
(1459, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:09:48', '2025-06-15 07:09:48'),
(1460, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:09:48', '2025-06-15 07:09:48'),
(1461, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:09:48', '2025-06-15 07:09:48'),
(1462, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:09:48', '2025-06-15 07:09:48'),
(1463, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:09:49', '2025-06-15 07:09:49'),
(1464, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:09:49', '2025-06-15 07:09:49'),
(1465, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:09:50', '2025-06-15 07:09:50'),
(1466, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:09:50', '2025-06-15 07:09:50'),
(1467, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:09:51', '2025-06-15 07:09:51'),
(1468, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:09:51', '2025-06-15 07:09:51'),
(1469, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:09:51', '2025-06-15 07:09:51'),
(1470, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:09:51', '2025-06-15 07:09:51'),
(1471, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:09:52', '2025-06-15 07:09:52'),
(1472, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:09:52', '2025-06-15 07:09:52'),
(1473, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:09:53', '2025-06-15 07:09:53'),
(1474, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:09:54', '2025-06-15 07:09:54'),
(1475, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:09:54', '2025-06-15 07:09:54'),
(1476, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:09:55', '2025-06-15 07:09:55'),
(1477, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:09:55', '2025-06-15 07:09:55'),
(1478, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:09:55', '2025-06-15 07:09:55'),
(1479, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:09:55', '2025-06-15 07:09:55'),
(1480, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:09:55', '2025-06-15 07:09:55'),
(1481, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:09:56', '2025-06-15 07:09:56'),
(1482, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:09:56', '2025-06-15 07:09:56'),
(1483, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:09:57', '2025-06-15 07:09:57'),
(1484, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:09:57', '2025-06-15 07:09:57'),
(1485, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:09:58', '2025-06-15 07:09:58'),
(1486, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:09:58', '2025-06-15 07:09:58'),
(1487, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:09:58', '2025-06-15 07:09:58'),
(1488, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:09:58', '2025-06-15 07:09:58'),
(1489, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:09:59', '2025-06-15 07:09:59'),
(1490, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:09:59', '2025-06-15 07:09:59'),
(1491, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:10:00', '2025-06-15 07:10:00'),
(1492, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:10:00', '2025-06-15 07:10:00'),
(1493, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:10:01', '2025-06-15 07:10:01'),
(1494, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:10:02', '2025-06-15 07:10:02'),
(1495, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:10:02', '2025-06-15 07:10:02'),
(1496, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:10:02', '2025-06-15 07:10:02'),
(1497, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:10:02', '2025-06-15 07:10:02'),
(1498, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:10:02', '2025-06-15 07:10:02'),
(1499, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:10:03', '2025-06-15 07:10:03'),
(1500, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:10:03', '2025-06-15 07:10:03'),
(1501, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:10:04', '2025-06-15 07:10:04'),
(1502, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:10:04', '2025-06-15 07:10:04'),
(1503, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:10:05', '2025-06-15 07:10:05'),
(1504, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:10:05', '2025-06-15 07:10:05'),
(1505, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:10:05', '2025-06-15 07:10:05'),
(1506, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:10:05', '2025-06-15 07:10:05'),
(1507, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:10:05', '2025-06-15 07:10:05'),
(1508, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:10:06', '2025-06-15 07:10:06'),
(1509, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:10:07', '2025-06-15 07:10:07'),
(1510, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:10:07', '2025-06-15 07:10:07'),
(1511, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:10:08', '2025-06-15 07:10:08'),
(1512, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:10:08', '2025-06-15 07:10:08'),
(1513, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:10:08', '2025-06-15 07:10:08'),
(1514, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:10:08', '2025-06-15 07:10:08'),
(1515, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:10:08', '2025-06-15 07:10:08'),
(1516, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:10:09', '2025-06-15 07:10:09'),
(1517, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:10:10', '2025-06-15 07:10:10'),
(1518, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:10:10', '2025-06-15 07:10:10'),
(1519, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:10:11', '2025-06-15 07:10:11'),
(1520, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:10:11', '2025-06-15 07:10:11'),
(1521, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:10:12', '2025-06-15 07:10:12'),
(1522, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:10:12', '2025-06-15 07:10:12'),
(1523, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:10:12', '2025-06-15 07:10:12'),
(1524, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:10:12', '2025-06-15 07:10:12'),
(1525, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:10:12', '2025-06-15 07:10:12'),
(1526, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:10:13', '2025-06-15 07:10:13'),
(1527, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:10:13', '2025-06-15 07:10:13'),
(1528, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:10:14', '2025-06-15 07:10:14'),
(1529, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:10:14', '2025-06-15 07:10:14'),
(1530, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:10:15', '2025-06-15 07:10:15'),
(1531, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:10:15', '2025-06-15 07:10:15'),
(1532, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:10:15', '2025-06-15 07:10:15'),
(1533, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:10:15', '2025-06-15 07:10:15'),
(1534, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:10:16', '2025-06-15 07:10:16'),
(1535, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:10:16', '2025-06-15 07:10:16'),
(1536, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:10:17', '2025-06-15 07:10:17'),
(1537, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:10:17', '2025-06-15 07:10:17'),
(1538, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:10:18', '2025-06-15 07:10:18'),
(1539, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:10:19', '2025-06-15 07:10:19'),
(1540, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:10:19', '2025-06-15 07:10:19'),
(1541, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:10:19', '2025-06-15 07:10:19'),
(1542, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:10:19', '2025-06-15 07:10:19'),
(1543, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:10:19', '2025-06-15 07:10:19'),
(1544, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:10:20', '2025-06-15 07:10:20'),
(1545, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:10:20', '2025-06-15 07:10:20'),
(1546, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:10:21', '2025-06-15 07:10:21'),
(1547, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:10:22', '2025-06-15 07:10:22'),
(1548, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:10:22', '2025-06-15 07:10:22'),
(1549, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:10:22', '2025-06-15 07:10:22'),
(1550, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:10:22', '2025-06-15 07:10:22'),
(1551, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:10:22', '2025-06-15 07:10:22'),
(1552, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:10:23', '2025-06-15 07:10:23'),
(1553, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:10:23', '2025-06-15 07:10:23'),
(1554, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:10:24', '2025-06-15 07:10:24'),
(1555, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:10:25', '2025-06-15 07:10:25'),
(1556, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:10:25', '2025-06-15 07:10:25'),
(1557, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:10:26', '2025-06-15 07:10:26'),
(1558, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:10:26', '2025-06-15 07:10:26'),
(1559, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:10:26', '2025-06-15 07:10:26'),
(1560, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:10:26', '2025-06-15 07:10:26'),
(1561, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:10:26', '2025-06-15 07:10:26'),
(1562, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:10:27', '2025-06-15 07:10:27'),
(1563, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:10:27', '2025-06-15 07:10:27'),
(1564, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:10:28', '2025-06-15 07:10:28'),
(1565, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:10:28', '2025-06-15 07:10:28'),
(1566, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:10:29', '2025-06-15 07:10:29'),
(1567, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:10:29', '2025-06-15 07:10:29'),
(1568, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:10:29', '2025-06-15 07:10:29'),
(1569, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:10:29', '2025-06-15 07:10:29'),
(1570, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:10:29', '2025-06-15 07:10:29'),
(1571, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:10:30', '2025-06-15 07:10:30'),
(1572, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:10:30', '2025-06-15 07:10:30');
INSERT INTO `failed_import_rows` (`id`, `data`, `import_id`, `validation_error`, `created_at`, `updated_at`) VALUES
(1573, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:10:31', '2025-06-15 07:10:31'),
(1574, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:10:31', '2025-06-15 07:10:31'),
(1575, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:10:32', '2025-06-15 07:10:32'),
(1576, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:10:32', '2025-06-15 07:10:32'),
(1577, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:10:32', '2025-06-15 07:10:32'),
(1578, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:10:32', '2025-06-15 07:10:32'),
(1579, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:10:33', '2025-06-15 07:10:33'),
(1580, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:10:33', '2025-06-15 07:10:33'),
(1581, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:10:34', '2025-06-15 07:10:34'),
(1582, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:10:35', '2025-06-15 07:10:35'),
(1583, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:10:35', '2025-06-15 07:10:35'),
(1584, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:10:36', '2025-06-15 07:10:36'),
(1585, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:10:36', '2025-06-15 07:10:36'),
(1586, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:10:36', '2025-06-15 07:10:36'),
(1587, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:10:36', '2025-06-15 07:10:36'),
(1588, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:10:36', '2025-06-15 07:10:36'),
(1589, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:10:37', '2025-06-15 07:10:37'),
(1590, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:10:37', '2025-06-15 07:10:37'),
(1591, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:10:38', '2025-06-15 07:10:38'),
(1592, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:10:39', '2025-06-15 07:10:39'),
(1593, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:10:39', '2025-06-15 07:10:39'),
(1594, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:10:39', '2025-06-15 07:10:39'),
(1595, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:10:39', '2025-06-15 07:10:39'),
(1596, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:10:39', '2025-06-15 07:10:39'),
(1597, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:10:40', '2025-06-15 07:10:40'),
(1598, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:10:40', '2025-06-15 07:10:40'),
(1599, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:10:41', '2025-06-15 07:10:41'),
(1600, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:10:42', '2025-06-15 07:10:42'),
(1601, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:10:42', '2025-06-15 07:10:42'),
(1602, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:10:43', '2025-06-15 07:10:43'),
(1603, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:10:43', '2025-06-15 07:10:43'),
(1604, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:10:43', '2025-06-15 07:10:43'),
(1605, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:10:43', '2025-06-15 07:10:43'),
(1606, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:10:43', '2025-06-15 07:10:43'),
(1607, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:10:44', '2025-06-15 07:10:44'),
(1608, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:10:44', '2025-06-15 07:10:44'),
(1609, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:10:45', '2025-06-15 07:10:45'),
(1610, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:10:45', '2025-06-15 07:10:45'),
(1611, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:10:46', '2025-06-15 07:10:46'),
(1612, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:10:46', '2025-06-15 07:10:46'),
(1613, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:10:46', '2025-06-15 07:10:46'),
(1614, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:10:46', '2025-06-15 07:10:46'),
(1615, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:10:46', '2025-06-15 07:10:46'),
(1616, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:10:47', '2025-06-15 07:10:47'),
(1617, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:10:47', '2025-06-15 07:10:47'),
(1618, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:10:48', '2025-06-15 07:10:48'),
(1619, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:10:49', '2025-06-15 07:10:49'),
(1620, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:10:49', '2025-06-15 07:10:49'),
(1621, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:10:49', '2025-06-15 07:10:49'),
(1622, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:10:49', '2025-06-15 07:10:49'),
(1623, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:10:49', '2025-06-15 07:10:49'),
(1624, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:10:50', '2025-06-15 07:10:50'),
(1625, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:10:50', '2025-06-15 07:10:50'),
(1626, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:10:51', '2025-06-15 07:10:51'),
(1627, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:10:52', '2025-06-15 07:10:52'),
(1628, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:10:52', '2025-06-15 07:10:52'),
(1629, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:10:53', '2025-06-15 07:10:53'),
(1630, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:10:53', '2025-06-15 07:10:53'),
(1631, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:10:53', '2025-06-15 07:10:53'),
(1632, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:10:53', '2025-06-15 07:10:53'),
(1633, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:10:53', '2025-06-15 07:10:53'),
(1634, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:10:54', '2025-06-15 07:10:54'),
(1635, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:10:54', '2025-06-15 07:10:54'),
(1636, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:10:55', '2025-06-15 07:10:55'),
(1637, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:10:55', '2025-06-15 07:10:55'),
(1638, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:10:56', '2025-06-15 07:10:56'),
(1639, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:10:56', '2025-06-15 07:10:56'),
(1640, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:10:56', '2025-06-15 07:10:56'),
(1641, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:10:56', '2025-06-15 07:10:56'),
(1642, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:10:56', '2025-06-15 07:10:56'),
(1643, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:10:57', '2025-06-15 07:10:57'),
(1644, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:10:57', '2025-06-15 07:10:57'),
(1645, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:10:58', '2025-06-15 07:10:58'),
(1646, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:10:59', '2025-06-15 07:10:59'),
(1647, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:10:59', '2025-06-15 07:10:59'),
(1648, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:10:59', '2025-06-15 07:10:59'),
(1649, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:10:59', '2025-06-15 07:10:59'),
(1650, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:10:59', '2025-06-15 07:10:59'),
(1651, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:11:00', '2025-06-15 07:11:00'),
(1652, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:11:00', '2025-06-15 07:11:00'),
(1653, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:11:01', '2025-06-15 07:11:01'),
(1654, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:11:02', '2025-06-15 07:11:02'),
(1655, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:11:02', '2025-06-15 07:11:02'),
(1656, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:11:03', '2025-06-15 07:11:03'),
(1657, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:11:03', '2025-06-15 07:11:03'),
(1658, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:11:03', '2025-06-15 07:11:03'),
(1659, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:11:03', '2025-06-15 07:11:03'),
(1660, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:11:03', '2025-06-15 07:11:03'),
(1661, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:11:04', '2025-06-15 07:11:04'),
(1662, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:11:04', '2025-06-15 07:11:04'),
(1663, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:11:05', '2025-06-15 07:11:05'),
(1664, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:11:06', '2025-06-15 07:11:06'),
(1665, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:11:06', '2025-06-15 07:11:06'),
(1666, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:11:06', '2025-06-15 07:11:06'),
(1667, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:11:06', '2025-06-15 07:11:06'),
(1668, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:11:06', '2025-06-15 07:11:06'),
(1669, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:11:07', '2025-06-15 07:11:07'),
(1670, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:11:07', '2025-06-15 07:11:07'),
(1671, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:11:08', '2025-06-15 07:11:08'),
(1672, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:11:09', '2025-06-15 07:11:09'),
(1673, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:11:09', '2025-06-15 07:11:09'),
(1674, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:11:10', '2025-06-15 07:11:10'),
(1675, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:11:10', '2025-06-15 07:11:10'),
(1676, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:11:10', '2025-06-15 07:11:10'),
(1677, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:11:10', '2025-06-15 07:11:10'),
(1678, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:11:10', '2025-06-15 07:11:10'),
(1679, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:11:11', '2025-06-15 07:11:11'),
(1680, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:11:11', '2025-06-15 07:11:11'),
(1681, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:11:12', '2025-06-15 07:11:12'),
(1682, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:11:13', '2025-06-15 07:11:13'),
(1683, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:11:13', '2025-06-15 07:11:13'),
(1684, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:11:13', '2025-06-15 07:11:13'),
(1685, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:11:13', '2025-06-15 07:11:13'),
(1686, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:11:13', '2025-06-15 07:11:13'),
(1687, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:11:14', '2025-06-15 07:11:14'),
(1688, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:11:14', '2025-06-15 07:11:14'),
(1689, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:11:15', '2025-06-15 07:11:15'),
(1690, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:11:15', '2025-06-15 07:11:15'),
(1691, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:11:16', '2025-06-15 07:11:16'),
(1692, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:11:16', '2025-06-15 07:11:16'),
(1693, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:11:16', '2025-06-15 07:11:16'),
(1694, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:11:16', '2025-06-15 07:11:16'),
(1695, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:11:16', '2025-06-15 07:11:16'),
(1696, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:11:17', '2025-06-15 07:11:17'),
(1697, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:11:18', '2025-06-15 07:11:18'),
(1698, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:11:18', '2025-06-15 07:11:18'),
(1699, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:11:19', '2025-06-15 07:11:19'),
(1700, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:11:19', '2025-06-15 07:11:19'),
(1701, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:11:20', '2025-06-15 07:11:20'),
(1702, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:11:20', '2025-06-15 07:11:20'),
(1703, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:11:20', '2025-06-15 07:11:20'),
(1704, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:11:20', '2025-06-15 07:11:20'),
(1705, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:11:20', '2025-06-15 07:11:20'),
(1706, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:11:21', '2025-06-15 07:11:21'),
(1707, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:11:22', '2025-06-15 07:11:22'),
(1708, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:11:22', '2025-06-15 07:11:22'),
(1709, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:11:23', '2025-06-15 07:11:23'),
(1710, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:11:23', '2025-06-15 07:11:23'),
(1711, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:11:23', '2025-06-15 07:11:23'),
(1712, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:11:23', '2025-06-15 07:11:23'),
(1713, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:11:23', '2025-06-15 07:11:23'),
(1714, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:11:24', '2025-06-15 07:11:24'),
(1715, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:11:25', '2025-06-15 07:11:25'),
(1716, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:11:25', '2025-06-15 07:11:25'),
(1717, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:11:26', '2025-06-15 07:11:26'),
(1718, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:11:26', '2025-06-15 07:11:26'),
(1719, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:11:27', '2025-06-15 07:11:27'),
(1720, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:11:27', '2025-06-15 07:11:27'),
(1721, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:11:27', '2025-06-15 07:11:27'),
(1722, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:11:27', '2025-06-15 07:11:27'),
(1723, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:11:27', '2025-06-15 07:11:27'),
(1724, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:11:28', '2025-06-15 07:11:28'),
(1725, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:11:28', '2025-06-15 07:11:28'),
(1726, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:11:29', '2025-06-15 07:11:29'),
(1727, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:11:30', '2025-06-15 07:11:30'),
(1728, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:11:30', '2025-06-15 07:11:30'),
(1729, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:11:30', '2025-06-15 07:11:30'),
(1730, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:11:30', '2025-06-15 07:11:30'),
(1731, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:11:30', '2025-06-15 07:11:30'),
(1732, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:11:31', '2025-06-15 07:11:31'),
(1733, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:11:31', '2025-06-15 07:11:31'),
(1734, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:11:32', '2025-06-15 07:11:32'),
(1735, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:11:32', '2025-06-15 07:11:32'),
(1736, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:11:33', '2025-06-15 07:11:33'),
(1737, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:11:33', '2025-06-15 07:11:33'),
(1738, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:11:33', '2025-06-15 07:11:33'),
(1739, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:11:33', '2025-06-15 07:11:33'),
(1740, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:11:33', '2025-06-15 07:11:33'),
(1741, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:11:34', '2025-06-15 07:11:34'),
(1742, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:11:35', '2025-06-15 07:11:35'),
(1743, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:11:35', '2025-06-15 07:11:35'),
(1744, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:11:36', '2025-06-15 07:11:36'),
(1745, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:11:36', '2025-06-15 07:11:36'),
(1746, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:11:37', '2025-06-15 07:11:37'),
(1747, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:11:37', '2025-06-15 07:11:37'),
(1748, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:11:37', '2025-06-15 07:11:37'),
(1749, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:11:37', '2025-06-15 07:11:37'),
(1750, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:11:37', '2025-06-15 07:11:37'),
(1751, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:11:38', '2025-06-15 07:11:38'),
(1752, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:11:38', '2025-06-15 07:11:38'),
(1753, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:11:39', '2025-06-15 07:11:39'),
(1754, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:11:39', '2025-06-15 07:11:39'),
(1755, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:11:40', '2025-06-15 07:11:40'),
(1756, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:11:40', '2025-06-15 07:11:40'),
(1757, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:11:40', '2025-06-15 07:11:40'),
(1758, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:11:40', '2025-06-15 07:11:40'),
(1759, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:11:40', '2025-06-15 07:11:40'),
(1760, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:11:41', '2025-06-15 07:11:41'),
(1761, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:11:41', '2025-06-15 07:11:41'),
(1762, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:11:42', '2025-06-15 07:11:42'),
(1763, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:11:42', '2025-06-15 07:11:42'),
(1764, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:11:43', '2025-06-15 07:11:43'),
(1765, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:11:43', '2025-06-15 07:11:43'),
(1766, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:11:43', '2025-06-15 07:11:43'),
(1767, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:11:43', '2025-06-15 07:11:43'),
(1768, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:11:43', '2025-06-15 07:11:43'),
(1769, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:11:44', '2025-06-15 07:11:44'),
(1770, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:11:44', '2025-06-15 07:11:44'),
(1771, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:11:45', '2025-06-15 07:11:45'),
(1772, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:11:46', '2025-06-15 07:11:46'),
(1773, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:11:46', '2025-06-15 07:11:46'),
(1774, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:11:46', '2025-06-15 07:11:46'),
(1775, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:11:46', '2025-06-15 07:11:46'),
(1776, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:11:46', '2025-06-15 07:11:46'),
(1777, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:11:47', '2025-06-15 07:11:47'),
(1778, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:11:47', '2025-06-15 07:11:47'),
(1779, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:11:48', '2025-06-15 07:11:48'),
(1780, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:11:48', '2025-06-15 07:11:48'),
(1781, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:11:49', '2025-06-15 07:11:49'),
(1782, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:11:49', '2025-06-15 07:11:49'),
(1783, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:11:49', '2025-06-15 07:11:49'),
(1784, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:11:49', '2025-06-15 07:11:49'),
(1785, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:11:49', '2025-06-15 07:11:49'),
(1786, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:11:50', '2025-06-15 07:11:50'),
(1787, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:11:50', '2025-06-15 07:11:50'),
(1788, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:11:51', '2025-06-15 07:11:51'),
(1789, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:11:51', '2025-06-15 07:11:51'),
(1790, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:11:52', '2025-06-15 07:11:52'),
(1791, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:11:52', '2025-06-15 07:11:52'),
(1792, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:11:52', '2025-06-15 07:11:52'),
(1793, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:11:52', '2025-06-15 07:11:52'),
(1794, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:11:52', '2025-06-15 07:11:52'),
(1795, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:11:53', '2025-06-15 07:11:53'),
(1796, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:11:54', '2025-06-15 07:11:54');
INSERT INTO `failed_import_rows` (`id`, `data`, `import_id`, `validation_error`, `created_at`, `updated_at`) VALUES
(1797, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:11:54', '2025-06-15 07:11:54'),
(1798, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:11:55', '2025-06-15 07:11:55'),
(1799, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:11:55', '2025-06-15 07:11:55'),
(1800, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:11:56', '2025-06-15 07:11:56'),
(1801, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:11:56', '2025-06-15 07:11:56'),
(1802, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:11:56', '2025-06-15 07:11:56'),
(1803, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:11:56', '2025-06-15 07:11:56'),
(1804, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:11:56', '2025-06-15 07:11:56'),
(1805, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:11:57', '2025-06-15 07:11:57'),
(1806, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:11:58', '2025-06-15 07:11:58'),
(1807, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:11:58', '2025-06-15 07:11:58'),
(1808, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:11:59', '2025-06-15 07:11:59'),
(1809, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:11:59', '2025-06-15 07:11:59'),
(1810, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:11:59', '2025-06-15 07:11:59'),
(1811, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:11:59', '2025-06-15 07:11:59'),
(1812, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:11:59', '2025-06-15 07:11:59'),
(1813, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:12:00', '2025-06-15 07:12:00'),
(1814, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:12:00', '2025-06-15 07:12:00'),
(1815, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:12:01', '2025-06-15 07:12:01'),
(1816, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:12:02', '2025-06-15 07:12:02'),
(1817, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:12:02', '2025-06-15 07:12:02'),
(1818, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:12:03', '2025-06-15 07:12:03'),
(1819, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:12:03', '2025-06-15 07:12:03'),
(1820, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:12:03', '2025-06-15 07:12:03'),
(1821, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:12:03', '2025-06-15 07:12:03'),
(1822, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:12:03', '2025-06-15 07:12:03'),
(1823, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:12:04', '2025-06-15 07:12:04'),
(1824, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:12:04', '2025-06-15 07:12:04'),
(1825, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:12:05', '2025-06-15 07:12:05'),
(1826, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:12:06', '2025-06-15 07:12:06'),
(1827, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:12:06', '2025-06-15 07:12:06'),
(1828, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:12:06', '2025-06-15 07:12:06'),
(1829, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:12:06', '2025-06-15 07:12:06'),
(1830, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:12:06', '2025-06-15 07:12:06'),
(1831, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:12:07', '2025-06-15 07:12:07'),
(1832, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:12:07', '2025-06-15 07:12:07'),
(1833, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:12:08', '2025-06-15 07:12:08'),
(1834, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:12:08', '2025-06-15 07:12:08'),
(1835, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:12:09', '2025-06-15 07:12:09'),
(1836, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:12:09', '2025-06-15 07:12:09'),
(1837, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:12:09', '2025-06-15 07:12:09'),
(1838, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:12:09', '2025-06-15 07:12:09'),
(1839, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:12:09', '2025-06-15 07:12:09'),
(1840, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:12:10', '2025-06-15 07:12:10'),
(1841, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:12:11', '2025-06-15 07:12:11'),
(1842, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:12:11', '2025-06-15 07:12:11'),
(1843, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:12:12', '2025-06-15 07:12:12'),
(1844, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:12:12', '2025-06-15 07:12:12'),
(1845, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:12:13', '2025-06-15 07:12:13'),
(1846, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:12:13', '2025-06-15 07:12:13'),
(1847, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:12:13', '2025-06-15 07:12:13'),
(1848, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:12:13', '2025-06-15 07:12:13'),
(1849, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:12:14', '2025-06-15 07:12:14'),
(1850, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:12:14', '2025-06-15 07:12:14'),
(1851, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:12:15', '2025-06-15 07:12:15'),
(1852, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:12:15', '2025-06-15 07:12:15'),
(1853, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:12:16', '2025-06-15 07:12:16'),
(1854, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:12:16', '2025-06-15 07:12:16'),
(1855, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:12:17', '2025-06-15 07:12:17'),
(1856, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:12:17', '2025-06-15 07:12:17'),
(1857, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:12:17', '2025-06-15 07:12:17'),
(1858, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:12:17', '2025-06-15 07:12:17'),
(1859, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:12:18', '2025-06-15 07:12:18'),
(1860, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:12:18', '2025-06-15 07:12:18'),
(1861, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:12:19', '2025-06-15 07:12:19'),
(1862, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:12:19', '2025-06-15 07:12:19'),
(1863, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:12:20', '2025-06-15 07:12:20'),
(1864, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:12:20', '2025-06-15 07:12:20'),
(1865, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:12:20', '2025-06-15 07:12:20'),
(1866, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:12:20', '2025-06-15 07:12:20'),
(1867, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:12:20', '2025-06-15 07:12:20'),
(1868, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:12:21', '2025-06-15 07:12:21'),
(1869, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:12:22', '2025-06-15 07:12:22'),
(1870, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:12:22', '2025-06-15 07:12:22'),
(1871, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:12:22', '2025-06-15 07:12:22'),
(1872, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:12:23', '2025-06-15 07:12:23'),
(1873, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:12:23', '2025-06-15 07:12:23'),
(1874, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:12:23', '2025-06-15 07:12:23'),
(1875, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:12:23', '2025-06-15 07:12:23'),
(1876, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:12:23', '2025-06-15 07:12:23'),
(1877, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:12:24', '2025-06-15 07:12:24'),
(1878, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:12:25', '2025-06-15 07:12:25'),
(1879, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:12:25', '2025-06-15 07:12:25'),
(1880, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:12:26', '2025-06-15 07:12:26'),
(1881, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:12:26', '2025-06-15 07:12:26'),
(1882, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:12:26', '2025-06-15 07:12:26'),
(1883, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:12:26', '2025-06-15 07:12:26'),
(1884, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:12:26', '2025-06-15 07:12:26'),
(1885, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:12:27', '2025-06-15 07:12:27'),
(1886, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:12:27', '2025-06-15 07:12:27'),
(1887, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:12:28', '2025-06-15 07:12:28'),
(1888, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:12:28', '2025-06-15 07:12:28'),
(1889, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:12:29', '2025-06-15 07:12:29'),
(1890, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:12:30', '2025-06-15 07:12:30'),
(1891, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:12:30', '2025-06-15 07:12:30'),
(1892, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:12:30', '2025-06-15 07:12:30'),
(1893, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:12:30', '2025-06-15 07:12:30'),
(1894, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:12:30', '2025-06-15 07:12:30'),
(1895, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:12:31', '2025-06-15 07:12:31'),
(1896, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:12:31', '2025-06-15 07:12:31'),
(1897, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:12:32', '2025-06-15 07:12:32'),
(1898, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:12:33', '2025-06-15 07:12:33'),
(1899, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:12:33', '2025-06-15 07:12:33'),
(1900, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:12:33', '2025-06-15 07:12:33'),
(1901, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:12:33', '2025-06-15 07:12:33'),
(1902, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:12:33', '2025-06-15 07:12:33'),
(1903, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:12:34', '2025-06-15 07:12:34'),
(1904, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:12:35', '2025-06-15 07:12:35'),
(1905, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:12:35', '2025-06-15 07:12:35'),
(1906, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:12:36', '2025-06-15 07:12:36'),
(1907, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:12:36', '2025-06-15 07:12:36'),
(1908, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:12:37', '2025-06-15 07:12:37'),
(1909, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:12:37', '2025-06-15 07:12:37'),
(1910, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:12:37', '2025-06-15 07:12:37'),
(1911, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:12:37', '2025-06-15 07:12:37'),
(1912, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:12:37', '2025-06-15 07:12:37'),
(1913, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:12:38', '2025-06-15 07:12:38'),
(1914, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:12:39', '2025-06-15 07:12:39'),
(1915, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:12:39', '2025-06-15 07:12:39'),
(1916, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:12:40', '2025-06-15 07:12:40'),
(1917, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:12:40', '2025-06-15 07:12:40'),
(1918, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:12:40', '2025-06-15 07:12:40'),
(1919, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:12:40', '2025-06-15 07:12:40'),
(1920, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:12:40', '2025-06-15 07:12:40'),
(1921, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:12:41', '2025-06-15 07:12:41'),
(1922, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:12:41', '2025-06-15 07:12:41'),
(1923, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:12:42', '2025-06-15 07:12:42'),
(1924, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:12:43', '2025-06-15 07:12:43'),
(1925, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:12:43', '2025-06-15 07:12:43'),
(1926, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:12:44', '2025-06-15 07:12:44'),
(1927, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:12:44', '2025-06-15 07:12:44'),
(1928, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:12:44', '2025-06-15 07:12:44'),
(1929, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:12:44', '2025-06-15 07:12:44'),
(1930, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:12:45', '2025-06-15 07:12:45'),
(1931, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:12:45', '2025-06-15 07:12:45'),
(1932, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:12:46', '2025-06-15 07:12:46'),
(1933, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:12:46', '2025-06-15 07:12:46'),
(1934, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:12:47', '2025-06-15 07:12:47'),
(1935, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:12:47', '2025-06-15 07:12:47'),
(1936, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:12:47', '2025-06-15 07:12:47'),
(1937, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:12:47', '2025-06-15 07:12:47'),
(1938, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:12:47', '2025-06-15 07:12:47'),
(1939, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:12:48', '2025-06-15 07:12:48'),
(1940, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:12:48', '2025-06-15 07:12:48'),
(1941, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:12:49', '2025-06-15 07:12:49'),
(1942, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:12:50', '2025-06-15 07:12:50'),
(1943, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:12:50', '2025-06-15 07:12:50'),
(1944, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:12:51', '2025-06-15 07:12:51'),
(1945, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:12:51', '2025-06-15 07:12:51'),
(1946, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:12:51', '2025-06-15 07:12:51'),
(1947, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:12:51', '2025-06-15 07:12:51'),
(1948, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:12:51', '2025-06-15 07:12:51'),
(1949, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:12:52', '2025-06-15 07:12:52'),
(1950, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:12:52', '2025-06-15 07:12:52'),
(1951, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:12:53', '2025-06-15 07:12:53'),
(1952, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:12:54', '2025-06-15 07:12:54'),
(1953, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:12:54', '2025-06-15 07:12:54'),
(1954, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:12:54', '2025-06-15 07:12:54'),
(1955, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:12:54', '2025-06-15 07:12:54'),
(1956, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:12:54', '2025-06-15 07:12:54'),
(1957, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:12:55', '2025-06-15 07:12:55'),
(1958, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:12:55', '2025-06-15 07:12:55'),
(1959, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:12:56', '2025-06-15 07:12:56'),
(1960, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:12:57', '2025-06-15 07:12:57'),
(1961, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:12:57', '2025-06-15 07:12:57'),
(1962, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:12:58', '2025-06-15 07:12:58'),
(1963, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:12:58', '2025-06-15 07:12:58'),
(1964, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:12:58', '2025-06-15 07:12:58'),
(1965, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:12:58', '2025-06-15 07:12:58'),
(1966, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:12:59', '2025-06-15 07:12:59'),
(1967, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:12:59', '2025-06-15 07:12:59'),
(1968, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:13:00', '2025-06-15 07:13:00'),
(1969, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:13:00', '2025-06-15 07:13:00'),
(1970, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:13:01', '2025-06-15 07:13:01'),
(1971, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:13:02', '2025-06-15 07:13:02'),
(1972, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:13:02', '2025-06-15 07:13:02'),
(1973, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:13:02', '2025-06-15 07:13:02'),
(1974, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:13:02', '2025-06-15 07:13:02'),
(1975, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:13:02', '2025-06-15 07:13:02'),
(1976, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:13:03', '2025-06-15 07:13:03'),
(1977, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:13:03', '2025-06-15 07:13:03'),
(1978, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:13:04', '2025-06-15 07:13:04'),
(1979, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:13:05', '2025-06-15 07:13:05'),
(1980, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:13:05', '2025-06-15 07:13:05'),
(1981, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:13:05', '2025-06-15 07:13:05'),
(1982, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:13:05', '2025-06-15 07:13:05'),
(1983, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:13:05', '2025-06-15 07:13:05'),
(1984, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:13:06', '2025-06-15 07:13:06'),
(1985, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:13:06', '2025-06-15 07:13:06'),
(1986, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:13:07', '2025-06-15 07:13:07'),
(1987, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:13:07', '2025-06-15 07:13:07'),
(1988, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:13:08', '2025-06-15 07:13:08'),
(1989, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:13:08', '2025-06-15 07:13:08'),
(1990, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:13:08', '2025-06-15 07:13:08'),
(1991, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:13:08', '2025-06-15 07:13:08'),
(1992, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:13:08', '2025-06-15 07:13:08'),
(1993, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:13:09', '2025-06-15 07:13:09'),
(1994, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:13:09', '2025-06-15 07:13:09'),
(1995, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:13:10', '2025-06-15 07:13:10'),
(1996, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:13:11', '2025-06-15 07:13:11'),
(1997, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:13:11', '2025-06-15 07:13:11'),
(1998, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:13:12', '2025-06-15 07:13:12'),
(1999, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:13:12', '2025-06-15 07:13:12'),
(2000, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:13:12', '2025-06-15 07:13:12'),
(2001, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:13:12', '2025-06-15 07:13:12'),
(2002, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:13:12', '2025-06-15 07:13:12'),
(2003, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:13:13', '2025-06-15 07:13:13'),
(2004, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:13:13', '2025-06-15 07:13:13'),
(2005, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:13:14', '2025-06-15 07:13:14'),
(2006, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:13:14', '2025-06-15 07:13:14'),
(2007, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:13:15', '2025-06-15 07:13:15'),
(2008, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:13:15', '2025-06-15 07:13:15'),
(2009, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:13:15', '2025-06-15 07:13:15'),
(2010, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:13:15', '2025-06-15 07:13:15'),
(2011, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:13:16', '2025-06-15 07:13:16'),
(2012, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:13:16', '2025-06-15 07:13:16'),
(2013, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:13:17', '2025-06-15 07:13:17'),
(2014, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:13:18', '2025-06-15 07:13:18'),
(2015, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:13:18', '2025-06-15 07:13:18'),
(2016, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:13:19', '2025-06-15 07:13:19'),
(2017, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:13:19', '2025-06-15 07:13:19'),
(2018, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:13:19', '2025-06-15 07:13:19'),
(2019, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:13:19', '2025-06-15 07:13:19'),
(2020, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:13:19', '2025-06-15 07:13:19');
INSERT INTO `failed_import_rows` (`id`, `data`, `import_id`, `validation_error`, `created_at`, `updated_at`) VALUES
(2021, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:13:20', '2025-06-15 07:13:20'),
(2022, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:13:21', '2025-06-15 07:13:21'),
(2023, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:13:21', '2025-06-15 07:13:21'),
(2024, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:13:22', '2025-06-15 07:13:22'),
(2025, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:13:22', '2025-06-15 07:13:22'),
(2026, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:13:22', '2025-06-15 07:13:22'),
(2027, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:13:22', '2025-06-15 07:13:22'),
(2028, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:13:22', '2025-06-15 07:13:22'),
(2029, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:13:23', '2025-06-15 07:13:23'),
(2030, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:13:24', '2025-06-15 07:13:24'),
(2031, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:13:24', '2025-06-15 07:13:24'),
(2032, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:13:25', '2025-06-15 07:13:25'),
(2033, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:13:25', '2025-06-15 07:13:25'),
(2034, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:13:26', '2025-06-15 07:13:26'),
(2035, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:13:26', '2025-06-15 07:13:26'),
(2036, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:13:26', '2025-06-15 07:13:26'),
(2037, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:13:26', '2025-06-15 07:13:26'),
(2038, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:13:27', '2025-06-15 07:13:27'),
(2039, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:13:27', '2025-06-15 07:13:27'),
(2040, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:13:28', '2025-06-15 07:13:28'),
(2041, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:13:28', '2025-06-15 07:13:28'),
(2042, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:13:29', '2025-06-15 07:13:29'),
(2043, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:13:29', '2025-06-15 07:13:29'),
(2044, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:13:29', '2025-06-15 07:13:29'),
(2045, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:13:29', '2025-06-15 07:13:29'),
(2046, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:13:29', '2025-06-15 07:13:29'),
(2047, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:13:30', '2025-06-15 07:13:30'),
(2048, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:13:31', '2025-06-15 07:13:31'),
(2049, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:13:31', '2025-06-15 07:13:31'),
(2050, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:13:32', '2025-06-15 07:13:32'),
(2051, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:13:32', '2025-06-15 07:13:32'),
(2052, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:13:33', '2025-06-15 07:13:33'),
(2053, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:13:33', '2025-06-15 07:13:33'),
(2054, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:13:33', '2025-06-15 07:13:33'),
(2055, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:13:33', '2025-06-15 07:13:33'),
(2056, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:13:34', '2025-06-15 07:13:34'),
(2057, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:13:34', '2025-06-15 07:13:34'),
(2058, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:13:35', '2025-06-15 07:13:35'),
(2059, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:13:36', '2025-06-15 07:13:36'),
(2060, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:13:36', '2025-06-15 07:13:36'),
(2061, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:13:37', '2025-06-15 07:13:37'),
(2062, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:13:37', '2025-06-15 07:13:37'),
(2063, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:13:37', '2025-06-15 07:13:37'),
(2064, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:13:37', '2025-06-15 07:13:37'),
(2065, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:13:37', '2025-06-15 07:13:37'),
(2066, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:13:38', '2025-06-15 07:13:38'),
(2067, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:13:39', '2025-06-15 07:13:39'),
(2068, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:13:39', '2025-06-15 07:13:39'),
(2069, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:13:40', '2025-06-15 07:13:40'),
(2070, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:13:40', '2025-06-15 07:13:40'),
(2071, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:13:40', '2025-06-15 07:13:40'),
(2072, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:13:40', '2025-06-15 07:13:40'),
(2073, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:13:40', '2025-06-15 07:13:40'),
(2074, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:13:41', '2025-06-15 07:13:41'),
(2075, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:13:41', '2025-06-15 07:13:41'),
(2076, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:13:42', '2025-06-15 07:13:42'),
(2077, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:13:42', '2025-06-15 07:13:42'),
(2078, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:13:43', '2025-06-15 07:13:43'),
(2079, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:13:44', '2025-06-15 07:13:44'),
(2080, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:13:44', '2025-06-15 07:13:44'),
(2081, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:13:44', '2025-06-15 07:13:44'),
(2082, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:13:44', '2025-06-15 07:13:44'),
(2083, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:13:44', '2025-06-15 07:13:44'),
(2084, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:13:45', '2025-06-15 07:13:45'),
(2085, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:13:46', '2025-06-15 07:13:46'),
(2086, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:13:46', '2025-06-15 07:13:46'),
(2087, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:13:47', '2025-06-15 07:13:47'),
(2088, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:13:47', '2025-06-15 07:13:47'),
(2089, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:13:47', '2025-06-15 07:13:47'),
(2090, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:13:47', '2025-06-15 07:13:47'),
(2091, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:13:47', '2025-06-15 07:13:47'),
(2092, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:13:48', '2025-06-15 07:13:48'),
(2093, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:13:49', '2025-06-15 07:13:49'),
(2094, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:13:49', '2025-06-15 07:13:49'),
(2095, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:13:50', '2025-06-15 07:13:50'),
(2096, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:13:50', '2025-06-15 07:13:50'),
(2097, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:13:51', '2025-06-15 07:13:51'),
(2098, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:13:51', '2025-06-15 07:13:51'),
(2099, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:13:51', '2025-06-15 07:13:51'),
(2100, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:13:51', '2025-06-15 07:13:51'),
(2101, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:13:52', '2025-06-15 07:13:52'),
(2102, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:13:52', '2025-06-15 07:13:52'),
(2103, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:13:53', '2025-06-15 07:13:53'),
(2104, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:13:53', '2025-06-15 07:13:53'),
(2105, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:13:54', '2025-06-15 07:13:54'),
(2106, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:13:54', '2025-06-15 07:13:54'),
(2107, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:13:54', '2025-06-15 07:13:54'),
(2108, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:13:54', '2025-06-15 07:13:54'),
(2109, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:13:54', '2025-06-15 07:13:54'),
(2110, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:13:55', '2025-06-15 07:13:55'),
(2111, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:13:55', '2025-06-15 07:13:55'),
(2112, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:13:56', '2025-06-15 07:13:56'),
(2113, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:13:57', '2025-06-15 07:13:57'),
(2114, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:13:57', '2025-06-15 07:13:57'),
(2115, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:13:58', '2025-06-15 07:13:58'),
(2116, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:13:58', '2025-06-15 07:13:58'),
(2117, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:13:58', '2025-06-15 07:13:58'),
(2118, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:13:58', '2025-06-15 07:13:58'),
(2119, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:13:59', '2025-06-15 07:13:59'),
(2120, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:13:59', '2025-06-15 07:13:59'),
(2121, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:14:00', '2025-06-15 07:14:00'),
(2122, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:14:00', '2025-06-15 07:14:00'),
(2123, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:14:01', '2025-06-15 07:14:01'),
(2124, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:14:02', '2025-06-15 07:14:02'),
(2125, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:14:02', '2025-06-15 07:14:02'),
(2126, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:14:02', '2025-06-15 07:14:02'),
(2127, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:14:02', '2025-06-15 07:14:02'),
(2128, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:14:02', '2025-06-15 07:14:02'),
(2129, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:14:03', '2025-06-15 07:14:03'),
(2130, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:14:03', '2025-06-15 07:14:03'),
(2131, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:14:04', '2025-06-15 07:14:04'),
(2132, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:14:05', '2025-06-15 07:14:05'),
(2133, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:14:05', '2025-06-15 07:14:05'),
(2134, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:14:05', '2025-06-15 07:14:05'),
(2135, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:14:05', '2025-06-15 07:14:05'),
(2136, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:14:05', '2025-06-15 07:14:05'),
(2137, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:14:06', '2025-06-15 07:14:06'),
(2138, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:14:06', '2025-06-15 07:14:06'),
(2139, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:14:07', '2025-06-15 07:14:07'),
(2140, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:14:08', '2025-06-15 07:14:08'),
(2141, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:14:08', '2025-06-15 07:14:08'),
(2142, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:14:09', '2025-06-15 07:14:09'),
(2143, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:14:09', '2025-06-15 07:14:09'),
(2144, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:14:09', '2025-06-15 07:14:09'),
(2145, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:14:09', '2025-06-15 07:14:09'),
(2146, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:14:09', '2025-06-15 07:14:09'),
(2147, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:14:10', '2025-06-15 07:14:10'),
(2148, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:14:10', '2025-06-15 07:14:10'),
(2149, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:14:11', '2025-06-15 07:14:11'),
(2150, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:14:12', '2025-06-15 07:14:12'),
(2151, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:14:12', '2025-06-15 07:14:12'),
(2152, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:14:12', '2025-06-15 07:14:12'),
(2153, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:14:12', '2025-06-15 07:14:12'),
(2154, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:14:12', '2025-06-15 07:14:12'),
(2155, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:14:13', '2025-06-15 07:14:13'),
(2156, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:14:13', '2025-06-15 07:14:13'),
(2157, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:14:14', '2025-06-15 07:14:14'),
(2158, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:14:15', '2025-06-15 07:14:15'),
(2159, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:14:15', '2025-06-15 07:14:15'),
(2160, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:14:16', '2025-06-15 07:14:16'),
(2161, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:14:16', '2025-06-15 07:14:16'),
(2162, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:14:16', '2025-06-15 07:14:16'),
(2163, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:14:16', '2025-06-15 07:14:16'),
(2164, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:14:16', '2025-06-15 07:14:16'),
(2165, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:14:17', '2025-06-15 07:14:17'),
(2166, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:14:17', '2025-06-15 07:14:17'),
(2167, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:14:18', '2025-06-15 07:14:18'),
(2168, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:14:18', '2025-06-15 07:14:18'),
(2169, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:14:19', '2025-06-15 07:14:19'),
(2170, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:14:19', '2025-06-15 07:14:19'),
(2171, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:14:19', '2025-06-15 07:14:19'),
(2172, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:14:19', '2025-06-15 07:14:19'),
(2173, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:14:20', '2025-06-15 07:14:20'),
(2174, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:14:20', '2025-06-15 07:14:20'),
(2175, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:14:21', '2025-06-15 07:14:21'),
(2176, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:14:21', '2025-06-15 07:14:21'),
(2177, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:14:22', '2025-06-15 07:14:22'),
(2178, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:14:22', '2025-06-15 07:14:22'),
(2179, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:14:23', '2025-06-15 07:14:23'),
(2180, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:14:23', '2025-06-15 07:14:23'),
(2181, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:14:23', '2025-06-15 07:14:23'),
(2182, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:14:23', '2025-06-15 07:14:23'),
(2183, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:14:24', '2025-06-15 07:14:24'),
(2184, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:14:24', '2025-06-15 07:14:24'),
(2185, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:14:25', '2025-06-15 07:14:25'),
(2186, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:14:25', '2025-06-15 07:14:25'),
(2187, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:14:26', '2025-06-15 07:14:26'),
(2188, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:14:26', '2025-06-15 07:14:26'),
(2189, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:14:26', '2025-06-15 07:14:26'),
(2190, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:14:26', '2025-06-15 07:14:26'),
(2191, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:14:26', '2025-06-15 07:14:26'),
(2192, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:14:27', '2025-06-15 07:14:27'),
(2193, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:14:28', '2025-06-15 07:14:28'),
(2194, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:14:28', '2025-06-15 07:14:28'),
(2195, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:14:29', '2025-06-15 07:14:29'),
(2196, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:14:29', '2025-06-15 07:14:29'),
(2197, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:14:29', '2025-06-15 07:14:29'),
(2198, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:14:29', '2025-06-15 07:14:29'),
(2199, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:14:29', '2025-06-15 07:14:29'),
(2200, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:14:30', '2025-06-15 07:14:30'),
(2201, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:14:30', '2025-06-15 07:14:30'),
(2202, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:14:31', '2025-06-15 07:14:31'),
(2203, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:14:32', '2025-06-15 07:14:32'),
(2204, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:14:32', '2025-06-15 07:14:32'),
(2205, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:14:33', '2025-06-15 07:14:33'),
(2206, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:14:33', '2025-06-15 07:14:33'),
(2207, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:14:33', '2025-06-15 07:14:33'),
(2208, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:14:33', '2025-06-15 07:14:33'),
(2209, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:14:34', '2025-06-15 07:14:34'),
(2210, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:14:35', '2025-06-15 07:14:35'),
(2211, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:14:35', '2025-06-15 07:14:35'),
(2212, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:14:36', '2025-06-15 07:14:36'),
(2213, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:14:36', '2025-06-15 07:14:36'),
(2214, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:14:37', '2025-06-15 07:14:37'),
(2215, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:14:37', '2025-06-15 07:14:37'),
(2216, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:14:37', '2025-06-15 07:14:37'),
(2217, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:14:37', '2025-06-15 07:14:37'),
(2218, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:14:38', '2025-06-15 07:14:38'),
(2219, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:14:39', '2025-06-15 07:14:39'),
(2220, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:14:39', '2025-06-15 07:14:39'),
(2221, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:14:40', '2025-06-15 07:14:40'),
(2222, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:14:41', '2025-06-15 07:14:41'),
(2223, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:14:41', '2025-06-15 07:14:41'),
(2224, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:14:41', '2025-06-15 07:14:41'),
(2225, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:14:41', '2025-06-15 07:14:41'),
(2226, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:14:41', '2025-06-15 07:14:41'),
(2227, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:14:42', '2025-06-15 07:14:42'),
(2228, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:14:42', '2025-06-15 07:14:42'),
(2229, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:14:43', '2025-06-15 07:14:43'),
(2230, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:14:43', '2025-06-15 07:14:43'),
(2231, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:14:44', '2025-06-15 07:14:44'),
(2232, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:14:44', '2025-06-15 07:14:44'),
(2233, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:14:44', '2025-06-15 07:14:44'),
(2234, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:14:44', '2025-06-15 07:14:44'),
(2235, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:14:44', '2025-06-15 07:14:44'),
(2236, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:14:45', '2025-06-15 07:14:45'),
(2237, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:14:46', '2025-06-15 07:14:46'),
(2238, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:14:46', '2025-06-15 07:14:46'),
(2239, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:14:47', '2025-06-15 07:14:47'),
(2240, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:14:47', '2025-06-15 07:14:47'),
(2241, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:14:48', '2025-06-15 07:14:48'),
(2242, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:14:48', '2025-06-15 07:14:48'),
(2243, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:14:48', '2025-06-15 07:14:48'),
(2244, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:14:48', '2025-06-15 07:14:48');
INSERT INTO `failed_import_rows` (`id`, `data`, `import_id`, `validation_error`, `created_at`, `updated_at`) VALUES
(2245, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:14:48', '2025-06-15 07:14:48'),
(2246, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:14:49', '2025-06-15 07:14:49'),
(2247, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:14:50', '2025-06-15 07:14:50'),
(2248, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:14:50', '2025-06-15 07:14:50'),
(2249, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:14:51', '2025-06-15 07:14:51'),
(2250, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:14:51', '2025-06-15 07:14:51'),
(2251, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:14:51', '2025-06-15 07:14:51'),
(2252, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:14:51', '2025-06-15 07:14:51'),
(2253, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:14:51', '2025-06-15 07:14:51'),
(2254, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:14:52', '2025-06-15 07:14:52'),
(2255, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:14:52', '2025-06-15 07:14:52'),
(2256, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:14:53', '2025-06-15 07:14:53'),
(2257, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:14:54', '2025-06-15 07:14:54'),
(2258, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:14:54', '2025-06-15 07:14:54'),
(2259, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:14:55', '2025-06-15 07:14:55'),
(2260, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:14:55', '2025-06-15 07:14:55'),
(2261, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:14:55', '2025-06-15 07:14:55'),
(2262, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:14:55', '2025-06-15 07:14:55'),
(2263, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:14:55', '2025-06-15 07:14:55'),
(2264, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:14:56', '2025-06-15 07:14:56'),
(2265, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:14:57', '2025-06-15 07:14:57'),
(2266, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:14:57', '2025-06-15 07:14:57'),
(2267, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:14:58', '2025-06-15 07:14:58'),
(2268, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:14:59', '2025-06-15 07:14:59'),
(2269, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:14:59', '2025-06-15 07:14:59'),
(2270, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:14:59', '2025-06-15 07:14:59'),
(2271, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:14:59', '2025-06-15 07:14:59'),
(2272, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:14:59', '2025-06-15 07:14:59'),
(2273, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:15:00', '2025-06-15 07:15:00'),
(2274, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:15:00', '2025-06-15 07:15:00'),
(2275, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:15:01', '2025-06-15 07:15:01'),
(2276, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:15:01', '2025-06-15 07:15:01'),
(2277, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:15:02', '2025-06-15 07:15:02'),
(2278, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:15:02', '2025-06-15 07:15:02'),
(2279, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:15:02', '2025-06-15 07:15:02'),
(2280, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:15:02', '2025-06-15 07:15:02'),
(2281, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:15:03', '2025-06-15 07:15:03'),
(2282, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:15:03', '2025-06-15 07:15:03'),
(2283, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:15:04', '2025-06-15 07:15:04'),
(2284, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:15:04', '2025-06-15 07:15:04'),
(2285, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:15:05', '2025-06-15 07:15:05'),
(2286, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:15:05', '2025-06-15 07:15:05'),
(2287, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:15:05', '2025-06-15 07:15:05'),
(2288, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:15:05', '2025-06-15 07:15:05'),
(2289, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:15:05', '2025-06-15 07:15:05'),
(2290, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:15:06', '2025-06-15 07:15:06'),
(2291, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:15:07', '2025-06-15 07:15:07'),
(2292, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 1, NULL, '2025-06-15 07:15:07', '2025-06-15 07:15:07'),
(2293, '{\"nip\": \"123456789\", \"name\": \"John Doe\", \"role\": \"super_admin\", \"email\": \"john@example.com\", \"password\": \"password1\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:15:08', '2025-06-15 07:15:08'),
(2294, '{\"nip\": \"987654321\", \"name\": \"Jane Smith\", \"role\": \"pimpinan\", \"email\": \"jane@example.com\", \"password\": \"password2\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:15:08', '2025-06-15 07:15:08'),
(2295, '{\"nip\": \"555555555\", \"name\": \"Alice Johnson\", \"role\": \"p2mpp\", \"email\": \"alice@example.com\", \"password\": \"password3\", \"unit_name\": \"c\"}', 2, NULL, '2025-06-15 07:15:09', '2025-06-15 07:15:09'),
(2296, '{\"status\": \"validated\", \"kode_unit\": \"D4 TI\", \"nama_unit\": \"Teknik Informatika\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:15:09', '2025-06-15 07:15:09'),
(2297, '{\"status\": \"pending\", \"kode_unit\": \"D4 SIB\", \"nama_unit\": \"Sistem Informasi Bisnis\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:15:09', '2025-06-15 07:15:09'),
(2298, '{\"status\": \"\", \"kode_unit\": \"\", \"nama_unit\": \"\", \"created_by\": \"\", \"validated_by\": \"\", \"validated_time\": \"\"}', 4, NULL, '2025-06-15 07:15:09', '2025-06-15 07:15:09');

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
-- Table structure for table `imports`
--

CREATE TABLE `imports` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `completed_at` timestamp NULL DEFAULT NULL,
  `file_name` varchar(255) NOT NULL,
  `file_path` varchar(255) NOT NULL,
  `importer` varchar(255) NOT NULL,
  `processed_rows` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `total_rows` int(10) UNSIGNED NOT NULL,
  `successful_rows` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `imports`
--

INSERT INTO `imports` (`id`, `completed_at`, `file_name`, `file_path`, `importer`, `processed_rows`, `total_rows`, `successful_rows`, `user_id`, `created_at`, `updated_at`) VALUES
(1, NULL, 'Book2.csv', 'H:\\espmi\\espmi-polinema\\espmi\\storage\\app/private\\livewire-tmp/PuKAQRzBfZcdB4gIQPB4rSEAlU8GLc-metaQm9vazIuY3N2-.csv', 'App\\Filament\\Imports\\UserImporter', 3, 3, 0, 11, '2025-06-15 06:33:43', '2025-06-15 07:15:07'),
(2, NULL, 'Book2.csv', 'H:\\espmi\\espmi-polinema\\espmi\\storage\\app/private\\livewire-tmp/FDpUZUH9fHKOtf29G9OQ7bsNM1311n-metaQm9vazIuY3N2-.csv', 'App\\Filament\\Imports\\UserImporter', 3, 3, 0, 11, '2025-06-15 06:37:11', '2025-06-15 07:15:09'),
(3, '2025-06-15 07:00:30', 'Book2.csv', 'H:\\espmi\\espmi-polinema\\espmi\\storage\\app/private\\livewire-tmp/77thVDSuGNeleFImGV5bjsxzXgdzKw-metaQm9vazIuY3N2-.csv', 'App\\Filament\\Imports\\UserImporter', 3, 3, 0, 11, '2025-06-15 06:43:42', '2025-06-15 07:00:30'),
(4, NULL, 'Books2.csv', 'H:\\espmi\\espmi-polinema\\espmi\\storage\\app/private\\livewire-tmp/S5nnrxonhHch9R7l6UvC7iSNUSRMfm-metaQm9va3MyLmNzdg==-.csv', 'App\\Filament\\Imports\\UnitImporter', 3, 3, 0, 11, '2025-06-15 06:56:55', '2025-06-15 07:15:09');

-- --------------------------------------------------------

--
-- Table structure for table `indikators`
--

CREATE TABLE `indikators` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `sub_standar_id` bigint(20) UNSIGNED NOT NULL,
  `status` enum('pending','validated') NOT NULL DEFAULT 'pending',
  `validated_by` bigint(20) UNSIGNED DEFAULT NULL,
  `validated_time` timestamp NULL DEFAULT NULL,
  `created_by` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `indikators`
--

INSERT INTO `indikators` (`id`, `sub_standar_id`, `status`, `validated_by`, `validated_time`, `created_by`, `created_at`, `updated_at`) VALUES
(2, 2, 'validated', 987654931, '2025-06-18 00:23:53', 987654931, '2025-06-18 00:21:06', '2025-06-18 00:23:57'),
(3, 3, 'validated', 987654931, '2025-06-18 00:23:59', 987654931, '2025-06-18 00:23:41', '2025-06-18 00:24:02'),
(4, 4, 'validated', 987654931, '2025-06-18 00:34:08', 987654931, '2025-06-18 00:28:00', '2025-06-18 00:34:24'),
(5, 5, 'validated', 987654931, '2025-06-18 00:34:01', 987654931, '2025-06-18 00:29:18', '2025-06-18 00:34:04'),
(6, 6, 'validated', 987654931, '2025-06-22 01:52:56', 987654931, '2025-06-18 00:37:55', '2025-06-22 01:52:59'),
(7, 7, 'validated', 987654931, '2025-06-22 01:52:50', 987654931, '2025-06-22 01:07:39', '2025-06-22 01:52:53'),
(8, 8, 'validated', 987654931, '2025-06-22 01:52:29', 987654931, '2025-06-22 01:11:10', '2025-06-22 01:52:32'),
(9, 9, 'validated', 987654931, '2025-06-22 01:52:09', 987654931, '2025-06-22 01:12:27', '2025-06-22 01:52:15'),
(10, 10, 'validated', 987654931, '2025-06-22 01:52:20', 987654931, '2025-06-22 01:16:49', '2025-06-22 01:52:25'),
(11, 11, 'validated', 987654931, '2025-06-22 01:52:00', 987654931, '2025-06-22 01:18:02', '2025-06-22 01:52:05'),
(12, 12, 'validated', 987654931, '2025-06-22 01:51:53', 987654931, '2025-06-22 01:19:10', '2025-06-22 01:51:56'),
(13, 13, 'validated', 987654931, '2025-06-22 01:51:44', 987654931, '2025-06-22 01:20:19', '2025-06-22 01:51:49'),
(14, 15, 'validated', 987654931, '2025-06-22 01:51:33', 987654931, '2025-06-22 01:21:23', '2025-06-22 01:51:38'),
(15, 16, 'validated', 987654931, '2025-06-22 01:51:25', 987654931, '2025-06-22 01:22:20', '2025-06-22 01:51:28'),
(16, 17, 'validated', 987654931, '2025-06-22 01:51:17', 987654931, '2025-06-22 01:23:08', '2025-06-22 01:51:21'),
(17, 18, 'validated', 987654931, '2025-06-22 01:51:12', 987654931, '2025-06-22 01:29:51', '2025-06-22 01:51:15'),
(18, 19, 'validated', 987654931, '2025-06-22 01:51:06', 987654931, '2025-06-22 01:31:05', '2025-06-22 01:51:09'),
(19, 20, 'validated', 987654931, '2025-06-22 01:50:58', 987654931, '2025-06-22 01:31:44', '2025-06-22 01:51:02'),
(20, 21, 'validated', 987654931, '2025-06-22 01:50:50', 987654931, '2025-06-22 01:32:21', '2025-06-22 01:50:54'),
(21, 22, 'validated', 987654931, '2025-06-22 01:50:42', 987654931, '2025-06-22 01:33:16', '2025-06-22 01:50:46'),
(22, 23, 'validated', 987654931, '2025-06-22 01:50:35', 987654931, '2025-06-22 01:34:00', '2025-06-22 01:50:38'),
(23, 24, 'validated', 987654931, '2025-06-22 01:50:26', 987654931, '2025-06-22 01:34:41', '2025-06-22 01:50:30'),
(24, 25, 'validated', 987654931, '2025-06-22 01:50:18', 987654931, '2025-06-22 01:36:21', '2025-06-22 01:50:22'),
(25, 26, 'validated', 987654931, '2025-06-22 01:50:10', 987654931, '2025-06-22 01:38:10', '2025-06-22 01:50:13'),
(26, 27, 'validated', 987654931, '2025-06-22 01:50:01', 987654931, '2025-06-22 01:40:00', '2025-06-22 01:50:05'),
(27, 28, 'validated', 987654931, '2025-06-22 01:49:54', 987654931, '2025-06-22 01:41:07', '2025-06-22 01:49:57'),
(28, 29, 'validated', 987654931, '2025-06-22 01:49:47', 987654931, '2025-06-22 01:41:53', '2025-06-22 01:49:51'),
(29, 31, 'validated', 987654931, '2025-06-22 01:49:41', 987654931, '2025-06-22 01:42:55', '2025-06-22 01:49:44'),
(30, 32, 'validated', 987654931, '2025-06-22 01:49:32', 987654931, '2025-06-22 01:44:13', '2025-06-22 01:49:36'),
(31, 33, 'validated', 987654931, '2025-06-22 01:49:25', 987654931, '2025-06-22 01:45:10', '2025-06-22 01:49:28'),
(32, 34, 'validated', 987654931, '2025-06-22 01:49:18', 987654931, '2025-06-22 01:46:38', '2025-06-22 01:49:21'),
(33, 35, 'validated', 987654931, '2025-06-22 01:49:10', 987654931, '2025-06-22 01:47:37', '2025-06-22 01:49:14'),
(34, 36, 'validated', 987654931, '2025-06-22 01:49:00', 987654931, '2025-06-22 01:48:38', '2025-06-22 01:49:04'),
(35, 14, 'validated', 987654931, '2025-06-22 02:16:17', 987654931, '2025-06-22 02:16:05', '2025-06-22 02:16:22'),
(36, 30, 'validated', 987654931, '2025-06-22 02:40:03', 987654931, '2025-06-22 02:39:35', '2025-06-22 02:40:09');

-- --------------------------------------------------------

--
-- Table structure for table `isi_indikators`
--

CREATE TABLE `isi_indikators` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `indikator_id` bigint(20) UNSIGNED NOT NULL,
  `isi_indikator` text NOT NULL,
  `target` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `isi_indikators`
--

INSERT INTO `isi_indikators` (`id`, `indikator_id`, `isi_indikator`, `target`, `created_at`, `updated_at`) VALUES
(2, 2, '<p>Tersedianya dokumen Pedoman Pembuatan Standar Kompetensi Lulusan, yang didalamnya mencakup analisis pemenuhan capaian pembelajaran lulusan (CPL) yang meliputi aspek: a) keserbacukupan,<br>b) kedalaman, dan c) kebermanfaatan analisis</p>', '100%', '2025-06-18 00:21:06', '2025-06-18 00:21:06'),
(3, 2, '<p>Tersedianya dokumen Standar kompetensi lulusan (Profil Lulusan dan Capaian Pembelajaran Lulusan) di setiap prodi yang berisi sikap, pengetahuan, keterampilan umum dan keterampilan khusus; mengacu pada pembelajaran lulusan KKNI; dan memiliki kesetaraan dengan jenjang kualifikasi pada KKNI.</p>', '100%', '2025-06-18 00:21:06', '2025-06-18 00:21:06'),
(4, 2, '<p>Tersedianya dokumen Pedoman magang industry dan PKL.</p>', '100%', '2025-06-18 00:21:06', '2025-06-18 00:21:06'),
(5, 2, '<p>Tersedianya dokumen kurikulum di setiap prodi yang memuat pengalaman kerja mahasiswa berbentuk pelatihan kerja, kerja praktik, praktik kerja lapangan atau bentuk kegiatan lain yang sejenis, yang dihargai dalam bentuk SKS.</p>', '100%', '2025-06-18 00:21:06', '2025-06-18 00:21:06'),
(6, 3, '<p>Tersedianya dokumen kebijakan pengembangan kurikulum (materi pembelajaran) mengacu pada profil lulusan dan capaian pembelajaran lulusan berbasis KKNI yang bersifat kumulatif dan integratif; tingkat kedalaman dan keluasan materi pembelajaran; serta sesuai dengan visi, misi, tujuan dan sasaran Polinema.</p>', '100%', '2025-06-18 00:23:41', '2025-06-18 00:23:41'),
(7, 3, '<p>Tersedianya dokumen kurikulum, yang berbasis pada sikap (afektif), penguasaan konsep teoritis bidang pengetahuan (kognitif) dan keterampilan tertentu (psikomotorik) secara umum dan khusus, pada setiap program studi</p>', '100%', '2025-06-18 00:23:41', '2025-06-18 00:23:41'),
(8, 3, '<p>Tersedianya dokumen kurikulum dengan tingkat kedalaman dan keluasan materi pembelajaran mengacu pada deskripsi capaian Pembelajaran lulusan dari KKNI, sebagai berikut:<br>a. lulusan program diploma tiga paling sedikit menguasai konsep teoritis bidang pengetahuan dan keterampilan tertentu secara umum;<br>b. lulusan program diploma empat paling sedikit menguasai konsep teoritis bidang pengetahuan dan keterampilan tertentu secara umum dan konsep teoritis bagian khusus dalam bidang pengetahuan dan keterampilan tersebut secara mendalam;<br>c. lulusan program magister terapan paling sedikit menguasai teori dan teori aplikasi bidang pengetahuan tertentu; dan<br>d. lulusan program doktor terapan paling sedikit menguasai filosofi keilmuan bidang pengetahuan dan keterampilan tertentu</p>', '100%', '2025-06-18 00:23:41', '2025-06-18 00:23:41'),
(9, 3, '<p>Tersedianya dokumen kurikulum pada program D3 dan D4 dengan jumlah jam pembelajaran praktikum, praktik studio, praktik bengkel, atau praktik lapangan (termasuk KKN) mencapai lebih dari 50% dari total jumlah jam pembelajaran.</p>', '100%', '2025-06-18 00:23:41', '2025-06-18 00:23:41'),
(10, 3, '<p>Tersedianya dokumen peninjauan kurikulum setiap tahun dengan melibatkan masukan dari pemangku kepentingan internal dan eksternal, serta dimutahirkan dengan perkembangan keilmuan dan teknologi di bidangnya.</p>', '100%', '2025-06-18 00:23:41', '2025-06-18 00:23:41'),
(11, 4, '<p>Tersedianya dokumen pedoman proses pembelajaran (buku Pedoman Akademik) di tiap program studi, yang mencakup: karakteristik proses pembelajaran; perencanaan proses pembelajaran; pelaksanaan proses pembelajaran; dan beban belajar mahasiswa.</p>', '100%', '2025-06-18 00:28:00', '2025-06-18 00:28:00'),
(12, 4, '<p>Tersedianya dokumen pedoman penyusunan Rencana pembelajaran Semester (RPS)</p>', '100%', '2025-06-18 00:28:00', '2025-06-18 00:28:00'),
(13, 4, '<p>Tersedianya dokumen RPS tiap mata kuliah di masing masing program studi.</p>', '100%', '2025-06-18 00:28:00', '2025-06-18 00:28:00'),
(14, 4, '<p>Tersedianya dokumen peninjauan RPS setiap tahun di masing masing program studi.</p>', '100%', '2025-06-18 00:28:00', '2025-06-18 00:28:00'),
(15, 4, '<p>Terdistribusinya dokumen Kontrak Kuliah, RPS, Daftar Presensi, dan Activity Control kepada mahasiswa pada awal perkuliahan</p>', '100%', '2025-06-18 00:28:00', '2025-06-18 00:28:00'),
(16, 4, '<p>Terdistribusinya dokumen Kalender Akademik kepada seluruh sivitas akademika pada awal tahun ajaran baru</p>', '100%', '2025-06-18 00:28:00', '2025-06-18 00:28:00'),
(17, 4, '<p>Tersedianya dokumen bukti analisis hasil monitoring dan evaluasi proses pembelajaran tiap semester</p>', '100%', '2025-06-18 00:28:00', '2025-06-18 00:28:00'),
(18, 4, '<p>Tersedianya dokumen bukti kesesuaian antara materi yang diajarkan dengan RPS minimal 80% pada activity control.</p>', '100%', '2025-06-18 00:28:00', '2025-06-18 00:28:00'),
(23, 5, '<p>Tersedianya dokumen pedoman penilaian proses dan hasil belajar mahasiswa, yang mencakup:<br>a. prinsip penilaian;<br>b. teknik dan instrumen penilaian;<br>c. mekanisme dan prosedur penilaian;<br>d. pelaksanaan penilaian;<br>e. pelaporan penilaian; dan<br>f. kelulusan mahasiswa.&nbsp;</p>', '100%', '2025-06-18 00:33:54', '2025-06-18 00:33:54'),
(24, 5, '<p>Tersedianya dokumen bukti penilaian proses dan hasil belajar mahasiswa telah menggunakan prinsip penilaian edukatif, otentik, objektif, akuntabel, dan transparan yang dilakukan secara terintegrasi.</p>', '100%', '2025-06-18 00:33:54', '2025-06-18 00:33:54'),
(25, 5, '<p>Tersedianya dokumen bukti penilaian proses dan hasil belajar mahasiswa telah menggunakan teknik penilaian antara lain observasi, partisipasi, unjuk kerja, tes tertulis, tes lisan, dan angket.</p>', '100%', '2025-06-18 00:33:54', '2025-06-18 00:33:54'),
(26, 5, '<p>Tersedianya dokumen bukti penilaian proses dan hasil belajar mahasiswa telah menggunakan Instrumen penilaian, yang terdiri atas penilaian proses dalam bentuk rubrik dan/atau penilaian hasil dalam bentuk portofolio atau karya desain.</p>', '100%', '2025-06-18 00:33:54', '2025-06-18 00:33:54'),
(27, 5, '<p>Tersedianya dokumen bukti penilaian proses dan hasil belajar mahasiswa telah mengikuti mekanisme penilaian sebagai berikut:<br>a. menyusun, menyampaikan, menyepakati tahap, teknik, instrumen, kriteria, indikator, dan bobot penilaian antara penilai dan yang dinilai sesuai dengan rencana Pembelajaran;<br>b. melaksanakan proses penilaian sesuai dengan tahap, teknik, instrumen, kriteria, indikator, dan bobot penilaian yang memuat prinsip penilaian;<br>c. memberikan umpan balik dan kesempatan untuk mempertanyakan hasil penilaian kepada mahasiswa; dan&nbsp;<br>d. mendokumentasikan penilaian proses dan hasil belajar mahasiswa secara akuntabel dan transparan.</p>', '100%', '2025-06-18 00:33:54', '2025-06-18 00:33:54'),
(28, 5, '<p>Tersedianya dokumen bukti penilaian proses dan hasil belajar mahasiswa telah mengikuti prosedur penilaian, yang mencakup tahap perencanaan, kegiatan pemberian tugas atau soal, observasi kinerja, pengembalian hasil observasi, dan pemberian nilai akhir, yang dapat dilakukan melalui penilaian bertahap dan/atau penilaian ulang.perencanaan.</p>', '100%', '2025-06-18 00:33:54', '2025-06-18 00:33:54'),
(29, 5, '<p>Tersedianya dokumen bukti pelaksana proses dan hasil belajar mahasiswa, dapat dilakukan oleh:<br>a. Dosen pengampu atau tim Dosen pengampu;<br>b. Dosen pengampu atau tim Dosen pengampu dengan mengikutsertakan mahasiswa; dan/atau<br>c. Dosen pengampu atau tim Dosen pengampu dengan mengikutsertakan pemangku kepentingan yang relevan.<br>d. Khusus untuk program program doktor terapan wajib menyertakan tim penilai eksternal dari Perguruan Tinggi yang berbeda.</p>', '100%', '2025-06-18 00:33:54', '2025-06-18 00:33:54'),
(30, 5, '<p>Tersedianya dokumen Kontrak Kuliah yang berisi:<br>a. teknik penilaian,<br>b. instrumen penilaian,<br>c. kriteria penilaian,<br>d. indikator penilaian,<br>e. bobot penilaian antara penilai dan yang dinilai sesuai dengan rencana pembelajaran</p>', '100%', '2025-06-18 00:33:54', '2025-06-18 00:33:54'),
(31, 5, '<p>Tersedianya dokumen bukti Dosen memberikan kesempatan kepada mahasiswa untuk mempertanyakan hasil penilaian pembelajaran (Form Banding Mahasiswa, yang tercantum dalam pedoman penilaian proses dan hasil belajar mahasiswa).</p>', '100%', '2025-06-18 00:33:54', '2025-06-18 00:33:54'),
(32, 5, '<p>Tersedianya dokumen pelaporan penilaian proses dan hasil belajar mahasiswa (daftar nilai mahasiswa)</p>', '100%', '2025-06-18 00:33:54', '2025-06-18 00:33:54'),
(33, 5, '<p>Tersedianya dokumen Berita Acara Yudisium Tengah Semester dan Akhir Semester.</p>', '100%', '2025-06-18 00:33:54', '2025-06-18 00:33:54'),
(34, 5, '<p>Tersedianya dokumen bukti lulusan:<br>a. Ijazah dan Transkrip akademik;<br>b. Sertifikat Kompetensi (jika lulus Uji Kompetensi);<br>c. Surat keterangan pendamping ijazah.</p>', '100%', '2025-06-18 00:33:54', '2025-06-18 00:33:54'),
(35, 6, '<p>Tersedianya dokumen rekrutmen Dosen dengan bukti kualifikasi akademik dan kompetensi pendidik yang sesuai (bukti ijazah dan transkrip dengan akreditasi prodi minimal B, sertifikat kompetensi, sertifikat profesi, dll), sehat jasmani dan rohani (surat keterangan sehat / hasil medical check up dari Rumah Sakit yang di tunjuk), serta memiliki kemampuan untuk menyelenggarakan pendidikan dalam rangka pemenuhan capaian pembelajaran lulusan (hasil ujian micro teaching).</p>', '100%', '2025-06-18 00:37:55', '2025-06-18 00:37:55'),
(36, 6, '<p>Tersedianya dokumen Dosen program diploma tiga dan program diploma empat yang menunjukkan berkualifikasi akademik paling rendah lulusan magister atau magister terapan atau setara dengan jenjang 8 (delapan) KKNI yang relevan dengan program studi (bukti SK Dosen, Sertifikat Pendidik, Sertifikat Pekerti, Surat Tu100%gas Mengajar, Sertifikat kompetensi, Sertifikat profesi).</p>', '100%', '2025-06-18 00:37:55', '2025-06-18 00:37:55'),
(37, 6, '<p>Tersedianya dokumen Dosen program magister terapan dan doktor terapan yang menunjukkan berkualifikasi akademik lulusan doktor atau doktor terapan atau setara dengan jenjang 9 (sembilan) KKNI yang relevan dengan program studi (bukti SK Dosen, Sertifikat Pendidik, Surat Tugas Mengajar, Sertifikat Pekerti, Sertifikat kompetensi, Sertifikat profesi).</p>', '100%', '2025-06-18 00:37:55', '2025-06-18 00:37:55'),
(38, 6, '<p>Tersedianya dokumen yang menunjukkan beban kerja atau ekuivalen waktu mengajar penuh (EWMP) dosen tetap sebesar minimal 12 SKS dan maksimal 16 SKS per semester (Surat Tugas Mengajar, SK Tugas Tambahan).</p>', '100%', '2025-06-18 00:37:55', '2025-06-18 00:37:55'),
(39, 6, '<p>Tersedianya dokumen yang menunjukkan nisbah dosen dan mahasiswa untuk program D3 rekayasa sebesar (1 : 10÷20) dan untuk program D3 tata niaga sebesar (1 : 15÷25).</p>', '100%', '2025-06-18 00:37:55', '2025-06-18 00:37:55'),
(40, 6, '<p>Tersedianya dokumen yang menunjukkan jumlah Dosen tetap di POLINEMA paling sedikit 90% (sembilan puluh persen) dari jumlah seluruh Dosen.</p>', '100%', '2025-06-18 00:37:55', '2025-06-18 00:37:55'),
(41, 6, '<p>Tersedianya dokumen yang menunjukkan jumlah dosen berkualifikasi akademik S3 di POLINEMA paling sedikit 30% (tiga puluh persen) untuk program D3 dan 45% (empat puluh lima persen) untuk program D4 dari jumlah seluruh dosen pada jenjang pendidikan tersebut.</p>', '100%', '2025-06-18 00:37:55', '2025-06-18 00:37:55'),
(42, 6, '<p>Tersedianya dokumen yang menunjukkan jumlah dosen yang memiliki jabatan Lektor Kepala di POLINEMA paling sedikit 30% (tiga puluh persen) untuk program D3; 45% (empat puluh lima persen) untuk program D4; dan 60% (enam puluh persen) untuk program Magister Terapan dari jumlah seluruh dosen pada jenjang pendidikan tersebut.</p>', '100%', '2025-06-18 00:37:55', '2025-06-18 00:37:55'),
(43, 6, '<p>Tersedianya dokumen yang menunjukkan jumlah Dosen yang ditugaskan untuk menjalankan proses Pembelajaran pada setiap Program Studi paling sedikit 5 (lima) orang.</p>', '100%', '2025-06-18 00:37:55', '2025-06-18 00:37:55'),
(44, 6, '<p>Tersedianya dokumen rekrutmen yang menunjukkan kualifikasi akademik Tenaga kependidikan paling rendah lulusan program diploma 3 (tiga) (bukti ijazah dan transkrip dengan akreditasi prodi minimal B) atau berkualifikasi setara dengan jenjang 5 (lima) KKNI sesuai dengan kualifikasi tugas pokok dan fungsinya. Khusus tenaga kependidikan sebagai tenaga administrasi, memiliki kualifikasi akademik paling rendah SMA atau sederajat (bukti ijazah dan transkrip dengan akreditasi sekolah minimal B).</p>', '100%', '2025-06-18 00:37:55', '2025-06-18 00:37:55'),
(45, 6, '<p>Tersedianya dokumen yang menunjukkan Tenaga kependidikan / Laboran / Teknisi memiliki sertifikat kompetensi sesuai dengan bidang tugas dan keahliannya (bukti sertifikat kompetensi, sertifikat pelatihan).</p>', '100%', '2025-06-18 00:37:55', '2025-06-18 00:37:55'),
(46, 7, '<p>Tersedianya bangunan kelas A atau setara yang memenuhi persyaratan teknis dan keamanan dan fasilitas umum dalam jumlah yang mencukupi sesuai persyaratan minimal SN-Dikti dalam penyelenggaraan proses pembelajaran.</p>', '100%', '2025-06-22 01:07:39', '2025-06-22 01:07:39'),
(47, 7, '<p>Ruang kerja pimpinan: minimal 15 m2 per orang.</p>', '100%', '2025-06-22 01:07:39', '2025-06-22 01:07:39'),
(48, 7, '<p>Ruang administrasi kantor: minimal 4 m2 per orang.</p>', '100%', '2025-06-22 01:07:39', '2025-06-22 01:07:39'),
(49, 7, '<p>Ruang kelas/aula: minimal 2 m2 per mahasiswa.</p>', '100%', '2025-06-22 01:07:39', '2025-06-22 01:07:39'),
(50, 7, '<p>Ruang kerja setiap dosen: minimal 4 m2 per dosen.</p>', '100%', '2025-06-22 01:07:39', '2025-06-22 01:07:39'),
(51, 7, '<p>Ruang ujian sidang D3/D4: 16 m2 per mahasiswa.</p>', '100%', '2025-06-22 01:07:39', '2025-06-22 01:07:39'),
(52, 7, '<p>Tersedia laboratorium/bengkel/studio/ ruang simulasi/lapang minimal 2 m2 per mahasiswa</p>', '100%', '2025-06-22 01:07:39', '2025-06-22 01:07:39'),
(53, 7, '<p>Tersedianya peralatan laboratorium dan bahan habis dengan jumlah yang memadai dan bermutu baik.</p>', '100%', '2025-06-22 01:07:39', '2025-06-22 01:07:39'),
(54, 7, '<p>Tersedia sarana belajar yang mencukupi (kursi, meja, papan tulis, spidol, penghapus, LCD, dekstop/ laptop, AC/kipas angin, sound system, dan internet/Wifi), serta dapat digunakan setiap hari (minimal 20 jam/ minggu).</p>', '100%', '2025-06-22 01:07:39', '2025-06-22 01:07:39'),
(55, 7, '<p>Tersedia Ruang perpustakaan: 1.6 m2 per orang.</p>', '100%', '2025-06-22 01:07:39', '2025-06-22 01:07:39'),
(56, 7, '<p>Tersedia akses internet di wilayah kampus dengan kecepatan minimal 10 MBPS</p>', '100%', '2025-06-22 01:07:39', '2025-06-22 01:07:39'),
(57, 8, '<p>Tersedianya dokumen kebijakan, rencana strategis, dan operasional terkait dengan pembelajaran yang dapat diakses oleh sivitas akademika dan pemangku kepentingan, serta dapat dijadikan pedoman bagi Program studi dalam melaksanakan program pembelajaran.</p>', '100%', '2025-06-22 01:11:10', '2025-06-22 01:11:10'),
(58, 8, '<p>Tersedianya dokumen panduan perencanaan, pelaksanaan, evaluasi, pengawasan, penjaminan mutu, dan pengembangan kegiatan pembelajaran dan dosen</p>', '100%', '2025-06-22 01:11:10', '2025-06-22 01:11:10'),
(59, 8, '<p>Tersedianya dokumen kurikulum pada setiap program studi.</p>', '100%', '2025-06-22 01:11:10', '2025-06-22 01:11:10'),
(60, 8, '<p>Tersedianya dokumen panduan penyusunan rencana pembelajaran semester (RPS)</p>', '100%', '2025-06-22 01:11:10', '2025-06-22 01:11:10'),
(61, 8, '<p>Tersedianya dokumen rencana pembelajaran semester (RPS) tiap mata kuliah.</p>', '100%', '2025-06-22 01:11:10', '2025-06-22 01:11:10'),
(62, 8, '<p>Tersedianya dokumen penyelenggaraan program pembelajaran (activity control, nilai mahasiswa, presensi mahasiswa dan dosen,presensi tenaga kependidikan, kontrak kuliah, rps, soal ujian, buku ajar/modul ajar, modul praktik/praktikum, berita acara yudisium, laporan panitia tugas akhir, dll) pada tiap program studi.</p>', '100%', '2025-06-22 01:11:10', '2025-06-22 01:11:10'),
(63, 8, '<p>Tersedianya dokumen kegiatan sistemik dalam rangka menciptakan suasana akademik dan budaya mutu yang baik (orasi ilmiah, kuliah tamu, seminar, dll).</p>', '100%', '2025-06-22 01:11:10', '2025-06-22 01:11:10'),
(64, 8, '<p>Tersedianya dokumen pemantauan dan evaluasi (hasil audit, hasil pengukuran kepuasan mahasiswa) secara periodik terhadap Program Studi dalam melaksanakan kegiatan Pembelajaran dalam rangka menjaga dan meningkatkan mutu proses pembelajaran.</p>', '100%', '2025-06-22 01:11:10', '2025-06-22 01:11:10'),
(65, 8, '<p>Tersedianya dokumen Rapat Tinjauan Manajemen (RTM).</p>', '100%', '2025-06-22 01:11:10', '2025-06-22 01:11:10'),
(66, 8, '<p>Tersedianya/terunggahnya dokumen laporan kinerja program studi dalam menyelenggarakan program pembelajaran pada pangkalan data pendidikan tinggi.</p>', '100%', '2025-06-22 01:11:10', '2025-06-22 01:11:10'),
(67, 9, '<p>Tercapainya standar satuan biaya operasional pendidikan (Dana Operasional Pendidikan/DOP) sebagai berikut:<br>a. Diploma 3 : DOP sebesar 21 juta rupiah/mahasiswa/tahun<br>b. Diploma 4 : DOP sebesar 21 Juta rupiah/mahasiswa/tahun<br>c. Magister Terapan: DOP sebesar 29 Juta rupiah/mahasiswa/tahun</p>', '100%', '2025-06-22 01:12:27', '2025-06-22 01:12:27'),
(68, 9, '<p>Tercapainya pendanaan dari sumber lain (diluar biaya pendidikan yang diperoleh dari mahasiswa (UKT)) sebesar 10% dari total pemasukan.</p>', '100%', '2025-06-22 01:12:27', '2025-06-22 01:12:27'),
(69, 10, '<p>1. Rasio Dosen Tetap terhadap Jumlah publikasi ilmiah hasil penelitian dalam<br>bentuk jurnal lokal ber-ISSN.</p>', '1', '2025-06-22 01:16:49', '2025-06-22 01:16:49'),
(70, 10, '<p>Rasio dosen tetap terhadap jumlah publikasi ilmiah hasil penelitian dalam bentuk jurnal ilmiah Nasional terakreditasi</p>', '0.9', '2025-06-22 01:16:49', '2025-06-22 01:16:49'),
(71, 10, '<p>Rasio Dosen tetap terhadap Publikasi ilmiah hasil penelitian dalam bentuk jurnal ilmiah Internasional</p>', '0.15', '2025-06-22 01:16:49', '2025-06-22 01:16:49'),
(72, 10, '<p>Jumlah publikasi artikel ilmiah terindex per Dosen setiap tahun meningkat</p>', '0.7', '2025-06-22 01:16:49', '2025-06-22 01:16:49'),
(73, 10, '<p>Jumlah sitasi artikel ilmiah per Dosen setiap tahun meningkat</p>', '1000', '2025-06-22 01:16:49', '2025-06-22 01:16:49'),
(74, 10, '<p>Jumlah produk inovasi dosen setiap tahun meningkat.</p>', '20', '2025-06-22 01:16:49', '2025-06-22 01:16:49'),
(75, 10, '<p>Jumlah publikasi ilmiah hasil penelitian dalam bentuk prosiding seminar/konferensi Nasional ber-ISSN</p>', '40', '2025-06-22 01:16:49', '2025-06-22 01:16:49'),
(76, 10, '<p>Jumlah publikasi ilmiah hasil penelitian dalam bentuk prosiding seminar/konferensi internasional berindeks</p>', '100', '2025-06-22 01:16:49', '2025-06-22 01:16:49'),
(77, 10, '<p>Jumlah Buku ajar/Teks buku setiap tahun meningkat</p>', '130', '2025-06-22 01:16:49', '2025-06-22 01:16:49'),
(78, 10, '<p>Jumlah Kekayaan Intelektual (paten dan hak cipta)) yang diregistrasi setiap tahun bertambah.</p>', '80', '2025-06-22 01:16:49', '2025-06-22 01:16:49'),
(79, 10, '<p>&nbsp;Jumlah mahasiswa yang terlibat dalam penelitian bertambah</p>', '6.5%', '2025-06-22 01:16:49', '2025-06-22 01:16:49'),
(80, 10, '<p>&nbsp;Jumlah prototype/model/rekayasa</p>', '15', '2025-06-22 01:16:49', '2025-06-22 01:16:49'),
(81, 11, '<p>Tersedianya Rencana Induk Penelitian (RIP) POLINEMA</p>', 'ada', '2025-06-22 01:18:02', '2025-06-22 01:18:02'),
(82, 11, '<p>Tersedianya Road Map Penelitian</p>', 'ada', '2025-06-22 01:18:02', '2025-06-22 01:18:02'),
(83, 12, '<p>Terlaksananya penyampaian informasi rencana kegiatan penelitian (pengumuan jadwal penelitian oleh P2M)</p>', '11.1', '2025-06-22 01:19:10', '2025-06-22 01:19:10'),
(84, 12, '<p>&nbsp;Terlaksananya penerimaan proposal penelitian</p>', '11.2', '2025-06-22 01:19:10', '2025-06-22 01:19:10'),
(85, 13, '<p>Tersedianya Dokumen hasil penilaian usul penelitian</p>', 'ada', '2025-06-22 01:20:19', '2025-06-22 01:20:19'),
(86, 13, '<p>Tersedianya Dokumen legalitas penugasan peneliti/kerjasama peneliti,</p>', 'ada', '2025-06-22 01:20:19', '2025-06-22 01:20:19'),
(87, 13, '<p>Tersedianya Dokumen dokumentasi output penelitian</p>', 'ada', '2025-06-22 01:20:19', '2025-06-22 01:20:19'),
(88, 14, '<p>Ketersediaan Ruang Penyimpanan Arsip</p>', 'ada', '2025-06-22 01:21:23', '2025-06-22 01:21:23'),
(89, 14, '<p>Ketersediaan ruang penelitian terkait dengan bidang ilmu program studi</p>', '34', '2025-06-22 01:21:23', '2025-06-22 01:21:23'),
(90, 15, '<p>Ketersediaan dokumen laporan kegiatan penelitian, yang memenuhi 5 aspek (komprehensif, rinci, relevan, mutakhir, dan tepat waktu) yang dibuat oleh pengelola penelitian dilaporkan kepada pimpinan perguruan tinggi dan mitra/pemberi dana</p>', 'ada', '2025-06-22 01:22:20', '2025-06-22 01:22:20'),
(91, 16, '<p>Rata-rata dana penelitian dosen/tahun<br>D3 10 juta<br>D4 15 Juta<br>Magister terapan 20Juta</p>', 'ada', '2025-06-22 01:23:08', '2025-06-22 01:23:08'),
(92, 17, '<p>Jumlah kegiatan PkM tiap dosen minimum 1 kali per tahun</p>', '2', '2025-06-22 01:29:51', '2025-06-22 01:29:51'),
(93, 17, '<p>Jumlah kegiatan PkM oleh Dosen yang melibatkan mahasiswa meningkat</p>', '2', '2025-06-22 01:29:51', '2025-06-22 01:29:51'),
(94, 17, '<p>Jumlah mahasiswa yang terlibat dalam PkM meningkat</p>', '40%', '2025-06-22 01:29:51', '2025-06-22 01:29:51'),
(95, 17, '<p>Publikasi hasil PkM oleh dosen yang melibatkan mahasiswa Polinema secara nasional meningkat.</p>', '40%', '2025-06-22 01:29:51', '2025-06-22 01:29:51'),
(96, 17, '<p>Publikasi hasil PkM oleh dosen yang melibatkan mahasiswa Polinema secara internasional meningkat.</p>', '40%', '2025-06-22 01:29:51', '2025-06-22 01:29:51'),
(97, 17, '<p>Jumlah tindaklanjut hilirisasi hasil PkM di masyarakat meningkat</p>', '40%', '2025-06-22 01:29:51', '2025-06-22 01:29:51'),
(98, 17, '<p>Jumlah tindaklanjut pengembangan keilmuan program studi dari hasil PkM meningkat</p>', '40%', '2025-06-22 01:29:51', '2025-06-22 01:29:51'),
(99, 17, '<p>Jumlah kegiatan PkM oleh Mahasiswa yang direkognisi oleh Institusi/Program studi menigkat</p>', '40%', '2025-06-22 01:29:51', '2025-06-22 01:29:51'),
(100, 18, '<p>Jumlah PkM yang bersumber dari hasil Penelitian</p>', '100%', '2025-06-22 01:31:05', '2025-06-22 01:31:05'),
(101, 19, '<p>PKM dilaksanakan sesuai dengan road map dan time schedule</p>', '100%', '2025-06-22 01:31:44', '2025-06-22 01:31:44'),
(102, 20, '<p>Luaran berupa publikasi, makalah, HAKI, produk, mitra berbadan hukum, buku, atau luaran iptek lainnya meningkat</p>', '100%', '2025-06-22 01:32:21', '2025-06-22 01:32:21'),
(103, 21, '<p>Ketersediaan bukti Pelaksana PkM dari unsur Mahasiswa telah memiliki surat ijin dan rekomendasi mengikuti kegiatan PkM dari Ketua Program Studi.</p>', 'ada', '2025-06-22 01:33:16', '2025-06-22 01:33:16'),
(104, 22, '<p>Tersedia sarana dan prasarana pendukung PkM dengan jumlah yang memadai dengan kualitas baik.</p>', '100%', '2025-06-22 01:34:00', '2025-06-22 01:34:00'),
(105, 23, '<p>Tersedianya dokumen keterlibatan Mahasiswa dalam kegiatan program PkM</p>', 'ada', '2025-06-22 01:34:41', '2025-06-22 01:34:41'),
(106, 24, '<p>Dana Swadana Politeknik Negeri Malang untuk pengabdian kepada masyarakat per dosen per tahun.</p>', '7 Juta', '2025-06-22 01:36:21', '2025-06-22 01:36:21'),
(107, 24, '<p>Prosentase dana kegiatan PkM yang bersumber dari pemerintah</p>', '7.50%', '2025-06-22 01:36:21', '2025-06-22 01:36:21'),
(108, 24, '<p>Prosentase dana kegiatan PkM yang bersumber dari kerja sama dengan<br>lembaga lain</p>', '7.50%', '2025-06-22 01:36:21', '2025-06-22 01:36:21'),
(109, 25, '<p>kecukupan koleksi perpustakaan, aksesibilitas termasuk ketersediaan dan kemudahan akses elibrary. Untuk setiap bahan pustaka berikut.</p><ul><li>&nbsp;Buku teks</li><li>Jurnal internasional</li><li>Jurnal nasional terakreditasi</li><li>Prosiding</li><li>e-Journal</li><li>e-Book</li></ul>', 'Buku teks (20.000), Jurnal internasional (10), Jurnal nasional terakreditasi (100), Prosiding (100), e-Journal (20), e-Book (14.000)', '2025-06-22 01:38:10', '2025-06-22 01:38:10'),
(110, 26, '<p>Rasio jumlah calon mahasiswa yang ikut seleksi terhadap jumlah calon mahasiswa yang lulus seleksi.</p>', 'ada', '2025-06-22 01:40:00', '2025-06-22 01:40:00'),
(111, 26, '<p>Rasio jumlah mahasiswa yang mendaftar ulang terhadap jumlah mahasiswa yang lulus seleksi.</p>', 'ada', '2025-06-22 01:40:00', '2025-06-22 01:40:00'),
(112, 26, '<p>Rasio jumlah mahasiswa baru transfer terhadap jumlah mahasiswa baru bukan transfer.</p>', 'ada', '2025-06-22 01:40:00', '2025-06-22 01:40:00'),
(113, 26, '<p>Rasio jumlah mahasiswa asing terhadap seluruh jumlah mahasiswa aktif.</p>', 'ada', '2025-06-22 01:40:00', '2025-06-22 01:40:00'),
(114, 26, '<p>metoda rekrutmen seleksi mahasiswa baru.</p><ul><li>uji kognitif,</li><li>uji aptitude, dan</li><li>bentuk uji lain yang relevan dengan karakteristik pembelajaran di program studi.</li></ul>', 'ada', '2025-06-22 01:40:00', '2025-06-22 01:40:00'),
(115, 26, '<p>Ketetatan seleksi</p>', 'ada', '2025-06-22 01:40:00', '2025-06-22 01:40:00'),
(116, 27, '<p>layanan berupa bimbingan akademik, bimbingan karir, dan konseling untuk mendukung kelancaran studi mahasiswa.</p>', 'ada', '2025-06-22 01:41:07', '2025-06-22 01:41:07'),
(117, 27, '<p>mahasiswa untuk terlibat aktif dan berprestasi dalam kegiatan ilmiah maupun kegiatan yang berhubungan dengan minat bakat.</p>', 'ada', '2025-06-22 01:41:08', '2025-06-22 01:41:08'),
(118, 27, '<p>penghargaan kepada mahasiswa yang berprestasi dalam kegiatan ilmiah maupun kegiatan yang berhubungan dengan minat bakat.</p>', 'ada', '2025-06-22 01:41:08', '2025-06-22 01:41:08'),
(119, 28, '<p>&nbsp;Tracer study alumni, baik di tingkat pusat maupun program studi melalui unit tugas masing-masing.</p>', 'ada', '2025-06-22 01:41:53', '2025-06-22 01:41:53'),
(120, 29, '<p>Struktur organisasi, termasuk industrial advisory board yang disesuaikan dengan kebutuhan program yang diselenggarakan, dan tata kerja institusi yang dilengkapi tugas dan fungsi guna menjamin terlaksananya fungsi perguruan tinggi secara konsisten, efektif, dan efisien.</p>', 'ada', '2025-06-22 01:42:55', '2025-06-22 01:42:55'),
(121, 29, '<p>Memiliki standar mutu yang melampaui SNDIKTI dan memiliki daya saing internasional. Data indikator kinerja tambahan telah diukur, dimonitor, dikaji, dan dianalisis untuk perbaikan berkelanjutan.</p>', 'ada', '2025-06-22 01:42:55', '2025-06-22 01:42:55'),
(122, 30, '<p>IPK calon pendaftar minimal 3.0 (tiga titik nol)</p>', NULL, '2025-06-22 01:44:13', '2025-06-22 01:44:13'),
(123, 30, '<p>Lulusan calon pendaftar tidak lebih dari 3 tahun</p>', NULL, '2025-06-22 01:44:13', '2025-06-22 01:44:13'),
(124, 30, '<p>Jurusan yang diambil Calon pendaftar Alih jenjang harus yang serumpul/sebidang ilmunya</p>', NULL, '2025-06-22 01:44:13', '2025-06-22 01:44:13'),
(125, 30, '<p>Tidak buta warna untuk jurusan rekayasa</p>', NULL, '2025-06-22 01:44:13', '2025-06-22 01:44:13'),
(126, 30, '<p>Mendapatkan Nilai Test yang paling baik/bagus</p>', NULL, '2025-06-22 01:44:13', '2025-06-22 01:44:13'),
(127, 31, '<p>IPK calon pendaftar minimal 3.0 (Tiga titik nol)</p>', NULL, '2025-06-22 01:45:10', '2025-06-22 01:45:10'),
(128, 31, '<p>&nbsp;Lulusan calon pendaftar tidak lebih dari 2 tahun</p>', NULL, '2025-06-22 01:45:10', '2025-06-22 01:45:10'),
(129, 31, '<p>Hasil evaluasi alih kredit minimal 80% dari total SKS</p>', NULL, '2025-06-22 01:45:10', '2025-06-22 01:45:10'),
(130, 31, '<p>Calon pendaftar dari program studi terakreditasi minimal B</p>', NULL, '2025-06-22 01:45:10', '2025-06-22 01:45:10'),
(131, 32, '<p>Prosentase lulusan D3 Polinema yang memperoleh nilai TOEIC minimal 400 dalam sekali tes.</p>', NULL, '2025-06-22 01:46:38', '2025-06-22 01:46:38'),
(132, 32, '<p>Prosentase lulusan Sarjana Terapan (D4) Polinema yang memperoleh nilai TOEIC minimal 450 dalam sekali tes.</p>', NULL, '2025-06-22 01:46:38', '2025-06-22 01:46:38'),
(133, 32, '<p>Prosentase lulusan S2 Terapan Polinema yang memperoleh nilai TOEIC minimal 500 dalam sekali tes.</p>', NULL, '2025-06-22 01:46:38', '2025-06-22 01:46:38'),
(134, 33, '<p>&nbsp;Jumlah laptop untuk Dosen</p>', NULL, '2025-06-22 01:47:37', '2025-06-22 01:47:37'),
(135, 33, '<p>Jumlah pengelola E-learning tiap Jurusan</p>', NULL, '2025-06-22 01:47:37', '2025-06-22 01:47:37'),
(136, 33, '<p>Dosen yang mengajar berbasis E-learning</p>', NULL, '2025-06-22 01:47:37', '2025-06-22 01:47:37'),
(137, 34, '<p>Peningkatan Jumlah Mahasiswa yang mendapat Sertifikat Kompetensi Kerja yang diakui secara Nasional/Internasional.</p>', '25%', '2025-06-22 01:48:38', '2025-06-22 01:48:38'),
(138, 34, '<p>Peningkatan jumlah mahasiswa yang mendapat sertifikat kompetensi kerja internasional</p>', '4%', '2025-06-22 01:48:38', '2025-06-22 01:48:38'),
(139, 35, '<p>Ketersediaan panduan persyaratan (kriteria) Peneliti</p>', 'ada', '2025-06-22 02:16:05', '2025-06-22 02:16:05'),
(140, 35, '<p>Kesesuaian bidang keilmuan peneliti dengan tema penelitian.</p>', 'ada', '2025-06-22 02:16:05', '2025-06-22 02:16:05'),
(141, 35, '<p>Jumlah rekam jejak penelitian yang diperoleh peneliti, berskala nasional (SINTA) , dan atau berskala internasional.</p>', 'ada', '2025-06-22 02:16:05', '2025-06-22 02:16:05'),
(142, 36, '<p>Visi, misi, tujuan dan sasaran harus ditetapkan dengan SK Direktur+D224</p>', 'ada', '2025-06-22 02:39:35', '2025-06-22 02:39:35'),
(143, 36, '<p>kesesuaian Visi, Misi, Tujuan dan Strategi (VMTS) Unit Pengelola Program Studi (UPPS) terhadap VMTS Perguruan Tinggi (PT) dan visi keilmuan Program Studi (PS) yang dikelolanya.</p>', 'ada', '2025-06-22 02:39:35', '2025-06-22 02:39:35');

-- --------------------------------------------------------

--
-- Table structure for table `isi_standars`
--

CREATE TABLE `isi_standars` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nama_isi` varchar(255) NOT NULL,
  `keterangan` varchar(255) NOT NULL,
  `deskripsi` text NOT NULL,
  `status` enum('pending','validated') NOT NULL DEFAULT 'pending',
  `validated_by` bigint(20) UNSIGNED DEFAULT NULL,
  `validated_time` timestamp NULL DEFAULT NULL,
  `created_by` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `isi_standars`
--

INSERT INTO `isi_standars` (`id`, `nama_isi`, `keterangan`, `deskripsi`, `status`, `validated_by`, `validated_time`, `created_by`, `created_at`, `updated_at`) VALUES
(1, 'd', 'd', '<p>dssds</p>', 'validated', 11, '2025-06-11 13:49:26', 11, '2025-06-11 13:49:20', '2025-06-11 13:49:28');

-- --------------------------------------------------------

--
-- Table structure for table `jadwal`
--

CREATE TABLE `jadwal` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `periode_id` bigint(20) UNSIGNED NOT NULL,
  `judul` varchar(255) NOT NULL,
  `deskripsi` text DEFAULT NULL,
  `start_date` date NOT NULL,
  `start_time` time DEFAULT NULL,
  `end_date` date NOT NULL,
  `end_time` time DEFAULT NULL,
  `is_all_day` tinyint(1) NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `type` enum('rapat','audit','pelatihan','lainnya') NOT NULL DEFAULT 'lainnya',
  `priority` enum('rendah','sedang','tinggi','mendesak') NOT NULL DEFAULT 'sedang',
  `location` varchar(255) DEFAULT NULL,
  `meeting_link` varchar(255) DEFAULT NULL,
  `status` enum('pending','validated','rejected') NOT NULL DEFAULT 'pending',
  `validated_by` bigint(20) UNSIGNED DEFAULT NULL,
  `validated_time` timestamp NULL DEFAULT NULL,
  `created_by` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `jadwal`
--

INSERT INTO `jadwal` (`id`, `periode_id`, `judul`, `deskripsi`, `start_date`, `start_time`, `end_date`, `end_time`, `is_all_day`, `is_active`, `type`, `priority`, `location`, `meeting_link`, `status`, `validated_by`, `validated_time`, `created_by`, `created_at`, `updated_at`) VALUES
(2, 2, 'D4 Bahasa Inggris Untuk Industri Pariwisata', 'D4 Bahasa Inggris Untuk Industri Pariwisata', '2025-06-23', '08:00:00', '2025-06-23', '11:00:00', 0, 1, 'audit', 'tinggi', 'D4 Bahasa Inggris Untuk Industri Pariwisata', NULL, 'validated', 987654931, '2025-06-22 05:00:26', 987654931, '2025-06-22 04:45:42', '2025-06-22 05:00:35'),
(3, 2, 'D4 Bahasa Inggris Untuk Komunikasi Bisnis Dan Profesional', 'D4 Bahasa Inggris Untuk Komunikasi Bisnis Dan Profesional', '2025-06-23', '08:00:00', '2025-06-23', '11:00:00', 0, 1, 'audit', 'tinggi', 'D4 Bahasa Inggris Untuk Komunikasi Bisnis Dan Profesional', NULL, 'validated', 987654931, '2025-06-22 05:00:39', 987654931, '2025-06-22 04:47:30', '2025-06-22 05:00:46'),
(4, 2, 'D4 Manajemen Pemasaran', 'D4 Manajemen Pemasaran', '2025-06-23', '13:00:00', '2025-06-23', '16:00:00', 0, 1, 'audit', 'tinggi', 'D4 Manajemen Pemasaran', NULL, 'validated', 987654931, '2025-06-22 05:01:39', 987654931, '2025-06-22 04:49:32', '2025-06-22 05:01:48'),
(5, 2, 'D4 Pengelolaan Arsip Dan Rekaman Informasi', 'D4 Pengelolaan Arsip Dan Rekaman Informasi', '2025-06-23', '08:00:00', '2025-06-23', '11:00:00', 0, 1, 'audit', 'tinggi', 'D4 Pengelolaan Arsip Dan Rekaman Informasi', NULL, 'validated', 987654931, '2025-06-22 04:58:28', 987654931, '2025-06-22 04:51:14', '2025-06-22 04:58:40'),
(6, 2, 'D3 Akuntansi', 'D3 Akuntansi', '2025-06-23', '08:00:00', '2025-06-23', '11:00:00', 0, 1, 'audit', 'tinggi', 'D3 Akuntansi', NULL, 'validated', 987654931, '2025-06-22 04:59:26', 987654931, '2025-06-22 04:53:51', '2025-06-22 04:59:34'),
(7, 2, 'D4 Akuntansi Manajemen', 'D4 Akuntansi Manajemen', '2025-06-23', '13:00:00', '2025-06-23', '16:00:00', 0, 1, 'audit', 'tinggi', 'D4 Akuntansi Manajemen', NULL, 'validated', 987654931, '2025-06-22 04:57:56', 987654931, '2025-06-22 04:55:35', '2025-06-22 04:58:04'),
(8, 2, 'S2 Magister Terapan Sistem Informasi Akuntansi', 'S2 Magister Terapan Sistem Informasi Akuntansi', '2025-06-24', '08:00:00', '2025-06-24', '16:00:00', 0, 1, 'audit', 'tinggi', 'S2 Magister Terapan Sistem Informasi Akuntansi', NULL, 'validated', 987654931, '2025-06-22 04:57:44', 987654931, '2025-06-22 04:57:10', '2025-06-22 04:57:52'),
(9, 2, 'JURUSAN AKUNTANSI', 'JURUSAN AKUNTANSI', '2025-06-24', '13:00:00', '2025-06-24', '16:00:00', 0, 1, 'audit', 'tinggi', 'JURUSAN AKUNTANSI', NULL, 'validated', 987654931, NULL, 987654931, '2025-06-22 05:03:33', '2025-06-22 05:03:33'),
(10, 2, 'D3 Teknik Elektronika', 'D3 Teknik Elektronika', '2025-06-24', '08:00:00', '2025-06-24', '11:00:00', 0, 1, 'audit', 'tinggi', 'D3 Teknik Elektronika', NULL, 'validated', 987654931, NULL, 987654931, '2025-06-22 05:05:02', '2025-06-22 05:05:02'),
(11, 2, 'D4 Sistem Kelistrikan', 'D4 Sistem Kelistrikan', '2025-06-24', '08:00:00', '2025-06-24', '11:00:00', 0, 1, 'audit', 'tinggi', 'D4 Sistem Kelistrikan', NULL, 'validated', 987654931, NULL, 987654931, '2025-06-22 05:06:39', '2025-06-22 05:06:39'),
(12, 2, 'D4 Teknik Elektronika', 'D4 Teknik Elektronika', '2025-06-24', '08:00:00', '2025-06-24', '11:00:00', 0, 1, 'audit', 'tinggi', 'D4 Teknik Elektronika', NULL, 'validated', 987654931, NULL, 987654931, '2025-06-22 05:10:25', '2025-06-22 05:10:25'),
(13, 2, 'D4 Teknik Jaringan Telekomunikasi Digital', 'D4 Teknik Jaringan Telekomunikasi Digital', '2025-06-24', '13:00:00', '2025-06-24', '16:00:00', 0, 1, 'audit', 'tinggi', 'D4 Teknik Jaringan Telekomunikasi Digital', NULL, 'validated', 987654931, NULL, 987654931, '2025-06-22 05:11:54', '2025-06-22 05:11:54'),
(14, 2, 'JURUSAN TEKNIK ELEKTRO', 'JURUSAN TEKNIK ELEKTRO', '2025-06-24', '08:00:00', '2025-06-24', '11:00:00', 0, 1, 'audit', 'tinggi', 'JURUSAN TEKNIK ELEKTRO', NULL, 'validated', 987654931, NULL, 987654931, '2025-06-22 05:13:53', '2025-06-22 05:13:53'),
(15, 2, 'D2 Pengembangan Piranti Lunak Situs', 'D2 Pengembangan Piranti Lunak Situs', '2025-06-24', '13:00:00', '2025-06-24', '16:00:00', 0, 1, 'audit', 'tinggi', 'D2 Pengembangan Piranti Lunak Situs', NULL, 'validated', 987654931, NULL, 987654931, '2025-06-22 05:15:03', '2025-06-22 05:15:03'),
(16, 2, 'D4 Sistem Informsi Bisnis', 'D4 Sistem Informsi Bisnis', '2025-06-24', '13:00:00', '2025-06-24', '16:00:00', 0, 1, 'audit', 'tinggi', 'D4 Sistem Informsi Bisnis', NULL, 'validated', 987654931, NULL, 987654931, '2025-06-22 05:16:23', '2025-06-22 05:16:23'),
(17, 2, 'D4 Teknik Informatika', 'D4 Teknik Informatika', '2025-06-24', '13:00:00', '2025-06-24', '16:00:00', 0, 1, 'audit', 'tinggi', 'D4 Teknik Informatika', NULL, 'validated', 987654931, NULL, 987654931, '2025-06-22 05:26:54', '2025-06-22 05:26:54'),
(18, 2, 'S2 Magister Terapan Rekayasa Teknologi Informatika', 'S2 Magister Terapan Rekayasa Teknologi Informatika', '2025-06-24', '13:00:00', '2025-06-24', '16:00:00', 0, 1, 'audit', 'tinggi', 'S2 Magister Terapan Rekayasa Teknologi Informatika', NULL, 'validated', 987654931, NULL, 987654931, '2025-06-22 05:28:17', '2025-06-22 05:28:17'),
(19, 2, 'JURUSAN TEKNOLOGI INFORMASI', 'JURUSAN TEKNOLOGI INFORMASI', '2025-06-24', '13:00:00', '2025-06-24', '16:00:00', 0, 1, 'audit', 'tinggi', 'JURUSAN TEKNOLOGI INFORMASI', NULL, 'validated', 987654931, NULL, 987654931, '2025-06-22 05:29:35', '2025-06-22 05:29:35'),
(20, 2, 'D4 Keuangan', 'D4 Keuangan', '2025-06-25', '13:00:00', '2025-06-25', '16:00:00', 0, 1, 'audit', 'tinggi', 'D4 Keuangan', NULL, 'validated', 987654931, NULL, 987654931, '2025-06-22 05:31:29', '2025-06-22 05:31:29'),
(21, 2, 'D3 Teknik Kimia', 'D3 Teknik Kimia', '2025-06-25', '08:00:00', '2025-06-25', '11:00:00', 0, 1, 'audit', 'tinggi', 'D3 Teknik Kimia', NULL, 'validated', 987654931, NULL, 987654931, '2025-06-22 05:33:01', '2025-06-22 05:33:01'),
(22, 2, 'D4 Teknologi Kimia Industri', 'D4 Teknologi Kimia Industri', '2025-06-25', '08:00:00', '2025-06-25', '11:00:00', 0, 1, 'audit', 'tinggi', 'D4 Teknologi Kimia Industri', NULL, 'validated', 987654931, NULL, 987654931, '2025-06-22 05:34:06', '2025-06-22 05:34:06'),
(23, 2, 'S2 Magister Terapan Optimasi Rekayasa Kimia', 'S2 Magister Terapan Optimasi Rekayasa Kimia', '2025-06-25', '13:00:00', '2025-06-25', '16:00:00', 0, 1, 'audit', 'tinggi', 'S2 Magister Terapan Optimasi Rekayasa Kimia', NULL, 'validated', 987654931, NULL, 987654931, '2025-06-22 05:35:06', '2025-06-22 05:35:06'),
(24, 2, 'JURUSAN TEKNIK KIMIA', NULL, '2025-06-25', '08:00:00', '2025-06-25', '11:00:00', 0, 1, 'audit', 'tinggi', 'JURUSAN TEKNIK KIMIA', NULL, 'validated', 987654931, NULL, 987654931, '2025-06-22 05:36:21', '2025-06-22 05:36:21'),
(25, 2, 'D3 Teknik Mesin', 'D3 Teknik Mesin', '2025-06-25', '13:00:00', '2025-06-25', '16:00:00', 0, 1, 'audit', 'tinggi', 'D3 Teknik Mesin', NULL, 'validated', 987654931, NULL, 987654931, '2025-06-22 05:37:46', '2025-06-22 05:37:46'),
(26, 2, 'D4 Teknik Mesin Produksi Dan Perawatan', 'D4 Teknik Mesin Produksi Dan Perawatan', '2025-06-25', '13:00:00', '2025-06-25', '16:00:00', 0, 1, 'audit', 'tinggi', 'D4 Teknik Mesin Produksi Dan Perawatan', NULL, 'validated', 987654931, NULL, 987654931, '2025-06-22 05:39:00', '2025-06-22 05:39:00'),
(27, 2, 'D4 Teknik Otomotif Elektronik', 'D4 Teknik Otomotif Elektronik', '2025-06-25', '13:00:00', '2025-06-25', '16:00:00', 0, 1, 'audit', 'tinggi', 'D4 Teknik Otomotif Elektronik', NULL, 'validated', 987654931, NULL, 987654931, '2025-06-22 05:40:37', '2025-06-22 05:40:37'),
(28, 2, 'S2 Magister Terapan Rekayasa Teknologi Manufaktur', 'S2 Magister Terapan Rekayasa Teknologi Manufaktur', '2025-06-25', '13:00:00', '2025-06-25', '16:00:00', 0, 1, 'audit', 'tinggi', 'S2 Magister Terapan Rekayasa Teknologi Manufaktur', NULL, 'validated', 987654931, NULL, 987654931, '2025-06-22 05:41:55', '2025-06-22 05:41:55'),
(29, 2, 'S3 Doktor Terapan Optimasi Desain Mekanik', 'S3 Doktor Terapan Optimasi Desain Mekanik', '2025-06-25', '13:00:00', '2025-06-25', '16:00:00', 0, 1, 'audit', 'tinggi', 'S3 Doktor Terapan Optimasi Desain Mekanik', NULL, 'validated', 987654931, NULL, 987654931, '2025-06-22 05:43:22', '2025-06-22 05:43:22'),
(30, 2, 'JURUSAN TEKNIK MESIN', 'JURUSAN TEKNIK MESIN', '2025-06-25', '13:00:00', '2025-06-25', '16:00:00', 0, 1, 'audit', 'tinggi', 'JURUSAN TEKNIK MESIN', NULL, 'validated', 987654931, NULL, 987654931, '2025-06-22 05:45:40', '2025-06-22 05:45:40'),
(31, 2, 'D3 Administrasi Bisnis', 'D3 Administrasi Bisnis', '2025-06-26', '13:00:00', '2025-06-26', '16:00:00', 0, 1, 'audit', 'tinggi', 'D3 Administrasi Bisnis', NULL, 'validated', 987654931, NULL, 987654931, '2025-06-22 05:46:50', '2025-06-22 05:46:50'),
(32, 2, 'D3 Teknik Sipil', 'D3 Teknik Sipil', '2025-06-26', '08:00:00', '2025-06-26', '11:00:00', 0, 1, 'audit', 'tinggi', 'D3 Teknik Sipil', NULL, 'validated', 987654931, NULL, 987654931, '2025-06-22 05:48:17', '2025-06-22 05:48:17'),
(33, 2, 'D3 Teknologi Pertambangan', 'D3 Teknologi Pertambangan', '2025-06-26', '08:00:00', '2025-06-26', '11:00:00', 0, 1, 'audit', 'tinggi', 'D3 Teknologi Pertambangan', NULL, 'validated', 987654931, NULL, 987654931, '2025-06-22 05:49:36', '2025-06-22 05:49:36'),
(34, 2, 'D4 Manajemen Rekayasa Konstruksi', 'D4 Manajemen Rekayasa Konstruksi', '2025-06-26', '08:00:00', '2025-06-26', '11:00:00', 0, 1, 'audit', 'tinggi', 'D4 Manajemen Rekayasa Konstruksi', NULL, 'validated', 987654931, NULL, 987654931, '2025-06-22 05:50:50', '2025-06-22 05:50:50'),
(35, 2, 'D4 Teknologi Rekayasa Konstruksi Jalan Dan Jembatan', 'D4 Teknologi Rekayasa Konstruksi Jalan Dan Jembatan', '2025-06-26', '08:00:00', '2025-06-26', '11:00:00', 0, 1, 'audit', 'tinggi', 'D4 Teknologi Rekayasa Konstruksi Jalan Dan Jembatan', NULL, 'validated', 987654931, NULL, 987654931, '2025-06-22 05:52:08', '2025-06-22 05:52:08'),
(36, 2, 'JURUSAN TEKNIK SIPIL', 'JURUSAN TEKNIK SIPIL', '2025-06-26', '08:00:00', '2025-06-26', '11:00:00', 0, 1, 'audit', 'tinggi', 'JURUSAN TEKNIK SIPIL', NULL, 'validated', 987654931, NULL, 987654931, '2025-06-22 05:53:47', '2025-06-22 05:53:47'),
(37, 2, 'D3 Akuntansi Kampus Kediri', 'D3 Akuntansi Kampus Kediri', '2025-06-26', '13:00:00', '2025-06-26', '16:00:00', 0, 1, 'audit', 'tinggi', 'D3 Akuntansi Kampus Kediri', NULL, 'validated', 987654931, NULL, 987654931, '2025-06-22 05:55:11', '2025-06-22 05:55:11'),
(38, 2, 'D3 Manajemen Informatika Kampus Kediri', 'D3 Manajemen Informatika Kampus Kediri', '2025-06-26', '13:00:00', '2025-06-26', '16:00:00', 0, 1, 'audit', 'tinggi', 'D3 Manajemen Informatika Kampus Kediri', NULL, 'validated', 987654931, NULL, 987654931, '2025-06-22 05:56:22', '2025-06-22 05:56:22'),
(39, 2, 'D3 Teknik Mesin Kampus Kediri', 'D3 Teknik Mesin Kampus Kediri', '2025-06-26', '13:00:00', '2025-06-26', '16:00:00', 0, 1, 'audit', 'tinggi', 'D3 Teknik Mesin Kampus Kediri', NULL, 'validated', 987654931, NULL, 987654931, '2025-06-22 05:57:44', '2025-06-22 05:57:44'),
(40, 2, 'D4 Keuangan Kampus Kediri', 'D4 Keuangan Kampus Kediri', '2025-06-26', '13:00:00', '2025-06-26', '16:00:00', 0, 1, 'audit', 'tinggi', 'D4 Keuangan Kampus Kediri', NULL, 'validated', 987654931, NULL, 987654931, '2025-06-22 05:59:24', '2025-06-22 05:59:24'),
(41, 2, 'D4 Teknik Elektronika Kampus Kediri', 'D4 Teknik Elektronika Kampus Kediri', '2025-06-26', '13:00:00', '2025-06-26', '16:00:00', 0, 1, 'audit', 'tinggi', 'D4 Teknik Elektronika Kampus Kediri', NULL, 'validated', 987654931, NULL, 987654931, '2025-06-22 06:00:31', '2025-06-22 06:00:31'),
(42, 2, 'D4 Teknik Mesin Produksi Dan Perawatan Kampus Kediri', 'D4 Teknik Mesin Produksi Dan Perawatan Kampus Kediri', '2025-06-26', '13:00:00', '2025-06-26', '16:00:00', 0, 1, 'audit', 'tinggi', 'D4 Teknik Mesin Produksi Dan Perawatan Kampus Kediri', NULL, 'validated', 987654931, NULL, 987654931, '2025-06-22 06:02:22', '2025-06-22 06:02:22'),
(43, 2, 'PSDKU KEDIRI', 'PSDKU KEDIRI', '2025-06-26', '13:00:00', '2025-06-26', '16:00:00', 0, 1, 'audit', 'tinggi', 'PSDKU KEDIRI', NULL, 'validated', 987654931, NULL, 987654931, '2025-06-22 06:03:40', '2025-06-22 06:03:40'),
(44, 2, 'D4 Usaha Perjalanan Wisata', 'D4 Usaha Perjalanan Wisata', '2025-06-30', '08:00:00', '2025-06-30', '11:00:00', 0, 1, 'audit', 'tinggi', 'D4 Usaha Perjalanan Wisata', NULL, 'validated', 987654931, NULL, 987654931, '2025-06-22 06:04:55', '2025-06-22 06:04:55'),
(45, 2, 'JURUSAN ADMINISTRASI NIAGA', 'JURUSAN ADMINISTRASI NIAGA', '2025-06-30', '08:00:00', '2025-06-30', '11:00:00', 0, 1, 'audit', 'tinggi', 'JURUSAN ADMINISTRASI NIAGA', NULL, 'validated', 987654931, NULL, 987654931, '2025-06-22 06:06:05', '2025-06-22 06:06:05'),
(46, 2, 'D3 Teknik Listrik', 'D3 Teknik Listrik', '2025-06-30', '08:00:00', '2025-06-30', '11:00:00', 0, 1, 'audit', 'tinggi', 'D3 Teknik Listrik', NULL, 'validated', 987654931, NULL, 987654931, '2025-06-22 06:07:36', '2025-06-22 06:07:36'),
(47, 2, 'D3 Akuntansi Kampus Lumajang', 'D3 Akuntansi Kampus Lumajang', '2025-06-30', '08:00:00', '2025-06-30', '11:00:00', 0, 1, 'audit', 'tinggi', 'D3 Akuntansi Kampus Lumajang', NULL, 'validated', 987654931, NULL, 987654931, '2025-06-22 06:08:39', '2025-06-22 06:08:39'),
(48, 2, 'D3 Teknologi Informasi Kampus Lumajang', 'D3 Teknologi Informasi Kampus Lumajang', '2025-06-30', '08:00:00', '2025-06-30', '11:00:00', 0, 1, 'audit', 'tinggi', 'D3 Teknologi Informasi Kampus Lumajang', NULL, 'validated', 987654931, NULL, 987654931, '2025-06-22 06:09:56', '2025-06-22 06:09:56'),
(49, 2, 'D4 Teknologi Rekayasa Otomotif Kampus Lumajang', 'D4 Teknologi Rekayasa Otomotif Kampus Lumajang', '2025-06-30', '08:00:00', '2025-06-30', '11:00:00', 0, 1, 'audit', 'tinggi', 'D4 Teknologi Rekayasa Otomotif Kampus Lumajang', NULL, 'validated', 987654931, NULL, 987654931, '2025-06-22 06:11:13', '2025-06-22 06:11:13'),
(50, 2, 'PSDKU LUMAJANG', 'PSDKU LUMAJANG', '2025-06-30', '08:00:00', '2025-06-30', '11:00:00', 0, 1, 'audit', 'tinggi', 'PSDKU LUMAJANG', NULL, 'validated', 987654931, NULL, 987654931, '2025-06-22 06:12:15', '2025-06-22 06:12:15'),
(51, 2, 'D3 Manajemen Informatika Kampus PamekasanD3 Manajemen Informatika Kampus Pamekasan', 'D3 Manajemen Informatika Kampus PamekasanD3 Manajemen Informatika Kampus Pamekasan', '2025-06-30', '13:00:00', '2025-06-30', '16:00:00', 0, 1, 'audit', 'tinggi', 'D3 Manajemen Informatika Kampus Pamekasan', NULL, 'validated', 987654931, NULL, 987654931, '2025-06-22 06:13:38', '2025-06-22 06:13:38'),
(52, 2, 'D4 Akuntansi Manajemen Kampus Pamekasan', 'D4 Akuntansi Manajemen Kampus Pamekasan', '2025-06-30', '13:00:00', '2025-06-30', '16:00:00', 0, 1, 'audit', 'tinggi', 'D4 Akuntansi Manajemen Kampus Pamekasan', NULL, 'validated', 987654931, NULL, 987654931, '2025-06-22 06:14:42', '2025-06-22 06:14:42'),
(53, 2, 'D4 Teknik Otomotif Elektronik Kampus Pamekasan', 'D4 Teknik Otomotif Elektronik Kampus Pamekasan', '2025-06-30', '13:00:00', '2025-06-30', '16:00:00', 0, 1, 'audit', 'tinggi', 'D4 Teknik Otomotif Elektronik Kampus Pamekasan', NULL, 'validated', 987654931, NULL, 987654931, '2025-06-22 06:16:03', '2025-06-22 06:16:03'),
(54, 2, 'PSDKU PAMEKASAN', 'PSDKU PAMEKASAN', '2025-06-30', '13:00:00', '2025-06-30', '16:00:00', 0, 1, 'audit', 'tinggi', 'PSDKU PAMEKASAN', NULL, 'validated', 987654931, NULL, 987654931, '2025-06-22 06:17:23', '2025-06-22 06:17:23'),
(55, 2, 'S2 Magister Terapan Teknik Elektro', 'S2 Magister Terapan Teknik Elektro', '2025-07-01', '08:00:00', '2025-07-01', '11:00:00', 0, 1, 'audit', 'tinggi', 'S2 Magister Terapan Teknik Elektro', NULL, 'validated', 987654931, NULL, 987654931, '2025-06-22 06:18:49', '2025-06-22 06:18:49'),
(56, 2, 'S2 Magister Terapan Teknik Elektro', 'S2 Magister Terapan Teknik Elektro', '2025-07-01', '08:00:00', '2025-07-01', '11:00:00', 0, 1, 'audit', 'tinggi', 'S2 Magister Terapan Teknik Elektro', NULL, 'validated', 987654931, NULL, 987654931, '2025-06-22 06:20:18', '2025-06-22 06:20:18'),
(57, 2, 'Kepala Bagian Akademik dan Kemahasiswaan (BAK)', 'Kepala Bagian Akademik dan Kemahasiswaan (BAK)', '2025-07-01', '13:00:00', '2025-07-01', '16:00:00', 0, 1, 'audit', 'tinggi', 'Kepala Bagian Akademik dan Kemahasiswaan (BAK)', NULL, 'validated', 987654931, NULL, 987654931, '2025-06-22 06:21:32', '2025-06-22 06:21:32'),
(58, 2, 'Kepala Bagian Perencanaan, Keuangan Dan Umum (BPKU)', 'Kepala Bagian Perencanaan, Keuangan Dan Umum (BPKU)', '2025-07-01', '13:00:00', '2025-09-01', '16:00:00', 0, 1, 'audit', 'tinggi', 'Kepala Bagian Perencanaan, Keuangan Dan Umum (BPKU)', NULL, 'validated', 987654931, NULL, 987654931, '2025-06-22 06:22:47', '2025-06-22 06:22:47'),
(59, 2, 'Kepala P2MPP', 'Kepala P2MPP', '2025-07-01', '13:00:00', '2025-07-01', '16:00:00', 0, 1, 'audit', 'tinggi', 'Kepala P2MPP', NULL, 'validated', 987654931, NULL, 987654931, '2025-06-22 06:23:52', '2025-06-22 06:23:52'),
(60, 2, 'D3 Teknologi Pemeliharaan Pesawat Udara', 'D3 Teknologi Pemeliharaan Pesawat Udara', '2025-07-02', '13:00:00', '2025-07-02', '16:00:00', 0, 1, 'audit', 'tinggi', 'D3 Teknologi Pemeliharaan Pesawat Udara', NULL, 'validated', 987654931, NULL, 987654931, '2025-06-22 06:24:57', '2025-06-22 06:24:57'),
(61, 2, 'Kepala Pusat Penelitian Dan Pengabdian Kepada Masyarakat (P3M)', 'Kepala Pusat Penelitian Dan Pengabdian Kepada Masyarakat (P3M)', '2025-07-02', '08:00:00', '2025-07-02', '11:00:00', 0, 1, 'audit', 'tinggi', 'Kepala Pusat Penelitian Dan Pengabdian Kepada Masyarakat (P3M)', NULL, 'validated', 987654931, NULL, 987654931, '2025-06-22 06:26:10', '2025-06-22 06:26:10'),
(62, 2, 'Kepala Unit Penunjang Akademik Perpustakaan (UPA Perpustakaan)', 'Kepala Unit Penunjang Akademik Perpustakaan (UPA Perpustakaan)', '2025-07-02', '13:00:00', '2025-07-02', '16:00:00', 0, 1, 'audit', 'tinggi', 'Kepala Unit Penunjang Akademik Perpustakaan (UPA Perpustakaan)', NULL, 'validated', 987654931, NULL, 987654931, '2025-06-22 06:27:29', '2025-06-22 06:27:29'),
(63, 2, 'Kepala Unit Penunjang Teknologi Informasi Dan Komunikasi (UPA TIK)', 'Kepala Unit Penunjang Teknologi Informasi Dan Komunikasi (UPA TIK)', '2025-07-02', '08:00:00', '2025-07-02', '11:00:00', 0, 1, 'audit', 'tinggi', 'Kepala Unit Penunjang Teknologi Informasi Dan Komunikasi (UPA TIK)', NULL, 'validated', 987654931, NULL, 987654931, '2025-06-22 06:28:43', '2025-06-22 06:28:43'),
(64, 2, 'Kepala UPA Bahasa', 'Kepala UPA Bahasa', '2025-07-02', '13:00:00', '2025-07-02', '16:00:00', 0, 1, 'audit', 'tinggi', 'Kepala UPA Bahasa', NULL, 'validated', 987654931, NULL, 987654931, '2025-06-22 06:29:59', '2025-06-22 06:29:59'),
(65, 2, 'Kepala UPA Layanan Uji Kompetensi (LUK)', 'Kepala UPA Layanan Uji Kompetensi (LUK)', '2025-07-03', '13:00:00', '2025-07-03', '16:00:00', 0, 1, 'audit', 'tinggi', 'Kepala UPA Layanan Uji Kompetensi (LUK)', NULL, 'validated', 987654931, NULL, 987654931, '2025-06-22 06:31:31', '2025-06-22 06:31:31'),
(66, 2, 'Kepala UPA Perawatan dan Perbaikan  (PP)', 'Kepala UPA Perawatan dan Perbaikan  (PP)', '2025-07-03', '13:00:00', '2025-07-03', '16:00:00', 0, 1, 'audit', 'tinggi', 'Kepala UPA Perawatan dan Perbaikan  (PP)', NULL, 'validated', 987654931, NULL, 987654931, '2025-06-22 06:32:39', '2025-06-22 06:32:39'),
(67, 2, 'D3 Teknik Telekomunikasi', 'D3 Teknik Telekomunikasi', '2025-06-30', '08:00:00', '2025-06-30', '11:00:00', 0, 1, 'audit', 'tinggi', 'D3 Teknik Telekomunikasi', NULL, 'validated', 987654931, NULL, 987654931, '2025-06-22 06:33:46', '2025-06-22 06:33:46'),
(68, 2, 'Kepala UPA Pengembangan Karir dan Kewirausahaan (PKK)', 'Kepala UPA Pengembangan Karir dan Kewirausahaan (PKK)', '2025-07-04', '08:00:00', '2025-07-04', '11:00:00', 0, 1, 'audit', 'tinggi', 'Kepala UPA Pengembangan Karir dan Kewirausahaan (PKK)', NULL, 'validated', 987654931, NULL, 987654931, '2025-06-22 06:34:46', '2025-06-22 06:34:46'),
(69, 2, 'Kepala UPA Percetakan dan Penerbitan', 'Kepala UPA Percetakan dan Penerbitan', '2025-07-04', '08:00:00', '2025-07-04', '11:00:00', 0, 1, 'audit', 'tinggi', 'Kepala UPA Percetakan dan Penerbitan', NULL, 'validated', 987654931, NULL, 987654931, '2025-06-22 06:36:10', '2025-06-22 06:36:10');

-- --------------------------------------------------------

--
-- Table structure for table `jadwal_assignments`
--

CREATE TABLE `jadwal_assignments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `jadwal_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `role_user` enum('organizer','attendee','auditor','auditee','pimpinan','p2mpp','optional') NOT NULL DEFAULT 'attendee',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `jadwal_assignments`
--

INSERT INTO `jadwal_assignments` (`id`, `jadwal_id`, `user_id`, `role_user`, `created_at`, `updated_at`) VALUES
(3, 2, 987654983, 'auditor', '2025-06-22 04:45:42', '2025-06-22 04:45:42'),
(4, 2, 987654951, 'auditor', '2025-06-22 04:45:42', '2025-06-22 04:45:42'),
(5, 2, 987655063, 'auditee', '2025-06-22 04:45:42', '2025-06-22 04:45:42'),
(6, 3, 987654982, 'auditor', '2025-06-22 04:47:30', '2025-06-22 04:47:30'),
(7, 3, 987654984, 'auditor', '2025-06-22 04:47:31', '2025-06-22 04:47:31'),
(8, 3, 987654995, 'auditee', '2025-06-22 04:47:31', '2025-06-22 04:47:31'),
(9, 4, 987654967, 'auditor', '2025-06-22 04:49:32', '2025-06-22 04:49:32'),
(10, 4, 987654965, 'auditor', '2025-06-22 04:49:32', '2025-06-22 04:49:32'),
(11, 4, 987654996, 'auditee', '2025-06-22 04:49:32', '2025-06-22 04:49:32'),
(12, 5, 987654967, 'auditor', '2025-06-22 04:51:14', '2025-06-22 04:51:14'),
(13, 5, 987654963, 'auditor', '2025-06-22 04:51:14', '2025-06-22 04:51:14'),
(14, 5, 987654997, 'auditee', '2025-06-22 04:51:14', '2025-06-22 04:51:14'),
(15, 6, 987654964, 'auditor', '2025-06-22 04:53:51', '2025-06-22 04:53:51'),
(16, 6, 987654974, 'auditor', '2025-06-22 04:53:51', '2025-06-22 04:53:51'),
(17, 6, 987654998, 'auditee', '2025-06-22 04:53:51', '2025-06-22 04:53:51'),
(18, 7, 987654945, 'auditor', '2025-06-22 04:55:35', '2025-06-22 04:55:35'),
(19, 7, 987654984, 'auditor', '2025-06-22 04:55:35', '2025-06-22 04:55:35'),
(20, 7, 987654999, 'attendee', '2025-06-22 04:55:35', '2025-06-22 04:55:35'),
(21, 8, 987654964, 'auditor', '2025-06-22 04:57:10', '2025-06-22 04:57:10'),
(22, 8, 987654946, 'auditor', '2025-06-22 04:57:10', '2025-06-22 04:57:10'),
(23, 8, 987655000, 'auditee', '2025-06-22 04:57:10', '2025-06-22 04:57:10'),
(24, 9, 987654962, 'auditor', '2025-06-22 05:03:33', '2025-06-22 05:03:33'),
(25, 9, 987654963, 'auditor', '2025-06-22 05:03:33', '2025-06-22 05:03:33'),
(26, 9, 987655001, 'auditee', '2025-06-22 05:03:33', '2025-06-22 05:03:33'),
(27, 10, 987654945, 'auditor', '2025-06-22 05:05:02', '2025-06-22 05:05:02'),
(28, 10, 987654966, 'auditor', '2025-06-22 05:05:02', '2025-06-22 05:05:02'),
(29, 11, 987654944, 'auditor', '2025-06-22 05:06:39', '2025-06-22 05:06:39'),
(30, 11, 987654983, 'auditor', '2025-06-22 05:06:39', '2025-06-22 05:06:39'),
(31, 11, 987655003, 'auditee', '2025-06-22 05:06:39', '2025-06-22 05:06:39'),
(32, 12, 987654950, 'auditor', '2025-06-22 05:10:25', '2025-06-22 05:10:25'),
(33, 12, 987654965, 'auditor', '2025-06-22 05:10:25', '2025-06-22 05:10:25'),
(34, 12, 987655004, 'auditee', '2025-06-22 05:10:25', '2025-06-22 05:10:25'),
(35, 13, 987654955, 'auditor', '2025-06-22 05:11:54', '2025-06-22 05:11:54'),
(36, 13, 987654950, 'auditor', '2025-06-22 05:11:54', '2025-06-22 05:11:54'),
(37, 13, 987655005, 'auditee', '2025-06-22 05:11:54', '2025-06-22 05:11:54'),
(38, 14, 987654981, 'auditor', '2025-06-22 05:13:53', '2025-06-22 05:13:53'),
(39, 14, 987654984, 'auditor', '2025-06-22 05:13:53', '2025-06-22 05:13:53'),
(40, 14, 987655006, 'auditee', '2025-06-22 05:13:53', '2025-06-22 05:13:53'),
(41, 15, 987654970, 'auditor', '2025-06-22 05:15:03', '2025-06-22 05:15:03'),
(42, 15, 987654959, 'auditor', '2025-06-22 05:15:03', '2025-06-22 05:15:03'),
(43, 16, 987654956, 'auditor', '2025-06-22 05:16:23', '2025-06-22 05:16:23'),
(44, 16, 987654948, 'auditor', '2025-06-22 05:16:23', '2025-06-22 05:16:23'),
(45, 17, 987654944, 'auditor', '2025-06-22 05:26:54', '2025-06-22 05:26:54'),
(46, 17, 987655064, 'auditor', '2025-06-22 05:26:54', '2025-06-22 05:26:54'),
(47, 17, 987655009, 'auditee', '2025-06-22 05:26:54', '2025-06-22 05:26:54'),
(48, 18, 987654972, 'auditor', '2025-06-22 05:28:17', '2025-06-22 05:28:17'),
(49, 18, 987654949, 'auditor', '2025-06-22 05:28:17', '2025-06-22 05:28:17'),
(50, 18, 987655010, 'auditee', '2025-06-22 05:28:17', '2025-06-22 05:28:17'),
(51, 19, 987654965, 'attendee', '2025-06-22 05:29:35', '2025-06-22 05:29:35'),
(52, 19, 987654974, 'auditor', '2025-06-22 05:29:35', '2025-06-22 05:29:35'),
(53, 19, 987655011, 'auditee', '2025-06-22 05:29:35', '2025-06-22 05:29:35'),
(54, 20, 987654944, 'auditor', '2025-06-22 05:31:29', '2025-06-22 05:31:29'),
(55, 20, 987655064, 'auditor', '2025-06-22 05:31:29', '2025-06-22 05:31:29'),
(56, 20, 987655012, 'auditee', '2025-06-22 05:31:29', '2025-06-22 05:31:29'),
(57, 21, 987654975, 'auditor', '2025-06-22 05:33:01', '2025-06-22 05:33:01'),
(58, 21, 987654946, 'auditor', '2025-06-22 05:33:01', '2025-06-22 05:33:01'),
(59, 21, 987655013, 'auditee', '2025-06-22 05:33:01', '2025-06-22 05:33:01'),
(60, 22, 987654962, 'auditor', '2025-06-22 05:34:06', '2025-06-22 05:34:06'),
(61, 22, 987654982, 'auditor', '2025-06-22 05:34:06', '2025-06-22 05:34:06'),
(62, 23, 987654955, 'auditor', '2025-06-22 05:35:06', '2025-06-22 05:35:06'),
(63, 23, 987654943, 'auditor', '2025-06-22 05:35:06', '2025-06-22 05:35:06'),
(64, 24, 987654952, 'attendee', '2025-06-22 05:36:21', '2025-06-22 05:36:21'),
(65, 24, 987654959, 'attendee', '2025-06-22 05:36:21', '2025-06-22 05:36:21'),
(66, 24, 987655016, 'auditee', '2025-06-22 05:36:21', '2025-06-22 05:36:21'),
(67, 25, 987654968, 'auditor', '2025-06-22 05:37:46', '2025-06-22 05:37:46'),
(68, 25, 987654963, 'auditor', '2025-06-22 05:37:46', '2025-06-22 05:37:46'),
(69, 25, 987655017, 'auditee', '2025-06-22 05:37:46', '2025-06-22 05:37:46'),
(70, 26, 987654985, 'auditor', '2025-06-22 05:39:00', '2025-06-22 05:39:00'),
(71, 26, 987654951, 'auditor', '2025-06-22 05:39:00', '2025-06-22 05:39:00'),
(72, 26, 987655018, 'auditee', '2025-06-22 05:39:00', '2025-06-22 05:39:00'),
(73, 27, 987654950, 'auditor', '2025-06-22 05:40:37', '2025-06-22 05:40:37'),
(74, 27, 987654954, 'auditor', '2025-06-22 05:40:37', '2025-06-22 05:40:37'),
(75, 27, 987655019, 'auditee', '2025-06-22 05:40:37', '2025-06-22 05:40:37'),
(76, 28, 987654981, 'auditor', '2025-06-22 05:41:55', '2025-06-22 05:41:55'),
(77, 28, 987654949, 'auditor', '2025-06-22 05:41:55', '2025-06-22 05:41:55'),
(78, 28, 987655020, 'auditee', '2025-06-22 05:41:55', '2025-06-22 05:41:55'),
(79, 29, 987654956, 'auditor', '2025-06-22 05:43:22', '2025-06-22 05:43:22'),
(80, 29, 987654964, 'auditor', '2025-06-22 05:43:22', '2025-06-22 05:43:22'),
(81, 29, 987655021, 'auditee', '2025-06-22 05:43:22', '2025-06-22 05:43:22'),
(82, 30, 987654969, 'auditor', '2025-06-22 05:45:40', '2025-06-22 05:45:40'),
(83, 30, 987654967, 'auditor', '2025-06-22 05:45:40', '2025-06-22 05:45:40'),
(84, 30, 987655022, 'auditee', '2025-06-22 05:45:40', '2025-06-22 05:45:40'),
(85, 31, 987654985, 'attendee', '2025-06-22 05:46:50', '2025-06-22 05:46:50'),
(86, 31, 987654950, 'auditor', '2025-06-22 05:46:50', '2025-06-22 05:46:50'),
(87, 31, 987655023, 'auditee', '2025-06-22 05:46:50', '2025-06-22 05:46:50'),
(88, 32, 987654970, 'auditor', '2025-06-22 05:48:17', '2025-06-22 05:48:17'),
(89, 32, 987654950, 'auditor', '2025-06-22 05:48:17', '2025-06-22 05:48:17'),
(90, 32, 987655024, 'auditee', '2025-06-22 05:48:17', '2025-06-22 05:48:17'),
(91, 33, 987654972, 'auditor', '2025-06-22 05:49:36', '2025-06-22 05:49:36'),
(92, 33, 987654964, 'auditor', '2025-06-22 05:49:36', '2025-06-22 05:49:36'),
(93, 34, 987654968, 'auditor', '2025-06-22 05:50:50', '2025-06-22 05:50:50'),
(94, 34, 987654966, 'auditor', '2025-06-22 05:50:50', '2025-06-22 05:50:50'),
(95, 34, 987655026, 'auditee', '2025-06-22 05:50:50', '2025-06-22 05:50:50'),
(96, 35, 987654944, 'auditor', '2025-06-22 05:52:08', '2025-06-22 05:52:08'),
(97, 35, 987654951, 'auditor', '2025-06-22 05:52:08', '2025-06-22 05:52:08'),
(98, 35, 987655027, 'auditee', '2025-06-22 05:52:08', '2025-06-22 05:52:08'),
(99, 36, 987654956, 'auditor', '2025-06-22 05:53:47', '2025-06-22 05:53:47'),
(100, 36, 987654987, 'auditor', '2025-06-22 05:53:47', '2025-06-22 05:53:47'),
(101, 36, 987655028, 'auditee', '2025-06-22 05:53:47', '2025-06-22 05:53:47'),
(102, 37, 987654975, 'auditor', '2025-06-22 05:55:11', '2025-06-22 05:55:11'),
(103, 37, 987654946, 'auditor', '2025-06-22 05:55:11', '2025-06-22 05:55:11'),
(104, 37, 987655029, 'auditee', '2025-06-22 05:55:11', '2025-06-22 05:55:11'),
(105, 38, 987654952, 'auditor', '2025-06-22 05:56:22', '2025-06-22 05:56:22'),
(106, 38, 987655064, 'auditor', '2025-06-22 05:56:22', '2025-06-22 05:56:22'),
(107, 39, 987654959, 'auditor', '2025-06-22 05:57:44', '2025-06-22 05:57:44'),
(108, 39, 987654954, 'auditor', '2025-06-22 05:57:44', '2025-06-22 05:57:44'),
(109, 39, 987654986, 'auditee', '2025-06-22 05:57:44', '2025-06-22 05:57:44'),
(110, 40, 987654976, 'auditor', '2025-06-22 05:59:24', '2025-06-22 05:59:24'),
(111, 40, 987654983, 'auditor', '2025-06-22 05:59:24', '2025-06-22 05:59:24'),
(112, 40, 987655032, 'auditee', '2025-06-22 05:59:24', '2025-06-22 05:59:24'),
(113, 41, 987654970, 'auditor', '2025-06-22 06:00:31', '2025-06-22 06:00:31'),
(114, 41, 987654987, 'auditor', '2025-06-22 06:00:31', '2025-06-22 06:00:31'),
(115, 41, 987655033, 'auditee', '2025-06-22 06:00:31', '2025-06-22 06:00:31'),
(116, 42, 987654969, 'auditor', '2025-06-22 06:02:22', '2025-06-22 06:02:22'),
(117, 42, 987654943, 'auditor', '2025-06-22 06:02:22', '2025-06-22 06:02:22'),
(118, 42, 987655034, 'auditee', '2025-06-22 06:02:22', '2025-06-22 06:02:22'),
(119, 43, 987654962, 'attendee', '2025-06-22 06:03:40', '2025-06-22 06:03:40'),
(120, 43, 987654949, 'auditor', '2025-06-22 06:03:40', '2025-06-22 06:03:40'),
(121, 43, 987655032, 'auditee', '2025-06-22 06:03:40', '2025-06-22 06:03:40'),
(122, 44, 987654948, 'auditor', '2025-06-22 06:04:55', '2025-06-22 06:04:55'),
(123, 44, 987654977, 'auditor', '2025-06-22 06:04:55', '2025-06-22 06:04:55'),
(124, 44, 987655036, 'auditee', '2025-06-22 06:04:55', '2025-06-22 06:04:55'),
(125, 45, 987654960, 'auditor', '2025-06-22 06:06:05', '2025-06-22 06:06:05'),
(126, 45, 987654977, 'auditor', '2025-06-22 06:06:05', '2025-06-22 06:06:05'),
(127, 45, 987655037, 'auditee', '2025-06-22 06:06:05', '2025-06-22 06:06:05'),
(128, 46, 987654952, 'auditor', '2025-06-22 06:07:36', '2025-06-22 06:07:36'),
(129, 46, 987655040, 'auditor', '2025-06-22 06:07:36', '2025-06-22 06:07:36'),
(130, 46, 987655038, 'auditee', '2025-06-22 06:07:36', '2025-06-22 06:07:36'),
(131, 47, 987654945, 'auditor', '2025-06-22 06:08:39', '2025-06-22 06:08:39'),
(132, 47, 987655027, 'auditor', '2025-06-22 06:08:39', '2025-06-22 06:08:39'),
(133, 48, 987654974, 'auditor', '2025-06-22 06:09:56', '2025-06-22 06:09:56'),
(134, 48, 987654982, 'auditor', '2025-06-22 06:09:56', '2025-06-22 06:09:56'),
(135, 48, 987655040, 'auditee', '2025-06-22 06:09:56', '2025-06-22 06:09:56'),
(136, 49, 987654966, 'auditor', '2025-06-22 06:11:13', '2025-06-22 06:11:13'),
(137, 49, 987654943, 'auditor', '2025-06-22 06:11:13', '2025-06-22 06:11:13'),
(138, 50, 987654971, 'auditor', '2025-06-22 06:12:15', '2025-06-22 06:12:15'),
(139, 50, 987654980, 'auditor', '2025-06-22 06:12:15', '2025-06-22 06:12:15'),
(140, 50, 987655040, 'auditee', '2025-06-22 06:12:15', '2025-06-22 06:12:15'),
(141, 51, 987654987, 'auditor', '2025-06-22 06:13:38', '2025-06-22 06:13:38'),
(142, 51, 987654954, 'auditor', '2025-06-22 06:13:38', '2025-06-22 06:13:38'),
(143, 51, 987655044, 'auditee', '2025-06-22 06:13:38', '2025-06-22 06:13:38'),
(144, 52, 987654945, 'auditor', '2025-06-22 06:14:42', '2025-06-22 06:14:42'),
(145, 52, 987654984, 'auditor', '2025-06-22 06:14:42', '2025-06-22 06:14:42'),
(146, 52, 987654999, 'auditee', '2025-06-22 06:14:42', '2025-06-22 06:14:42'),
(147, 53, 987654974, 'auditor', '2025-06-22 06:16:03', '2025-06-22 06:16:03'),
(148, 53, 987654943, 'auditor', '2025-06-22 06:16:03', '2025-06-22 06:16:03'),
(149, 53, 987655046, 'auditee', '2025-06-22 06:16:03', '2025-06-22 06:16:03'),
(150, 54, 987654972, 'auditor', '2025-06-22 06:17:23', '2025-06-22 06:17:23'),
(151, 54, 987654963, 'auditor', '2025-06-22 06:17:23', '2025-06-22 06:17:23'),
(152, 54, 987655046, 'auditee', '2025-06-22 06:17:23', '2025-06-22 06:17:23'),
(153, 55, 987654971, 'attendee', '2025-06-22 06:18:49', '2025-06-22 06:18:49'),
(154, 55, 987654977, 'auditor', '2025-06-22 06:18:49', '2025-06-22 06:18:49'),
(155, 55, 987655048, 'auditee', '2025-06-22 06:18:49', '2025-06-22 06:18:49'),
(156, 56, 987654971, 'auditor', '2025-06-22 06:20:18', '2025-06-22 06:20:18'),
(157, 56, 987654985, 'auditor', '2025-06-22 06:20:18', '2025-06-22 06:20:18'),
(158, 56, 987655049, 'auditee', '2025-06-22 06:20:18', '2025-06-22 06:20:18'),
(159, 57, 987654960, 'auditor', '2025-06-22 06:21:32', '2025-06-22 06:21:32'),
(160, 57, 987654988, 'auditor', '2025-06-22 06:21:32', '2025-06-22 06:21:32'),
(161, 57, 987655050, 'auditee', '2025-06-22 06:21:32', '2025-06-22 06:21:32'),
(162, 58, 987654947, 'auditor', '2025-06-22 06:22:47', '2025-06-22 06:22:47'),
(163, 58, 987654989, 'auditor', '2025-06-22 06:22:47', '2025-06-22 06:22:47'),
(164, 58, 987655051, 'auditee', '2025-06-22 06:22:47', '2025-06-22 06:22:47'),
(165, 59, 987654981, 'auditor', '2025-06-22 06:23:52', '2025-06-22 06:23:52'),
(166, 59, 987654989, 'auditor', '2025-06-22 06:23:52', '2025-06-22 06:23:52'),
(167, 59, 987654960, 'auditee', '2025-06-22 06:23:52', '2025-06-22 06:23:52'),
(168, 60, 987654977, 'auditor', '2025-06-22 06:24:57', '2025-06-22 06:24:57'),
(169, 60, 987654948, 'auditor', '2025-06-22 06:24:57', '2025-06-22 06:24:57'),
(170, 60, 987655053, 'auditee', '2025-06-22 06:24:57', '2025-06-22 06:24:57'),
(171, 61, 987654947, 'auditor', '2025-06-22 06:26:10', '2025-06-22 06:26:10'),
(172, 61, 987654990, 'auditor', '2025-06-22 06:26:10', '2025-06-22 06:26:10'),
(173, 61, 987655054, 'auditor', '2025-06-22 06:26:10', '2025-06-22 06:26:10'),
(174, 62, 987654947, 'auditor', '2025-06-22 06:27:29', '2025-06-22 06:27:29'),
(175, 62, 987654988, 'auditor', '2025-06-22 06:27:29', '2025-06-22 06:27:29'),
(176, 62, 987655055, 'auditee', '2025-06-22 06:27:29', '2025-06-22 06:27:29'),
(177, 63, 987654960, 'auditor', '2025-06-22 06:28:43', '2025-06-22 06:28:43'),
(178, 63, 987654989, 'auditor', '2025-06-22 06:28:43', '2025-06-22 06:28:43'),
(179, 63, 987655056, 'auditee', '2025-06-22 06:28:43', '2025-06-22 06:28:43'),
(180, 64, 987654953, 'auditor', '2025-06-22 06:29:59', '2025-06-22 06:29:59'),
(181, 64, 987654990, 'auditor', '2025-06-22 06:29:59', '2025-06-22 06:29:59'),
(182, 64, 987655057, 'auditee', '2025-06-22 06:29:59', '2025-06-22 06:29:59'),
(183, 65, 987654953, 'auditor', '2025-06-22 06:31:31', '2025-06-22 06:31:31'),
(184, 65, 987654988, 'auditor', '2025-06-22 06:31:31', '2025-06-22 06:31:31'),
(185, 65, 987655058, 'auditee', '2025-06-22 06:31:31', '2025-06-22 06:31:31'),
(186, 66, 987654960, 'auditor', '2025-06-22 06:32:39', '2025-06-22 06:32:39'),
(187, 66, 987654990, 'auditor', '2025-06-22 06:32:39', '2025-06-22 06:32:39'),
(188, 66, 987655062, 'auditor', '2025-06-22 06:32:39', '2025-06-22 06:32:39'),
(189, 67, 987654976, 'auditor', '2025-06-22 06:33:46', '2025-06-22 06:33:46'),
(190, 67, 987654980, 'auditor', '2025-06-22 06:33:46', '2025-06-22 06:33:46'),
(191, 67, 987655059, 'auditee', '2025-06-22 06:33:46', '2025-06-22 06:33:46'),
(192, 68, 987654953, 'auditor', '2025-06-22 06:34:46', '2025-06-22 06:34:46'),
(193, 68, 987654988, 'auditor', '2025-06-22 06:34:46', '2025-06-22 06:34:46'),
(194, 68, 987655060, 'auditee', '2025-06-22 06:34:46', '2025-06-22 06:34:46'),
(195, 69, 987654977, 'auditor', '2025-06-22 06:36:10', '2025-06-22 06:36:10'),
(196, 69, 987654989, 'auditor', '2025-06-22 06:36:10', '2025-06-22 06:36:10'),
(197, 69, 987655061, 'auditee', '2025-06-22 06:36:10', '2025-06-22 06:36:10');

-- --------------------------------------------------------

--
-- Table structure for table `jadwal_units`
--

CREATE TABLE `jadwal_units` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `jadwal_id` bigint(20) UNSIGNED NOT NULL,
  `unit_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `jadwal_units`
--

INSERT INTO `jadwal_units` (`id`, `jadwal_id`, `unit_id`, `created_at`, `updated_at`) VALUES
(2, 2, 3, '2025-06-22 04:45:42', '2025-06-22 04:45:42'),
(3, 3, 4, '2025-06-22 04:47:31', '2025-06-22 04:47:31'),
(4, 4, 5, '2025-06-22 04:49:32', '2025-06-22 04:49:32'),
(5, 5, 6, '2025-06-22 04:51:14', '2025-06-22 04:51:14'),
(6, 6, 9, '2025-06-22 04:53:51', '2025-06-22 04:53:51'),
(7, 7, 10, '2025-06-22 04:55:35', '2025-06-22 04:55:35'),
(8, 8, 12, '2025-06-22 04:57:10', '2025-06-22 04:57:10'),
(9, 9, 13, '2025-06-22 05:03:33', '2025-06-22 05:03:33'),
(10, 10, 14, '2025-06-22 05:05:02', '2025-06-22 05:05:02'),
(11, 12, 16, '2025-06-22 05:10:25', '2025-06-22 05:10:25'),
(12, 13, 17, '2025-06-22 05:11:54', '2025-06-22 05:11:54'),
(13, 14, 21, '2025-06-22 05:13:53', '2025-06-22 05:13:53'),
(14, 15, 22, '2025-06-22 05:15:03', '2025-06-22 05:15:03'),
(15, 16, 23, '2025-06-22 05:16:23', '2025-06-22 05:16:23'),
(16, 17, 24, '2025-06-22 05:26:54', '2025-06-22 05:26:54'),
(17, 18, 25, '2025-06-22 05:28:17', '2025-06-22 05:28:17'),
(18, 19, 26, '2025-06-22 05:29:35', '2025-06-22 05:29:35'),
(19, 22, 28, '2025-06-22 05:34:06', '2025-06-22 05:34:06'),
(20, 23, 29, '2025-06-22 05:35:06', '2025-06-22 05:35:06'),
(21, 24, 30, '2025-06-22 05:36:21', '2025-06-22 05:36:21'),
(22, 25, 31, '2025-06-22 05:37:46', '2025-06-22 05:37:46'),
(23, 26, 33, '2025-06-22 05:39:00', '2025-06-22 05:39:00'),
(24, 27, 34, '2025-06-22 05:40:37', '2025-06-22 05:40:37'),
(25, 28, 35, '2025-06-22 05:41:55', '2025-06-22 05:41:55'),
(26, 29, 36, '2025-06-22 05:43:22', '2025-06-22 05:43:22'),
(27, 30, 37, '2025-06-22 05:45:40', '2025-06-22 05:45:40'),
(28, 31, 2, '2025-06-22 05:46:50', '2025-06-22 05:46:50'),
(29, 32, 38, '2025-06-22 05:48:17', '2025-06-22 05:48:17'),
(30, 33, 40, '2025-06-22 05:49:36', '2025-06-22 05:49:36'),
(31, 34, 41, '2025-06-22 05:50:50', '2025-06-22 05:50:50'),
(32, 35, 42, '2025-06-22 05:52:08', '2025-06-22 05:52:08'),
(33, 36, 43, '2025-06-22 05:53:47', '2025-06-22 05:53:47'),
(34, 38, 45, '2025-06-22 05:56:22', '2025-06-22 05:56:22'),
(35, 39, 46, '2025-06-22 05:57:44', '2025-06-22 05:57:44'),
(36, 40, 47, '2025-06-22 05:59:24', '2025-06-22 05:59:24'),
(37, 43, 50, '2025-06-22 06:03:40', '2025-06-22 06:03:40'),
(38, 44, 7, '2025-06-22 06:04:55', '2025-06-22 06:04:55'),
(39, 45, 8, '2025-06-22 06:06:05', '2025-06-22 06:06:05'),
(40, 51, 56, '2025-06-22 06:13:38', '2025-06-22 06:13:38'),
(41, 52, 57, '2025-06-22 06:14:42', '2025-06-22 06:14:42'),
(42, 53, 58, '2025-06-22 06:16:03', '2025-06-22 06:16:03'),
(43, 54, 59, '2025-06-22 06:17:23', '2025-06-22 06:17:23'),
(44, 55, 20, '2025-06-22 06:18:49', '2025-06-22 06:18:49'),
(45, 56, 20, '2025-06-22 06:20:18', '2025-06-22 06:20:18'),
(46, 57, 60, '2025-06-22 06:21:32', '2025-06-22 06:21:32'),
(47, 58, 61, '2025-06-22 06:22:47', '2025-06-22 06:22:47'),
(48, 59, 62, '2025-06-22 06:23:52', '2025-06-22 06:23:52'),
(49, 60, 32, '2025-06-22 06:24:57', '2025-06-22 06:24:57'),
(50, 63, 65, '2025-06-22 06:28:43', '2025-06-22 06:28:43'),
(51, 66, 68, '2025-06-22 06:32:39', '2025-06-22 06:32:39'),
(52, 67, 19, '2025-06-22 06:33:46', '2025-06-22 06:33:46'),
(53, 69, 70, '2025-06-22 06:36:10', '2025-06-22 06:36:10');

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

--
-- Dumping data for table `jobs`
--

INSERT INTO `jobs` (`id`, `queue`, `payload`, `attempts`, `reserved_at`, `available_at`, `created_at`) VALUES
(769, 'default', '{\"uuid\":\"4f02839f-fcf4-4881-8f6c-f325f4f58dc8\",\"displayName\":\"Filament\\\\Actions\\\\Imports\\\\Jobs\\\\ImportCsv\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":1750055625,\"data\":{\"commandName\":\"Filament\\\\Actions\\\\Imports\\\\Jobs\\\\ImportCsv\",\"command\":\"O:39:\\\"Filament\\\\Actions\\\\Imports\\\\Jobs\\\\ImportCsv\\\":6:{s:11:\\\"\\u0000*\\u0000importer\\\";O:33:\\\"App\\\\Filament\\\\Imports\\\\UserImporter\\\":3:{s:9:\\\"\\u0000*\\u0000import\\\";O:38:\\\"Filament\\\\Actions\\\\Imports\\\\Models\\\\Import\\\":30:{s:13:\\\"\\u0000*\\u0000connection\\\";s:5:\\\"mysql\\\";s:8:\\\"\\u0000*\\u0000table\\\";N;s:13:\\\"\\u0000*\\u0000primaryKey\\\";s:2:\\\"id\\\";s:10:\\\"\\u0000*\\u0000keyType\\\";s:3:\\\"int\\\";s:12:\\\"incrementing\\\";b:1;s:7:\\\"\\u0000*\\u0000with\\\";a:0:{}s:12:\\\"\\u0000*\\u0000withCount\\\";a:0:{}s:19:\\\"preventsLazyLoading\\\";b:0;s:10:\\\"\\u0000*\\u0000perPage\\\";i:15;s:6:\\\"exists\\\";b:1;s:18:\\\"wasRecentlyCreated\\\";b:1;s:28:\\\"\\u0000*\\u0000escapeWhenCastingToString\\\";b:0;s:13:\\\"\\u0000*\\u0000attributes\\\";a:8:{s:7:\\\"user_id\\\";i:11;s:9:\\\"file_name\\\";s:9:\\\"Book2.csv\\\";s:9:\\\"file_path\\\";s:115:\\\"H:\\\\espmi\\\\espmi-polinema\\\\espmi\\\\storage\\\\app\\/private\\\\livewire-tmp\\/PuKAQRzBfZcdB4gIQPB4rSEAlU8GLc-metaQm9vazIuY3N2-.csv\\\";s:8:\\\"importer\\\";s:33:\\\"App\\\\Filament\\\\Imports\\\\UserImporter\\\";s:10:\\\"total_rows\\\";i:3;s:10:\\\"updated_at\\\";s:19:\\\"2025-06-15 13:33:43\\\";s:10:\\\"created_at\\\";s:19:\\\"2025-06-15 13:33:43\\\";s:2:\\\"id\\\";i:1;}s:11:\\\"\\u0000*\\u0000original\\\";a:8:{s:7:\\\"user_id\\\";i:11;s:9:\\\"file_name\\\";s:9:\\\"Book2.csv\\\";s:9:\\\"file_path\\\";s:115:\\\"H:\\\\espmi\\\\espmi-polinema\\\\espmi\\\\storage\\\\app\\/private\\\\livewire-tmp\\/PuKAQRzBfZcdB4gIQPB4rSEAlU8GLc-metaQm9vazIuY3N2-.csv\\\";s:8:\\\"importer\\\";s:33:\\\"App\\\\Filament\\\\Imports\\\\UserImporter\\\";s:10:\\\"total_rows\\\";i:3;s:10:\\\"updated_at\\\";s:19:\\\"2025-06-15 13:33:43\\\";s:10:\\\"created_at\\\";s:19:\\\"2025-06-15 13:33:43\\\";s:2:\\\"id\\\";i:1;}s:10:\\\"\\u0000*\\u0000changes\\\";a:0:{}s:8:\\\"\\u0000*\\u0000casts\\\";a:4:{s:12:\\\"completed_at\\\";s:9:\\\"timestamp\\\";s:14:\\\"processed_rows\\\";s:7:\\\"integer\\\";s:10:\\\"total_rows\\\";s:7:\\\"integer\\\";s:15:\\\"successful_rows\\\";s:7:\\\"integer\\\";}s:17:\\\"\\u0000*\\u0000classCastCache\\\";a:0:{}s:21:\\\"\\u0000*\\u0000attributeCastCache\\\";a:0:{}s:13:\\\"\\u0000*\\u0000dateFormat\\\";N;s:10:\\\"\\u0000*\\u0000appends\\\";a:0:{}s:19:\\\"\\u0000*\\u0000dispatchesEvents\\\";a:0:{}s:14:\\\"\\u0000*\\u0000observables\\\";a:0:{}s:12:\\\"\\u0000*\\u0000relations\\\";a:0:{}s:10:\\\"\\u0000*\\u0000touches\\\";a:0:{}s:10:\\\"timestamps\\\";b:1;s:13:\\\"usesUniqueIds\\\";b:0;s:9:\\\"\\u0000*\\u0000hidden\\\";a:0:{}s:10:\\\"\\u0000*\\u0000visible\\\";a:0:{}s:11:\\\"\\u0000*\\u0000fillable\\\";a:0:{}s:10:\\\"\\u0000*\\u0000guarded\\\";a:0:{}}s:12:\\\"\\u0000*\\u0000columnMap\\\";a:6:{s:3:\\\"nip\\\";s:3:\\\"nip\\\";s:4:\\\"name\\\";s:4:\\\"name\\\";s:5:\\\"email\\\";s:5:\\\"email\\\";s:7:\\\"unit_id\\\";s:9:\\\"unit_name\\\";s:8:\\\"password\\\";s:8:\\\"password\\\";s:4:\\\"role\\\";s:4:\\\"role\\\";}s:10:\\\"\\u0000*\\u0000options\\\";a:0:{}}s:9:\\\"\\u0000*\\u0000import\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:38:\\\"Filament\\\\Actions\\\\Imports\\\\Models\\\\Import\\\";s:2:\\\"id\\\";i:1;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:7:\\\"\\u0000*\\u0000rows\\\";s:740:\\\"YTozOntpOjA7YTo2OntzOjM6Im5pcCI7czo5OiIxMjM0NTY3ODkiO3M6NDoibmFtZSI7czo4OiJKb2huIERvZSI7czo1OiJlbWFpbCI7czoxNjoiam9obkBleGFtcGxlLmNvbSI7czo4OiJwYXNzd29yZCI7czo5OiJwYXNzd29yZDEiO3M6NDoicm9sZSI7czoxMToic3VwZXJfYWRtaW4iO3M6OToidW5pdF9uYW1lIjtzOjE6ImMiO31pOjE7YTo2OntzOjM6Im5pcCI7czo5OiI5ODc2NTQzMjEiO3M6NDoibmFtZSI7czoxMDoiSmFuZSBTbWl0aCI7czo1OiJlbWFpbCI7czoxNjoiamFuZUBleGFtcGxlLmNvbSI7czo4OiJwYXNzd29yZCI7czo5OiJwYXNzd29yZDIiO3M6NDoicm9sZSI7czo4OiJwaW1waW5hbiI7czo5OiJ1bml0X25hbWUiO3M6MToiYyI7fWk6MjthOjY6e3M6MzoibmlwIjtzOjk6IjU1NTU1NTU1NSI7czo0OiJuYW1lIjtzOjEzOiJBbGljZSBKb2huc29uIjtzOjU6ImVtYWlsIjtzOjE3OiJhbGljZUBleGFtcGxlLmNvbSI7czo4OiJwYXNzd29yZCI7czo5OiJwYXNzd29yZDMiO3M6NDoicm9sZSI7czo1OiJwMm1wcCI7czo5OiJ1bml0X25hbWUiO3M6MToiYyI7fX0=\\\";s:12:\\\"\\u0000*\\u0000columnMap\\\";a:6:{s:3:\\\"nip\\\";s:3:\\\"nip\\\";s:4:\\\"name\\\";s:4:\\\"name\\\";s:5:\\\"email\\\";s:5:\\\"email\\\";s:7:\\\"unit_id\\\";s:9:\\\"unit_name\\\";s:8:\\\"password\\\";s:8:\\\"password\\\";s:4:\\\"role\\\";s:4:\\\"role\\\";}s:10:\\\"\\u0000*\\u0000options\\\";a:0:{}s:7:\\\"batchId\\\";s:36:\\\"9f28a566-4b6f-4940-a4ef-5e56b45d7471\\\";}\"}}', 255, NULL, 1749971707, 1749971707),
(770, 'default', '{\"uuid\":\"e527ca95-e621-4854-8491-6fb511ee2f5b\",\"displayName\":\"Filament\\\\Actions\\\\Imports\\\\Jobs\\\\ImportCsv\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":1750055831,\"data\":{\"commandName\":\"Filament\\\\Actions\\\\Imports\\\\Jobs\\\\ImportCsv\",\"command\":\"O:39:\\\"Filament\\\\Actions\\\\Imports\\\\Jobs\\\\ImportCsv\\\":6:{s:11:\\\"\\u0000*\\u0000importer\\\";O:33:\\\"App\\\\Filament\\\\Imports\\\\UserImporter\\\":3:{s:9:\\\"\\u0000*\\u0000import\\\";O:38:\\\"Filament\\\\Actions\\\\Imports\\\\Models\\\\Import\\\":30:{s:13:\\\"\\u0000*\\u0000connection\\\";s:5:\\\"mysql\\\";s:8:\\\"\\u0000*\\u0000table\\\";N;s:13:\\\"\\u0000*\\u0000primaryKey\\\";s:2:\\\"id\\\";s:10:\\\"\\u0000*\\u0000keyType\\\";s:3:\\\"int\\\";s:12:\\\"incrementing\\\";b:1;s:7:\\\"\\u0000*\\u0000with\\\";a:0:{}s:12:\\\"\\u0000*\\u0000withCount\\\";a:0:{}s:19:\\\"preventsLazyLoading\\\";b:0;s:10:\\\"\\u0000*\\u0000perPage\\\";i:15;s:6:\\\"exists\\\";b:1;s:18:\\\"wasRecentlyCreated\\\";b:1;s:28:\\\"\\u0000*\\u0000escapeWhenCastingToString\\\";b:0;s:13:\\\"\\u0000*\\u0000attributes\\\";a:8:{s:7:\\\"user_id\\\";i:11;s:9:\\\"file_name\\\";s:9:\\\"Book2.csv\\\";s:9:\\\"file_path\\\";s:115:\\\"H:\\\\espmi\\\\espmi-polinema\\\\espmi\\\\storage\\\\app\\/private\\\\livewire-tmp\\/FDpUZUH9fHKOtf29G9OQ7bsNM1311n-metaQm9vazIuY3N2-.csv\\\";s:8:\\\"importer\\\";s:33:\\\"App\\\\Filament\\\\Imports\\\\UserImporter\\\";s:10:\\\"total_rows\\\";i:3;s:10:\\\"updated_at\\\";s:19:\\\"2025-06-15 13:37:11\\\";s:10:\\\"created_at\\\";s:19:\\\"2025-06-15 13:37:11\\\";s:2:\\\"id\\\";i:2;}s:11:\\\"\\u0000*\\u0000original\\\";a:8:{s:7:\\\"user_id\\\";i:11;s:9:\\\"file_name\\\";s:9:\\\"Book2.csv\\\";s:9:\\\"file_path\\\";s:115:\\\"H:\\\\espmi\\\\espmi-polinema\\\\espmi\\\\storage\\\\app\\/private\\\\livewire-tmp\\/FDpUZUH9fHKOtf29G9OQ7bsNM1311n-metaQm9vazIuY3N2-.csv\\\";s:8:\\\"importer\\\";s:33:\\\"App\\\\Filament\\\\Imports\\\\UserImporter\\\";s:10:\\\"total_rows\\\";i:3;s:10:\\\"updated_at\\\";s:19:\\\"2025-06-15 13:37:11\\\";s:10:\\\"created_at\\\";s:19:\\\"2025-06-15 13:37:11\\\";s:2:\\\"id\\\";i:2;}s:10:\\\"\\u0000*\\u0000changes\\\";a:0:{}s:8:\\\"\\u0000*\\u0000casts\\\";a:4:{s:12:\\\"completed_at\\\";s:9:\\\"timestamp\\\";s:14:\\\"processed_rows\\\";s:7:\\\"integer\\\";s:10:\\\"total_rows\\\";s:7:\\\"integer\\\";s:15:\\\"successful_rows\\\";s:7:\\\"integer\\\";}s:17:\\\"\\u0000*\\u0000classCastCache\\\";a:0:{}s:21:\\\"\\u0000*\\u0000attributeCastCache\\\";a:0:{}s:13:\\\"\\u0000*\\u0000dateFormat\\\";N;s:10:\\\"\\u0000*\\u0000appends\\\";a:0:{}s:19:\\\"\\u0000*\\u0000dispatchesEvents\\\";a:0:{}s:14:\\\"\\u0000*\\u0000observables\\\";a:0:{}s:12:\\\"\\u0000*\\u0000relations\\\";a:0:{}s:10:\\\"\\u0000*\\u0000touches\\\";a:0:{}s:10:\\\"timestamps\\\";b:1;s:13:\\\"usesUniqueIds\\\";b:0;s:9:\\\"\\u0000*\\u0000hidden\\\";a:0:{}s:10:\\\"\\u0000*\\u0000visible\\\";a:0:{}s:11:\\\"\\u0000*\\u0000fillable\\\";a:0:{}s:10:\\\"\\u0000*\\u0000guarded\\\";a:0:{}}s:12:\\\"\\u0000*\\u0000columnMap\\\";a:6:{s:3:\\\"nip\\\";s:3:\\\"nip\\\";s:4:\\\"name\\\";s:4:\\\"name\\\";s:5:\\\"email\\\";s:5:\\\"email\\\";s:7:\\\"unit_id\\\";s:9:\\\"unit_name\\\";s:8:\\\"password\\\";s:8:\\\"password\\\";s:4:\\\"role\\\";s:4:\\\"role\\\";}s:10:\\\"\\u0000*\\u0000options\\\";a:0:{}}s:9:\\\"\\u0000*\\u0000import\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:38:\\\"Filament\\\\Actions\\\\Imports\\\\Models\\\\Import\\\";s:2:\\\"id\\\";i:2;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:7:\\\"\\u0000*\\u0000rows\\\";s:740:\\\"YTozOntpOjA7YTo2OntzOjM6Im5pcCI7czo5OiIxMjM0NTY3ODkiO3M6NDoibmFtZSI7czo4OiJKb2huIERvZSI7czo1OiJlbWFpbCI7czoxNjoiam9obkBleGFtcGxlLmNvbSI7czo4OiJwYXNzd29yZCI7czo5OiJwYXNzd29yZDEiO3M6NDoicm9sZSI7czoxMToic3VwZXJfYWRtaW4iO3M6OToidW5pdF9uYW1lIjtzOjE6ImMiO31pOjE7YTo2OntzOjM6Im5pcCI7czo5OiI5ODc2NTQzMjEiO3M6NDoibmFtZSI7czoxMDoiSmFuZSBTbWl0aCI7czo1OiJlbWFpbCI7czoxNjoiamFuZUBleGFtcGxlLmNvbSI7czo4OiJwYXNzd29yZCI7czo5OiJwYXNzd29yZDIiO3M6NDoicm9sZSI7czo4OiJwaW1waW5hbiI7czo5OiJ1bml0X25hbWUiO3M6MToiYyI7fWk6MjthOjY6e3M6MzoibmlwIjtzOjk6IjU1NTU1NTU1NSI7czo0OiJuYW1lIjtzOjEzOiJBbGljZSBKb2huc29uIjtzOjU6ImVtYWlsIjtzOjE3OiJhbGljZUBleGFtcGxlLmNvbSI7czo4OiJwYXNzd29yZCI7czo5OiJwYXNzd29yZDMiO3M6NDoicm9sZSI7czo1OiJwMm1wcCI7czo5OiJ1bml0X25hbWUiO3M6MToiYyI7fX0=\\\";s:12:\\\"\\u0000*\\u0000columnMap\\\";a:6:{s:3:\\\"nip\\\";s:3:\\\"nip\\\";s:4:\\\"name\\\";s:4:\\\"name\\\";s:5:\\\"email\\\";s:5:\\\"email\\\";s:7:\\\"unit_id\\\";s:9:\\\"unit_name\\\";s:8:\\\"password\\\";s:8:\\\"password\\\";s:4:\\\"role\\\";s:4:\\\"role\\\";}s:10:\\\"\\u0000*\\u0000options\\\";a:0:{}s:7:\\\"batchId\\\";s:36:\\\"9f28a6a2-9f43-417e-bcf8-8e73ea60c942\\\";}\"}}', 255, NULL, 1749971709, 1749971709),
(771, 'default', '{\"uuid\":\"ee672b4c-8867-4d36-9213-7d0f8702637f\",\"displayName\":\"Filament\\\\Actions\\\\Imports\\\\Jobs\\\\ImportCsv\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":1750057016,\"data\":{\"commandName\":\"Filament\\\\Actions\\\\Imports\\\\Jobs\\\\ImportCsv\",\"command\":\"O:39:\\\"Filament\\\\Actions\\\\Imports\\\\Jobs\\\\ImportCsv\\\":6:{s:11:\\\"\\u0000*\\u0000importer\\\";O:33:\\\"App\\\\Filament\\\\Imports\\\\UnitImporter\\\":3:{s:9:\\\"\\u0000*\\u0000import\\\";O:38:\\\"Filament\\\\Actions\\\\Imports\\\\Models\\\\Import\\\":30:{s:13:\\\"\\u0000*\\u0000connection\\\";s:5:\\\"mysql\\\";s:8:\\\"\\u0000*\\u0000table\\\";N;s:13:\\\"\\u0000*\\u0000primaryKey\\\";s:2:\\\"id\\\";s:10:\\\"\\u0000*\\u0000keyType\\\";s:3:\\\"int\\\";s:12:\\\"incrementing\\\";b:1;s:7:\\\"\\u0000*\\u0000with\\\";a:0:{}s:12:\\\"\\u0000*\\u0000withCount\\\";a:0:{}s:19:\\\"preventsLazyLoading\\\";b:0;s:10:\\\"\\u0000*\\u0000perPage\\\";i:15;s:6:\\\"exists\\\";b:1;s:18:\\\"wasRecentlyCreated\\\";b:1;s:28:\\\"\\u0000*\\u0000escapeWhenCastingToString\\\";b:0;s:13:\\\"\\u0000*\\u0000attributes\\\";a:8:{s:7:\\\"user_id\\\";i:11;s:9:\\\"file_name\\\";s:10:\\\"Books2.csv\\\";s:9:\\\"file_path\\\";s:119:\\\"H:\\\\espmi\\\\espmi-polinema\\\\espmi\\\\storage\\\\app\\/private\\\\livewire-tmp\\/S5nnrxonhHch9R7l6UvC7iSNUSRMfm-metaQm9va3MyLmNzdg==-.csv\\\";s:8:\\\"importer\\\";s:33:\\\"App\\\\Filament\\\\Imports\\\\UnitImporter\\\";s:10:\\\"total_rows\\\";i:3;s:10:\\\"updated_at\\\";s:19:\\\"2025-06-15 13:56:55\\\";s:10:\\\"created_at\\\";s:19:\\\"2025-06-15 13:56:55\\\";s:2:\\\"id\\\";i:4;}s:11:\\\"\\u0000*\\u0000original\\\";a:8:{s:7:\\\"user_id\\\";i:11;s:9:\\\"file_name\\\";s:10:\\\"Books2.csv\\\";s:9:\\\"file_path\\\";s:119:\\\"H:\\\\espmi\\\\espmi-polinema\\\\espmi\\\\storage\\\\app\\/private\\\\livewire-tmp\\/S5nnrxonhHch9R7l6UvC7iSNUSRMfm-metaQm9va3MyLmNzdg==-.csv\\\";s:8:\\\"importer\\\";s:33:\\\"App\\\\Filament\\\\Imports\\\\UnitImporter\\\";s:10:\\\"total_rows\\\";i:3;s:10:\\\"updated_at\\\";s:19:\\\"2025-06-15 13:56:55\\\";s:10:\\\"created_at\\\";s:19:\\\"2025-06-15 13:56:55\\\";s:2:\\\"id\\\";i:4;}s:10:\\\"\\u0000*\\u0000changes\\\";a:0:{}s:8:\\\"\\u0000*\\u0000casts\\\";a:4:{s:12:\\\"completed_at\\\";s:9:\\\"timestamp\\\";s:14:\\\"processed_rows\\\";s:7:\\\"integer\\\";s:10:\\\"total_rows\\\";s:7:\\\"integer\\\";s:15:\\\"successful_rows\\\";s:7:\\\"integer\\\";}s:17:\\\"\\u0000*\\u0000classCastCache\\\";a:0:{}s:21:\\\"\\u0000*\\u0000attributeCastCache\\\";a:0:{}s:13:\\\"\\u0000*\\u0000dateFormat\\\";N;s:10:\\\"\\u0000*\\u0000appends\\\";a:0:{}s:19:\\\"\\u0000*\\u0000dispatchesEvents\\\";a:0:{}s:14:\\\"\\u0000*\\u0000observables\\\";a:0:{}s:12:\\\"\\u0000*\\u0000relations\\\";a:0:{}s:10:\\\"\\u0000*\\u0000touches\\\";a:0:{}s:10:\\\"timestamps\\\";b:1;s:13:\\\"usesUniqueIds\\\";b:0;s:9:\\\"\\u0000*\\u0000hidden\\\";a:0:{}s:10:\\\"\\u0000*\\u0000visible\\\";a:0:{}s:11:\\\"\\u0000*\\u0000fillable\\\";a:0:{}s:10:\\\"\\u0000*\\u0000guarded\\\";a:0:{}}s:12:\\\"\\u0000*\\u0000columnMap\\\";a:6:{s:9:\\\"kode_unit\\\";s:9:\\\"kode_unit\\\";s:9:\\\"nama_unit\\\";s:9:\\\"nama_unit\\\";s:6:\\\"status\\\";s:6:\\\"status\\\";s:12:\\\"validated_by\\\";s:12:\\\"validated_by\\\";s:14:\\\"validated_time\\\";s:14:\\\"validated_time\\\";s:10:\\\"created_by\\\";s:10:\\\"created_by\\\";}s:10:\\\"\\u0000*\\u0000options\\\";a:0:{}}s:9:\\\"\\u0000*\\u0000import\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:38:\\\"Filament\\\\Actions\\\\Imports\\\\Models\\\\Import\\\";s:2:\\\"id\\\";i:4;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:7:\\\"\\u0000*\\u0000rows\\\";s:732:\\\"YTozOntpOjA7YTo2OntzOjk6ImtvZGVfdW5pdCI7czo1OiJENCBUSSI7czo5OiJuYW1hX3VuaXQiO3M6MTg6IlRla25payBJbmZvcm1hdGlrYSI7czo2OiJzdGF0dXMiO3M6OToidmFsaWRhdGVkIjtzOjEyOiJ2YWxpZGF0ZWRfYnkiO3M6MDoiIjtzOjE0OiJ2YWxpZGF0ZWRfdGltZSI7czowOiIiO3M6MTA6ImNyZWF0ZWRfYnkiO3M6MDoiIjt9aToxO2E6Njp7czo5OiJrb2RlX3VuaXQiO3M6NjoiRDQgU0lCIjtzOjk6Im5hbWFfdW5pdCI7czoyMzoiU2lzdGVtIEluZm9ybWFzaSBCaXNuaXMiO3M6Njoic3RhdHVzIjtzOjc6InBlbmRpbmciO3M6MTI6InZhbGlkYXRlZF9ieSI7czowOiIiO3M6MTQ6InZhbGlkYXRlZF90aW1lIjtzOjA6IiI7czoxMDoiY3JlYXRlZF9ieSI7czowOiIiO31pOjI7YTo2OntzOjk6ImtvZGVfdW5pdCI7czowOiIiO3M6OToibmFtYV91bml0IjtzOjA6IiI7czo2OiJzdGF0dXMiO3M6MDoiIjtzOjEyOiJ2YWxpZGF0ZWRfYnkiO3M6MDoiIjtzOjE0OiJ2YWxpZGF0ZWRfdGltZSI7czowOiIiO3M6MTA6ImNyZWF0ZWRfYnkiO3M6MDoiIjt9fQ==\\\";s:12:\\\"\\u0000*\\u0000columnMap\\\";a:6:{s:9:\\\"kode_unit\\\";s:9:\\\"kode_unit\\\";s:9:\\\"nama_unit\\\";s:9:\\\"nama_unit\\\";s:6:\\\"status\\\";s:6:\\\"status\\\";s:12:\\\"validated_by\\\";s:12:\\\"validated_by\\\";s:14:\\\"validated_time\\\";s:14:\\\"validated_time\\\";s:10:\\\"created_by\\\";s:10:\\\"created_by\\\";}s:10:\\\"\\u0000*\\u0000options\\\";a:0:{}s:7:\\\"batchId\\\";s:36:\\\"9f28adb1-8c51-493f-89e3-ca0d737f9b00\\\";}\"}}', 255, NULL, 1749971709, 1749971709);

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

--
-- Dumping data for table `job_batches`
--

INSERT INTO `job_batches` (`id`, `name`, `total_jobs`, `pending_jobs`, `failed_jobs`, `failed_job_ids`, `options`, `cancelled_at`, `created_at`, `finished_at`) VALUES
('9f28a566-4b6f-4940-a4ef-5e56b45d7471', '', 1, 1, 0, '[]', 'a:2:{s:13:\"allowFailures\";b:1;s:7:\"finally\";a:1:{i:0;O:47:\"Laravel\\SerializableClosure\\SerializableClosure\":1:{s:12:\"serializable\";O:46:\"Laravel\\SerializableClosure\\Serializers\\Signed\":2:{s:12:\"serializable\";s:3568:\"O:46:\"Laravel\\SerializableClosure\\Serializers\\Native\":5:{s:3:\"use\";a:4:{s:9:\"columnMap\";a:6:{s:3:\"nip\";s:3:\"nip\";s:4:\"name\";s:4:\"name\";s:5:\"email\";s:5:\"email\";s:7:\"unit_id\";s:9:\"unit_name\";s:8:\"password\";s:8:\"password\";s:4:\"role\";s:4:\"role\";}s:6:\"import\";O:45:\"Illuminate\\Contracts\\Database\\ModelIdentifier\":5:{s:5:\"class\";s:38:\"Filament\\Actions\\Imports\\Models\\Import\";s:2:\"id\";i:1;s:9:\"relations\";a:0:{}s:10:\"connection\";s:5:\"mysql\";s:15:\"collectionClass\";N;}s:13:\"jobConnection\";N;s:7:\"options\";a:0:{}}s:8:\"function\";s:2925:\"function () use ($columnMap, $import, $jobConnection, $options) {\n                    $import->touch(\'completed_at\');\n\n                    event(new \\Filament\\Actions\\Imports\\Events\\ImportCompleted($import, $columnMap, $options));\n\n                    if (! $import->user instanceof \\Illuminate\\Contracts\\Auth\\Authenticatable) {\n                        return;\n                    }\n\n                    $failedRowsCount = $import->getFailedRowsCount();\n\n                    \\Filament\\Notifications\\Notification::make()\n                        ->title($import->importer::getCompletedNotificationTitle($import))\n                        ->body($import->importer::getCompletedNotificationBody($import))\n                        ->when(\n                            ! $failedRowsCount,\n                            fn (\\Filament\\Notifications\\Notification $notification) => $notification->success(),\n                        )\n                        ->when(\n                            $failedRowsCount && ($failedRowsCount < $import->total_rows),\n                            fn (\\Filament\\Notifications\\Notification $notification) => $notification->warning(),\n                        )\n                        ->when(\n                            $failedRowsCount === $import->total_rows,\n                            fn (\\Filament\\Notifications\\Notification $notification) => $notification->danger(),\n                        )\n                        ->when(\n                            $failedRowsCount,\n                            fn (\\Filament\\Notifications\\Notification $notification) => $notification->actions([\n                                \\Filament\\Notifications\\Actions\\Action::make(\'downloadFailedRowsCsv\')\n                                    ->label(trans_choice(\'filament-actions::import.notifications.completed.actions.download_failed_rows_csv.label\', $failedRowsCount, [\n                                        \'count\' => \\Illuminate\\Support\\Number::format($failedRowsCount),\n                                    ]))\n                                    ->color(\'danger\')\n                                    ->url(route(\'filament.imports.failed-rows.download\', [\'import\' => $import], absolute: false), shouldOpenInNewTab: true)\n                                    ->markAsRead(),\n                            ]),\n                        )\n                        ->when(\n                            ($jobConnection === \'sync\') ||\n                                (blank($jobConnection) && (config(\'queue.default\') === \'sync\')),\n                            fn (\\Filament\\Notifications\\Notification $notification) => $notification\n                                ->persistent()\n                                ->send(),\n                            fn (\\Filament\\Notifications\\Notification $notification) => $notification->sendToDatabase($import->user, isEventDispatched: true),\n                        );\n                }\";s:5:\"scope\";s:29:\"Filament\\Actions\\ImportAction\";s:4:\"this\";N;s:4:\"self\";s:32:\"00000000000008680000000000000000\";}\";s:4:\"hash\";s:44:\"d+Ljgz44BuwS7lT65IE6Q/Sa8G486olNXGB+utaZd50=\";}}}}', NULL, 1749969224, NULL),
('9f28a6a2-9f43-417e-bcf8-8e73ea60c942', '', 1, 1, 0, '[]', 'a:2:{s:13:\"allowFailures\";b:1;s:7:\"finally\";a:1:{i:0;O:47:\"Laravel\\SerializableClosure\\SerializableClosure\":1:{s:12:\"serializable\";O:46:\"Laravel\\SerializableClosure\\Serializers\\Signed\":2:{s:12:\"serializable\";s:3568:\"O:46:\"Laravel\\SerializableClosure\\Serializers\\Native\":5:{s:3:\"use\";a:4:{s:9:\"columnMap\";a:6:{s:3:\"nip\";s:3:\"nip\";s:4:\"name\";s:4:\"name\";s:5:\"email\";s:5:\"email\";s:7:\"unit_id\";s:9:\"unit_name\";s:8:\"password\";s:8:\"password\";s:4:\"role\";s:4:\"role\";}s:6:\"import\";O:45:\"Illuminate\\Contracts\\Database\\ModelIdentifier\":5:{s:5:\"class\";s:38:\"Filament\\Actions\\Imports\\Models\\Import\";s:2:\"id\";i:2;s:9:\"relations\";a:0:{}s:10:\"connection\";s:5:\"mysql\";s:15:\"collectionClass\";N;}s:13:\"jobConnection\";N;s:7:\"options\";a:0:{}}s:8:\"function\";s:2925:\"function () use ($columnMap, $import, $jobConnection, $options) {\n                    $import->touch(\'completed_at\');\n\n                    event(new \\Filament\\Actions\\Imports\\Events\\ImportCompleted($import, $columnMap, $options));\n\n                    if (! $import->user instanceof \\Illuminate\\Contracts\\Auth\\Authenticatable) {\n                        return;\n                    }\n\n                    $failedRowsCount = $import->getFailedRowsCount();\n\n                    \\Filament\\Notifications\\Notification::make()\n                        ->title($import->importer::getCompletedNotificationTitle($import))\n                        ->body($import->importer::getCompletedNotificationBody($import))\n                        ->when(\n                            ! $failedRowsCount,\n                            fn (\\Filament\\Notifications\\Notification $notification) => $notification->success(),\n                        )\n                        ->when(\n                            $failedRowsCount && ($failedRowsCount < $import->total_rows),\n                            fn (\\Filament\\Notifications\\Notification $notification) => $notification->warning(),\n                        )\n                        ->when(\n                            $failedRowsCount === $import->total_rows,\n                            fn (\\Filament\\Notifications\\Notification $notification) => $notification->danger(),\n                        )\n                        ->when(\n                            $failedRowsCount,\n                            fn (\\Filament\\Notifications\\Notification $notification) => $notification->actions([\n                                \\Filament\\Notifications\\Actions\\Action::make(\'downloadFailedRowsCsv\')\n                                    ->label(trans_choice(\'filament-actions::import.notifications.completed.actions.download_failed_rows_csv.label\', $failedRowsCount, [\n                                        \'count\' => \\Illuminate\\Support\\Number::format($failedRowsCount),\n                                    ]))\n                                    ->color(\'danger\')\n                                    ->url(route(\'filament.imports.failed-rows.download\', [\'import\' => $import], absolute: false), shouldOpenInNewTab: true)\n                                    ->markAsRead(),\n                            ]),\n                        )\n                        ->when(\n                            ($jobConnection === \'sync\') ||\n                                (blank($jobConnection) && (config(\'queue.default\') === \'sync\')),\n                            fn (\\Filament\\Notifications\\Notification $notification) => $notification\n                                ->persistent()\n                                ->send(),\n                            fn (\\Filament\\Notifications\\Notification $notification) => $notification->sendToDatabase($import->user, isEventDispatched: true),\n                        );\n                }\";s:5:\"scope\";s:29:\"Filament\\Actions\\ImportAction\";s:4:\"this\";N;s:4:\"self\";s:32:\"0000000000000d640000000000000000\";}\";s:4:\"hash\";s:44:\"XrpmbHsNZ+1eAtLEB6W2zE8dRCUjF95QcbFFl3TQbyQ=\";}}}}', NULL, 1749969431, NULL),
('9f28a8f8-2263-4de0-b6a5-4fd50f29a032', '', 1, 0, 0, '[]', 'a:2:{s:13:\"allowFailures\";b:1;s:7:\"finally\";a:1:{i:0;O:47:\"Laravel\\SerializableClosure\\SerializableClosure\":1:{s:12:\"serializable\";O:46:\"Laravel\\SerializableClosure\\Serializers\\Signed\":2:{s:12:\"serializable\";s:3604:\"O:46:\"Laravel\\SerializableClosure\\Serializers\\Native\":5:{s:3:\"use\";a:4:{s:9:\"columnMap\";a:7:{s:3:\"nip\";s:3:\"nip\";s:4:\"name\";s:4:\"name\";s:5:\"email\";s:5:\"email\";s:9:\"unit_name\";s:9:\"unit_name\";s:10:\"avatar_url\";s:9:\"unit_name\";s:8:\"password\";s:8:\"password\";s:4:\"role\";s:4:\"role\";}s:6:\"import\";O:45:\"Illuminate\\Contracts\\Database\\ModelIdentifier\":5:{s:5:\"class\";s:38:\"Filament\\Actions\\Imports\\Models\\Import\";s:2:\"id\";i:3;s:9:\"relations\";a:0:{}s:10:\"connection\";s:5:\"mysql\";s:15:\"collectionClass\";N;}s:13:\"jobConnection\";N;s:7:\"options\";a:0:{}}s:8:\"function\";s:2925:\"function () use ($columnMap, $import, $jobConnection, $options) {\n                    $import->touch(\'completed_at\');\n\n                    event(new \\Filament\\Actions\\Imports\\Events\\ImportCompleted($import, $columnMap, $options));\n\n                    if (! $import->user instanceof \\Illuminate\\Contracts\\Auth\\Authenticatable) {\n                        return;\n                    }\n\n                    $failedRowsCount = $import->getFailedRowsCount();\n\n                    \\Filament\\Notifications\\Notification::make()\n                        ->title($import->importer::getCompletedNotificationTitle($import))\n                        ->body($import->importer::getCompletedNotificationBody($import))\n                        ->when(\n                            ! $failedRowsCount,\n                            fn (\\Filament\\Notifications\\Notification $notification) => $notification->success(),\n                        )\n                        ->when(\n                            $failedRowsCount && ($failedRowsCount < $import->total_rows),\n                            fn (\\Filament\\Notifications\\Notification $notification) => $notification->warning(),\n                        )\n                        ->when(\n                            $failedRowsCount === $import->total_rows,\n                            fn (\\Filament\\Notifications\\Notification $notification) => $notification->danger(),\n                        )\n                        ->when(\n                            $failedRowsCount,\n                            fn (\\Filament\\Notifications\\Notification $notification) => $notification->actions([\n                                \\Filament\\Notifications\\Actions\\Action::make(\'downloadFailedRowsCsv\')\n                                    ->label(trans_choice(\'filament-actions::import.notifications.completed.actions.download_failed_rows_csv.label\', $failedRowsCount, [\n                                        \'count\' => \\Illuminate\\Support\\Number::format($failedRowsCount),\n                                    ]))\n                                    ->color(\'danger\')\n                                    ->url(route(\'filament.imports.failed-rows.download\', [\'import\' => $import], absolute: false), shouldOpenInNewTab: true)\n                                    ->markAsRead(),\n                            ]),\n                        )\n                        ->when(\n                            ($jobConnection === \'sync\') ||\n                                (blank($jobConnection) && (config(\'queue.default\') === \'sync\')),\n                            fn (\\Filament\\Notifications\\Notification $notification) => $notification\n                                ->persistent()\n                                ->send(),\n                            fn (\\Filament\\Notifications\\Notification $notification) => $notification->sendToDatabase($import->user, isEventDispatched: true),\n                        );\n                }\";s:5:\"scope\";s:29:\"Filament\\Actions\\ImportAction\";s:4:\"this\";N;s:4:\"self\";s:32:\"0000000000000d8a0000000000000000\";}\";s:4:\"hash\";s:44:\"68haNu28R4fMViU/BhMzTWVhANXwPKgvsyl+8U7WFXk=\";}}}}', NULL, 1749969823, 1749970830),
('9f28adb1-8c51-493f-89e3-ca0d737f9b00', '', 1, 1, 0, '[]', 'a:2:{s:13:\"allowFailures\";b:1;s:7:\"finally\";a:1:{i:0;O:47:\"Laravel\\SerializableClosure\\SerializableClosure\":1:{s:12:\"serializable\";O:46:\"Laravel\\SerializableClosure\\Serializers\\Signed\":2:{s:12:\"serializable\";s:3630:\"O:46:\"Laravel\\SerializableClosure\\Serializers\\Native\":5:{s:3:\"use\";a:4:{s:9:\"columnMap\";a:6:{s:9:\"kode_unit\";s:9:\"kode_unit\";s:9:\"nama_unit\";s:9:\"nama_unit\";s:6:\"status\";s:6:\"status\";s:12:\"validated_by\";s:12:\"validated_by\";s:14:\"validated_time\";s:14:\"validated_time\";s:10:\"created_by\";s:10:\"created_by\";}s:6:\"import\";O:45:\"Illuminate\\Contracts\\Database\\ModelIdentifier\":5:{s:5:\"class\";s:38:\"Filament\\Actions\\Imports\\Models\\Import\";s:2:\"id\";i:4;s:9:\"relations\";a:0:{}s:10:\"connection\";s:5:\"mysql\";s:15:\"collectionClass\";N;}s:13:\"jobConnection\";N;s:7:\"options\";a:0:{}}s:8:\"function\";s:2925:\"function () use ($columnMap, $import, $jobConnection, $options) {\n                    $import->touch(\'completed_at\');\n\n                    event(new \\Filament\\Actions\\Imports\\Events\\ImportCompleted($import, $columnMap, $options));\n\n                    if (! $import->user instanceof \\Illuminate\\Contracts\\Auth\\Authenticatable) {\n                        return;\n                    }\n\n                    $failedRowsCount = $import->getFailedRowsCount();\n\n                    \\Filament\\Notifications\\Notification::make()\n                        ->title($import->importer::getCompletedNotificationTitle($import))\n                        ->body($import->importer::getCompletedNotificationBody($import))\n                        ->when(\n                            ! $failedRowsCount,\n                            fn (\\Filament\\Notifications\\Notification $notification) => $notification->success(),\n                        )\n                        ->when(\n                            $failedRowsCount && ($failedRowsCount < $import->total_rows),\n                            fn (\\Filament\\Notifications\\Notification $notification) => $notification->warning(),\n                        )\n                        ->when(\n                            $failedRowsCount === $import->total_rows,\n                            fn (\\Filament\\Notifications\\Notification $notification) => $notification->danger(),\n                        )\n                        ->when(\n                            $failedRowsCount,\n                            fn (\\Filament\\Notifications\\Notification $notification) => $notification->actions([\n                                \\Filament\\Notifications\\Actions\\Action::make(\'downloadFailedRowsCsv\')\n                                    ->label(trans_choice(\'filament-actions::import.notifications.completed.actions.download_failed_rows_csv.label\', $failedRowsCount, [\n                                        \'count\' => \\Illuminate\\Support\\Number::format($failedRowsCount),\n                                    ]))\n                                    ->color(\'danger\')\n                                    ->url(route(\'filament.imports.failed-rows.download\', [\'import\' => $import], absolute: false), shouldOpenInNewTab: true)\n                                    ->markAsRead(),\n                            ]),\n                        )\n                        ->when(\n                            ($jobConnection === \'sync\') ||\n                                (blank($jobConnection) && (config(\'queue.default\') === \'sync\')),\n                            fn (\\Filament\\Notifications\\Notification $notification) => $notification\n                                ->persistent()\n                                ->send(),\n                            fn (\\Filament\\Notifications\\Notification $notification) => $notification->sendToDatabase($import->user, isEventDispatched: true),\n                        );\n                }\";s:5:\"scope\";s:29:\"Filament\\Actions\\ImportAction\";s:4:\"this\";N;s:4:\"self\";s:32:\"000000000000088b0000000000000000\";}\";s:4:\"hash\";s:44:\"ZAMeRToWvtv0kKR3NAuEfLqLcYPzj1bEohEZdXD0z74=\";}}}}', NULL, 1749970616, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `media`
--

CREATE TABLE `media` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL,
  `uuid` char(36) DEFAULT NULL,
  `collection_name` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `mime_type` varchar(255) DEFAULT NULL,
  `disk` varchar(255) NOT NULL,
  `conversions_disk` varchar(255) DEFAULT NULL,
  `size` bigint(20) UNSIGNED NOT NULL,
  `manipulations` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`manipulations`)),
  `custom_properties` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`custom_properties`)),
  `generated_conversions` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`generated_conversions`)),
  `responsive_images` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`responsive_images`)),
  `order_column` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
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
(1, '0001_01_01_000001_create_cache_table', 1),
(2, '0001_01_01_000002_create_jobs_table', 1),
(3, '0001_01_01_000003_create_users_table', 1),
(4, '2025_02_23_164932_create_permission_tables', 1),
(5, '2025_03_11_060314_create_periodes_table', 1),
(6, '2025_03_11_154009_create_media_table', 1),
(7, '2025_03_14_104437_create_units_table', 1),
(8, '2025_03_16_121724_create_standars_table', 1),
(9, '2025_03_16_124634_create_isi_standars_table', 1),
(10, '2025_03_16_133134_create_sub_standars_table', 1),
(11, '2025_03_16_192611_create_indikators_table', 1),
(12, '2025_03_17_012509_create_unit_indikators_table', 1),
(13, '2025_04_11_040607_create_isi_indikators_table', 1),
(14, '2025_04_14_015019_add_foreign_keys_to_users_and_units', 1),
(15, '2025_04_20_133914_unit_indikator_standars', 1),
(16, '2025_04_20_133922_unit_indikator_indikators', 1),
(17, '2025_04_20_133939_unit_indikator_isi_indikators', 1),
(18, '2025_04_21_063457_create_assign_pengisians_table', 1),
(19, '2025_04_21_063605_create_auditor_assignments_table', 1),
(20, '2025_04_21_064051_create_pengisian_indikators_table', 1),
(21, '2025_04_21_064606_create_review_auditor1s_table', 1),
(22, '2025_04_21_064606_create_review_auditor2s_table', 1),
(23, '2025_05_20_add_periode_id_to_unit_indikators', 1),
(24, '2025_06_09_095924_create_jadwal_table', 1),
(25, '2025_06_15_133239_create_notifications_table', 2),
(26, '2025_06_15_133258_create_imports_table', 2),
(27, '2025_06_15_133259_create_exports_table', 2),
(28, '2025_06_15_133300_create_failed_import_rows_table', 2);

-- --------------------------------------------------------

--
-- Table structure for table `model_has_permissions`
--

CREATE TABLE `model_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `model_has_roles`
--

CREATE TABLE `model_has_roles` (
  `role_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `model_has_roles`
--

INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
(1, 'App\\Models\\User', 11),
(1, 'App\\Models\\User', 987654931),
(2, 'App\\Models\\User', 987654933),
(2, 'App\\Models\\User', 987654935),
(2, 'App\\Models\\User', 987654937),
(2, 'App\\Models\\User', 987654939),
(2, 'App\\Models\\User', 987654941),
(2, 'App\\Models\\User', 987654991),
(3, 'App\\Models\\User', 987654932),
(4, 'App\\Models\\User', 987654934),
(4, 'App\\Models\\User', 987654936),
(4, 'App\\Models\\User', 987654938),
(4, 'App\\Models\\User', 987654940),
(4, 'App\\Models\\User', 987654942),
(4, 'App\\Models\\User', 987654994),
(4, 'App\\Models\\User', 987654995),
(4, 'App\\Models\\User', 987654996),
(4, 'App\\Models\\User', 987654997),
(4, 'App\\Models\\User', 987654998),
(4, 'App\\Models\\User', 987654999),
(4, 'App\\Models\\User', 987655000),
(4, 'App\\Models\\User', 987655001),
(4, 'App\\Models\\User', 987655002),
(4, 'App\\Models\\User', 987655003),
(4, 'App\\Models\\User', 987655004),
(4, 'App\\Models\\User', 987655005),
(4, 'App\\Models\\User', 987655006),
(4, 'App\\Models\\User', 987655007),
(4, 'App\\Models\\User', 987655008),
(4, 'App\\Models\\User', 987655009),
(4, 'App\\Models\\User', 987655010),
(4, 'App\\Models\\User', 987655011),
(4, 'App\\Models\\User', 987655012),
(4, 'App\\Models\\User', 987655013),
(4, 'App\\Models\\User', 987655014),
(4, 'App\\Models\\User', 987655015),
(4, 'App\\Models\\User', 987655016),
(4, 'App\\Models\\User', 987655017),
(4, 'App\\Models\\User', 987655018),
(4, 'App\\Models\\User', 987655019),
(4, 'App\\Models\\User', 987655020),
(4, 'App\\Models\\User', 987655021),
(4, 'App\\Models\\User', 987655022),
(4, 'App\\Models\\User', 987655023),
(4, 'App\\Models\\User', 987655024),
(4, 'App\\Models\\User', 987655025),
(4, 'App\\Models\\User', 987655026),
(4, 'App\\Models\\User', 987655027),
(4, 'App\\Models\\User', 987655028),
(4, 'App\\Models\\User', 987655029),
(4, 'App\\Models\\User', 987655030),
(4, 'App\\Models\\User', 987655031),
(4, 'App\\Models\\User', 987655032),
(4, 'App\\Models\\User', 987655033),
(4, 'App\\Models\\User', 987655034),
(4, 'App\\Models\\User', 987655035),
(4, 'App\\Models\\User', 987655036),
(4, 'App\\Models\\User', 987655037),
(4, 'App\\Models\\User', 987655038),
(4, 'App\\Models\\User', 987655039),
(4, 'App\\Models\\User', 987655040),
(4, 'App\\Models\\User', 987655041),
(4, 'App\\Models\\User', 987655042),
(4, 'App\\Models\\User', 987655043),
(4, 'App\\Models\\User', 987655044),
(4, 'App\\Models\\User', 987655045),
(4, 'App\\Models\\User', 987655046),
(4, 'App\\Models\\User', 987655047),
(4, 'App\\Models\\User', 987655048),
(4, 'App\\Models\\User', 987655049),
(4, 'App\\Models\\User', 987655050),
(4, 'App\\Models\\User', 987655051),
(4, 'App\\Models\\User', 987655052),
(4, 'App\\Models\\User', 987655053),
(4, 'App\\Models\\User', 987655054),
(4, 'App\\Models\\User', 987655055),
(4, 'App\\Models\\User', 987655056),
(4, 'App\\Models\\User', 987655057),
(4, 'App\\Models\\User', 987655058),
(4, 'App\\Models\\User', 987655059),
(4, 'App\\Models\\User', 987655060),
(4, 'App\\Models\\User', 987655061),
(4, 'App\\Models\\User', 987655062),
(4, 'App\\Models\\User', 987655063),
(5, 'App\\Models\\User', 987654943),
(5, 'App\\Models\\User', 987654944),
(5, 'App\\Models\\User', 987654945),
(5, 'App\\Models\\User', 987654946),
(5, 'App\\Models\\User', 987654947),
(5, 'App\\Models\\User', 987654948),
(5, 'App\\Models\\User', 987654949),
(5, 'App\\Models\\User', 987654950),
(5, 'App\\Models\\User', 987654951),
(5, 'App\\Models\\User', 987654952),
(5, 'App\\Models\\User', 987654953),
(5, 'App\\Models\\User', 987654954),
(5, 'App\\Models\\User', 987654955),
(5, 'App\\Models\\User', 987654956),
(5, 'App\\Models\\User', 987654957),
(5, 'App\\Models\\User', 987654958),
(5, 'App\\Models\\User', 987654959),
(5, 'App\\Models\\User', 987654960),
(5, 'App\\Models\\User', 987654961),
(5, 'App\\Models\\User', 987654962),
(5, 'App\\Models\\User', 987654963),
(5, 'App\\Models\\User', 987654964),
(5, 'App\\Models\\User', 987654965),
(5, 'App\\Models\\User', 987654966),
(5, 'App\\Models\\User', 987654967),
(5, 'App\\Models\\User', 987654968),
(5, 'App\\Models\\User', 987654969),
(5, 'App\\Models\\User', 987654970),
(5, 'App\\Models\\User', 987654971),
(5, 'App\\Models\\User', 987654972),
(5, 'App\\Models\\User', 987654973),
(5, 'App\\Models\\User', 987654974),
(5, 'App\\Models\\User', 987654975),
(5, 'App\\Models\\User', 987654976),
(5, 'App\\Models\\User', 987654977),
(5, 'App\\Models\\User', 987654978),
(5, 'App\\Models\\User', 987654979),
(5, 'App\\Models\\User', 987654980),
(5, 'App\\Models\\User', 987654981),
(5, 'App\\Models\\User', 987654982),
(5, 'App\\Models\\User', 987654983),
(5, 'App\\Models\\User', 987654984),
(5, 'App\\Models\\User', 987654985),
(5, 'App\\Models\\User', 987654986),
(5, 'App\\Models\\User', 987654987),
(5, 'App\\Models\\User', 987654988),
(5, 'App\\Models\\User', 987654989),
(5, 'App\\Models\\User', 987654990),
(5, 'App\\Models\\User', 987655064);

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` char(36) NOT NULL,
  `type` varchar(255) NOT NULL,
  `notifiable_type` varchar(255) NOT NULL,
  `notifiable_id` bigint(20) UNSIGNED NOT NULL,
  `data` text NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `type`, `notifiable_type`, `notifiable_id`, `data`, `read_at`, `created_at`, `updated_at`) VALUES
('82a22251-8732-4b7f-b347-1fdfef79a81c', 'Filament\\Notifications\\DatabaseNotification', 'App\\Models\\User', 11, '{\"actions\":[{\"name\":\"downloadFailedRowsCsv\",\"color\":\"danger\",\"event\":null,\"eventData\":[],\"dispatchDirection\":false,\"dispatchToComponent\":null,\"extraAttributes\":[],\"icon\":null,\"iconPosition\":\"before\",\"iconSize\":null,\"isOutlined\":false,\"isDisabled\":false,\"label\":\"Download information about the failed rows\",\"shouldClose\":false,\"shouldMarkAsRead\":true,\"shouldMarkAsUnread\":false,\"shouldOpenUrlInNewTab\":true,\"size\":\"sm\",\"tooltip\":null,\"url\":\"\\/filament\\/imports\\/3\\/failed-rows\\/download\",\"view\":\"filament-actions::link-action\"}],\"body\":\"Your user import has completed and 0 rows imported. 3 rows failed to import.\",\"color\":null,\"duration\":\"persistent\",\"icon\":\"heroicon-o-x-circle\",\"iconColor\":\"danger\",\"status\":\"danger\",\"title\":\"Import completed\",\"view\":\"filament-notifications::notification\",\"viewData\":[],\"format\":\"filament\"}', NULL, '2025-06-15 07:00:34', '2025-06-15 07:00:34');

-- --------------------------------------------------------

--
-- Table structure for table `pengisian_indikators`
--

CREATE TABLE `pengisian_indikators` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `assign_pengisian_id` bigint(20) UNSIGNED NOT NULL,
  `ui_isi_indikator_id` bigint(20) UNSIGNED NOT NULL,
  `isi` enum('tercapai','tidak_tercapai') NOT NULL,
  `bukti` text DEFAULT NULL,
  `faktor_penghambat` text DEFAULT NULL,
  `answered_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pengisian_indikators`
--

INSERT INTO `pengisian_indikators` (`id`, `assign_pengisian_id`, `ui_isi_indikator_id`, `isi`, `bukti`, `faktor_penghambat`, `answered_at`, `created_at`, `updated_at`) VALUES
(2, 2, 2, 'tercapai', 'https://drive.google.com/file/d/11UtuC_gM1jI8_bAxhyMp1VyGgjIVFmrM/view?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-18 02:06:29', '2025-06-22 03:17:37'),
(3, 2, 3, 'tercapai', 'https://drive.google.com/file/d/11UtuC_gM1jI8_bAxhyMp1VyGgjIVFmrM/view?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-18 02:06:29', '2025-06-22 03:17:37'),
(4, 2, 4, 'tercapai', 'https://drive.google.com/file/d/1FDwTDfxGxD3fBNGzoZFGUdS3M0Fowy8s/view?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-18 02:06:29', '2025-06-22 03:17:37'),
(5, 2, 5, 'tercapai', 'https://drive.google.com/file/d/11UtuC_gM1jI8_bAxhyMp1VyGgjIVFmrM/view?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-18 02:06:29', '2025-06-22 03:17:37'),
(6, 2, 6, 'tercapai', 'https://drive.google.com/file/d/11UtuC_gM1jI8_bAxhyMp1VyGgjIVFmrM/view?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-18 02:06:29', '2025-06-22 03:17:37'),
(7, 2, 7, 'tercapai', 'https://drive.google.com/file/d/11UtuC_gM1jI8_bAxhyMp1VyGgjIVFmrM/view?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-18 02:06:29', '2025-06-22 03:17:37'),
(8, 2, 8, 'tercapai', 'https://drive.google.com/file/d/11UtuC_gM1jI8_bAxhyMp1VyGgjIVFmrM/view?usp=drive_link+', NULL, '2025-06-22 03:17:37', '2025-06-18 02:06:29', '2025-06-22 03:17:37'),
(9, 2, 9, 'tercapai', 'https://drive.google.com/file/d/11UtuC_gM1jI8_bAxhyMp1VyGgjIVFmrM/view?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-18 02:06:29', '2025-06-22 03:17:37'),
(10, 2, 10, 'tercapai', 'https://drive.google.com/file/d/1Wksajt4zjqdb5YwexGiFrpXLHin3YYb3/view?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-18 02:06:29', '2025-06-22 03:17:37'),
(11, 2, 11, 'tercapai', '\'https://drive.google.com/file/d/11UtuC_gM1jI8_bAxhyMp1VyGgjIVFmrM/view?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-18 02:06:29', '2025-06-22 03:17:37'),
(12, 2, 12, 'tercapai', '\'https://drive.google.com/file/d/1WHpVwShc3CznVP6xTfUXp4EG-pv2wlc7/view?usp=drive_link, https://drive.google.com/file/d/1YcWphNowC-6A78KWHvXYVcFdaEpsUBGt/view?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-18 02:06:29', '2025-06-22 03:17:37'),
(13, 2, 13, 'tercapai', 'https://drive.google.com/drive/folders/1p0VoIapNddQwetPTjy4d-VLty58cuIQf?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-18 02:06:29', '2025-06-22 03:17:37'),
(14, 2, 14, 'tercapai', 'https://drive.google.com/drive/folders/1p0VoIapNddQwetPTjy4d-VLty58cuIQf?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-18 02:06:29', '2025-06-22 03:17:37'),
(15, 2, 15, 'tercapai', 'https://drive.google.com/drive/folders/1P5pvwzLhwiXqLk8MbBk1XBxnTkGWLfxW?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-18 02:06:29', '2025-06-22 03:17:37'),
(16, 2, 16, 'tercapai', 'https://drive.google.com/file/d/1lfvMDRZlmmQy2mKmuj7KhEAeGHzua9l1/view?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-18 02:06:29', '2025-06-22 03:17:37'),
(17, 2, 17, 'tercapai', 'https://drive.google.com/drive/folders/1ctTMEuVpIEwVeFgYVsh9QI5u_pX8ryr8?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-18 02:06:29', '2025-06-22 03:17:37'),
(18, 2, 18, 'tercapai', 'https://drive.google.com/drive/folders/1p0VoIapNddQwetPTjy4d-VLty58cuIQf?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-18 02:06:29', '2025-06-22 03:17:37'),
(19, 2, 19, 'tercapai', 'https://drive.google.com/file/d/1WHpVwShc3CznVP6xTfUXp4EG-pv2wlc7/view?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-18 02:06:29', '2025-06-22 03:17:37'),
(20, 2, 20, 'tercapai', 'https://drive.google.com/drive/folders/1c6Cr7F2yo4ssGeRODZ6QlH3FCBe6i0oy?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-18 02:06:29', '2025-06-22 03:17:37'),
(21, 2, 21, 'tercapai', 'https://drive.google.com/file/d/11UtuC_gM1jI8_bAxhyMp1VyGgjIVFmrM/view?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-18 02:06:29', '2025-06-22 03:17:37'),
(22, 2, 22, 'tercapai', 'https://drive.google.com/drive/folders/1c6Cr7F2yo4ssGeRODZ6QlH3FCBe6i0oy?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-18 02:06:29', '2025-06-22 03:17:37'),
(23, 2, 23, 'tercapai', 'https://docs.google.com/presentation/d/179tCehA7Umx8k3BN9VgcU61SQY69LQ0v/edit?usp=drive_link&ouid=103931872620453333023&rtpof=true&sd=true', NULL, '2025-06-22 03:17:37', '2025-06-18 02:06:29', '2025-06-22 03:17:37'),
(24, 2, 24, 'tercapai', 'https://drive.google.com/drive/folders/1p0VoIapNddQwetPTjy4d-VLty58cuIQf?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-18 02:06:29', '2025-06-22 03:17:37'),
(25, 2, 25, 'tercapai', 'https://docs.google.com/document/d/1iOzi-OwLcWhsrniGp_nmTUaeHca20UZ5/edit?usp=drive_link&ouid=103931872620453333023&rtpof=true&sd=true', NULL, '2025-06-22 03:17:37', '2025-06-18 02:06:29', '2025-06-22 03:17:37'),
(26, 2, 26, 'tercapai', 'https://drive.google.com/drive/folders/1c6Cr7F2yo4ssGeRODZ6QlH3FCBe6i0oy?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-18 02:06:29', '2025-06-22 03:17:37'),
(27, 2, 27, 'tercapai', 'https://docs.google.com/presentation/d/179tCehA7Umx8k3BN9VgcU61SQY69LQ0v/edit?usp=drive_link&ouid=103931872620453333023&rtpof=true&sd=true', NULL, '2025-06-22 03:17:37', '2025-06-18 02:06:29', '2025-06-22 03:17:37'),
(28, 2, 28, 'tercapai', 'https://drive.google.com/drive/folders/1ctTMEuVpIEwVeFgYVsh9QI5u_pX8ryr8?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-18 02:06:29', '2025-06-22 03:17:37'),
(29, 2, 29, 'tercapai', 'https://drive.google.com/drive/folders/1ctTMEuVpIEwVeFgYVsh9QI5u_pX8ryr8?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-18 02:06:29', '2025-06-22 03:17:37'),
(30, 2, 30, 'tercapai', 'https://drive.google.com/drive/folders/14xj50o6HTlrurWmzIIM2KOM1CMzMScF5?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-18 02:06:29', '2025-06-22 03:17:37'),
(31, 2, 31, 'tercapai', 'https://drive.google.com/drive/folders/1Z1oFYKIXX62YLBaqMC0MNM91jpzUAfkY?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-18 02:06:29', '2025-06-22 03:17:37'),
(32, 2, 32, 'tercapai', 'https://drive.google.com/drive/folders/1Z1oFYKIXX62YLBaqMC0MNM91jpzUAfkY?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-18 02:06:29', '2025-06-22 03:17:37'),
(33, 2, 33, 'tidak_tercapai', NULL, 'Program D3', '2025-06-22 03:17:37', '2025-06-18 02:06:29', '2025-06-22 03:17:37'),
(34, 2, 34, 'tercapai', 'https://drive.google.com/drive/folders/1DMCyPkUJgR0y32RE8sW-i2JeA_G1CNqs?usp=drive_link+L48', NULL, '2025-06-22 03:17:37', '2025-06-18 02:06:29', '2025-06-22 03:17:37'),
(35, 2, 35, 'tercapai', 'https://drive.google.com/drive/folders/1H-j_W2dt35D4unuC6Tb38WGEYJAj7t7C?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-18 02:06:29', '2025-06-22 03:17:37'),
(36, 2, 36, 'tercapai', 'https://drive.google.com/drive/folders/1H-j_W2dt35D4unuC6Tb38WGEYJAj7t7C?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-18 02:06:29', '2025-06-22 03:17:37'),
(37, 2, 37, 'tidak_tercapai', NULL, 'Belum ada dosen S3', '2025-06-22 03:17:37', '2025-06-18 02:06:29', '2025-06-22 03:17:37'),
(38, 2, 38, 'tidak_tercapai', NULL, 'Belum ada dosen S3', '2025-06-22 03:17:37', '2025-06-18 02:06:29', '2025-06-22 03:17:37'),
(39, 2, 39, 'tercapai', NULL, 'https://drive.google.com/drive/folders/1Z1oFYKIXX62YLBaqMC0MNM91jpzUAfkY?usp=drive_link', '2025-06-22 03:17:37', '2025-06-18 02:06:29', '2025-06-22 03:17:37'),
(40, 2, 40, 'tercapai', NULL, 'https://drive.google.com/drive/folders/1ELnRgRv2Enzc7OAZyJVHOQcPyekvqq08?usp=drive_link', '2025-06-22 03:17:37', '2025-06-18 02:06:29', '2025-06-22 03:17:37'),
(41, 2, 41, 'tidak_tercapai', NULL, 'Belum sertifikasi', '2025-06-22 03:17:37', '2025-06-18 02:06:29', '2025-06-22 03:17:37'),
(42, 2, 42, 'tercapai', 'https://drive.google.com/drive/folders/15Kjc_qoVCj0zxT36GinzwSh8OMVMCV45?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(43, 2, 43, 'tercapai', 'https://drive.google.com/drive/folders/15Kjc_qoVCj0zxT36GinzwSh8OMVMCV45?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(44, 2, 44, 'tidak_tercapai', NULL, 'Ruang kurang dari 4 m2 per orang', '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(45, 2, 45, 'tercapai', 'https://drive.google.com/file/d/1211gvhgW-CF5FkLJc-WK1uRVG0YKey0K/view?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(46, 2, 46, 'tidak_tercapai', NULL, '-', '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(47, 2, 47, 'tercapai', 'https://drive.google.com/file/d/1211gvhgW-CF5FkLJc-WK1uRVG0YKey0K/view?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(48, 2, 48, 'tercapai', 'https://drive.google.com/file/d/1FaLjH70mtG4826YRhpe7lSZ6f-NujupK/view?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(49, 2, 49, 'tercapai', 'https://drive.google.com/file/d/153z2NGzXxdW-_d2_LzVw-CrYiWQ4vQLW/view?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(50, 2, 50, 'tercapai', 'https://drive.google.com/file/d/1BB-F6ugYTz4SywvYP9qmi3MDKigoA2Aj/view?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(51, 2, 51, 'tercapai', 'https://drive.google.com/file/d/1JlDNl5H4L8lJtTB12BnnEIfh91Op1vLz/view?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(52, 2, 52, 'tidak_tercapai', NULL, '-', '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(53, 2, 53, 'tercapai', 'https://drive.google.com/file/d/1goLWldBzsYRXPAjVxVMfgmx8mc2D70iH/view?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(54, 2, 54, 'tercapai', 'https://drive.google.com/file/d/1goLWldBzsYRXPAjVxVMfgmx8mc2D70iH/view?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(55, 2, 55, 'tercapai', 'https://drive.google.com/drive/folders/10PakEQa89CX_5IvcrDpdG3b3lNxAFRAi?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(56, 2, 56, 'tercapai', 'https://drive.google.com/file/d/1WHpVwShc3CznVP6xTfUXp4EG-pv2wlc7/view?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(57, 2, 57, 'tercapai', 'https://drive.google.com/drive/folders/1p0VoIapNddQwetPTjy4d-VLty58cuIQf?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(58, 2, 58, 'tercapai', 'https://drive.google.com/drive/folders/1pZPvC7Fy9Tj2EbupQYYLHMQfIPCgF4Zb?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(59, 2, 59, 'tercapai', 'https://drive.google.com/drive/folders/1iDP5pZio-sfyj9G-lESb2XMC7RjgEhqA?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(60, 2, 60, 'tercapai', 'https://drive.google.com/file/d/1lfvMDRZlmmQy2mKmuj7KhEAeGHzua9l1/view?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(61, 2, 61, 'tercapai', 'https://drive.google.com/drive/folders/1pQlzrLgFUaMqIBR4wiCe7J-aJ0O7VyNz?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(62, 2, 62, 'tercapai', 'https://drive.google.com/file/d/1WpYYrpemgmHt7ILOA7Mm3UeJhOngOCfm/view?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(63, 2, 63, 'tidak_tercapai', 'https://drive.google.com/file/d/1OfiFotwP1QgBDfb0OspxjY_bFctESZ6D/view', '-', '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(64, 2, 64, 'tidak_tercapai', NULL, 'Jasa Kurang dari 10%', '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(65, 2, 65, 'tercapai', 'https://drive.google.com/drive/folders/1Wh_ZkD9vrwp9EAl6j9xghYPrwweePpzC?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(66, 2, 66, 'tercapai', 'https://drive.google.com/drive/folders/1Wh_ZkD9vrwp9EAl6j9xghYPrwweePpzC?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(67, 2, 67, 'tercapai', 'https://drive.google.com/drive/folders/1Wh_ZkD9vrwp9EAl6j9xghYPrwweePpzC?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(68, 2, 68, 'tercapai', 'https://drive.google.com/drive/folders/1Wh_ZkD9vrwp9EAl6j9xghYPrwweePpzC?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(69, 2, 69, 'tercapai', 'https://drive.google.com/drive/folders/1Wh_ZkD9vrwp9EAl6j9xghYPrwweePpzC?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(70, 2, 70, 'tercapai', 'https://drive.google.com/drive/folders/1Wh_ZkD9vrwp9EAl6j9xghYPrwweePpzC?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(71, 2, 71, 'tercapai', 'https://drive.google.com/drive/folders/1Wh_ZkD9vrwp9EAl6j9xghYPrwweePpzC?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(72, 2, 72, 'tercapai', 'https://drive.google.com/drive/folders/1Wh_ZkD9vrwp9EAl6j9xghYPrwweePpzC?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(73, 2, 73, 'tercapai', 'https://drive.google.com/drive/folders/1Km9lXvjjJ0lHM6D_CACEYwXIWrJvoK5u?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(74, 2, 74, 'tercapai', 'https://drive.google.com/drive/folders/1Wh_ZkD9vrwp9EAl6j9xghYPrwweePpzC?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(75, 2, 75, 'tercapai', 'https://drive.google.com/drive/folders/1Wh_ZkD9vrwp9EAl6j9xghYPrwweePpzC?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(76, 2, 76, 'tercapai', 'https://drive.google.com/drive/folders/1Wh_ZkD9vrwp9EAl6j9xghYPrwweePpzC?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(77, 2, 77, 'tercapai', 'https://drive.google.com/drive/folders/1Wh_ZkD9vrwp9EAl6j9xghYPrwweePpzC?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(78, 2, 78, 'tercapai', 'https://drive.google.com/drive/folders/1Wh_ZkD9vrwp9EAl6j9xghYPrwweePpzC?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(79, 2, 79, 'tercapai', 'https://drive.google.com/drive/folders/1Wh_ZkD9vrwp9EAl6j9xghYPrwweePpzC?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(80, 2, 80, 'tercapai', 'https://drive.google.com/drive/folders/1Wh_ZkD9vrwp9EAl6j9xghYPrwweePpzC?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(81, 2, 81, 'tercapai', 'https://drive.google.com/drive/folders/1Wh_ZkD9vrwp9EAl6j9xghYPrwweePpzC?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(82, 2, 82, 'tercapai', 'https://drive.google.com/drive/folders/1Wh_ZkD9vrwp9EAl6j9xghYPrwweePpzC?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(83, 2, 83, 'tercapai', 'https://drive.google.com/drive/folders/1Wh_ZkD9vrwp9EAl6j9xghYPrwweePpzC?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(84, 2, 84, 'tidak_tercapai', NULL, 'Untuk P3M', '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(85, 2, 85, 'tercapai', 'https://drive.google.com/drive/folders/1Wh_ZkD9vrwp9EAl6j9xghYPrwweePpzC?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(86, 2, 86, 'tercapai', 'https://drive.google.com/drive/folders/1Wh_ZkD9vrwp9EAl6j9xghYPrwweePpzC?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(87, 2, 87, 'tidak_tercapai', NULL, 'Terletak di P3M PSDKU', '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(88, 2, 88, 'tercapai', 'https://drive.google.com/drive/folders/1Wh_ZkD9vrwp9EAl6j9xghYPrwweePpzC?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(89, 2, 89, 'tercapai', 'https://drive.google.com/drive/folders/1Wh_ZkD9vrwp9EAl6j9xghYPrwweePpzC?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(90, 2, 90, 'tercapai', 'https://drive.google.com/drive/folders/1Wh_ZkD9vrwp9EAl6j9xghYPrwweePpzC?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(91, 2, 91, 'tercapai', 'https://drive.google.com/drive/folders/1Wh_ZkD9vrwp9EAl6j9xghYPrwweePpzC?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(92, 2, 92, 'tercapai', 'https://drive.google.com/drive/folders/1Wh_ZkD9vrwp9EAl6j9xghYPrwweePpzC?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(93, 2, 93, 'tercapai', 'https://drive.google.com/drive/folders/1Wh_ZkD9vrwp9EAl6j9xghYPrwweePpzC?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(94, 2, 94, 'tercapai', 'https://drive.google.com/drive/folders/1Wh_ZkD9vrwp9EAl6j9xghYPrwweePpzC?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(95, 2, 95, 'tidak_tercapai', NULL, 'Tidak Melibarkan mahasiswa', '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(96, 2, 96, 'tercapai', 'https://drive.google.com/drive/folders/1Wh_ZkD9vrwp9EAl6j9xghYPrwweePpzC?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(97, 2, 97, 'tercapai', 'https://drive.google.com/drive/folders/1Wh_ZkD9vrwp9EAl6j9xghYPrwweePpzC?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(98, 2, 98, 'tidak_tercapai', NULL, '-', '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(99, 2, 99, 'tercapai', 'https://drive.google.com/drive/folders/1Wh_ZkD9vrwp9EAl6j9xghYPrwweePpzC?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(100, 2, 100, 'tercapai', 'https://drive.google.com/drive/folders/1Wh_ZkD9vrwp9EAl6j9xghYPrwweePpzC?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(101, 2, 101, 'tercapai', 'https://drive.google.com/drive/folders/1Wh_ZkD9vrwp9EAl6j9xghYPrwweePpzC?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(102, 2, 102, 'tidak_tercapai', NULL, 'prodi sudah melakukan pemetaan hanya belum dilakukan dokumentasi dalam bentuk persuratan', '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(103, 2, 103, 'tercapai', 'https://drive.google.com/drive/folders/1Wh_ZkD9vrwp9EAl6j9xghYPrwweePpzC?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(104, 2, 104, 'tercapai', 'https://drive.google.com/drive/folders/1Wh_ZkD9vrwp9EAl6j9xghYPrwweePpzC?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(105, 2, 105, 'tercapai', 'https://drive.google.com/drive/folders/1Wh_ZkD9vrwp9EAl6j9xghYPrwweePpzC?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(106, 2, 106, 'tercapai', 'https://drive.google.com/drive/folders/1Wh_ZkD9vrwp9EAl6j9xghYPrwweePpzC?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(107, 2, 107, 'tercapai', 'https://drive.google.com/drive/folders/1Wh_ZkD9vrwp9EAl6j9xghYPrwweePpzC?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(108, 2, 108, 'tercapai', 'https://drive.google.com/file/d/1MHq6xVaGF0DzmMbGJ1Fj4fzicOUH1kAa/view?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(109, 2, 109, 'tidak_tercapai', NULL, 'Sudah meminta ke bag Akademik/belum ada balasan', '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(110, 2, 110, 'tidak_tercapai', NULL, 'Sudah meminta ke bag Akademik/belum ada balasan', '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(111, 2, 111, 'tidak_tercapai', NULL, 'Tidak ada mahasiswa transfer', '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(112, 2, 112, 'tidak_tercapai', NULL, 'Tidak ada mahasiswa asing', '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(113, 2, 113, 'tidak_tercapai', NULL, 'Hanya tes tertulis\nJATAH BIDIK MISI BELUM DAPAT', '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(114, 2, 114, 'tercapai', 'https://drive.google.com/drive/folders/1CfqbJyVHThwahDL58ZFDIJKJqwtqgmEQ?usp=drive_link', 'mandiri 1:3', '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(115, 2, 115, 'tercapai', 'https://drive.google.com/drive/folders/1Q38QK5jFT1lF9VD1YPETieC_7-es3x1Z?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(116, 2, 116, 'tercapai', 'https://drive.google.com/drive/folders/1mWcvv5UfDcvoo8bV5MyojrwiaGrELZ1W?usp=sharing', NULL, '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(117, 2, 117, 'tercapai', 'https://drive.google.com/drive/folders/1mWcvv5UfDcvoo8bV5MyojrwiaGrELZ1W?usp=sharing', NULL, '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(118, 2, 118, 'tercapai', 'https://drive.google.com/file/d/1AB5TSiXCKmBj9e7drEKkNQvR0iw67f2q/view?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(119, 2, 119, 'tercapai', 'https://drive.google.com/drive/u/1/folders/1_8Z7X7EwYsYJPdRCoqp3AEUZBn-4cCED?pli=1', NULL, '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(120, 2, 120, 'tercapai', 'https://drive.google.com/drive/u/1/folders/1_8Z7X7EwYsYJPdRCoqp3AEUZBn-4cCED?pli=1', NULL, '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(121, 2, 121, 'tidak_tercapai', NULL, 'Belum ada organisasi dengan Board Advisory', '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(122, 2, 122, 'tercapai', 'https://drive.google.com/file/d/1aDWIG5oC7QcgRL_9tBx7vtlskiqjBx27/view?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(123, 2, 123, 'tidak_tercapai', NULL, 'Jenjang D3', '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(124, 2, 124, 'tidak_tercapai', NULL, '-', '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(125, 2, 125, 'tidak_tercapai', NULL, 'Jenjang D3', '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(126, 2, 126, 'tidak_tercapai', NULL, 'Jenjang D3', '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(127, 2, 127, 'tidak_tercapai', NULL, 'Jenjang D3', '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(128, 2, 128, 'tidak_tercapai', NULL, 'Jenjang D3', '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(129, 2, 129, 'tidak_tercapai', NULL, 'Jenjang D3', '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(130, 2, 130, 'tidak_tercapai', NULL, 'Jenjang D3', '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(131, 2, 131, 'tidak_tercapai', NULL, 'Jenjang D3', '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(132, 2, 132, 'tercapai', NULL, 'https://docs.google.com/spreadsheets/d/1RoabM2RPMSWqwr81-lR-cTcGyMPvE9O1/edit?usp=drive_link&ouid=103931872620453333023&rtpof=true&sd=true', '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(133, 2, 133, 'tidak_tercapai', NULL, 'Jenjang D3', '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(134, 2, 134, 'tidak_tercapai', NULL, 'Jenjang D3', '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(135, 2, 135, 'tidak_tercapai', NULL, 'Laptop Pribadi', '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(136, 2, 136, 'tidak_tercapai', NULL, 'Pembelajaran Offline', '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(137, 2, 137, 'tidak_tercapai', NULL, 'Pembelajaran Offline', '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(138, 2, 138, 'tercapai', 'https://drive.google.com/file/d/1uAVy4mi5ycg-_aL03frB4a9ttSUOKLBT/view?usp=drive_link', NULL, '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37'),
(139, 2, 139, 'tidak_tercapai', NULL, 'Sertifikasi Nasional', '2025-06-22 03:17:37', '2025-06-22 03:17:36', '2025-06-22 03:17:37');

-- --------------------------------------------------------

--
-- Table structure for table `periodes`
--

CREATE TABLE `periodes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `periode_kode` varchar(255) NOT NULL,
  `periode_name` varchar(255) NOT NULL,
  `start_date` datetime NOT NULL,
  `end_date` datetime NOT NULL,
  `status_periode` enum('active','inactive') NOT NULL DEFAULT 'inactive',
  `status` enum('pending','validated') NOT NULL DEFAULT 'pending',
  `validated_by` bigint(20) UNSIGNED DEFAULT NULL,
  `validated_time` timestamp NULL DEFAULT NULL,
  `created_by` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `periodes`
--

INSERT INTO `periodes` (`id`, `periode_kode`, `periode_name`, `start_date`, `end_date`, `status_periode`, `status`, `validated_by`, `validated_time`, `created_by`, `created_at`, `updated_at`) VALUES
(1, '2024', '2024', '2024-06-11 00:00:00', '2024-06-14 00:00:00', 'inactive', 'validated', 11, '2025-06-11 13:47:51', 11, '2025-06-11 13:47:38', '2025-06-14 04:45:17'),
(2, '2025 - 1', '2025 - 1', '2025-06-07 00:00:00', '2025-07-11 23:59:00', 'active', 'validated', 11, '2025-06-14 04:44:43', 11, '2025-06-14 04:43:12', '2025-06-22 04:23:38'),
(3, '2024 - 1', '2024 - 1', '2024-06-01 00:00:00', '2024-06-30 00:00:00', 'inactive', 'validated', 11, '2025-06-17 22:58:53', 987654931, '2025-06-17 22:58:38', '2025-06-17 22:58:56');

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'view_assign::pengisian', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(2, 'view_any_assign::pengisian', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(3, 'create_assign::pengisian', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(4, 'update_assign::pengisian', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(5, 'restore_assign::pengisian', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(6, 'restore_any_assign::pengisian', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(7, 'replicate_assign::pengisian', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(8, 'reorder_assign::pengisian', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(9, 'delete_assign::pengisian', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(10, 'delete_any_assign::pengisian', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(11, 'force_delete_assign::pengisian', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(12, 'force_delete_any_assign::pengisian', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(13, 'view_indikator', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(14, 'view_any_indikator', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(15, 'create_indikator', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(16, 'update_indikator', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(17, 'restore_indikator', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(18, 'restore_any_indikator', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(19, 'replicate_indikator', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(20, 'reorder_indikator', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(21, 'delete_indikator', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(22, 'delete_any_indikator', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(23, 'force_delete_indikator', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(24, 'force_delete_any_indikator', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(25, 'view_isi::standar', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(26, 'view_any_isi::standar', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(27, 'create_isi::standar', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(28, 'update_isi::standar', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(29, 'restore_isi::standar', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(30, 'restore_any_isi::standar', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(31, 'replicate_isi::standar', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(32, 'reorder_isi::standar', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(33, 'delete_isi::standar', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(34, 'delete_any_isi::standar', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(35, 'force_delete_isi::standar', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(36, 'force_delete_any_isi::standar', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(37, 'view_jadwal', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(38, 'view_any_jadwal', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(39, 'create_jadwal', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(40, 'update_jadwal', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(41, 'restore_jadwal', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(42, 'restore_any_jadwal', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(43, 'replicate_jadwal', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(44, 'reorder_jadwal', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(45, 'delete_jadwal', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(46, 'delete_any_jadwal', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(47, 'force_delete_jadwal', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(48, 'force_delete_any_jadwal', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(49, 'view_pengisian::indikator', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(50, 'view_any_pengisian::indikator', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(51, 'create_pengisian::indikator', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(52, 'update_pengisian::indikator', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(53, 'restore_pengisian::indikator', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(54, 'restore_any_pengisian::indikator', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(55, 'replicate_pengisian::indikator', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(56, 'reorder_pengisian::indikator', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(57, 'delete_pengisian::indikator', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(58, 'delete_any_pengisian::indikator', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(59, 'force_delete_pengisian::indikator', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(60, 'force_delete_any_pengisian::indikator', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(61, 'view_periode', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(62, 'view_any_periode', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(63, 'create_periode', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(64, 'update_periode', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(65, 'restore_periode', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(66, 'restore_any_periode', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(67, 'replicate_periode', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(68, 'reorder_periode', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(69, 'delete_periode', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(70, 'delete_any_periode', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(71, 'force_delete_periode', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(72, 'force_delete_any_periode', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(73, 'view_review::indikator', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(74, 'view_any_review::indikator', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(75, 'create_review::indikator', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(76, 'update_review::indikator', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(77, 'restore_review::indikator', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(78, 'restore_any_review::indikator', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(79, 'replicate_review::indikator', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(80, 'reorder_review::indikator', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(81, 'delete_review::indikator', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(82, 'delete_any_review::indikator', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(83, 'force_delete_review::indikator', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(84, 'force_delete_any_review::indikator', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(85, 'view_role', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(86, 'view_any_role', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(87, 'create_role', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(88, 'update_role', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(89, 'delete_role', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(90, 'delete_any_role', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(91, 'view_standar', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(92, 'view_any_standar', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(93, 'create_standar', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(94, 'update_standar', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(95, 'restore_standar', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(96, 'restore_any_standar', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(97, 'replicate_standar', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(98, 'reorder_standar', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(99, 'delete_standar', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(100, 'delete_any_standar', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(101, 'force_delete_standar', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(102, 'force_delete_any_standar', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(103, 'view_sub::standar', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(104, 'view_any_sub::standar', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(105, 'create_sub::standar', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(106, 'update_sub::standar', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(107, 'restore_sub::standar', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(108, 'restore_any_sub::standar', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(109, 'replicate_sub::standar', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(110, 'reorder_sub::standar', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(111, 'delete_sub::standar', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(112, 'delete_any_sub::standar', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(113, 'force_delete_sub::standar', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(114, 'force_delete_any_sub::standar', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(115, 'view_unit', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(116, 'view_any_unit', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(117, 'create_unit', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(118, 'update_unit', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(119, 'restore_unit', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(120, 'restore_any_unit', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(121, 'replicate_unit', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(122, 'reorder_unit', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(123, 'delete_unit', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(124, 'delete_any_unit', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(125, 'force_delete_unit', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(126, 'force_delete_any_unit', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(127, 'view_unit::indikator', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(128, 'view_any_unit::indikator', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(129, 'create_unit::indikator', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(130, 'update_unit::indikator', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(131, 'restore_unit::indikator', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(132, 'restore_any_unit::indikator', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(133, 'replicate_unit::indikator', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(134, 'reorder_unit::indikator', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(135, 'delete_unit::indikator', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(136, 'delete_any_unit::indikator', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(137, 'force_delete_unit::indikator', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(138, 'force_delete_any_unit::indikator', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(139, 'view_user', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(140, 'view_any_user', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(141, 'create_user', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(142, 'update_user', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(143, 'restore_user', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(144, 'restore_any_user', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(145, 'replicate_user', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(146, 'reorder_user', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(147, 'delete_user', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(148, 'delete_any_user', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(149, 'force_delete_user', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(150, 'force_delete_any_user', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(151, 'page_JadwalCalendarPage', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(152, 'page_Themes', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(153, 'page_MyProfilePage', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(154, 'widget_DateTimeWidget', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48'),
(155, 'widget_JadwalCalendarWidget', 'web', '2025-06-11 13:45:48', '2025-06-11 13:45:48');

-- --------------------------------------------------------

--
-- Table structure for table `review_auditor1s`
--

CREATE TABLE `review_auditor1s` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `pengisian_indikators_id` bigint(20) UNSIGNED NOT NULL,
  `status_temuan` enum('sesuai','tidak_sesuai') DEFAULT NULL,
  `hasil_pengamatan` text DEFAULT NULL,
  `status` enum('pending','reviewed') NOT NULL DEFAULT 'pending',
  `reviewed_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `review_auditor1s`
--

INSERT INTO `review_auditor1s` (`id`, `pengisian_indikators_id`, `status_temuan`, `hasil_pengamatan`, `status`, `reviewed_at`, `created_at`, `updated_at`) VALUES
(4, 2, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-18 12:24:50', '2025-06-22 04:03:54'),
(5, 3, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-18 12:24:50', '2025-06-22 04:03:54'),
(6, 4, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-18 12:24:50', '2025-06-22 04:03:54'),
(7, 5, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-18 12:24:50', '2025-06-22 04:03:54'),
(8, 6, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-18 12:24:50', '2025-06-22 04:03:54'),
(9, 7, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-18 12:24:50', '2025-06-22 04:03:54'),
(10, 8, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-18 12:24:50', '2025-06-22 04:03:54'),
(11, 9, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-18 12:24:50', '2025-06-22 04:03:54'),
(12, 10, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-18 12:24:50', '2025-06-22 04:03:54'),
(13, 11, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-18 12:24:50', '2025-06-22 04:03:54'),
(14, 12, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-18 12:24:50', '2025-06-22 04:03:54'),
(15, 13, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-18 12:24:50', '2025-06-22 04:03:54'),
(16, 14, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-18 12:24:50', '2025-06-22 04:03:54'),
(17, 15, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-18 12:24:50', '2025-06-22 04:03:54'),
(18, 16, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-18 12:24:50', '2025-06-22 04:03:54'),
(19, 17, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-18 12:24:50', '2025-06-22 04:03:54'),
(20, 18, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-18 12:24:50', '2025-06-22 04:03:54'),
(21, 19, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-18 12:24:50', '2025-06-22 04:03:54'),
(22, 20, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-18 12:24:50', '2025-06-22 04:03:54'),
(23, 21, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-18 12:24:50', '2025-06-22 04:03:54'),
(24, 22, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-18 12:24:50', '2025-06-22 04:03:54'),
(25, 23, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-18 12:24:50', '2025-06-22 04:03:54'),
(26, 24, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-18 12:24:50', '2025-06-22 04:03:54'),
(27, 25, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-18 12:24:50', '2025-06-22 04:03:54'),
(28, 26, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-18 12:24:50', '2025-06-22 04:03:54'),
(29, 27, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-18 12:24:50', '2025-06-22 04:03:54'),
(30, 28, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-18 12:24:50', '2025-06-22 04:03:54'),
(31, 29, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-18 12:24:50', '2025-06-22 04:03:54'),
(32, 30, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-18 12:24:50', '2025-06-22 04:03:54'),
(33, 31, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-18 12:24:50', '2025-06-22 04:03:54'),
(34, 32, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-18 12:24:50', '2025-06-22 04:03:54'),
(35, 33, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-18 12:24:50', '2025-06-22 04:03:54'),
(36, 34, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-18 12:24:50', '2025-06-22 04:03:54'),
(37, 35, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-18 12:24:50', '2025-06-22 04:03:54'),
(38, 36, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-18 12:24:50', '2025-06-22 04:03:54'),
(39, 37, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-18 12:24:50', '2025-06-22 04:03:54'),
(40, 38, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-18 12:24:50', '2025-06-22 04:03:54'),
(41, 39, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-18 12:24:50', '2025-06-22 04:03:54'),
(42, 40, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-18 12:24:50', '2025-06-22 04:03:54'),
(43, 41, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-18 12:24:50', '2025-06-22 04:03:54'),
(44, 42, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:04', '2025-06-22 04:03:54'),
(45, 43, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(46, 44, 'tidak_sesuai', 'Ruang kurang dari 4 m2 per orang', 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(47, 45, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(48, 46, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(49, 47, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(50, 48, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(51, 49, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(52, 50, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(53, 51, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(54, 52, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(55, 53, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(56, 54, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(57, 55, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(58, 56, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(59, 57, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(60, 58, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(61, 59, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(62, 60, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(63, 61, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(64, 62, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(65, 63, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(66, 64, 'tidak_sesuai', 'Jasa Kurang dari 10%', 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(67, 65, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(68, 66, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(69, 67, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(70, 68, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(71, 69, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(72, 70, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(73, 71, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(74, 72, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(75, 73, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(76, 74, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(77, 75, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(78, 76, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(79, 77, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(80, 78, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(81, 79, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(82, 80, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(83, 81, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(84, 82, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(85, 83, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(86, 84, 'sesuai', 'Untuk P3M', 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(87, 85, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(88, 86, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(89, 87, 'sesuai', 'Terletak di P3M PSDKU', 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(90, 88, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(91, 89, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(92, 90, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(93, 91, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(94, 92, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(95, 93, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(96, 94, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(97, 95, 'tidak_sesuai', 'Tidak Melibarkan mahasiswa', 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(98, 96, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(99, 97, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(100, 98, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(101, 99, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(102, 100, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(103, 101, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(104, 102, 'tidak_sesuai', 'prodi sudah melakukan pemetaan hanya belum dilakukan dokumentasi dalam bentuk persuratan', 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(105, 103, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(106, 104, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(107, 105, 'sesuai', 'banyak yang mengajukan namun harus dibagi, internal dan eksternal rasion ya 50:50, 17.6 juta perdosen DTPS', 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(108, 106, 'sesuai', 'sudah ada doumentasi perencanaan / perhitungan', 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(109, 107, 'sesuai', 'lolos litabmas 1 dosen, mujahid wahyu', 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(110, 108, 'tidak_sesuai', 'masukan: monev pembelajaran di masukkan evaluasi buku di RPS\n\nmelakukan monev untuk ketersediaan buku untuk diajukan ke perpustakaan', 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(111, 109, 'tidak_sesuai', 'belum ada akses data pendaftaran mahasiswa dari akademik pusat, prodi menunggu data hanya dari buku pemutakhiran data', 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(112, 110, 'tidak_sesuai', 'belum ada akses data pendaftaran mahasiswa dari akademik pusat, prodi menunggu data hanya dari buku pemutakhiran data', 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(113, 111, 'sesuai', 'TIDAK ADA TRANSFER KARENA D3', 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(114, 112, 'sesuai', 'tidak ada mahasiswa asing', 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(115, 113, 'sesuai', 'tidak ada mahasiswa asing+BW205+BW206+BW205+BW206+BW2+BW206', 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(116, 114, 'sesuai', 'mandiri 1:3\nprestasi 1:2', 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(117, 115, 'sesuai', 'layanan melalui DPA setiap semester minimal 1x', 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(118, 116, 'sesuai', '1 nasional, non akademik 1', 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(119, 117, 'sesuai', '1 nasional, non akademik 1', 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(120, 118, 'tidak_sesuai', 'tracer di bawah wadir 4, dan belum dapat feedback dari wadir 4, pakah prodi boleh mengetahui data tracernya, bentuk yang diberikan pada saat rapim berupa presentase dan tidak dapat dilacak berapa yang mengisi dari prodi yang bersangkutan', 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(121, 119, 'sesuai', 'sudah tertuang di dokumen kurikulum', 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(122, 120, 'sesuai', 'ada di buku kurikulum', 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(123, 121, 'tidak_sesuai', 'Belum ada organisasi dengan Board Advisory', 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(124, 122, 'tidak_sesuai', 'belum mendata secara keseluruhan, akan segera dilakukan pendataan, waktu evaluasinya belum dilaksanakan', 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(125, 123, 'sesuai', 'Jenjang D3', 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(126, 124, 'sesuai', 'Jenjang D3', 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(127, 125, 'sesuai', 'Jenjang D3', 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(128, 126, 'sesuai', 'Jenjang D3', 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(129, 127, 'sesuai', 'Jenjang D3', 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(130, 128, 'sesuai', 'Jenjang D3', 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(131, 129, 'sesuai', 'Jenjang D3', 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(132, 130, 'sesuai', 'Jenjang D3', 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(133, 131, 'sesuai', 'Jenjang D3', 'reviewed', '2025-06-22 04:03:55', '2025-06-22 03:25:05', '2025-06-22 04:03:55'),
(134, 132, 'tidak_sesuai', 'tersedia data toeic', 'reviewed', '2025-06-22 04:03:55', '2025-06-22 03:25:05', '2025-06-22 04:03:55'),
(135, 133, 'sesuai', 'Jenjang D3', 'reviewed', '2025-06-22 04:03:55', '2025-06-22 03:25:05', '2025-06-22 04:03:55'),
(136, 134, 'sesuai', 'Jenjang D3', 'reviewed', '2025-06-22 04:03:55', '2025-06-22 03:25:05', '2025-06-22 04:03:55'),
(137, 135, 'tidak_sesuai', 'masih belum mendapatkan laptop seperti di pusat', 'reviewed', '2025-06-22 04:03:55', '2025-06-22 03:25:05', '2025-06-22 04:03:55'),
(138, 136, 'tidak_sesuai', 'Pembelajaran Offline', 'reviewed', '2025-06-22 04:03:55', '2025-06-22 03:25:05', '2025-06-22 04:03:55'),
(139, 137, 'tidak_sesuai', 'Pembelajaran Offline', 'reviewed', '2025-06-22 04:03:55', '2025-06-22 03:25:05', '2025-06-22 04:03:55'),
(140, 138, 'sesuai', 'LSP datang ke PSDKU untuk dilakukan sertikom', 'reviewed', '2025-06-22 04:03:55', '2025-06-22 03:25:05', '2025-06-22 04:03:55'),
(141, 139, 'tidak_sesuai', 'belum ada skema sertikom internasional\nkendala untuk pelaksanaan tidak bisa langsung dilaksanakan oleh prodi, harus melalui wadir 4,', 'reviewed', '2025-06-22 04:03:55', '2025-06-22 03:25:05', '2025-06-22 04:03:55');

-- --------------------------------------------------------

--
-- Table structure for table `review_auditor2s`
--

CREATE TABLE `review_auditor2s` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `pengisian_indikators_id` bigint(20) UNSIGNED NOT NULL,
  `status_temuan` enum('sesuai','tidak_sesuai') DEFAULT NULL,
  `hasil_pengamatan` text DEFAULT NULL,
  `status` enum('pending','reviewed') NOT NULL DEFAULT 'pending',
  `reviewed_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `review_auditor2s`
--

INSERT INTO `review_auditor2s` (`id`, `pengisian_indikators_id`, `status_temuan`, `hasil_pengamatan`, `status`, `reviewed_at`, `created_at`, `updated_at`) VALUES
(4, 2, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-18 12:24:50', '2025-06-22 04:03:54'),
(5, 3, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-18 12:24:50', '2025-06-22 04:03:54'),
(6, 4, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-18 12:24:50', '2025-06-22 04:03:54'),
(7, 5, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-18 12:24:50', '2025-06-22 04:03:54'),
(8, 6, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-18 12:24:50', '2025-06-22 04:03:54'),
(9, 7, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-18 12:24:50', '2025-06-22 04:03:54'),
(10, 8, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-18 12:24:50', '2025-06-22 04:03:54'),
(11, 9, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-18 12:24:50', '2025-06-22 04:03:54'),
(12, 10, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-18 12:24:50', '2025-06-22 04:03:54'),
(13, 11, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-18 12:24:50', '2025-06-22 04:03:54'),
(14, 12, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-18 12:24:50', '2025-06-22 04:03:54'),
(15, 13, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-18 12:24:50', '2025-06-22 04:03:54'),
(16, 14, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-18 12:24:50', '2025-06-22 04:03:54'),
(17, 15, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-18 12:24:50', '2025-06-22 04:03:54'),
(18, 16, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-18 12:24:50', '2025-06-22 04:03:54'),
(19, 17, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-18 12:24:50', '2025-06-22 04:03:54'),
(20, 18, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-18 12:24:50', '2025-06-22 04:03:54'),
(21, 19, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-18 12:24:50', '2025-06-22 04:03:54'),
(22, 20, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-18 12:24:50', '2025-06-22 04:03:54'),
(23, 21, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-18 12:24:50', '2025-06-22 04:03:54'),
(24, 22, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-18 12:24:50', '2025-06-22 04:03:54'),
(25, 23, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-18 12:24:50', '2025-06-22 04:03:54'),
(26, 24, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-18 12:24:50', '2025-06-22 04:03:54'),
(27, 25, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-18 12:24:50', '2025-06-22 04:03:54'),
(28, 26, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-18 12:24:50', '2025-06-22 04:03:54'),
(29, 27, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-18 12:24:50', '2025-06-22 04:03:54'),
(30, 28, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-18 12:24:50', '2025-06-22 04:03:54'),
(31, 29, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-18 12:24:50', '2025-06-22 04:03:54'),
(32, 30, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-18 12:24:50', '2025-06-22 04:03:54'),
(33, 31, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-18 12:24:50', '2025-06-22 04:03:54'),
(34, 32, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-18 12:24:50', '2025-06-22 04:03:54'),
(35, 33, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-18 12:24:50', '2025-06-22 04:03:54'),
(36, 34, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-18 12:24:50', '2025-06-22 04:03:54'),
(37, 35, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-18 12:24:50', '2025-06-22 04:03:54'),
(38, 36, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-18 12:24:50', '2025-06-22 04:03:54'),
(39, 37, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-18 12:24:50', '2025-06-22 04:03:54'),
(40, 38, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-18 12:24:50', '2025-06-22 04:03:54'),
(41, 39, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-18 12:24:50', '2025-06-22 04:03:54'),
(42, 40, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-18 12:24:50', '2025-06-22 04:03:54'),
(43, 41, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-18 12:24:50', '2025-06-22 04:03:54'),
(44, 42, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:04', '2025-06-22 04:03:54'),
(45, 43, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(46, 44, 'tidak_sesuai', 'Ruang kurang dari 4 m2 per orang', 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(47, 45, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(48, 46, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(49, 47, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(50, 48, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(51, 49, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(52, 50, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(53, 51, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(54, 52, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(55, 53, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(56, 54, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(57, 55, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(58, 56, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(59, 57, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(60, 58, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(61, 59, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(62, 60, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(63, 61, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(64, 62, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(65, 63, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(66, 64, 'tidak_sesuai', 'Jasa Kurang dari 10%', 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(67, 65, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(68, 66, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(69, 67, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(70, 68, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(71, 69, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(72, 70, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(73, 71, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(74, 72, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(75, 73, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(76, 74, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(77, 75, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(78, 76, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(79, 77, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(80, 78, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(81, 79, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(82, 80, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(83, 81, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(84, 82, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(85, 83, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(86, 84, 'sesuai', 'Untuk P3M', 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(87, 85, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(88, 86, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(89, 87, 'sesuai', 'Terletak di P3M PSDKU', 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(90, 88, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(91, 89, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(92, 90, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(93, 91, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(94, 92, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(95, 93, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(96, 94, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(97, 95, 'tidak_sesuai', 'Tidak Melibarkan mahasiswa', 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(98, 96, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(99, 97, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(100, 98, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(101, 99, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(102, 100, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(103, 101, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(104, 102, 'tidak_sesuai', 'prodi sudah melakukan pemetaan hanya belum dilakukan dokumentasi dalam bentuk persuratan', 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(105, 103, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(106, 104, 'sesuai', NULL, 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(107, 105, 'sesuai', 'banyak yang mengajukan namun harus dibagi, internal dan eksternal rasion ya 50:50, 17.6 juta perdosen DTPS', 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(108, 106, 'sesuai', 'sudah ada doumentasi perencanaan / perhitungan', 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(109, 107, 'sesuai', 'lolos litabmas 1 dosen, mujahid wahyu', 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(110, 108, 'tidak_sesuai', 'masukan: monev pembelajaran di masukkan evaluasi buku di RPS\n\nmelakukan monev untuk ketersediaan buku untuk diajukan ke perpustakaan', 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(111, 109, 'tidak_sesuai', 'belum ada akses data pendaftaran mahasiswa dari akademik pusat, prodi menunggu data hanya dari buku pemutakhiran data', 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(112, 110, 'tidak_sesuai', 'belum ada akses data pendaftaran mahasiswa dari akademik pusat, prodi menunggu data hanya dari buku pemutakhiran data', 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(113, 111, 'sesuai', 'TIDAK ADA TRANSFER KARENA D3', 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(114, 112, 'sesuai', 'tidak ada mahasiswa asing', 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(115, 113, 'sesuai', 'tidak ada mahasiswa asing+BW205+BW206+BW205+BW206+BW2+BW206', 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(116, 114, 'sesuai', 'mandiri 1:3\nprestasi 1:2', 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(117, 115, 'sesuai', 'layanan melalui DPA setiap semester minimal 1x', 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(118, 116, 'sesuai', '1 nasional, non akademik 1', 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(119, 117, 'sesuai', '1 nasional, non akademik 1', 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(120, 118, 'tidak_sesuai', 'tracer di bawah wadir 4, dan belum dapat feedback dari wadir 4, pakah prodi boleh mengetahui data tracernya, bentuk yang diberikan pada saat rapim berupa presentase dan tidak dapat dilacak berapa yang mengisi dari prodi yang bersangkutan', 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(121, 119, 'sesuai', 'sudah tertuang di dokumen kurikulum', 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(122, 120, 'sesuai', 'ada di buku kurikulum', 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(123, 121, 'tidak_sesuai', 'Belum ada organisasi dengan Board Advisory', 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(124, 122, 'tidak_sesuai', 'belum mendata secara keseluruhan, akan segera dilakukan pendataan, waktu evaluasinya belum dilaksanakan', 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(125, 123, 'sesuai', 'Jenjang D3', 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(126, 124, 'sesuai', 'Jenjang D3', 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(127, 125, 'sesuai', 'Jenjang D3', 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(128, 126, 'sesuai', 'Jenjang D3', 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(129, 127, 'sesuai', 'Jenjang D3', 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(130, 128, 'sesuai', 'Jenjang D3', 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(131, 129, 'sesuai', 'Jenjang D3', 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(132, 130, 'sesuai', 'Jenjang D3', 'reviewed', '2025-06-22 04:03:54', '2025-06-22 03:25:05', '2025-06-22 04:03:54'),
(133, 131, 'sesuai', 'Jenjang D3', 'reviewed', '2025-06-22 04:03:55', '2025-06-22 03:25:05', '2025-06-22 04:03:55'),
(134, 132, 'tidak_sesuai', 'tersedia data toeic', 'reviewed', '2025-06-22 04:03:55', '2025-06-22 03:25:05', '2025-06-22 04:03:55'),
(135, 133, 'sesuai', 'Jenjang D3', 'reviewed', '2025-06-22 04:03:55', '2025-06-22 03:25:05', '2025-06-22 04:03:55'),
(136, 134, 'sesuai', 'Jenjang D3', 'reviewed', '2025-06-22 04:03:55', '2025-06-22 03:25:05', '2025-06-22 04:03:55'),
(137, 135, 'tidak_sesuai', 'masih belum mendapatkan laptop seperti di pusat', 'reviewed', '2025-06-22 04:03:55', '2025-06-22 03:25:05', '2025-06-22 04:03:55'),
(138, 136, 'tidak_sesuai', 'Pembelajaran Offline', 'reviewed', '2025-06-22 04:03:55', '2025-06-22 03:25:05', '2025-06-22 04:03:55'),
(139, 137, 'tidak_sesuai', 'Pembelajaran Offline', 'reviewed', '2025-06-22 04:03:55', '2025-06-22 03:25:05', '2025-06-22 04:03:55'),
(140, 138, 'sesuai', 'LSP datang ke PSDKU untuk dilakukan sertikom', 'reviewed', '2025-06-22 04:03:55', '2025-06-22 03:25:05', '2025-06-22 04:03:55'),
(141, 139, 'tidak_sesuai', 'belum ada skema sertikom internasional\nkendala untuk pelaksanaan tidak bisa langsung dilaksanakan oleh prodi, harus melalui wadir 4,', 'reviewed', '2025-06-22 04:03:55', '2025-06-22 03:25:05', '2025-06-22 04:03:55');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'super_admin', 'web', '2025-06-11 13:45:39', '2025-06-11 13:45:39'),
(2, 'pimpinan', 'web', '2025-06-11 13:45:39', '2025-06-11 13:45:39'),
(3, 'p2mpp', 'web', '2025-06-11 13:45:39', '2025-06-11 13:45:39'),
(4, 'auditee', 'web', '2025-06-11 13:45:39', '2025-06-11 13:45:39'),
(5, 'auditor', 'web', '2025-06-11 13:45:39', '2025-06-11 13:45:39');

-- --------------------------------------------------------

--
-- Table structure for table `role_has_permissions`
--

CREATE TABLE `role_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `role_has_permissions`
--

INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 1),
(6, 1),
(7, 1),
(8, 1),
(9, 1),
(10, 1),
(11, 1),
(12, 1),
(13, 1),
(14, 1),
(15, 1),
(16, 1),
(17, 1),
(18, 1),
(19, 1),
(20, 1),
(21, 1),
(22, 1),
(23, 1),
(24, 1),
(25, 1),
(26, 1),
(27, 1),
(28, 1),
(29, 1),
(30, 1),
(31, 1),
(32, 1),
(33, 1),
(34, 1),
(35, 1),
(36, 1),
(37, 1),
(37, 5),
(38, 1),
(38, 5),
(39, 1),
(40, 1),
(41, 1),
(42, 1),
(43, 1),
(44, 1),
(45, 1),
(46, 1),
(47, 1),
(48, 1),
(49, 1),
(49, 4),
(50, 1),
(50, 4),
(51, 1),
(51, 4),
(52, 1),
(53, 1),
(54, 1),
(55, 1),
(56, 1),
(57, 1),
(58, 1),
(59, 1),
(60, 1),
(61, 1),
(62, 1),
(63, 1),
(64, 1),
(65, 1),
(66, 1),
(67, 1),
(68, 1),
(69, 1),
(70, 1),
(71, 1),
(72, 1),
(73, 1),
(73, 4),
(73, 5),
(74, 1),
(74, 4),
(74, 5),
(75, 1),
(75, 5),
(76, 1),
(76, 5),
(77, 1),
(78, 1),
(79, 1),
(80, 1),
(81, 1),
(82, 1),
(83, 1),
(84, 1),
(85, 1),
(86, 1),
(87, 1),
(88, 1),
(89, 1),
(90, 1),
(91, 1),
(92, 1),
(93, 1),
(94, 1),
(95, 1),
(96, 1),
(97, 1),
(98, 1),
(99, 1),
(100, 1),
(101, 1),
(102, 1),
(103, 1),
(104, 1),
(105, 1),
(106, 1),
(107, 1),
(108, 1),
(109, 1),
(110, 1),
(111, 1),
(112, 1),
(113, 1),
(114, 1),
(115, 1),
(116, 1),
(117, 1),
(118, 1),
(119, 1),
(120, 1),
(121, 1),
(122, 1),
(123, 1),
(124, 1),
(125, 1),
(126, 1),
(127, 1),
(128, 1),
(129, 1),
(130, 1),
(131, 1),
(132, 1),
(133, 1),
(134, 1),
(135, 1),
(136, 1),
(137, 1),
(138, 1),
(139, 1),
(140, 1),
(141, 1),
(142, 1),
(143, 1),
(144, 1),
(145, 1),
(146, 1),
(147, 1),
(148, 1),
(149, 1),
(150, 1),
(151, 1),
(151, 2),
(151, 3),
(151, 4),
(151, 5),
(152, 1),
(153, 1),
(153, 4),
(153, 5),
(154, 1),
(154, 5),
(155, 1),
(155, 2),
(155, 3),
(155, 4),
(155, 5);

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
('kzYjmEwo75xVterfMV6asU3sRVNQkanurRJNcvB8', 11, '103.125.36.233', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTo3OntzOjY6Il90b2tlbiI7czo0MDoiMWtZQlQxSnRrSjAwcUZIMTJ0M2xOcWt2QmtkNGc2SVFGb3pDT1BIZyI7czozOiJ1cmwiO2E6MDp7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjQwOiJodHRwczovL3NwbWktcG9saW5lbWEucHBhZHpkemlrcmFid2kubmV0Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo1MDoibG9naW5fd2ViXzNkYzdhOTEzZWY1ZmQ0Yjg5MGVjYWJlMzQ4NzA4NTU3M2UxNmNmODIiO2k6MTE7czoxNzoicGFzc3dvcmRfaGFzaF93ZWIiO3M6NjA6IiQyeSQxMiRVNFQzZUR5Tm40QnRVQ21UZUhRZFouZHBTL2tSRENiNHJ1SndDdHBPWVBOaW1yQ3FycnFTcSI7czoxOToic2VsZWN0ZWRfcGVyaW9kZV9pZCI7aToyO30=', 1750678551);

-- --------------------------------------------------------

--
-- Table structure for table `standars`
--

CREATE TABLE `standars` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `kode_standar` varchar(255) NOT NULL,
  `nama_standar` varchar(255) NOT NULL,
  `tahun` year(4) NOT NULL,
  `status` enum('pending','validated') NOT NULL DEFAULT 'pending',
  `validated_by` bigint(20) UNSIGNED DEFAULT NULL,
  `validated_time` timestamp NULL DEFAULT NULL,
  `created_by` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `standars`
--

INSERT INTO `standars` (`id`, `kode_standar`, `nama_standar`, `tahun`, `status`, `validated_by`, `validated_time`, `created_by`, `created_at`, `updated_at`) VALUES
(1, '3', 'hi', '2024', 'validated', 11, '2024-06-11 13:48:54', 11, '2024-06-11 13:48:41', '2024-06-14 05:03:03'),
(2, '1', 'Standar Kompetensi lulusan', '2024', 'validated', 987654931, '2024-06-16 10:39:58', 987654931, '2024-06-16 10:39:58', '2024-06-16 10:39:58'),
(3, '2', 'Standar Isi Pembelajaran', '2024', 'validated', 987654931, '2024-06-16 10:39:58', 987654931, '2024-06-16 10:39:58', '2024-06-16 10:39:58'),
(4, '3', 'Standar Proses Pembelajaran', '2024', 'validated', 987654931, '2024-06-16 10:39:58', 987654931, '2024-06-16 10:39:58', '2024-06-16 10:39:58'),
(5, '4', 'Standar Penilaian Pembelajaran', '2024', 'validated', 987654931, '2024-06-16 10:39:58', 987654931, '2024-06-16 10:39:58', '2024-06-16 10:39:58'),
(6, '5', 'Standar Pendidik dan Tenaga Kependidikan', '2024', 'validated', 987654931, '2024-06-16 10:39:58', 987654931, '2024-06-16 10:39:58', '2024-06-16 10:39:58'),
(7, '6', 'Standar Sarana dan Prasarana Pembelajaran', '2024', 'validated', 987654931, '2024-06-16 10:39:58', 987654931, '2024-06-16 10:39:58', '2024-06-16 10:39:58'),
(8, '7', 'Standar Pengelolaan Pembelajaran', '2024', 'validated', 987654931, '2024-06-16 10:39:58', 987654931, '2024-06-16 10:39:58', '2024-06-16 10:39:58'),
(9, '8', 'Standar Pendanaan dan Pembiayaan Pembelajaran', '2024', 'validated', 987654931, '2024-06-16 10:39:58', 987654931, '2024-06-16 10:39:58', '2024-06-16 10:39:58'),
(10, '9', 'Standar Hasil Penelitian', '2024', 'validated', 987654931, '2024-06-16 10:39:58', 987654931, '2024-06-16 10:39:58', '2024-06-16 10:39:58'),
(12, '11', 'Standar Proses Penelitian', '2024', 'validated', 987654931, '2024-06-16 10:39:58', 987654931, '2024-06-16 10:39:58', '2024-06-16 10:39:58'),
(13, '12', 'Standar Penilaian Penelitian', '2024', 'validated', 987654931, '2024-06-16 10:39:58', 987654931, '2024-06-16 10:39:58', '2024-06-16 10:39:58'),
(14, '13', 'Standar Peneliti', '2024', 'validated', 987654931, '2024-06-16 10:39:58', 987654931, '2024-06-16 10:39:58', '2024-06-16 10:39:58'),
(15, '14', 'Standar Sarana dan Prasarana Penelitian', '2024', 'validated', 987654931, '2024-06-16 10:39:58', 987654931, '2024-06-16 10:39:58', '2024-06-16 10:39:58'),
(16, '15', 'Standar Pengelolaan Penelitian', '2024', 'validated', 987654931, '2024-06-16 10:39:58', 987654931, '2024-06-16 10:39:58', '2024-06-16 10:39:58'),
(17, '16', 'Standar Pendanaan dan Pembiayaan Penelitian', '2024', 'validated', 987654931, '2024-06-16 10:39:58', 987654931, '2024-06-16 10:39:58', '2024-06-16 10:39:58'),
(18, '17', 'Standar Hasil Pengabdian kepada Masyarakat', '2024', 'validated', 987654931, '2024-06-16 10:39:58', 987654931, '2024-06-16 10:39:58', '2024-06-16 10:39:58'),
(19, '18', 'Standar Isi Pengabdian kepada Masyarakat', '2024', 'validated', 11, '2024-06-16 10:39:58', 11, '2024-06-16 10:39:58', '2024-06-16 10:39:58'),
(20, '19', 'Standar Proses Pengabdian kepada Masyarakat', '2024', 'validated', 11, '2024-06-16 10:39:58', 11, '2024-06-16 10:39:58', '2024-06-16 10:39:58'),
(21, '20', 'Standar Penilaian Pengabdian kepada Masyarakat', '2024', 'validated', 11, '2024-06-16 10:39:58', 11, '2024-06-16 10:39:58', '2024-06-16 10:39:58'),
(22, '21', 'Standar Pelaksana Pengabdian kepada Masyarakat', '2024', 'validated', 11, '2024-06-16 10:39:58', 11, '2024-06-16 10:39:58', '2024-06-16 10:39:58'),
(23, '22', 'Standar Sarana dan Prasarana Pengabdian kepada Masyarakat', '2024', 'validated', 11, '2024-06-16 10:39:58', 11, '2024-06-16 10:39:58', '2024-06-16 10:39:58'),
(24, '23', 'Standar Pengelolaan Pengabdian kepada Masyarakat', '2024', 'validated', 11, '2024-06-16 10:39:58', 11, '2024-06-16 10:39:58', '2024-06-16 10:39:58'),
(25, '24', 'Standar Pendanaan dan Pembiayaan Pengabdian kepada Masyarakat', '2024', 'validated', 11, '2024-06-16 10:39:58', 11, '2024-06-16 10:39:58', '2024-06-16 10:39:58'),
(26, '25', 'Standar Perpustakaan', '2024', 'validated', 11, '2024-06-16 10:39:58', 11, '2024-06-16 10:39:58', '2024-06-16 10:39:58'),
(27, '27', 'Standar Penerimaan Mahasiswa Baru', '2024', 'validated', 11, '2024-06-16 10:39:58', 11, '2024-06-16 10:39:58', '2024-06-16 10:39:58'),
(28, '28', 'Standar Kemahasiswaan', '2024', 'validated', 11, '2024-06-16 10:39:58', 11, '2024-06-16 10:39:58', '2024-06-16 10:39:58'),
(29, '30', 'Standar Alumni', '2024', 'validated', 11, '2024-06-16 10:39:58', 11, '2024-06-16 10:39:58', '2024-06-16 10:39:58'),
(30, '31', 'Standar Visi, Misi, Tujuan dan Sasaran', '2024', 'validated', 11, '2024-06-16 10:39:58', 11, '2024-06-16 10:39:58', '2024-06-16 10:39:58'),
(31, '34', 'Standar Pengelolaan Institusi', '2024', 'validated', 11, '2024-06-16 10:39:58', 11, '2024-06-16 10:39:58', '2024-06-16 10:39:58'),
(32, '37', 'Standar Alih Jenjang', '2024', 'validated', 11, '2024-06-16 10:39:58', 11, '2024-06-16 10:39:58', '2024-06-16 10:39:58'),
(33, '38', 'Standar Rekognisi Pembelajaran Lampau (A1)', '2024', 'validated', 11, '2024-06-16 10:39:58', 11, '2024-06-16 10:39:58', '2024-06-16 10:39:58'),
(34, '39', 'Standar Kompetensi Lulusan Dalam Berbahasa Inggris', '2024', 'validated', 11, '2024-06-16 10:39:58', 11, '2024-06-16 10:39:58', '2024-06-16 10:39:58'),
(35, '40', 'Standar E-Learning', '2024', 'validated', 11, '2024-06-16 10:39:58', 11, '2024-06-16 10:39:58', '2024-06-16 10:39:58'),
(36, '41', 'Standar Kompetensi Kerja Nasional', '2024', 'validated', 987654931, '2025-06-16 10:39:58', 987654931, '2025-06-16 10:39:58', '2025-06-17 23:10:35'),
(987654931, '10', 'Standar Isi Penelitian', '2024', 'validated', 987654931, '2024-06-16 10:39:58', 987654931, '2024-06-16 10:39:58', '2024-06-16 10:39:58');

-- --------------------------------------------------------

--
-- Table structure for table `sub_standars`
--

CREATE TABLE `sub_standars` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nama_sub_standar` varchar(255) NOT NULL,
  `standar_id` bigint(20) UNSIGNED NOT NULL,
  `isi_standar_id` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`isi_standar_id`)),
  `status` enum('pending','validated') NOT NULL DEFAULT 'pending',
  `validated_by` bigint(20) UNSIGNED DEFAULT NULL,
  `validated_time` timestamp NULL DEFAULT NULL,
  `created_by` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sub_standars`
--

INSERT INTO `sub_standars` (`id`, `nama_sub_standar`, `standar_id`, `isi_standar_id`, `status`, `validated_by`, `validated_time`, `created_by`, `created_at`, `updated_at`) VALUES
(1, 'd', 1, '[{\"isi_id\": \"1\"}]', 'validated', 11, '2025-06-11 13:50:04', 11, '2025-06-11 13:49:57', '2025-06-11 13:50:06'),
(2, 'Standar Kompetensi lulusan', 2, '[{\"isi_id\": \"1\"}]', 'validated', 987654931, '2025-06-17 23:06:59', 987654931, '2025-06-17 23:06:51', '2025-06-17 23:07:04'),
(3, 'Standar Isi Pembelajaran', 3, '[{\"isi_id\": \"1\"}]', 'validated', 987654931, '2025-06-17 23:08:20', 987654931, '2025-06-17 23:08:13', '2025-06-17 23:08:24'),
(4, 'Standar Proses Pembelajaran', 4, '[{\"isi_id\": \"1\"}]', 'validated', 987654931, '2025-06-17 23:12:58', 987654931, '2025-06-17 23:09:17', '2025-06-17 23:13:02'),
(5, 'Standar Penilaian Pembelajara', 5, '[{\"isi_id\": \"1\"}]', 'validated', 11, '2025-06-17 23:12:51', 987654931, '2025-06-17 23:09:58', '2025-06-17 23:12:55'),
(6, 'Standar Pendidik dan Tenaga Kependidikan', 6, '[{\"isi_id\": \"1\"}]', 'validated', 11, '2025-06-17 23:12:45', 987654931, '2025-06-17 23:12:01', '2025-06-17 23:12:48'),
(7, 'Standar Sarana dan Prasarana Pembelajaran', 7, '[{\"isi_id\": \"1\"}]', 'validated', 987654931, '2025-06-17 23:15:12', 987654931, '2025-06-17 23:14:10', '2025-06-17 23:15:15'),
(8, 'Standar Pengelolaan Pembelajaran', 8, '[{\"isi_id\": \"1\"}]', 'validated', 987654931, '2025-06-17 23:15:07', 987654931, '2025-06-17 23:14:59', '2025-06-17 23:15:10'),
(9, 'Standar Pendanaan dan Pembiayaan Pembelajaran', 9, '[{\"isi_id\": \"1\"}]', 'validated', 987654931, '2025-06-17 23:16:02', 987654931, '2025-06-17 23:15:54', '2025-06-17 23:16:06'),
(10, 'Standar Hasil Penelitian', 10, '[{\"isi_id\": \"1\"}]', 'validated', 987654931, '2025-06-17 23:17:08', 987654931, '2025-06-17 23:17:00', '2025-06-17 23:17:13'),
(11, 'Standar Isi Penelitian', 987654931, '[{\"isi_id\": \"1\"}]', 'validated', 11, '2025-06-17 23:18:02', 987654931, '2025-06-17 23:17:53', '2025-06-17 23:18:05'),
(12, 'Standar Proses Penelitian', 12, '[{\"isi_id\": \"1\"}]', 'validated', 987654931, '2025-06-17 23:18:51', 987654931, '2025-06-17 23:18:42', '2025-06-17 23:18:55'),
(13, 'Standar Penilaian Penelitian', 13, '[{\"isi_id\": \"1\"}]', 'validated', 987654931, '2025-06-17 23:19:42', 987654931, '2025-06-17 23:19:35', '2025-06-17 23:19:47'),
(14, 'Standar Peneliti', 14, '[{\"isi_id\": \"1\"}]', 'validated', 987654931, '2025-06-17 23:20:36', 987654931, '2025-06-17 23:20:27', '2025-06-17 23:20:41'),
(15, 'Standar Sarana dan Prasarana Penelitian', 15, '[{\"isi_id\": \"1\"}]', 'validated', 987654931, '2025-06-17 23:26:37', 987654931, '2025-06-17 23:26:29', '2025-06-17 23:26:41'),
(16, 'Standar Pengelolaan Penelitian', 16, '[{\"isi_id\": \"1\"}]', 'validated', 987654931, '2025-06-17 23:27:22', 987654931, '2025-06-17 23:27:13', '2025-06-17 23:27:25'),
(17, 'Standar Pendanaan dan Pembiayaan Penelitian', 17, '[{\"isi_id\": \"1\"}]', 'validated', 987654931, '2025-06-17 23:28:07', 987654931, '2025-06-17 23:27:58', '2025-06-17 23:28:10'),
(18, 'Standar Hasil Pengabdian kepada Masyarakat', 18, '[{\"isi_id\": \"1\"}]', 'validated', 987654931, '2025-06-17 23:28:57', 987654931, '2025-06-17 23:28:49', '2025-06-17 23:29:00'),
(19, 'Standar Isi Pengabdian kepada Masyarakat', 19, '[{\"isi_id\": \"1\"}]', 'validated', 987654931, '2025-06-22 01:26:50', 987654931, '2025-06-17 23:54:38', '2025-06-22 01:26:53'),
(20, 'Standar Proses Pengabdian kepada Masyarakat', 20, '[{\"isi_id\": \"1\"}]', 'validated', 987654931, '2025-06-22 01:26:46', 987654931, '2025-06-17 23:58:19', '2025-06-22 01:26:48'),
(21, 'Standar Penilaian Pengabdian kepada Masyarakat', 21, '[{\"isi_id\": \"1\"}]', 'validated', 987654931, '2025-06-22 01:26:38', 987654931, '2025-06-17 23:59:21', '2025-06-22 01:26:41'),
(22, 'Standar Pelaksana Pengabdian kepada Masyarakat', 22, '[{\"isi_id\": \"1\"}]', 'validated', 987654931, '2025-06-22 01:26:30', 987654931, '2025-06-17 23:59:49', '2025-06-22 01:26:34'),
(23, 'Standar Sarana dan Prasarana Pengabdian kepada Masyarakat', 23, '[{\"isi_id\": \"1\"}]', 'validated', 987654931, '2025-06-22 01:26:23', 987654931, '2025-06-18 00:00:42', '2025-06-22 01:26:27'),
(24, 'Standar Pengelolaan Pengabdian kepada Masyarakat', 24, '[{\"isi_id\": \"1\"}]', 'validated', 987654931, '2025-06-22 01:26:16', 987654931, '2025-06-18 00:01:18', '2025-06-22 01:26:19'),
(25, 'Standar Pendanaan dan Pembiayaan Pengabdian kepada Masyarakat', 25, '[{\"isi_id\": \"1\"}]', 'validated', 987654931, '2025-06-22 01:26:09', 987654931, '2025-06-18 00:02:06', '2025-06-22 01:26:12'),
(26, 'Standar Perpustakaan', 26, '[{\"isi_id\": \"1\"}]', 'validated', 987654931, '2025-06-22 01:26:01', 987654931, '2025-06-18 00:02:38', '2025-06-22 01:26:05'),
(27, 'Standar Penerimaan Mahasiswa Baru', 27, '[{\"isi_id\": \"1\"}]', 'validated', 987654931, '2025-06-22 01:25:53', 987654931, '2025-06-18 00:03:11', '2025-06-22 01:25:57'),
(28, 'Standar Kemahasiswaan', 28, '[{\"isi_id\": \"1\"}]', 'validated', 987654931, '2025-06-22 01:25:45', 987654931, '2025-06-18 00:04:18', '2025-06-22 01:25:49'),
(29, 'Standar Alumni', 29, '[{\"isi_id\": \"1\"}]', 'validated', 987654931, '2025-06-22 01:25:36', 987654931, '2025-06-18 00:05:33', '2025-06-22 01:25:40'),
(30, 'Standar Visi, Misi, Tujuan dan Sasaran', 30, '[{\"isi_id\": \"1\"}]', 'validated', 987654931, '2025-06-22 01:25:23', 987654931, '2025-06-18 00:07:20', '2025-06-22 01:25:28'),
(31, 'Standar Pengelolaan Institusi', 31, '[{\"isi_id\": \"1\"}]', 'validated', 987654931, '2025-06-22 01:25:12', 987654931, '2025-06-18 00:09:03', '2025-06-22 01:25:18'),
(32, 'Standar Alih Jenjang', 32, '[{\"isi_id\": \"1\"}]', 'validated', 987654931, '2025-06-22 01:25:03', 987654931, '2025-06-18 00:09:45', '2025-06-22 01:25:06'),
(33, 'Standar Rekognisi Pembelajaran Lampau (A1)', 33, '[{\"isi_id\": \"1\"}]', 'validated', 987654931, '2025-06-22 01:24:36', 987654931, '2025-06-18 00:10:24', '2025-06-22 01:24:38'),
(34, 'Standar Kompetensi Lulusan Dalam Berbahasa Inggris', 34, '[{\"isi_id\": \"1\"}]', 'validated', 987654931, '2025-06-22 01:24:29', 987654931, '2025-06-18 00:11:01', '2025-06-22 01:24:32'),
(35, 'Standar E-Learning', 35, '[{\"isi_id\": \"1\"}]', 'validated', 987654931, '2025-06-22 01:24:19', 987654931, '2025-06-18 00:11:36', '2025-06-22 01:24:22'),
(36, 'Standar Kompetensi Kerja Nasional', 36, '[{\"isi_id\": \"1\"}]', 'validated', 987654931, '2025-06-22 01:24:09', 987654931, '2025-06-18 00:12:08', '2025-06-22 01:24:13');

-- --------------------------------------------------------

--
-- Table structure for table `units`
--

CREATE TABLE `units` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `kode_unit` varchar(255) NOT NULL,
  `nama_unit` varchar(255) NOT NULL,
  `status` enum('pending','validated') NOT NULL DEFAULT 'pending',
  `validated_by` bigint(20) UNSIGNED DEFAULT NULL,
  `validated_time` timestamp NULL DEFAULT NULL,
  `created_by` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `units`
--

INSERT INTO `units` (`id`, `kode_unit`, `nama_unit`, `status`, `validated_by`, `validated_time`, `created_by`, `created_at`, `updated_at`) VALUES
(1, 'cc', 'c', 'pending', 11, NULL, 11, '2025-06-11 13:51:24', '2025-06-11 13:51:24'),
(2, '001', 'D3 Administrasi Bisnis', 'validated', NULL, '2025-06-16 10:29:46', NULL, '2025-06-16 10:29:46', '2025-06-16 10:29:46'),
(3, '002', 'D4 Bahasa Inggris Untuk Industri Pariwisata', 'validated', NULL, '2025-06-16 10:29:46', NULL, '2025-06-16 10:29:46', '2025-06-16 10:29:46'),
(4, '003', 'D4 Bahasa Inggris Untuk Komunikasi Bisnis Dan Profesional', 'validated', NULL, '2025-06-16 10:29:46', NULL, '2025-06-16 10:29:46', '2025-06-16 10:29:46'),
(5, '004', 'D4 Manajemen Pemasaran', 'validated', NULL, '2025-06-16 10:29:46', NULL, '2025-06-16 10:29:46', '2025-06-16 10:29:46'),
(6, '005', 'D4 Pengelolaan Arsip Dan Rekaman Informasi', 'validated', NULL, '2025-06-16 10:29:46', NULL, '2025-06-16 10:29:46', '2025-06-16 10:29:46'),
(7, '006', 'D4 Usaha Perjalanan Wisata', 'validated', NULL, '2025-06-16 10:29:46', NULL, '2025-06-16 10:29:46', '2025-06-16 10:29:46'),
(8, '007', 'JURUSAN ADMINISTRASI NIAGA', 'validated', NULL, '2025-06-16 10:29:46', NULL, '2025-06-16 10:29:46', '2025-06-16 10:29:46'),
(9, '008', 'D3 Akuntansi', 'validated', NULL, '2025-06-16 10:29:46', NULL, '2025-06-16 10:29:46', '2025-06-16 10:29:46'),
(10, '009', 'D4 Akuntansi Manajemen', 'validated', NULL, '2025-06-16 10:29:46', NULL, '2025-06-16 10:29:46', '2025-06-16 10:29:46'),
(11, '010', 'D4 Keuangan', 'validated', NULL, '2025-06-16 10:29:46', NULL, '2025-06-16 10:29:46', '2025-06-16 10:29:46'),
(12, '011', 'S2 Magister Terapan Sistem Informasi Akuntansi', 'validated', NULL, '2025-06-16 10:29:46', NULL, '2025-06-16 10:29:46', '2025-06-16 10:29:46'),
(13, '012', 'JURUSAN AKUNTANSI', 'validated', NULL, '2025-06-16 10:29:46', NULL, '2025-06-16 10:29:46', '2025-06-16 10:29:46'),
(14, '013', 'D3 Teknik Elektronika', 'validated', NULL, '2025-06-16 10:29:46', NULL, '2025-06-16 10:29:46', '2025-06-16 10:29:46'),
(15, '014', 'D4 Sistem Kelistrikan', 'validated', NULL, '2025-06-16 10:29:46', NULL, '2025-06-16 10:29:46', '2025-06-16 10:29:46'),
(16, '015', 'D4 Teknik Elektronika', 'validated', NULL, '2025-06-16 10:29:46', NULL, '2025-06-16 10:29:46', '2025-06-16 10:29:46'),
(17, '016', 'D4 Teknik Jaringan Telekomunikasi Digital', 'validated', NULL, '2025-06-16 10:29:46', NULL, '2025-06-16 10:29:46', '2025-06-16 10:29:46'),
(18, '017', 'D3 Teknik Listrik', 'validated', NULL, '2025-06-16 10:29:46', NULL, '2025-06-16 10:29:46', '2025-06-16 10:29:46'),
(19, '018', 'D3 Teknik Telekomunikasi', 'validated', NULL, '2025-06-16 10:29:46', NULL, '2025-06-16 10:29:46', '2025-06-16 10:29:46'),
(20, '019', 'S2 Magister Terapan Teknik Elektro', 'validated', NULL, '2025-06-16 10:29:46', NULL, '2025-06-16 10:29:46', '2025-06-16 10:29:46'),
(21, '020', 'JURUSAN TEKNIK ELEKTRO', 'validated', NULL, '2025-06-16 10:29:46', NULL, '2025-06-16 10:29:46', '2025-06-16 10:29:46'),
(22, '021', 'D2 Pengembangan Piranti Lunak Situs', 'validated', NULL, '2025-06-16 10:29:46', NULL, '2025-06-16 10:29:46', '2025-06-16 10:29:46'),
(23, '022', 'D4 Sistem Informsi Bisnis', 'validated', NULL, '2025-06-16 10:29:46', NULL, '2025-06-16 10:29:46', '2025-06-16 10:29:46'),
(24, '023', 'D4 Teknik Informatika', 'validated', NULL, '2025-06-16 10:29:46', NULL, '2025-06-16 10:29:46', '2025-06-16 10:29:46'),
(25, '024', 'S2 Magister Terapan Rekayasa Teknologi Informatika', 'validated', NULL, '2025-06-16 10:29:46', NULL, '2025-06-16 10:29:46', '2025-06-16 10:29:46'),
(26, '025', 'JURUSAN TEKNOLOGI INFORMASI', 'validated', NULL, '2025-06-16 10:29:46', NULL, '2025-06-16 10:29:46', '2025-06-16 10:29:46'),
(27, '026', 'D3 Teknik Kimia', 'validated', NULL, '2025-06-16 10:29:46', NULL, '2025-06-16 10:29:46', '2025-06-16 10:29:46'),
(28, '027', 'D4 Teknologi Kimia Industri', 'validated', NULL, '2025-06-16 10:29:46', NULL, '2025-06-16 10:29:46', '2025-06-16 10:29:46'),
(29, '028', 'S2 Magister Terapan Optimasi Rekayasa Kimia', 'validated', NULL, '2025-06-16 10:29:46', NULL, '2025-06-16 10:29:46', '2025-06-16 10:29:46'),
(30, '029', 'JURUSAN TEKNIK KIMIA', 'validated', NULL, '2025-06-16 10:29:46', NULL, '2025-06-16 10:29:46', '2025-06-16 10:29:46'),
(31, '030', 'D3 Teknik Mesin', 'validated', NULL, '2025-06-16 10:29:46', NULL, '2025-06-16 10:29:46', '2025-06-16 10:29:46'),
(32, '031', 'D3 Teknologi Pemeliharaan Pesawat Udara', 'validated', NULL, '2025-06-16 10:29:46', NULL, '2025-06-16 10:29:46', '2025-06-16 10:29:46'),
(33, '032', 'D4 Teknik Mesin Produksi Dan Perawatan', 'validated', NULL, '2025-06-16 10:29:46', NULL, '2025-06-16 10:29:46', '2025-06-16 10:29:46'),
(34, '033', 'D4 Teknik Otomotif Elektronik', 'validated', NULL, '2025-06-16 10:29:46', NULL, '2025-06-16 10:29:46', '2025-06-16 10:29:46'),
(35, '034', 'S2 Magister Terapan Rekayasa Teknologi Manufaktur', 'validated', NULL, '2025-06-16 10:29:46', NULL, '2025-06-16 10:29:46', '2025-06-16 10:29:46'),
(36, '035', 'S3 Doktor Terapan Optimasi Desain Mekanik', 'validated', NULL, '2025-06-16 10:29:46', NULL, '2025-06-16 10:29:46', '2025-06-16 10:29:46'),
(37, '036', 'JURUSAN TEKNIK MESIN', 'validated', NULL, '2025-06-16 10:29:46', NULL, '2025-06-16 10:29:46', '2025-06-16 10:29:46'),
(38, '037', 'D3 Teknik Sipil', 'validated', NULL, '2025-06-16 10:29:46', NULL, '2025-06-16 10:29:46', '2025-06-16 10:29:46'),
(39, '038', 'D3 Teknologi Konstruksi, Jalan, Jembatan Dan Bangunan Air', 'validated', NULL, '2025-06-16 10:29:46', NULL, '2025-06-16 10:29:46', '2025-06-16 10:29:46'),
(40, '039', 'D3 Teknologi Pertambangan', 'validated', NULL, '2025-06-16 10:29:46', NULL, '2025-06-16 10:29:46', '2025-06-16 10:29:46'),
(41, '040', 'D4 Manajemen Rekayasa Konstruksi', 'validated', NULL, '2025-06-16 10:29:46', NULL, '2025-06-16 10:29:46', '2025-06-16 10:29:46'),
(42, '041', 'D4 Teknologi Rekayasa Konstruksi Jalan Dan Jembatan', 'validated', NULL, '2025-06-16 10:29:46', NULL, '2025-06-16 10:29:46', '2025-06-16 10:29:46'),
(43, '042', 'JURUSAN TEKNIK SIPIL', 'validated', NULL, '2025-06-16 10:29:46', NULL, '2025-06-16 10:29:46', '2025-06-16 10:29:46'),
(44, '043', 'D3 Akuntansi Kampus Kediri', 'validated', NULL, '2025-06-16 10:29:46', NULL, '2025-06-16 10:29:46', '2025-06-16 10:29:46'),
(45, '044', 'D3 Manajemen Informatika Kampus Kediri', 'validated', NULL, '2025-06-16 10:29:46', NULL, '2025-06-16 10:29:46', '2025-06-16 10:29:46'),
(46, '045', 'D3 Teknik Mesin Kampus Kediri', 'validated', NULL, '2025-06-16 10:29:46', NULL, '2025-06-16 10:29:46', '2025-06-16 10:29:46'),
(47, '046', 'D4 Keuangan Kampus Kediri', 'validated', NULL, '2025-06-16 10:29:46', NULL, '2025-06-16 10:29:46', '2025-06-16 10:29:46'),
(48, '047', 'D4 Teknik Elektronika Kampus Kediri', 'validated', NULL, '2025-06-16 10:29:46', NULL, '2025-06-16 10:29:46', '2025-06-16 10:29:46'),
(49, '048', 'D4 Teknik Mesin Produksi Dan Perawatan Kampus Kediri', 'validated', NULL, '2025-06-16 10:29:46', NULL, '2025-06-16 10:29:46', '2025-06-16 10:29:46'),
(50, '049', 'PSDKU KEDIRI', 'validated', NULL, '2025-06-16 10:29:46', NULL, '2025-06-16 10:29:46', '2025-06-16 10:29:46'),
(51, '050', 'D3 Akuntansi Kampus Lumajang', 'validated', NULL, '2025-06-16 10:29:46', NULL, '2025-06-16 10:29:46', '2025-06-16 10:29:46'),
(52, '051', 'D3 Teknologi Informasi Kampus Lumajang', 'validated', NULL, '2025-06-16 10:29:46', NULL, '2025-06-16 10:29:46', '2025-06-16 10:29:46'),
(53, '052', 'D3 Teknologi Sipil Kampus Lumajang', 'validated', NULL, '2025-06-16 10:29:46', NULL, '2025-06-16 10:29:46', '2025-06-16 10:29:46'),
(54, '053', 'D4 Teknologi Rekayasa Otomotif Kampus Lumajang', 'validated', NULL, '2025-06-16 10:29:46', NULL, '2025-06-16 10:29:46', '2025-06-16 10:29:46'),
(55, '054', 'PSDKU LUMAJANG', 'validated', NULL, '2025-06-16 10:29:46', NULL, '2025-06-16 10:29:46', '2025-06-16 10:29:46'),
(56, '055', 'D3 Manajemen Informatika Kampus Pamekasan', 'validated', NULL, '2025-06-16 10:29:46', NULL, '2025-06-16 10:29:46', '2025-06-16 10:29:46'),
(57, '056', 'D4 Akuntansi Manajemen Kampus Pamekasan', 'validated', NULL, '2025-06-16 10:29:46', NULL, '2025-06-16 10:29:46', '2025-06-16 10:29:46'),
(58, '057', 'D4 Teknik Otomotif Elektronik Kampus Pamekasan', 'validated', NULL, '2025-06-16 10:29:46', NULL, '2025-06-16 10:29:46', '2025-06-16 10:29:46'),
(59, '058', 'PSDKU PAMEKASAN', 'validated', NULL, '2025-06-16 10:29:46', NULL, '2025-06-16 10:29:46', '2025-06-16 10:29:46'),
(60, '059', 'Kepala Bagian Akademik dan Kemahasiswaan (BAK)', 'validated', NULL, '2025-06-16 10:29:46', NULL, '2025-06-16 10:29:46', '2025-06-16 10:29:46'),
(61, '060', 'Kepala Bagian Perencanaan, Keuangan Dan Umum (BPKU)', 'validated', NULL, '2025-06-16 10:29:46', NULL, '2025-06-16 10:29:46', '2025-06-16 10:29:46'),
(62, '061', 'Kepala P2MPP', 'validated', NULL, '2025-06-16 10:29:46', NULL, '2025-06-16 10:29:46', '2025-06-16 10:29:46'),
(63, '062', 'Kepala Pusat Penelitian Dan Pengabdian Kepada Masyarakat (P3M)', 'validated', NULL, '2025-06-16 10:29:46', NULL, '2025-06-16 10:29:46', '2025-06-16 10:29:46'),
(64, '063', 'Kepala Unit Penunjang Akademik Perpustakaan (UPA Perpustakaan)', 'validated', NULL, '2025-06-16 10:29:46', NULL, '2025-06-16 10:29:46', '2025-06-16 10:29:46'),
(65, '064', 'Kepala Unit Penunjang Teknologi Informasi Dan Komunikasi (UPA TIK)', 'validated', NULL, '2025-06-16 10:29:46', NULL, '2025-06-16 10:29:46', '2025-06-16 10:29:46'),
(66, '065', 'Kepala UPA Bahasa', 'validated', NULL, '2025-06-16 10:29:46', NULL, '2025-06-16 10:29:46', '2025-06-16 10:29:46'),
(67, '066', 'Kepala UPA Layanan Uji Kompetensi (LUK)', 'validated', NULL, '2025-06-16 10:29:46', NULL, '2025-06-16 10:29:46', '2025-06-16 10:29:46'),
(68, '067', 'Kepala UPA Perawatan dan Perbaikan (PP)', 'validated', NULL, '2025-06-16 10:29:46', NULL, '2025-06-16 10:29:46', '2025-06-16 10:29:46'),
(69, '068', 'Kepala UPA Pengembangan Karir dan Kewirausahaan (PKK)', 'validated', NULL, '2025-06-16 10:29:46', NULL, '2025-06-16 10:29:46', '2025-06-16 10:29:46'),
(70, '069', 'Kepala UPA Percetakan dan Penerbitan', 'validated', NULL, '2025-06-16 10:29:46', NULL, '2025-06-16 10:29:46', '2025-06-16 10:29:46'),
(71, '070', 'PUSAT', 'validated', NULL, '2025-06-16 10:29:46', NULL, '2025-06-16 10:29:46', '2025-06-16 10:29:46');

-- --------------------------------------------------------

--
-- Table structure for table `unit_indikators`
--

CREATE TABLE `unit_indikators` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `unit_id` bigint(20) UNSIGNED NOT NULL,
  `status` enum('pending','validated') NOT NULL DEFAULT 'pending',
  `auditee` bigint(20) UNSIGNED DEFAULT NULL,
  `validator_1_id` bigint(20) UNSIGNED DEFAULT NULL,
  `status_validasi_1` enum('pending','validated','rejected') NOT NULL DEFAULT 'pending',
  `validated_time_1` timestamp NULL DEFAULT NULL,
  `komentar_validasi_1` text DEFAULT NULL,
  `created_by` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `periode_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `unit_indikators`
--

INSERT INTO `unit_indikators` (`id`, `unit_id`, `status`, `auditee`, `validator_1_id`, `status_validasi_1`, `validated_time_1`, `komentar_validasi_1`, `created_by`, `created_at`, `updated_at`, `periode_id`) VALUES
(2, 46, 'validated', 987654994, 987654931, 'validated', '2025-06-22 02:51:04', NULL, 987654931, '2025-06-18 01:01:54', '2025-06-22 02:51:04', 3);

-- --------------------------------------------------------

--
-- Table structure for table `unit_indikator_indikators`
--

CREATE TABLE `unit_indikator_indikators` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `unit_indikator_standar_id` bigint(20) UNSIGNED NOT NULL,
  `indikator_id` bigint(20) UNSIGNED NOT NULL,
  `is_rejected` tinyint(1) NOT NULL DEFAULT 0,
  `komentar` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `unit_indikator_indikators`
--

INSERT INTO `unit_indikator_indikators` (`id`, `unit_indikator_standar_id`, `indikator_id`, `is_rejected`, `komentar`, `created_at`, `updated_at`) VALUES
(2, 2, 2, 0, NULL, '2025-06-18 01:01:54', '2025-06-18 01:01:54'),
(3, 3, 3, 0, NULL, '2025-06-18 01:01:54', '2025-06-18 01:01:54'),
(4, 4, 4, 0, NULL, '2025-06-18 01:01:54', '2025-06-18 01:01:54'),
(5, 5, 5, 0, NULL, '2025-06-18 01:01:54', '2025-06-18 01:01:54'),
(6, 6, 6, 0, NULL, '2025-06-18 01:01:54', '2025-06-18 01:01:54'),
(7, 7, 7, 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(8, 8, 8, 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(9, 9, 9, 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(10, 10, 10, 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(11, 11, 11, 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(12, 12, 12, 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(13, 13, 13, 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(14, 14, 35, 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(15, 15, 14, 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(16, 16, 15, 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(17, 17, 16, 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(18, 18, 17, 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(19, 19, 18, 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(20, 20, 19, 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(21, 21, 20, 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(22, 22, 21, 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(23, 23, 22, 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(24, 24, 23, 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(25, 25, 24, 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(26, 26, 25, 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(27, 27, 26, 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(28, 28, 27, 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(29, 29, 28, 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(30, 30, 36, 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(31, 31, 29, 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(32, 32, 30, 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(33, 33, 31, 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(34, 34, 32, 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(35, 35, 33, 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(36, 36, 34, 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23');

-- --------------------------------------------------------

--
-- Table structure for table `unit_indikator_isi_indikators`
--

CREATE TABLE `unit_indikator_isi_indikators` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `unit_indikator_indikator_id` bigint(20) UNSIGNED NOT NULL,
  `isi_indikator_id` bigint(20) UNSIGNED NOT NULL,
  `pertanyaan` text NOT NULL,
  `target` varchar(255) DEFAULT NULL,
  `bukti` text DEFAULT NULL,
  `is_rejected` tinyint(1) NOT NULL DEFAULT 0,
  `komentar` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `unit_indikator_isi_indikators`
--

INSERT INTO `unit_indikator_isi_indikators` (`id`, `unit_indikator_indikator_id`, `isi_indikator_id`, `pertanyaan`, `target`, `bukti`, `is_rejected`, `komentar`, `created_at`, `updated_at`) VALUES
(2, 2, 2, 'Melihat apakah prodi memiliki pedoman penyusunan CP 2020, melakukan kajian terhadap CP melalui evaluasi kurikulum. ', 'Tersedia', '-', 0, NULL, '2025-06-18 01:01:54', '2025-06-18 01:01:54'),
(3, 2, 3, 'Melihat apakah prodi memiliki dokumen penetapan (berbentuk SK) tentang Standar kompetensi lulusan (Profil Lulusan dan Capaian Pembelajaran Lulusan) di setiap prodi yang berisi sikap, pengetahuan, keterampilan umum dan keterampilan khusus; mengacu pada pembelajaran lulusan KKNI; dan memiliki kesetaraan dengan jenjang kualifikasi pada KKNI.', 'Tersedia', '-', 0, NULL, '2025-06-18 01:01:54', '2025-06-18 01:01:54'),
(4, 2, 4, 'Melihat apakah prodi memiliki dokumen Pedoman magang industry dan PKL.', 'Tersedia', '-', 0, NULL, '2025-06-18 01:01:54', '2025-06-18 01:01:54'),
(5, 2, 5, 'Melihat apakah prodi memiliki dokumen kurikulum yang memuat pengalaman kerja mahasiswa berbentuk pelatihan kerja, kerja praktik, praktik kerja lapangan atau bentuk kegiatan lain yang sejenis, yang dihargai dalam bentuk SKS.', 'Tersedia', '-', 0, NULL, '2025-06-18 01:01:54', '2025-06-18 01:01:54'),
(6, 3, 6, 'Melihat apakah prodi memiliki dokumen pedoman dan prosedur penyusunan kurikulum tahun 2020, serta melakukan kajian pengembangan kurikulum.', 'Tersedia', '-', 0, NULL, '2025-06-18 01:01:54', '2025-06-18 01:01:54'),
(7, 3, 7, 'Melihat apakah dokumen kurikulum berbasis pada  sikap (afektif), penguasaan konsep teoritis bidang pengetahuan (kognitif) dan keterampilan tertentu (psikomotorik) secara umum dan khusus, pada setiap program studi', 'Tersedia', '-', 0, NULL, '2025-06-18 01:01:54', '2025-06-18 01:01:54'),
(8, 3, 8, 'Melihat apakah dokumen kurikulum memiliki kajian tingkat kedalaman dan keluasan materi pembelajaran mengacu pada deskripsi capaian Pembelajaran lulusan dari KKNI, sebagai berikut:\na. lulusan program diploma tiga paling sedikit menguasai konsep teoritis bidang pengetahuan dan keterampilan tertentu secara umum;\nb. lulusan program diploma empat paling sedikit menguasai konsep teoritis bidang pengetahuan dan keterampilan tertentu secara umum dan konsep teoritis bagian khusus dalam bidang pengetahuan dan keterampilan tersebut secara mendalam;\nc. lulusan program magister terapan paling sedikit menguasai teori dan teori aplikasi bidang pengetahuan tertentu; dan\nd. lulusan program doktor terapan paling sedikit menguasai filosofi keilmuan bidang pengetahuan dan keterampilan tertentu', 'Tersedia', '-', 0, NULL, '2025-06-18 01:01:54', '2025-06-18 01:01:54'),
(9, 3, 9, 'Melihat dokumen kurikulum telah memenuhi lebih dari 50% total jumlah jam pembelajaran adalah  praktikum, praktik studio, praktik bengkel, atau praktik lapangan (termasuk KKN)', 'Tersedia', '-', 0, NULL, '2025-06-18 01:01:54', '2025-06-18 01:01:54'),
(10, 3, 10, 'Melihat dokumen peninjauan kurikulum dilaksanakan  setiap tahun dengan melibatkan masukan dari pemangku kepentingan internal dan eksternal, serta dimutahirkan dengan perkembangan keilmuan dan teknologi di bidangnya.', 'Tersedia', '-', 0, NULL, '2025-06-18 01:01:54', '2025-06-18 01:01:54'),
(11, 4, 11, 'Melihat dokumen pedoman PBM polinema 2020', 'Tersedia', 'Pedoman PBM polinema 2020', 0, NULL, '2025-06-18 01:01:54', '2025-06-18 01:01:54'),
(12, 4, 12, 'Melihat dokumen pedoman penyusunan RPS', 'Tersedia', 'Pedoman penyusunan RPS', 0, NULL, '2025-06-18 01:01:54', '2025-06-18 01:01:54'),
(13, 4, 13, 'Melihat dokumen RPS semua mata kuliah', 'Tersedia', '-', 0, NULL, '2025-06-18 01:01:54', '2025-06-18 01:01:54'),
(14, 4, 14, 'Melihat dokumen Peninjauan RPS ', 'Tersedia', 'Form peninjauan RPS', 0, NULL, '2025-06-18 01:01:54', '2025-06-18 01:01:54'),
(15, 4, 15, 'Melihat hasil quisioner Kepuasan PBM oleh mahasiswa', '100%', '-', 0, NULL, '2025-06-18 01:01:54', '2025-06-18 01:01:54'),
(16, 4, 16, 'Melihat hasil quisioner Kepuasan PBM oleh mahasiswa ', '100%', '-', 0, NULL, '2025-06-18 01:01:54', '2025-06-18 01:01:54'),
(17, 4, 17, 'Melihat hasil monev pembelajaran', 'Tersedia', 'Form monev pembelajaran', 0, NULL, '2025-06-18 01:01:54', '2025-06-18 01:01:54'),
(18, 4, 18, 'Melihat dokumen bukti kesesuaian antara materi yang diajarkan dengan RPS minimal 80% pada activity control.', 'Tersedia', 'Form kesesuaian antara materi yang diajarkan dengan RPS minimal 80% pada activity control.', 0, NULL, '2025-06-18 01:01:54', '2025-06-18 01:01:54'),
(19, 5, 23, 'Melihat apakah prodi memiliki dokumen pedoman dan prosedur penilaian hasil belajar 2020', 'Tersedia', '-', 0, NULL, '2025-06-18 01:01:54', '2025-06-18 01:01:54'),
(20, 5, 24, 'Melihat apakah penilaian memiliki dokumen penilaian proses dan hasil belajar dengan komposisi yang sesuai (dapat dilihat dlam kontrak kuliah dan rekap nilai akhir)', 'Tersedia', '-', 0, NULL, '2025-06-18 01:01:54', '2025-06-18 01:01:54'),
(21, 5, 25, 'Melihat form matrik daftar mata kuliah terhadap bentuk penilaian', 'Tersedia', 'form matrik daftar mata kuliah terhadap bentuk penilaian', 0, NULL, '2025-06-18 01:01:54', '2025-06-18 01:01:54'),
(22, 5, 26, 'Melihat ketersediaan kunci jawaban untuk setiap bentuk penilaian / Rubrik penilaian / Portofolio', 'Tersedia', '-', 0, NULL, '2025-06-18 01:01:54', '2025-06-18 01:01:54'),
(23, 5, 27, 'Melihat hasil quisioner Kepuasan PBM oleh mahasiswa ', 'Tersedia', '-', 0, NULL, '2025-06-18 01:01:54', '2025-06-18 01:01:54'),
(24, 5, 28, 'Melihat apakah prodi telah melaksanakan penilaian sesuai dengan RPS / perencanan, hasil penilaian dikembalikan kepada mahasiswa ', 'Tersedia', '-', 0, NULL, '2025-06-18 01:01:54', '2025-06-18 01:01:54'),
(25, 5, 29, 'Melihat apakah penilai proses belajar telah melibatkan:\n- dosen pengampuh\n- Tim dosen pengampuh dengan melibatkan mahasiswa\n- Pemangku kepentingan yang relevan\n- Khusus program doktor terapan wajib menyertakan tim penilai eksternal dari Perguruan Tinggi yang berbeda.', 'Tersedia', '-', 0, NULL, '2025-06-18 01:01:54', '2025-06-18 01:01:54'),
(26, 5, 30, 'Melihat apakah prodi memiliki kontrak kuliah dengan 5 unsur+H39', 'Tersedia', '-', 0, NULL, '2025-06-18 01:01:54', '2025-06-18 01:01:54'),
(27, 5, 31, 'Melihat hasil quisioner Kepuasan PBM oleh mahasiswa ', '100%', '-', 0, NULL, '2025-06-18 01:01:54', '2025-06-18 01:01:54'),
(28, 5, 32, 'Melihat daftar nilai akhir telah sesuai dengan form nilai yang diunggah dalam siakad', 'Tersedia', '-', 0, NULL, '2025-06-18 01:01:54', '2025-06-18 01:01:54'),
(29, 5, 33, 'Melihat berita acara yudisium', 'Tersedia', '-', 0, NULL, '2025-06-18 01:01:54', '2025-06-18 01:01:54'),
(30, 5, 34, 'Melihat dokumen bukti kelulusan yang tersedia yaitu:\na. Ijazah dan Transkrip akademik;\nb. Sertifikat Kompetensi (jika lulus Uji Kompetensi);\nc. Surat keterangan pendamping ijazah. ', 'Tersedia', '-', 0, NULL, '2025-06-18 01:01:54', '2025-06-18 01:01:54'),
(31, 6, 35, 'Melihat apakah prodi memiliki salinan / data dokumen rekrutmen dosen (dapat mengisi form matrik data dosen tetap)', 'Tersedia', 'Form matrik data dosen tetap', 0, NULL, '2025-06-18 01:01:54', '2025-06-18 01:01:54'),
(32, 6, 36, 'Melihat apakah prodi memiliki salinan / data dokumen kualifikasi dosen tetap (dapat mengisi form matrik data kualifikasi dosen tetap)', 'Tersedia', 'Form matrik data kualifikasi dosen tetap', 0, NULL, '2025-06-18 01:01:54', '2025-06-18 01:01:54'),
(33, 6, 37, 'Melihat apakah prodi memiliki salinan / data dokumen kualifikasi dosen tetap (dapat mengisi form matrik data kualifikasi dosen tetap)', 'Tersedia', 'Form matrik data kualifikasi dosen tetap', 0, NULL, '2025-06-18 01:01:54', '2025-06-18 01:01:54'),
(34, 6, 38, 'Melihat apakah prodi memiliki Form daftar EWMP terhadap dosen tetap, serta nilai EWMP antara 12 sampai 16 SKS persemester', 'Tersedia', 'Form daftar EWMP terhadap dosen tetap', 0, NULL, '2025-06-18 01:01:54', '2025-06-18 01:01:54'),
(35, 6, 39, 'Melihat apakah rasio dosen terhadap jumlah mahasiswa aktif pada saat monev dan audit berjalan, serta terpenuhi untuk kriteria rasio', 'Tersedia', 'Form rasio dosen mahasiswa', 0, NULL, '2025-06-18 01:01:54', '2025-06-18 01:01:54'),
(36, 6, 40, 'Melihat apakah rasio jumlah dosen tetap terhadap seluruh dosen pengajar (Tetap + tidak tetap) lebih besar 90%', 'Tersedia', 'Form daftar dosen prodi', 0, NULL, '2025-06-18 01:01:54', '2025-06-18 01:01:54'),
(37, 6, 41, 'Melihat apakah prodi memiliki jumlah dosen berkualifikasi S3 sesuai kriteria / standar', 'Tersedia', 'Form daftar dosen prodi', 0, NULL, '2025-06-18 01:01:54', '2025-06-18 01:01:54'),
(38, 6, 42, 'Melihat apakah prodi memiliki jumlah dosen dengan jabatan fungsional lektor kepala sesuai dengan kriteria dan standar', 'Tersedia', 'Form daftar dosen prodi', 0, NULL, '2025-06-18 01:01:54', '2025-06-18 01:01:54'),
(39, 6, 43, 'Melihat apakah prodi memiliki jumlah dosen minimal 5 orang', 'Tersedia', 'Form daftar dosen prodi', 0, NULL, '2025-06-18 01:01:54', '2025-06-18 01:01:54'),
(40, 6, 44, 'Melihat apakah prodi memiliki daftar tendik dan admin dengan kualifikasi dan kriteria / standar', 'Tersedia', 'Form daftar tendik dan admin', 0, NULL, '2025-06-18 01:01:54', '2025-06-18 01:01:54'),
(41, 6, 45, 'Melihat apakah prodi memiliki daftar tendik Tenaga kependidikan / Laboran / Teknisi memiliki sertifikat kompetensi sesuai dengan bidang tugas dan keahliannya (bukti sertifikat kompetensi, sertifikat pelatihan).', 'Tersedia', 'Form daftar tendik dan admin', 0, NULL, '2025-06-18 01:01:54', '2025-06-18 01:01:54'),
(42, 7, 46, 'Melihat apakah prodi memiliki daftar ruangan yang digunakan, memenuhi kriteria dan standar', 'Tersedia', 'Form daftar ruangan dan fasilitas pembelajaran', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(43, 7, 47, 'Melihat apakah prodi memiliki daftar ruangan yang digunakan, memenuhi kriteria dan standar', 'Tersedia', 'Form daftar ruangan dan fasilitas pembelajaran', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(44, 7, 48, 'Melihat apakah prodi memiliki daftar ruangan yang digunakan, memenuhi kriteria dan standar', 'Tersedia', 'Form daftar ruangan dan fasilitas pembelajaran', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(45, 7, 49, 'Melihat apakah prodi memiliki daftar ruangan yang digunakan, memenuhi kriteria dan standar', 'Tersedia', 'Form daftar ruangan dan fasilitas pembelajaran', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(46, 7, 50, 'Melihat apakah prodi memiliki daftar ruangan yang digunakan, memenuhi kriteria dan standar', 'Tersedia', 'Form daftar ruangan dan fasilitas pembelajaran', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(47, 7, 51, 'Melihat apakah prodi memiliki daftar ruangan yang digunakan, memenuhi kriteria dan standar', 'Tersedia', 'Form daftar ruangan dan fasilitas pembelajaran', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(48, 7, 52, 'Melihat apakah prodi memiliki daftar ruangan yang digunakan, memenuhi kriteria dan standar', 'Tersedia', 'Form daftar ruangan dan fasilitas pembelajaran', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(49, 7, 53, 'Melihat apakah prodi memiliki dokumen Tersedianya peralatan laboratorium dan bahan habis dengan jumlah yang memadai dan bermutu baik.', 'Tersedia', 'Form daftar ruangan dan fasilitas pembelajaran', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(50, 7, 54, 'Melihat apakah prodi memiliki dokumen Tersedia sarana belajar yang mencukupi (kursi, meja, papan tulis, spidol, penghapus, LCD, dekstop/ laptop, AC/kipas angin, sound system, dan internet/Wifi), serta dapat digunakan setiap hari (minimal 20 jam/ minggu).', 'Tersedia', 'Form daftar ruangan dan fasilitas pembelajaran', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(51, 7, 55, 'Melihat apakah prodi memiliki perpustakaan / ruang baca dengan akses dan kriteria sesuai standar', 'Tersedia', '-', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(52, 7, 56, 'Melihat apakah prodi memiliki daftar akses internet sesuai dengan kriteria dan standar dari UPA TIK', 'Tersedia', '-', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(53, 8, 57, 'Melihat apakah prodi memiliki dokumen rencana kerja (operasional) terkait pembelajaran yang dapat diakses oleh sivitas akademika dan pemangku kepentingan, serta dapat dijadikan pedoman bagi Program studi dalam melaksanakan program pembelajaran', 'Tersedia', '-', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(54, 8, 58, 'Melihat apakah prodi memiliki  panduan perencanaan, pelaksanaan, evaluasi, pengawasan, penjaminan mutu, dan pengembangan kegiatan pembelajaran dan dosen', 'Tersedia', '-', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(55, 8, 59, 'Melihat apakah prodi memiliki dokumen kurikulum', 'Tersedia', '-', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(56, 8, 60, 'Melihat apakah prodi memiliki panduan RPS', 'Tersedia', '-', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(57, 8, 61, 'Melihat apakah prodi memliki RPS sesuai pedoman untuk semua mata kuliah', 'Tersedia', '-', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(58, 8, 62, 'Melihat apakah prodi memiliki okumen penyelenggaraan program pembelajaran (activity control, nilai mahasiswa, presensi mahasiswa dan dosen,presensi tenaga kependidikan, kontrak kuliah, rps, soal ujian, buku ajar/modul ajar, modul praktik/praktikum, berita acara yudisium, laporan panitia tugas akhir, dll)', 'Tersedia', 'form daftar dokumen penyelenggaraan PBM', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(59, 8, 63, 'Melihat apakah prodi memiliki dokumen / berita acara kegiatan sistemik dalam rangka menciptakan suasana akademik dan budaya mutu yang baik (orasi ilmiah, kuliah tamu, seminar, dll).', 'Tersedia', '-', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(60, 8, 64, 'Melihat apakah prodi memiliki  pemantauan dan evaluasi (hasil audit, hasil pengukuran kepuasan mahasiswa) secara periodik terhadap Program Studi dalam melaksanakan kegiatan Pembelajaran dalam rangka menjaga dan meningkatkan mutu proses pembelajaran.\n(dokumen tindak lanjut hasil monev dan audit  yang dilaksanakan secara internal prodo/jurusan)', 'Tersedia', '-', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(61, 8, 65, 'Melihat apakah prodi memiliki dokumen RTM', 'Tersedia', '-', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(62, 8, 66, 'Melihat apakah prodi memiliki dokumen laporan kinerja program studi dalam menyelenggarakan program pembelajaran pada pangkalan data pendidikan tinggi.', 'Tersedia', 'Perlu koordinasi dengan bidang akademik terkait pelaporan ', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(63, 9, 67, 'Melihat apakah prodi memiliki analisis DOP sesuai kriteria', 'Tersedia', '-', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(64, 9, 68, 'Melihat apakah prodi/jurusan memiliki pendapatan lain  (diluar biaya pendidikan yang diperoleh dari mahasiswa (UKT)), seperti hibah, jasa layanan profesi dan/atau keahlian, dana lestari dari alumni dan filantropis, dan/atau kerja sama kelembagaan pemerintah dan swasta, sebesar 10% dari total pemasukan.', 'Tersedia', '-', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(65, 10, 69, 'Melihat apakah prodi memiliki dokumen Rasio Dosen Tetap terhadap Jumlah publikasi ilmiah hasil penelitian dalam bentuk jurnal lokal ber-ISSN.', 'Tersedia', '-', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(66, 10, 70, 'Melihat apakah prodi memiliki data Rasio dosen tetap terhadap jumlah publikasi ilmiah hasil penelitian dalam bentuk jurnal ilmiah Nasional terakreditasi', 'Tersedia', 'Form publikasi ilmiah hasil penelitian dosen tetap', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(67, 10, 71, 'Melihat apakah proodi memiliki data rasio Rasio Dosen tetap terhadap Publikasi ilmiah hasil penelitian dalam bentuk\njurnal ilmiah Internasional', 'Tersedia', 'Form data rasio Rasio Dosen tetap terhadap Publikasi ilmiah hasil penelitian dalam bentuk jurnal ilmiah Internasional', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(68, 10, 72, 'Melihat apakah prodi memiliki data Jumlah publikasi artikel ilmiah terindex per Dosen setiap tahun meningkat', 'Tersedia', 'Form publikasi artikel terindex', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(69, 10, 73, 'Melihat apakah prodi memiliki data Jumlah sitasi artikel ilmiah per Dosen setiap tahun meningkat', 'Tersedia', 'form publikasi dan tersitasi', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(70, 10, 74, 'Melihat apakah prodi memiliki data Jumlah produk inovasi dosen setiap tahun meningkat.', 'Tersedia', 'Form produk inovasi', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(71, 10, 75, 'Melihat apakah prodi memiliki data publikasi ilmiah hasil penelitian dalam bentuk prosiding seminar/konferensi Nasional ber-ISSN', '', '', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(72, 10, 76, 'Melihat apakah prodi memiliki data publikasi ilmiah hasil penelitian dalam bentuk prosiding seminar/ konferensi internasional berindeks', 'Tersedia', 'Form data publikasi ilmiah hasil penelitian hasil penelitian dalam bentuk prosiding seminar/ konferensi internasional berindeks', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(73, 10, 77, 'Melihat apakah prodi memiliki data buku ajar/text book dan memastikan peningkatannya setiap tahun', 'Tersedia', '-', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(74, 10, 78, 'Melihat apakah prodi memeiliki data Jumlah Kekayaan Intelektual (paten dan hak cipta)) yang diregistrasi setiap tahun bertambah.', 'Tersedia', 'Form Kekayaan Intelektual (paten dan hak cipta)', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(75, 10, 79, 'Melihat apakah prodi memiliki data Jumlah mahasiswa yang terlibat dalam penelitian bertambah', 'Tersedia', 'Form keterlibatan penelitian mahasiswa', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(76, 10, 80, 'Melihat apakah prodi memiliki data Jumlah Prototipe/model/kebijakan/model setiap tahun bertambah', 'Tersedia', 'form Jumlah Prototipe/model/kebijakan/model ', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(77, 11, 81, 'Melihat apakah prodi memiliki Rencana Induk Penelitian (RIP) POLINEMA', 'Tersedia', '-', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(78, 11, 82, 'Melihat apakah memiliki road map penelitian ', 'Tersedia', '-', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(79, 12, 83, 'Melihat apakah .prodi menyampaikan informasi rencana kegiatan penelitian (pengumuan jadwal penelitian oleh P2M)', 'Tersedia', '-', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(80, 12, 84, 'Melihat apakah prodi memiliki daftar proposal penelitian DTPS', 'Tersedia', '-', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(81, 13, 85, 'Melihat apakah prodi memiliki dokumen hasil penilaian usulan penelitian DTPS', 'Tersedia', '-', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(82, 13, 86, 'Melihat apakah prodi memiliki dokumen legalitas penugasan peneliti/kerjasama peneliti,', 'Tersedia', '-', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(83, 13, 87, 'Melihat apakah prodi memiliki Dokumen dokumentasi output penelitian', 'Tersedia', '-', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(84, 14, 139, 'Audit untuk P3M', '', '', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(85, 14, 140, 'Melihat apakah prodi memiliki dokumen Kesesuaian bidang keilmuan peneliti dengan tema penelitian.', 'Tersedia', '-', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(86, 14, 141, 'Melihat apakah prodi memiliki data jumlah rekam jejak penelitian yang diperoleh peneliti, berskala nasional (SINTA) , dan atau berskala internasional.', 'Tersedia', '-', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(87, 15, 88, 'Melihat apakah prodi memiliki ruangan penyimpanan arsip penelitian', 'Tersedia', '-', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(88, 15, 89, 'Melihat apakah prodi memiliki daftar data ketersediaan ruang penelitian terkait dengan bidang ilmu program studi', 'Tersedia', 'Form daftar kebutuhan Lab/bengkel untuk penelitian', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(89, 16, 90, 'Melihat apakah prodi memiliki dokumen laporan kegiatan penelitian yang memenuhi 5 aspek (komprehensif, rinci, relevan, mutakhir, dan tepat waktu)', 'Tersedia', '-', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(90, 17, 91, 'Melihat apakah prodi memiliki dokumen rencana dana penelitian dosen/tahun serta jumlah dana penelitan > 10jt/dosen/tahun', 'Tersedia', '-', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(91, 18, 92, 'Melihat apakah prodi memiliki daftar PKM DTPS tiap tahun', 'Tersedia', '-', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(92, 18, 93, 'Melihat apakah prodi memiliki daftar mahasiswa yang terlibat PKM tiap tahun dan mengalami peningkatan jumlah PKM', 'Tersedia', '-', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(93, 18, 94, 'Melihat apakah prodi memiliki daftar mahasiswa yang terlibat PKM tiap tahun dan mengalami peningkatan jumlah Mahasiswa', 'Tersedia', '-', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(94, 18, 95, 'Melihat apakah program studi memiliki publikasi hasil PkM oleh dosen yang melibatkan mahasiswa Polinema secara nasional meningkat.', 'Tersedia', '-', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(95, 18, 96, 'Melihat apakah program studi memiliki Publikasi hasil PkM oleh dosen yang melibatkan mahasiswa Polinema secara internasional meningkat.', 'Tersedia', '-', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(96, 18, 97, 'Melihat apakah prodi memiliki Jumlah tindaklanjut hilirisasi hasil PkM di masyarakat meningkat', 'Tersedia', '-', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(97, 18, 98, 'Melihat apakah prodi memiliki Jumlah tindaklanjut pengembangan keilmuan program studi dari hasil PkM meningkat', 'Tersedia', '-', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(98, 18, 99, 'Melihat apakah prodi memiliki Jumlah kegiatan PkM oleh Mahasiswa yang direkognisi oleh Institusi/Program studi menigkat', 'Tersedia', '-', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(99, 19, 100, 'Melihat apakah prodi memiliki daftar kegiatan kegiatan PkM yang bersumber dari hasil Penelitian.', 'Tersedia', '-', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(100, 20, 101, 'Melihat apakah prodi memiliki data kesesuai pelaksanaan PKM terhadap roadmap oleh dosen tetap', 'Tersedia', 'Form kesesuaian PKM terhadap roadmap oleh dosen tetap', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(101, 21, 102, 'Melihat apakah prodi memiliki dokumen Luaran berupa publikasi, makalah, HAKI, produk, mitra berbadan hukum, buku, atau luaran iptek lainnya meningkat', 'Tersedia', '-', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(102, 22, 103, 'Melihat apakah prodi memiliki dokumen  surat ijin dan rekomendasi mengikuti kegiatan PkM dari Ketua Program Studi.', 'Tersedia', '-', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(103, 23, 104, 'Melihat apakah prodi memiliki dokumen sarana pendukung PKM oleh dosen tetap memadai di jurusan maupun prodi (penggunaan sarana di prodi untuk PKM)', 'Tersedia', '-', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(104, 24, 105, 'Melihat apakah prodi memiliki data mahasiswa yang terlibat dalam PKM dosen tetap', 'Tersedia', '-', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(105, 25, 106, 'Melihat apakah prodi memiliki rasio dana PKM sebesar >7 juta/dosen/tahun', 'Tersedia', '-', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(106, 25, 107, 'Melihat apakah prodi memiliki dokumen Prosentase dana kegiatan PkM yang bersumber dari pemerintah', 'Tersedia', '-', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(107, 25, 108, 'Melihat apakah prodi memiliki dokumen Prosentase dana kegiatan PkM yang bersumber dari kerja sama dengan lembaga lain', 'Tersedia', '-', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(108, 26, 109, 'Melihat apakah prodi memiliki daftar buku referensi yang digunakan dalam pembelajaran (RPS) telah tersedia 100%', 'Tersedia', '-', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(109, 27, 110, 'Melihat apakah prodi memiliki data rasio jumlah calon mahasiswa yang ikut seleksi/pendaftar terhadap jumlah calon mahasiswa yang lulus seleksi.', 'Tersedia', '', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(110, 27, 111, 'Melihat apakah prodi memiliki data Rasio jumlah mahasiswa yang mendaftar ulang terhadap jumlah mahasiswa yang lulus seleksi sesuai standar / kriteria', 'Tersedia', '', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(111, 27, 112, 'Melihat apakah prodi memiliki data  Rasio jumlah mahasiswa baru transfer terhadap jumlah mahasiswa baru bukan transfer.sesuai standar / kriteria', 'Tersedia', '', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(112, 27, 113, 'Melihat apakah prodi memiliki data Rasio jumlah mahasiswa asing terhadap seluruh jumlah mahasiswa aktif.', 'Tersedia', '', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(113, 27, 114, 'Melihat bukti apakah prodi menerapkan minimal 3 uji sesuai standar dan kriteria', 'Tersedia', '', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(114, 27, 115, 'Melihat apakah prodi memiliki keketatan seleksi sesuai standar / kriteria', 'Tersedia', '', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(115, 28, 116, 'Melihat apakah prodi memiliki layanan ( bimbingan akademik, bimbingan karir, dan konseling untuk mendukung kelancaran studi mahasiswa)', 'TErsedia', '', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(116, 28, 117, 'Melihat apakah prodi memiliki data Keikutsertaan mahasiswa dalam kegiatan kemahahasiswaan dalam tingkat lokal regional nasional internasional lihat', 'Tersedia', '', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(117, 28, 118, 'Melihat apakah prodi memiliki data prestasi mahasiswa', 'Tersedia', '', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(118, 29, 119, 'Melihat apakah program studi memanfaatkan data tracer dan data keterkaitan hasil tracer dengan evaluasi kurikulum', 'Tersdia', '', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(119, 30, 142, 'Apakah prodi memiliki visi keilmuan dan sudah ditetapkan sesuai kriteria / standar', 'Tersedia', '', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(120, 30, 143, 'Melihat apakah prodi memiliki dokumen kesesuaian Visi, Misi, Tujuan dan Strategi (VMTS) Unit Pengelola Program Studi (UPPS) terhadap VMTS Perguruan Tinggi (PT) dan visi keilmuan Program Studi (PS) yang dikelolanya.', 'Tersedia', '', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(121, 31, 120, 'Melihat apakah prodi memiliki dokumen Industrial advisory board', 'Tersedia', '', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(122, 31, 121, 'Melihat apakah prodi memiliki dokumen pelampauan SN DIKTI yang ditetapkan institusi', 'Tersedia', '', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(123, 32, 122, 'Melihat apakah prodi menyelenggarakan program alih jenjang dengan kriteria IPK sesuai standar', 'Tersedia', 'Form data mahasiswa alih jenjang', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(124, 32, 123, 'Melihat apakah prodi menyelenggarakan program alih jenjang dengan kriteria lulusan sesuai standar', 'Tersedia', 'Form data mahasiswa alih jenjang', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(125, 32, 124, 'Melihat apakah prodi menyelenggarakan program alih jenjang dengan kriteria bidang ilmu sesuai standar', 'Tersedia', 'Form data mahasiswa alih jenjang', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(126, 32, 125, 'Melihat apakah prodi menyelenggarakan program alih jenjang dengan kriteria seleksi buta warna (untuk jurusan rekayasa) sesuai standar', 'Tersedia', 'Form data mahasiswa alih jenjang', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(127, 32, 126, 'Melihat apakah prodi menyelenggarakan program alih jenjang dengan kriteria nilai tes sesuai standar', 'Tersedia', 'Form data mahasiswa alih jenjang', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(128, 33, 127, 'Melihat apakah prodi memiliki mahaisiswa RPL dengan syarat IPK sesuai standar', 'Tersedia', '', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(129, 33, 128, 'Melihat apakah prodi memiliki mahaisiswa RPL dengan syarat Lulusan calon pendaftar tidak lebih dari 2 tahun', 'Tersedia', '', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(130, 33, 129, 'Melihat apakah prodi memiliki mahaisiswa RPL dengan syarat Hasil evaluasi alih kredit minimal 80% dari total SKS', 'Tersedia', '', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(131, 33, 130, 'Melihat apakah prodi memiliki mahaisiswa RPL dengan syarat Calon pendaftar dari program studi terakreditasi minimal B', 'Tersedia', '', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(132, 34, 131, 'Melihat apakah prodi memiliki data nilai TOEIC lulusan D3 Polinema yang memperoleh nilai TOEIC minimal 400 dalam sekali tes.', 'Tersedia', '', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(133, 34, 132, 'Melihat apakah prodi memiliki data nilai TOEIC  lulusan Sarjana Terapan (D4) Polinema yang memperoleh nilai\nTOEIC minimal 450 dalam sekali tes.', 'Tersedia', '', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(134, 34, 133, 'Melihat apakah prodi memiliki data nilai TOEIC  lulusan S2 Terapan Polinema yang memperoleh nilai TOEIC\nminimal 500 dalam sekali tes.', 'Tersedia', '', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(135, 35, 134, 'Apakah prodi memiliki data laptop dosen dan status nya', 'Tersedia', '', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(136, 35, 135, 'Melihat apakah prodi memiliki data pengelola e-learnng', 'Tersedia', '', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(137, 35, 136, 'Melihat apkah prodi memiliki data dosen yang menggunakan e-learning', 'Tersedia', '', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(138, 36, 137, 'Melihat apakah prodi memiliki dokumen Peningkatan Jumlah Mahasiswa yang mendapat Sertifikat Kompetensi\nKerja yang diakui secara Nasional/Internasional.', 'Tersedia', '', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(139, 36, 138, 'Melihat apakah prodi memiliki dokumen Peningkatan jumlah mahasiswa yang mendapat sertifikat kompetensi kerja internasional', 'Tersedia', '', 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23');

-- --------------------------------------------------------

--
-- Table structure for table `unit_indikator_standars`
--

CREATE TABLE `unit_indikator_standars` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `unit_indikator_id` bigint(20) UNSIGNED NOT NULL,
  `standar_id` bigint(20) UNSIGNED NOT NULL,
  `is_rejected` tinyint(1) NOT NULL DEFAULT 0,
  `komentar` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `unit_indikator_standars`
--

INSERT INTO `unit_indikator_standars` (`id`, `unit_indikator_id`, `standar_id`, `is_rejected`, `komentar`, `created_at`, `updated_at`) VALUES
(2, 2, 2, 0, NULL, '2025-06-18 01:01:54', '2025-06-18 01:01:54'),
(3, 2, 3, 0, NULL, '2025-06-18 01:01:54', '2025-06-18 01:01:54'),
(4, 2, 4, 0, NULL, '2025-06-18 01:01:54', '2025-06-18 01:01:54'),
(5, 2, 5, 0, NULL, '2025-06-18 01:01:54', '2025-06-18 01:01:54'),
(6, 2, 6, 0, NULL, '2025-06-18 01:01:54', '2025-06-18 01:01:54'),
(7, 2, 7, 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(8, 2, 8, 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(9, 2, 9, 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(10, 2, 10, 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(11, 2, 987654931, 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(12, 2, 12, 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(13, 2, 13, 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(14, 2, 14, 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(15, 2, 15, 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(16, 2, 16, 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(17, 2, 17, 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(18, 2, 18, 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(19, 2, 19, 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(20, 2, 20, 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(21, 2, 21, 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(22, 2, 22, 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(23, 2, 23, 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(24, 2, 24, 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(25, 2, 25, 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(26, 2, 26, 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(27, 2, 27, 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(28, 2, 28, 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(29, 2, 29, 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(30, 2, 30, 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(31, 2, 31, 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(32, 2, 32, 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(33, 2, 33, 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(34, 2, 34, 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(35, 2, 35, 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23'),
(36, 2, 36, 0, NULL, '2025-06-22 02:50:23', '2025-06-22 02:50:23');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nip` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `unit_id` bigint(20) UNSIGNED DEFAULT NULL,
  `avatar_url` varchar(255) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_by` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `nip`, `name`, `email`, `unit_id`, `avatar_url`, `password`, `remember_token`, `created_by`, `created_at`, `updated_at`) VALUES
(11, '001', 'Test User', 'test@example.com', 1, NULL, '$2y$12$U4T3eDyNn4BtUCmTeHQdZ.dpS/kRDCb4ruJwCtpOYPNimrCqrrqSq', 'aljfujUuRz6QVgHwS5NfSjPUElWYfjUoGPi388yissw2il9aJPILDVFjQuTn', NULL, '2025-06-11 13:45:41', '2025-06-11 13:51:24'),
(987654931, '00000001', 'Super Admin', 'admin@example.com', NULL, NULL, '$2y$12$mqZfXIAd0vVjcCojEreAyObyJCS2ODm6TM0.wzaHz.FbVUQR5eONm', 'ZFARxOSH3aU5mhX6uoqaOGnLDfELHzrwpz0JAqyNYm0lJIkhJrsYRMAJAT3d', NULL, '2025-06-16 10:29:47', '2025-06-16 10:29:47'),
(987654932, '00000002', 'P2MPP Staff', 'p2mpp@example.com', 62, NULL, '$2y$12$oBJWgH4wE.LYo0s6zrcThO7yKt2gDS9YIbZ.XZ9I0BmdDYhvN/qC6', NULL, NULL, '2025-06-16 10:29:47', '2025-06-16 10:29:47'),
(987654933, '10000001', 'Pimpinan c', 'pimpinan1@example.com', 1, NULL, '$2y$12$RhoplJTgCrQQHWvyquLkCexn2uo/4eZA/LgEySJ9.wWW3vGUBMdxW', '7eV3MTbZxSiLXtCPRdR4NHhDz9a6OSZ4iEKEro4NbEsFqN5HjoZ9HRJRZIV8', NULL, '2025-06-16 10:29:47', '2025-06-16 10:29:47'),
(987654935, '10000002', 'Pimpinan D3 Administrasi Bisnis', 'pimpinan2@example.com', 2, NULL, '$2y$12$35N9PU99UvlupsKpld1XEeUvjLYh0503e1lFRzsyOFAs0eCAa.c92', 'BUztMRGvBLHltnOFkfTqatLdWREqxHhHW75quc1sWaYDQjkNn09s3XVPKDqy', NULL, '2025-06-16 10:29:47', '2025-06-16 10:29:47'),
(987654936, '30000002', 'Auditee D3 Administrasi Bisnis', 'auditee2@example.com', 2, NULL, '$2y$12$qbQ8uyrp/i0tDWkzgnacweA9Ez/WPVlsikgdINmvzZ7mEOr6ZGm/a', '6YV8V43p3AOTa4WF99lShYXsXNjEL5eay2yP1aDxNQeFKZyOx2rCydLOyJq8', NULL, '2025-06-16 10:29:48', '2025-06-16 10:29:48'),
(987654937, '10000003', 'Pimpinan D4 Bahasa Inggris Untuk Industri Pariwisata', 'pimpinan3@example.com', 3, NULL, '$2y$12$ILtVsnWoz.XLI5JaeNcgTeoXX4CeCLArk0NGzPcM3oWmyyZ69jcXy', 'fGcS3p6LkdyyX2EeCXsX9yGcepA3jKW50bdxDjp41SAHjdckUNLZ8O05Ghuw', NULL, '2025-06-16 10:29:48', '2025-06-16 10:29:48'),
(987654938, '30000003', 'Auditee D4 Bahasa Inggris Untuk Industri Pariwisata', 'auditee3@example.com', 3, NULL, '$2y$12$Og7kZ9MGPTnVBL1dn2ZzgeIbC1h0c7ino1uMjeNFxSkyq1GAUNXDa', 'ASufCPbCXjeYGGMchiFgW1W1MWYryFeylDZ8Ng8inrtOfMOfPlPRlRUqi72b', NULL, '2025-06-16 10:29:48', '2025-06-16 10:29:48'),
(987654939, '10000004', 'Pimpinan D4 Bahasa Inggris Untuk Komunikasi Bisnis Dan Profesional', 'pimpinan4@example.com', 4, NULL, '$2y$12$2I1Pc3y/a.aQutaYhnAtseb8IFrgbImz7KHu16dfGCOKmqmaO.D.O', '5yo7Pizs572as3ADAvT0tqunM8wutuI03ItVALf7eE1iwGvFJfO1yXWURLEz', NULL, '2025-06-16 10:29:48', '2025-06-16 10:29:48'),
(987654940, '30000004', 'Auditee D4 Bahasa Inggris Untuk Komunikasi Bisnis Dan Profesional', 'auditee4@example.com', 4, NULL, '$2y$12$k14AXiRjbXbSKMH1dyRqiue1twjVy/d8YTNu/LmhPg6F1MC9c/5U2', NULL, NULL, '2025-06-16 10:29:48', '2025-06-16 10:29:48'),
(987654941, '10000005', 'Pimpinan D4 Manajemen Pemasaran', 'pimpinan5@example.com', 5, NULL, '$2y$12$PIU1dZYAkue9Ea.3Jn7IYOzYk1Kxr/N27ELRSxZREfwSp1e9Xrbb2', NULL, NULL, '2025-06-16 10:29:49', '2025-06-16 10:29:49'),
(987654942, '30000005', 'Auditee D4 Manajemen Pemasaran', 'auditee5@example.com', 5, NULL, '$2y$12$7ZMhy02B1RFAQYNPr64u4uabiJb9lFJzOEzlC23gkfmveYQUZZ.1y', NULL, NULL, '2025-06-16 10:29:49', '2025-06-16 10:29:49'),
(987654943, '00000003', 'Rachma Bhakti Utami S.E., M.AB', 'jagaraga31@example.org', 8, NULL, '$2y$12$u1uG58w7igWEDZBGJQX92uU2NNzXM8gS9Y5svD2nq4n4yMLxKvHOq', 'VO7kWABxgehgIkH8aNUePrR4JK0sJKI07tbXr71AAFgDQh4GssY7SidRrHcm', NULL, '2025-06-16 10:29:51', '2025-06-16 10:29:51'),
(987654944, '00000004', 'Dr., Drs., Mohammad Maskan, M.SI.', 'padmi.maheswara@example.com', 8, NULL, '$2y$12$lVpde139TRUxixmzT4M8m.UW/6.qsuTXCHr82lE5rGjpcqMkEXyVi', 'u5Uvj7KBqAtZ71PdruoQQpA3REwjB9HAJ580tNmuJ2xqasaVNnHLYdme9hXB', NULL, '2025-06-16 10:29:51', '2025-06-16 10:29:51'),
(987654945, '00000005', 'Tiara Estu Amanda, S.S., M.Par.', 'carla.setiawan@example.org', 8, NULL, '$2y$12$xyFM6OuUarIZoqc4A3ABw.5Ijw7ySL7HhJmPVwNn8YHNdoDJKv71C', 'eufDxtmgcsXxBt7wBVYGBtGAhytRfJ8kv5BmaZtLbLnNcJYDVA9wLTUtonCx', NULL, '2025-06-16 10:29:51', '2025-06-16 10:29:51'),
(987654946, '00000006', 'Dra. Eni Widyowati M.Pd.', 'puji77@example.net', 8, NULL, '$2y$12$3xL4oRbRYloP0w4otelgz.REkJIdeT63qzTofSZO/tHWBaKrP.JIm', '22FBIU5XUmE2pvCKT7dr4wWBsnbCIii7ab2a5M87hBFHe40r8jpthUbgns3R', NULL, '2025-06-16 10:29:51', '2025-06-16 10:29:51'),
(987654947, '00000007', 'Dr. Drs. Sumiadji, Ak., M.SA.', 'purnawati.nurul@example.org', 13, NULL, '$2y$12$QaJI3Rurc3eaJ6zbI/DvW.PBoaQi5eeT2XQ7dj5AyyEQcxEvpR0/m', 'ZRNvY70IuFX3c0ogi35j0cH6dQ5d5iDuI86vOH35tSAlXtNmRObYwEOki8T5', NULL, '2025-06-16 10:29:51', '2025-06-16 10:29:51'),
(987654948, '00000008', 'Muhammad Kholisul Imam S.E., M.E', 'usyi.rahimah@example.org', 13, NULL, '$2y$12$yHJ8r8lD9zidr8c1qTHG6eD3dk8zOoZiUOKISHuVxqRfk/xT1QPG2', 'ROaAAtE8VBk3yMC3s0qI4va0oS5eSIJDQGe0HyRPJ7Ml2aZMUofsWRBqO3rH', NULL, '2025-06-16 10:29:52', '2025-06-16 10:29:52'),
(987654949, '00000009', 'Padma adriana sari, SE., MSA., Ak.', 'gunawan.icha@example.com', 13, NULL, '$2y$12$TDjsOihFTGh3QYsEULb/e.RR.myS9u/kIqapynqFLZlPjXnhI0IS2', 'FGUKjvMGTcMRDkvKoh3Av5GGfT3BGCYU3jN661yOXGPzgxwG2UzW9VTcEdpg', NULL, '2025-06-16 10:29:52', '2025-06-16 10:29:52'),
(987654950, '00000010', 'Rika Wijayanti, S.Pd. M.Ak.', 'fusada@example.org', 13, NULL, '$2y$12$rA4RvLuM046UoC3Qtb0V6O9ohAbMZ71pBAitWBoet8.J.yrb78noS', 'f9YjpDn7JR20YH1IPjQYIBvtq2eH4dDkKDAlei4uQKD18vWzfNujuzejjZ7V', NULL, '2025-06-16 10:29:52', '2025-06-16 10:29:52'),
(987654951, '00000011', 'Ikhsan Setiawan S.Pd.I., M.Pd.', 'zmangunsong@example.org', 21, NULL, '$2y$12$AZ5KZYzvNDFwnkYSPKtHVOwhHL5xtUn6DoFDbmwa8hd5NYkVwdcH2', 'KvOf5mJMmEKTDOZX8F2eLSwo2Dx7V4jnpcfh9teOEaLFmtTPq0WDoS8qoWsf', NULL, '2025-06-16 10:29:52', '2025-06-16 10:29:52'),
(987654952, '00000012', 'Drs. Bambang Budiprayitno., AK., M.SI.', 'lasmanto71@example.com', 13, NULL, '$2y$12$7Qi5VOfATj6sL.OHhzL38e1F78Eea5BP6QkDk5BwqxyFvdod5B/4y', 'sHnGVVhW2mNRN6QTrWUd7i7Lu4xgAmZKDxmS2q8CKreBKNiIv40umRbVEVJZ', NULL, '2025-06-16 10:29:52', '2025-06-16 10:29:52'),
(987654953, '00000013', 'Dr. Drs. Ludfi Djajanto, MBA', 'hasan.hutapea@example.org', 13, NULL, '$2y$12$vu6vxNKvDFJBpLXZlx5lqOIdBwSWiCWfcBkOJcPx5NKnz3N/PBRZS', 'COQ36sBB6xmiTfoEtNmFzeut2RV3ELH8siUo5ScYf7jaAblG7pwxdvmPprqY', NULL, '2025-06-16 10:29:53', '2025-06-16 10:29:53'),
(987654954, '00000014', 'Aditya Arisudhana S.E., Akt., M.Acc., CPA', 'gyuniar@example.net', 13, NULL, '$2y$12$5HCe8TR9agwXoVcYMFhH6eoy8rpGE3Qm6FcSCiZayss1yTB3drrYi', 'asiD5YbOP8eQsffoLIxGcvdf3whgJnk7N2UoeCmZHpp7VZZxDoEdJoCmDGmy', NULL, '2025-06-16 10:29:53', '2025-06-16 10:29:53'),
(987654955, '00000015', 'Elvyra Handayani Soedarso, S.E., M.SA.', 'qhasanah@example.org', 13, NULL, '$2y$12$UcJW1cEBpxrssdi1Jsi9AeRndyDL9oAgbwN2ZWrFDTc/n9642h88u', 'AycZPlyMABoPPtKq05yman9DkRARoYKCbslgy6Q3CndM868DcoPWKZd7mhAf', NULL, '2025-06-16 10:29:53', '2025-06-16 10:29:53'),
(987654956, '00000016', 'Ir. Mohammad Luqman, MS.', 'mahendra.tiara@example.com', 21, NULL, '$2y$12$YW8n3mW/8Sf7r9K56zmUNurXYVUVfVhCJ3A.HTEZhVfbdrxHkUrzu', 'hS6RIop7plq1FQ67EPH6VejnpIRyKbGmvmQGvI6mKlDJZzUHZURbcmBPfQmJ', NULL, '2025-06-16 10:29:53', '2025-06-16 10:29:53'),
(987654957, '00000017', 'Ir. Waluyo, MT', 'xyolanda@example.net', 21, NULL, '$2y$12$jvhUaqja/y9HqvZB1mdpseFT6D/XauLOhAMgvj/rKwLTCHehONyMS', 'JNnhQlGKTDFSsyeRW6kuo86oYuFVT5paWMpnwxPLJkvdu1wfKQXrv1Qzx5Hi', NULL, '2025-06-16 10:29:53', '2025-06-16 10:29:53'),
(987654958, '00000018', 'Amalia Eka Rakhmania, ST, MT., M.Sc.', 'tasnim72@example.com', 21, NULL, '$2y$12$RBtYEsohXaI9/hV3dtK5jOEOv8N6zwg7yBgB.imE9XE684SizrcVi', 'NCYTKgrVw12u1aYtiB4Inj2rlxTFaxOXEZ6bRWLRBBZjnFOlpaI8xkB7BRYV', NULL, '2025-06-16 10:29:54', '2025-06-16 10:29:54'),
(987654959, '00000019', 'Asfari Hariz Santoso, ST., MT.', 'liman.putra@example.com', 21, NULL, '$2y$12$V9XvMdiw4UQ0/pyfyGfy.u81uDo3lem7oUBe/9n4TMCs4uwDUfQfO', 'EaMa9hSKiixGt141LhLTqbr3hIuZSko5g1aOHbSy8piIXLFY13H2KFmQpKPn', NULL, '2025-06-16 10:29:54', '2025-06-16 10:29:54'),
(987654960, '00000020', 'Doddy Maulana, SE, MT. M.Sc.', 'zamira.jailani@example.org', 21, NULL, '$2y$12$2RpAU7lEFTvbCquxNqTaGusTL2wXUa5Oej1xQYZqS5mKdO9.KZkXW', NULL, NULL, '2025-06-16 10:29:54', '2025-06-16 10:29:54'),
(987654961, '00000021', 'Mila Kusuma Wardhani S.T., M.T.', 'saragih.padma@example.net', 21, NULL, '$2y$12$5zCiWTtnVp5Ulwek7yYp7OBWcfB61P/09o3pB8Ht37oVr92l0BVzi', NULL, NULL, '2025-06-16 10:29:54', '2025-06-16 10:29:54'),
(987654962, '00000022', 'Mila Fauziyah., ST., MT.', 'jarwadi.prabowo@example.com', 21, NULL, '$2y$12$bpebA32CdVA8Y.FlNG65T.UI/gs8J4j8EgZmg/78t6WU4JYMNZ/mq', NULL, NULL, '2025-06-16 10:29:54', '2025-06-16 10:29:54'),
(987654963, '00000023', 'Listiyana Candra Dewi S.Si., M.Si', 'gilda82@example.com', 30, NULL, '$2y$12$Ej6SklsSLdR6Vrqi/vTI.en5naPEheDkptnLY.mPzRBpLvkjaQ/5a', NULL, NULL, '2025-06-16 10:29:55', '2025-06-16 10:29:55'),
(987654964, '00000024', 'Dr. Dyah Ratna Wulan S.Si.,M.Si', 'julia34@example.net', 30, NULL, '$2y$12$PXiZD66I1uYq38c/zHUIRuru7nHqdfppW/j6IpWLt8/zWWPiKQkPy', NULL, NULL, '2025-06-16 10:29:55', '2025-06-16 10:29:55'),
(987654965, '00000025', 'Wahyuni Ningsih S.Si., M.Si.', 'prakasa.pangeran@example.org', 30, NULL, '$2y$12$vG/Gd4FVxjcz8QToFLRlnuEDKc.mS4Kn79mhc1ffLvl2bBvAjER8q', NULL, NULL, '2025-06-16 10:29:55', '2025-06-16 10:29:55'),
(987654966, '00000026', 'Profiyanti Hermien Suharti S.T., M.T', 'hasim.wijayanti@example.org', 30, NULL, '$2y$12$s2Uuti3Qp8VMdAABU4MRVOkT/kv4SWDFqUz7NmlgrLjOwSouQFLNu', NULL, NULL, '2025-06-16 10:29:55', '2025-06-16 10:29:55'),
(987654967, '00000027', 'Noor Isnaini Azkiya, S.Si., M.Si.', 'sarah97@example.net', 30, NULL, '$2y$12$tsncCfvF75mNyhsg8LNxzeM.VY5Kt0CNZJ7j3v3gROjyAK9ZwHdJi', NULL, NULL, '2025-06-16 10:29:56', '2025-06-16 10:29:56'),
(987654968, '00000028', 'Dr. Ir. Ariani, MT.', 'hamzah.wijayanti@example.com', 30, NULL, '$2y$12$RF12wi6lZlnP3j8WJjAKXuwrxdCmKKT86rf5umiLzoeaIl6W/hoIy', NULL, NULL, '2025-06-16 10:29:56', '2025-06-16 10:29:56'),
(987654969, '00000029', 'Prof. Dr. Ir. Dwina Moentamaria, M.T.', 'ayu37@example.org', 30, NULL, '$2y$12$YoiqzucTiH2w.tYVqPKuJuvVh4eh11PHctEcu5eLUPorTya6dvkaC', NULL, NULL, '2025-06-16 10:29:56', '2025-06-16 10:29:56'),
(987654970, '00000030', 'Santoso, S.T.,M.T.', 'maida.natsir@example.com', 37, NULL, '$2y$12$EBMd36dAqLjuKaKPx4TIFuJovS5SHQWHmCnrFkyaALVBAblhg7BfS', NULL, NULL, '2025-06-16 10:29:56', '2025-06-16 10:29:56'),
(987654971, '00000031', 'Dr. Drs. Moh. Hartono, M.T.', 'eli28@example.com', 37, NULL, '$2y$12$GQAFf5MaClQluuN5N5bgFeDMVS6Ou/4KjvirVTS6PEhR6YFdttfxC', NULL, NULL, '2025-06-16 10:29:56', '2025-06-16 10:29:56'),
(987654972, '00000032', 'Dr. Wirawan, B.Eng.(Hons.), M.T.', 'wahyuni.tugiman@example.com', 37, NULL, '$2y$12$tfp3LiQV0MQp.002sKm9U.TrvGUHT/cbLmTVCsjMDxWHGIcq/RKDy', NULL, NULL, '2025-06-16 10:29:57', '2025-06-16 10:29:57'),
(987654973, '00000033', 'Kris Witono S.T., M.T.', 'xlaksmiwati@example.com', 37, NULL, '$2y$12$VKoog/VfDJ2Pv4KKgWgJeuuCd/AM3As/sBszgKXI6Ijk3Ekkirr7i', NULL, NULL, '2025-06-16 10:29:57', '2025-06-16 10:29:57'),
(987654974, '00000034', 'Novita Anggraini, SST., MT', 'kwinarsih@example.com', 43, NULL, '$2y$12$Zt5kNPxBs60TZ8exNvf6u.avWsQdBYHyHe7i2M1n7HBz6H4bvhp9G', NULL, NULL, '2025-06-16 10:29:57', '2025-06-16 10:29:57'),
(987654975, '00000035', 'Winda Harsanti, ST., MT.', 'amelia.pertiwi@example.net', 43, NULL, '$2y$12$BzslHSXB6h8vdBtpdSRqP.27KLCCJQemCzC.Nc.wByj3XBobj6iYu', NULL, NULL, '2025-06-16 10:29:57', '2025-06-16 10:29:57'),
(987654976, '00000036', 'Moch. Sholeh, ST. MT.', 'rahmi28@example.net', 43, NULL, '$2y$12$4/cMrEElDNH6N/G9HGDwJOSM7D2sYCK5nlHSawF4dGUkU7sHsi9oW', NULL, NULL, '2025-06-16 10:29:57', '2025-06-16 10:29:57'),
(987654977, '00000037', 'Ikrar Hanggara, ST., MT.', 'warsita.suryatmi@example.com', 43, NULL, '$2y$12$br/DwZ.jxoD/XqbtZ/ZEuek3d29UlX8Ei7nX3EoYY/mfz/2.hyVVm', NULL, NULL, '2025-06-16 10:29:58', '2025-06-16 10:29:58'),
(987654978, '00000038', 'Luqman Affandi S.Kom.,MMSI', 'elma.aryani@example.com', 26, NULL, '$2y$12$5cJ9OfXJ/b/fkXD//pAUyuWGmu3aFJIDRWQE6JjjJ7nRmqbWILZsW', NULL, NULL, '2025-06-16 10:29:58', '2025-06-16 10:29:58'),
(987654979, '00000039', 'Septian Enggar Sukmana, S.Pd., M.T.', 'karna.riyanti@example.net', 26, NULL, '$2y$12$xljid7bkEd.Bw5xCJKhEzuPmHDjX86lBv77bUbtd6bKgpTNx2DSnS', 'io8WlT3SmUyJId1Yqn8gJncqYhe001zqtqf3lma3bs8SDLEbgP8tygYbbnMw', NULL, '2025-06-16 10:29:58', '2025-06-16 10:29:58'),
(987654980, '00000040', 'Ade Ismail, S.Kom., M.TI.', 'nuraini.artanto@example.net', 26, NULL, '$2y$12$p3t6D6WCGb33CGW7jYJSbeDSaqqtl2KzCzt3DlvG79/yb5RAWL3lK', 'PwxKIO7bIQpGplJih4aHoFUKlevovKnGtVHJ2AklgHlARzqusU7WZ2SzI3ad', NULL, '2025-06-16 10:29:58', '2025-06-16 10:29:58'),
(987654981, '00000041', 'Budi Harijanto, ST., M.Mkom.', 'kezia52@example.org', 26, NULL, '$2y$12$5lMDJEetbpfuZ9BOPNf8n.whPvVKMirq2ahEUQolnSCvG/lVfDF4W', '3In0lb8SoNZN0SY2Rg175NJ324l4qHNX0omK4EaAjvvHjEts8ZDdSx6Rh47y', NULL, '2025-06-16 10:29:58', '2025-06-16 10:29:58'),
(987654982, '00000042', 'Dr. Widaningsih S.Psi., S.H., M.H.', 'endah.gunawan@example.org', 26, NULL, '$2y$12$u8YzDZxeNxaWEB99A9MKeeXDEReFM9nQno3e4QczcYRj78b7TjSbK', '8JSgqAEuLYYMKsLBNp4PEAZ6qPsq0mFTGmCJeogNUSfVm85PWiy2vpN6vsGt', NULL, '2025-06-16 10:29:59', '2025-06-16 10:29:59'),
(987654983, '00000043', 'Farid Angga Pribadi, S.Kom., M.Kom.', 'pradipta.embuh@example.net', 26, NULL, '$2y$12$e65IAdZFr8eIZEO8GZMBT.K8aMHR5w/29CqgW3a.vjsLjGbtp2lMy', NULL, NULL, '2025-06-16 10:29:59', '2025-06-16 10:29:59'),
(987654984, '00000044', 'Retno Damayanti S.Pd., M.T.', 'jhabibi@example.org', 26, NULL, '$2y$12$BHD61ldj3MF3IqRo5le5PObCI1qP0QD9CJeEXg79zLWu4amwPz19O', 'MewPCZ8mip3HVRb7kIo1hkrOEjVZgMOKhe6WZRti5qG1aTtp6Hl1dB3YQX7S', NULL, '2025-06-16 10:29:59', '2025-06-16 10:29:59'),
(987654985, '00000045', 'Yoppy Yunhasnawa S.ST., M.Sc.', 'ynurdiyanti@example.net', 26, NULL, '$2y$12$RODGBS1FyV2stWolIH4XA.TUQHjB8TcVNBGpDXpouTlFctNS/8wby', 'SEC8tGKjyNSLTXczrfDZ7wMjnyVK4x0rbbXyRsD4eLlgsz9nRI90tC6EkrVx', NULL, '2025-06-16 10:29:59', '2025-06-16 10:29:59'),
(987654986, '00000046', 'Riswan Eko Wahyu Susanto S.Pd., M.T.', 'novitasari.bahuwirya@example.net', 50, NULL, '$2y$12$pZJbAeFoLtTajngxuJ/Xo.hRPq6NS1qWabQXj56YvFoW9FDR9CISC', NULL, NULL, '2025-06-16 10:29:59', '2025-06-16 10:29:59'),
(987654987, '00000047', 'Mochamad Muzaki, ST. MT.', 'latupono.asman@example.com', 37, NULL, '$2y$12$3RUEmFzcPi.5srdFvrQmbOdZgEdlHjO0sFjOs4t9OBP699Wvca0UW', NULL, NULL, '2025-06-16 10:30:00', '2025-06-16 10:30:00'),
(987654988, '00000048', 'Masfufah', 'indra.lailasari@example.org', 62, NULL, '$2y$12$J.sidNhrmt2m8ckGfViZ/uCObqyh3YCKlYrYhOPPNuiSM63ViLB/G', NULL, NULL, '2025-06-16 10:30:00', '2025-06-16 10:30:00'),
(987654989, '00000049', 'Lita Berlianti Imaniar', 'gwidiastuti@example.net', 62, NULL, '$2y$12$Q3riP7HK6UnduE/QNWXWcOHmXd4ovaCw4cf.BkVg.nBOrEH1JqzD.', NULL, NULL, '2025-06-16 10:30:00', '2025-06-16 10:30:00'),
(987654990, '00000050', 'Andini Galih Widya Putri', 'kpurnawati@example.org', 62, NULL, '$2y$12$0TtU586IDALpCXHXKZIL7.2wS/65PvDTbIFglqn2uykHMU75vaVV2', NULL, NULL, '2025-06-16 10:30:00', '2025-06-16 10:30:00'),
(987654991, '10000100', 'Supriatna Adhisuwignjo, ST., MT', 'supriatna.pimpinan@example.com', 1, NULL, '$2y$12$VTVe0fOBHl0c6fTqpz2ypORXdIG7zExwLeRebNtNPo5UXobbkabPu', 'tSd9MM6omuirtb0pjbU3kdK8RUQbpGUj8WhBab5FI4Ri8BN3LkYvjebvF6b3', NULL, '2025-06-16 11:00:27', '2025-06-16 11:00:27'),
(987654994, '00000100', 'Riswan Eko Wahyu Susanto, S.Pd.,M.T', 'riswan.auditee@example.com', 46, NULL, '$2y$12$zhy8k/92v/RJv6kQzYxOQOkJJDI6qv3FoQ6Jhv/vysj0LdVYoB0zi', '3K2YO3tryG3EEAbopCjgcpzdLKCSvjPcpt21Ak9JJu3FVtx0f9qOlP1xuzzC', NULL, '2025-06-16 11:01:25', '2025-06-16 11:01:25'),
(987654995, '00000101', 'Siti Rohani, S.Pd., M.Pd., Ph.D.', 'damanik.yahya@example.com', 4, NULL, '$2y$12$wCHQAquCKfInblrRBApLlOwMrIDf8xXA/HsnSdT0O5FYN2ljFZvte', NULL, NULL, '2025-06-22 04:37:36', '2025-06-22 04:37:36'),
(987654996, '00000102', 'Dr. Tri Yulistyawati Evelina, S.E., M.M.', 'melani.chelsea@example.com', 5, NULL, '$2y$12$zmBxvb3Y0MqVET1QkJAX6OnEuFi1P4Uj50yp32N31a3wha0ycwDhy', NULL, NULL, '2025-06-22 04:37:36', '2025-06-22 04:37:36'),
(987654997, '00000103', 'Dr. Farika Nikmah, S.Sos., M.AB.', 'aisyah.adriansyah@example.com', 6, NULL, '$2y$12$sqhBTOd/l1.9MFexYGiHSe5YI0IJYua6ltCR/ohTq5Nhky9leXkuq', NULL, NULL, '2025-06-22 04:37:36', '2025-06-22 04:37:36'),
(987654998, '00000104', 'Erlin Melani, S.E.Ak., M.SA.', 'martani43@example.com', 9, NULL, '$2y$12$lAiXK8DgbvisOIwR4IX11.DyjYk0sj.69Xfae3hx6cjUwOwKKa1iK', NULL, NULL, '2025-06-22 04:37:36', '2025-06-22 04:37:36'),
(987654999, '00000105', 'Yusna, S.E., M.Si.', 'adika.pratiwi@example.net', 10, NULL, '$2y$12$K6TXOo2ZxyJ4VEmtjH3R8e1uMcOqDPq9o8Bej8FjDAiXJ5UlAavMu', NULL, NULL, '2025-06-22 04:37:37', '2025-06-22 04:37:37'),
(987655000, '00000106', 'Nur Indah Riwajanti, S.E., M.Comm., Ph.D.', 'jmarpaung@example.net', 12, NULL, '$2y$12$FBSp2VJDdXyDPJzJfhTfPONqOt6wFy/Jngn2MTS/NaPN1pXbbQKLC', NULL, NULL, '2025-06-22 04:37:37', '2025-06-22 04:37:37'),
(987655001, '00000107', 'Dr. Nurafni Eltivia, S.E., M.SA.', 'ynurdiyanti@example.org', 13, NULL, '$2y$12$ygOg1Sx40P9dyvqDPNfXTOIMteyhJ.wV.Q.PZTCGDeaRsfKADT7Ja', NULL, NULL, '2025-06-22 04:37:37', '2025-06-22 04:37:37'),
(987655002, '00000108', 'Dr. Beauty Anggraheny Ikawanty, S.T., M.T.', 'vanesa60@example.com', 14, NULL, '$2y$12$LpxjRBgir.VuU.YOBcYA8eVQNd9hQ5hO6G/DYoJdgQqY54mrLas.y', NULL, NULL, '2025-06-22 04:37:37', '2025-06-22 04:37:37'),
(987655003, '00000109', 'Irwan Heryanto/Eryk, S.T., M.T.', 'xandriani@example.com', 15, NULL, '$2y$12$Z8kyJp9L9.LC9qOlEh0cluqHuPnEDwZ6WFf6zaYvcDYdYR0nqHhui', NULL, NULL, '2025-06-22 04:37:37', '2025-06-22 04:37:37'),
(987655004, '00000110', 'Hari Kurnia Safitri, S.T., M.T.', 'lfirmansyah@example.net', 16, NULL, '$2y$12$8b1epyI5qdZENOniSNduE.QdQY4phUIApqMzRqY3OJyGHni8.uCt2', NULL, NULL, '2025-06-22 04:37:38', '2025-06-22 04:37:38'),
(987655005, '00000111', 'Mila Kusumawardani, S.T., M.T.', 'limar.hariyah@example.net', 17, NULL, '$2y$12$QwG1z1PlfkxsWx1QrefV7eLJDDvSMkcqIvyG2Uuf0UXubAYxV0mtC', NULL, NULL, '2025-06-22 04:37:38', '2025-06-22 04:37:38'),
(987655006, '00000112', 'Prof. Mohammad Noor Hidayat, S.T., M.Sc., Ph.D.', 'firmansyah.hafshah@example.com', 21, NULL, '$2y$12$LaNu.qOVm58XnxeQUXhWkudnh5ir8wQaMc7JB5GXFeEzemn8pHZJq', NULL, NULL, '2025-06-22 04:37:38', '2025-06-22 04:37:38'),
(987655007, '00000113', 'Pramana Yoga Saputra, S.Kom., M.MT.', 'msaptono@example.net', 22, NULL, '$2y$12$OMPvPqYDg52Iu2kPRmxc5embtuEtPOoGm1SKT/hL./17R3A5geGsu', NULL, NULL, '2025-06-22 04:37:38', '2025-06-22 04:37:38'),
(987655008, '00000114', 'Hendra Pradibta, S.E., M.Sc.', 'damanik.galuh@example.org', 23, NULL, '$2y$12$Jw3kfBYUVa1eusMknP/ifObAV/Yp1ukRlSvGMeonxAq8rJqa3LHaC', NULL, NULL, '2025-06-22 04:37:38', '2025-06-22 04:37:38'),
(987655009, '00000115', 'Dr. Ely Setyo Astuti, S.T., M.T.', 'wulan.padmasari@example.com', 24, NULL, '$2y$12$kof1Z9MTsJ7Yv9sk7amw5ew0o8rW4vZwIXr8JjZT1jo0ZeHsO8lR6', NULL, NULL, '2025-06-22 04:37:39', '2025-06-22 04:37:39'),
(987655010, '00000116', 'Dr. Eng. Banni Satria Andoko, S.Kom., M.MSI.', 'narpati.tina@example.net', 25, NULL, '$2y$12$egkzP81FfTlV2ttZBQjIpun1S4iAKWJyjEiFuAUp3F197.fb3oOW.', NULL, NULL, '2025-06-22 04:37:39', '2025-06-22 04:37:39'),
(987655011, '00000117', 'Prof. Dr. Eng. Rosa Andrie Asmara, S.T., M.T.', 'hassanah.putu@example.com', 26, NULL, '$2y$12$2/cSyQ3t9i83AxnY8c84te4cLJ/kinE4ztil.l4w0OYqmoE9jVOaS', NULL, NULL, '2025-06-22 04:37:39', '2025-06-22 04:37:39'),
(987655012, '00000118', 'Dr. Aang Afandi, S.E., M.M.', 'llailasari@example.com', 11, NULL, '$2y$12$7y0BZ596Zssh/p2KH./LoO0LSxEpWu9JQI2RNN0ACYixQLVlVfUza', NULL, NULL, '2025-06-22 04:37:39', '2025-06-22 04:37:39'),
(987655013, '00000119', 'Dr. Yanty Maryanty, S.T., M.Si.', 'nurul30@example.net', 27, NULL, '$2y$12$m01aMRklymaaziasngGE2./q443RhS3pZQ7Czk5BdnaIm5LcSJA0K', NULL, NULL, '2025-06-22 04:37:39', '2025-06-22 04:37:39'),
(987655014, '00000120', 'Dr. Zakijah Irfin, S.T., M.T.', 'msafitri@example.org', 28, NULL, '$2y$12$aRKmCX7V7naSMq7ZIT7hCusVFJ57we6xWplkZdPFkNchuz0krKhXC', NULL, NULL, '2025-06-22 04:37:40', '2025-06-22 04:37:40'),
(987655015, '00000121', 'Dr. Haris puspito Buwono, M.T', 'dhutapea@example.net', 29, NULL, '$2y$12$.k2QArCm5zKrTmTY6GV4T.2gt2zIYIivr/xsmEUWYoWNaQf4Zf0CK', NULL, NULL, '2025-06-22 04:37:40', '2025-06-22 04:37:40'),
(987655016, '00000122', 'Dr. Windi Zamrudy, B.Tech., M.Pd.', 'smaulana@example.net', 30, NULL, '$2y$12$gstIAt9Q5Vr9L2cwOX/Q4eOOe4gecQzly4JO1G48xqzmbHQP1bNS.', NULL, NULL, '2025-06-22 04:37:40', '2025-06-22 04:37:40'),
(987655017, '00000123', 'Lisa Agustriyana, S.T., M.T.', 'citra.wulandari@example.com', 31, NULL, '$2y$12$NPWGZiw2pbC6sK8XZwkswuvWJhmcvlDW7VxbWTKqmFhssArDBT6dS', NULL, NULL, '2025-06-22 04:37:40', '2025-06-22 04:37:40'),
(987655018, '00000124', 'Kris Witono, S.T., M.T.', 'paulin.prasasta@example.com', 33, NULL, '$2y$12$xu5iStO1QXU9vK3dC4rlqO.EgTrTru73NLUEtiOKl08CX5BANfDAu', NULL, NULL, '2025-06-22 04:37:41', '2025-06-22 04:37:41'),
(987655019, '00000125', 'Dr. Asrori, S.T., M.T.', 'mulya.zulkarnain@example.org', 34, NULL, '$2y$12$MV9sTX.O/VzdfGvXvm2BJ./AjCH9Td3KyJEytfS4oyLDrkeRDlLvm', NULL, NULL, '2025-06-22 04:37:41', '2025-06-22 04:37:41'),
(987655020, '00000126', 'Dr. Muhammad Akhlis Rizza, S.T., M.T.', 'paulin.kurniawan@example.org', 35, NULL, '$2y$12$MwpP31swdAyogMnCIKLJv.6NBKWBYpCLwgmGKgWP6FUINLWd8BTA2', NULL, NULL, '2025-06-22 04:37:41', '2025-06-22 04:37:41'),
(987655021, '00000127', 'Dr. Sugeng Hadi Susilo, ST.,MT.', 'elisa.palastri@example.net', 36, NULL, '$2y$12$BpT57jD.KwvPOcbpOhpUCekauWg7xJc46bYDyrQCEOOqOYaIFL2f.', NULL, NULL, '2025-06-22 04:37:41', '2025-06-22 04:37:41'),
(987655022, '00000128', 'Ir. Pipit Wahyu Nugroho, M.T.', 'juli.utama@example.com', 37, NULL, '$2y$12$OhTnvhbnRbNFQUJKhd92rOmiphqR9pUwbyxQ5l3vJXQ.P7iMlnTNG', NULL, NULL, '2025-06-22 04:37:41', '2025-06-22 04:37:41'),
(987655023, '00000129', 'Ahmad Fauzi, S.Kom., M.MT.', 'widya81@example.com', 2, NULL, '$2y$12$pNOZesosPnTd1v1XH5toFudb9mUjqXNEqUfzFuTbSp6YQ0JndcKJq', NULL, NULL, '2025-06-22 04:37:42', '2025-06-22 04:37:42'),
(987655024, '00000130', 'Dr. Nawir Rasidi, S.T., M.T.', 'citra.rahimah@example.org', 38, NULL, '$2y$12$DT7tMKg0aQiSW4evmfRaE.VU6U.od2FQogrGKOgn26m0lu.WiAPbi', NULL, NULL, '2025-06-22 04:37:42', '2025-06-22 04:37:42'),
(987655025, '00000131', 'Drs. Armin Naibaho, S.T., M.T.', 'dwi.kusumo@example.com', 40, NULL, '$2y$12$yjfZHmzlFLpH1/.xTcktjeKPGOirdknpO7XcNWV6bXEnp.l5LAmqe', NULL, NULL, '2025-06-22 04:37:42', '2025-06-22 04:37:42'),
(987655026, '00000132', 'Sitti Safiatus Riskijah, S.T., M.T.', 'halimah.estiono@example.com', 41, NULL, '$2y$12$fg6hj61OjiuGkzzP7tNine1BCXGyjEdgr6kbaHqbt.xglxZV7O0qe', NULL, NULL, '2025-06-22 04:37:42', '2025-06-22 04:37:42'),
(987655027, '00000133', 'Supiyono, S.T., M.T.', 'maryati.endah@example.org', 42, NULL, '$2y$12$3D3w.qpH6jDXXh96xzUWDejNrQ4q8E7XsIi5v5LoXGV1rPNwRB0W6', NULL, NULL, '2025-06-22 04:37:42', '2025-06-22 04:37:42'),
(987655028, '00000134', 'Mohamad Zenurianto, DIPL.Ing.HTL., M.Sc.', 'pranowo.maya@example.net', 43, NULL, '$2y$12$RoG1DuOVxPv8O5ydb./pKehfI7gO5CSrT6O0lmAJimIl2BWlPhwcy', NULL, NULL, '2025-06-22 04:37:43', '2025-06-22 04:37:43'),
(987655029, '00000135', 'Dra. Fita Setiati, Ak., M.Si.', 'xhassanah@example.net', 44, NULL, '$2y$12$HFNbK6Po3RHtFUA8QLkKDuEnfwcJH2N8ZKoKwWJgS17h29V5B2jY6', NULL, NULL, '2025-06-22 04:37:43', '2025-06-22 04:37:43'),
(987655030, '00000136', 'Benni Agung Nugroho, S.Kom., M.Cs.', 'novi.habibi@example.org', 45, NULL, '$2y$12$DlPNkbMI1uk9oaySstMmM.ZvdaVW6eTkuNil/OQVBBRBuiKF5dOuG', NULL, NULL, '2025-06-22 04:37:43', '2025-06-22 04:37:43'),
(987655031, '00000137', 'Riswan Eko Wahyu Susanto S.Pd., M.T.', 'martaka20@example.com', 46, NULL, '$2y$12$mzgwaNEFyrhxX/p.0.0nkOVgTrX/3EZDedH/XDUx8ZtQ0u5rV4hPK', NULL, NULL, '2025-06-22 04:37:43', '2025-06-22 04:37:43'),
(987655032, '00000138', 'Drs. Mohamad Arief Setiawan, M.Kom.', 'lasmono.astuti@example.net', 47, NULL, '$2y$12$negGo9brm5o7cQknqqfkCOcw.GH/pvWKCHVSSXPkk/JlwQ05lsbdy', NULL, NULL, '2025-06-22 04:37:43', '2025-06-22 04:37:43'),
(987655033, '00000139', 'Agustono Heriadi, S.ST., M.Kom.', 'luluh38@example.com', 48, NULL, '$2y$12$B0Mq2xUxwr0XAIseSb4.7.15KsFk2JZGGlT7cfXirXkUnzNGKMsR6', NULL, NULL, '2025-06-22 04:37:44', '2025-06-22 04:37:44'),
(987655034, '00000140', 'Agus Dani, S.T., M.T.', 'damanik.jumari@example.org', 49, NULL, '$2y$12$Z1gVo3ZbxHIDluQNmdHagOV6Ai7fV/gC4eJEuCIrRq/o0ayt/OQ96', NULL, NULL, '2025-06-22 04:37:44', '2025-06-22 04:37:44'),
(987655035, '00000141', 'Drs. MOHAMAD ARIEF SETIAWAN, M.Kom.', 'rafid50@example.com', 50, NULL, '$2y$12$dOaddnV/LWSX4subKe81i.qyyEYBye4TlYe87no.5k2h5w86Y2b8i', NULL, NULL, '2025-06-22 04:37:44', '2025-06-22 04:37:44'),
(987655036, '00000142', 'Drs. Ir. Abdullah Helmy, M.Pd., Ph.D.', 'igunarto@example.org', 7, NULL, '$2y$12$6e6wBh4XRpl/INMMZ3O.0eBPIGTEd1kjDRy0r8gOjnyJLJ2HvRnBC', NULL, NULL, '2025-06-22 04:37:44', '2025-06-22 04:37:44'),
(987655037, '00000143', 'Drs. Zubaidi., M.Pd.', 'fnurdiyanti@example.net', 8, NULL, '$2y$12$5JmP2AKSuliKv3QnnILFoeH69k86mWUY3ZclNtVm2fkwb2bQeRub.', NULL, NULL, '2025-06-22 04:37:45', '2025-06-22 04:37:45'),
(987655038, '00000144', 'Ir. Imron Ridzki, S.T., M.T.', 'raden.ramadan@example.org', 18, NULL, '$2y$12$tK5VSkoKsq46xEm0BQvtAOubhIN6lIhbR39RjkSrawKoPh.mDAha2', NULL, NULL, '2025-06-22 04:37:45', '2025-06-22 04:37:45'),
(987655039, '00000145', 'Drs. Subekhi Hadi Purnomo, M.Pd.', 'hassanah.humaira@example.net', 51, NULL, '$2y$12$sRgZ6GRJR.XYnOxTZ9QVnuuOz4U.tgCPjpds18JjJJWOrIyGpRGW.', NULL, NULL, '2025-06-22 04:37:45', '2025-06-22 04:37:45'),
(987655040, '00000146', 'Gunawan Budiprasetyo, S.T., M.MT., Ph.D.', 'eka75@example.com', 52, NULL, '$2y$12$4k/aXRi1RGxHL3hXALGRFO6R04rs1kmKpXhkNhy.ftHIQbzwV8.O2', NULL, NULL, '2025-06-22 04:37:45', '2025-06-22 04:37:45'),
(987655041, '00000147', 'Dr. Diah Lydianingtias, S.T., M.M.', 'talia.yuniar@example.com', 53, NULL, '$2y$12$jRrXofGu4d3jiqMIzDrdHOzvLB.HNGaP1qqQ9odmt8NbKInjSET1W', NULL, NULL, '2025-06-22 04:37:45', '2025-06-22 04:37:45'),
(987655042, '00000148', 'Yuniarto Agus Winoko, S.T., M.T.', 'zyuniar@example.org', 54, NULL, '$2y$12$w.NN2NrnKC42KTDQOfxZsekHCSZbckoCeksOt6gjgH4BhOZcSpQq6', NULL, NULL, '2025-06-22 04:37:46', '2025-06-22 04:37:46'),
(987655043, '00000149', 'GUNAWAN BUDIPRASETYO, S.T., M.MT., Ph.D.', 'purwadi.andriani@example.com', 55, NULL, '$2y$12$tt7lWV/5Qhfki2VYC9I/Huk94ssO7TAM1G.rhLbW7O8O/ciAvpnZa', NULL, NULL, '2025-06-22 04:37:46', '2025-06-22 04:37:46'),
(987655044, '00000150', 'Luqman Affandi, S.Kom., M.MSI.', 'lrahayu@example.net', 56, NULL, '$2y$12$dhpftpgetuci9lftcZSomevShwWAE1rxf.ImCoNYfypZE8fP0OEN.', NULL, NULL, '2025-06-22 04:37:46', '2025-06-22 04:37:46'),
(987655045, '00000151', 'Yusna, S.E., M.Si.', 'tami90@example.com', 57, NULL, '$2y$12$XCjkP49KEliiRjf23c.2Hum6G0Q/O53qDBBjCVV1.8hhg3vuX6xNa', NULL, NULL, '2025-06-22 04:37:46', '2025-06-22 04:37:46'),
(987655046, '00000152', 'Dr. Achmad Walid, S.T., M.T.', 'habibi.ajiono@example.org', 58, NULL, '$2y$12$kQCVZ/17Ald5uRS0LVqlyeFeFVguiVKYRwmPYPHB/Qacx/3dP5TJK', NULL, NULL, '2025-06-22 04:37:46', '2025-06-22 04:37:46'),
(987655047, '00000153', 'Dr. ACHMAD WALID, S.T., M.T.', 'wasita.mursinin@example.org', 59, NULL, '$2y$12$xoWUQB8XAsbA3.R4oZJ32OPRmzd55ZrKhz1rFK3wvhSv0GEx1iUki', NULL, NULL, '2025-06-22 04:37:47', '2025-06-22 04:37:47'),
(987655048, '00000154', 'Sapto Wibowo, S.T., M.Sc., Ph.D.', 'tira.andriani@example.net', 20, NULL, '$2y$12$mZSBpSzQoWYWeQhgjfUAn.yEoeEL2aJapuXvIh4BmKMXnGdNvVnxy', NULL, NULL, '2025-06-22 04:37:47', '2025-06-22 04:37:47'),
(987655049, '00000155', 'Agus Suhardono, S.T., M.T.', 'oskar.tamba@example.com', 39, NULL, '$2y$12$ixpNg50xPqIxJv1f4KAizurhvfJeVDzXh.YqN9Ea.Fcj8gF2eWQhy', NULL, NULL, '2025-06-22 04:37:47', '2025-06-22 04:37:47'),
(987655050, '00000156', 'Tjandra Dewi Wulandari, S.E., M.M.', 'prasetyo.lintang@example.com', 60, NULL, '$2y$12$dnrlxxB4ikwawIEdq3H66OvA7EqfmJks1BEGFINj1Co0f2DDGwJEy', NULL, NULL, '2025-06-22 04:37:47', '2025-06-22 04:37:47'),
(987655051, '00000157', 'Suwarno, S.T.', 'usyi.wijaya@example.net', 61, NULL, '$2y$12$CeYoD7GX/.wejDPRyjFTtO8wCUHilrAVcDO5K/1H506x7nBd/h.v.', NULL, NULL, '2025-06-22 04:37:47', '2025-06-22 04:37:47'),
(987655052, '00000158', 'Doddy Maulana, SE, MT. M.Sc.', 'latika.tampubolon@example.com', 62, NULL, '$2y$12$6jJOlZ.MBGv4qXtoCAI.heml.7ZGzr3W.w8VbUwImsZJ7DTA8gXWm', NULL, NULL, '2025-06-22 04:37:48', '2025-06-22 04:37:48'),
(987655053, '00000159', 'Utsman Syah Amrullah, S.T., M.T.', 'maida02@example.net', 32, NULL, '$2y$12$OiL2qIXhTgTioIGYoYkQ/eGbgrp8V50Ezzkizthcx/mriCxIXVz5m', NULL, NULL, '2025-06-22 04:37:48', '2025-06-22 04:37:48'),
(987655054, '00000160', 'Prof. Dr. Ratna Ika Putri, S.T., M.T.,', 'ikin.wahyudin@example.org', 63, NULL, '$2y$12$YMIV34t1X8g06TFp5BIAG.SlCvEQ.H6KLMagr.tngbSWAUm0VpPCi', NULL, NULL, '2025-06-22 04:37:48', '2025-06-22 04:37:48'),
(987655055, '00000161', 'Saep Suherman, S.Kom.', 'genta13@example.com', 64, NULL, '$2y$12$MkVVNXmVLRd05bhkjY2HaeBm.V13orZQcUM/3FrF.Rj3HP5/ZI8Fu', NULL, NULL, '2025-06-22 04:37:48', '2025-06-22 04:37:48'),
(987655056, '00000162', 'Andi Kusuma Indrawan, S.Kom., M.T.', 'danang91@example.com', 65, NULL, '$2y$12$JQyf92RTwZBZcKjic9RSvusTB7t5CsZWw/s0.XwVfuqXXUeCCYT8q', NULL, NULL, '2025-06-22 04:37:48', '2025-06-22 04:37:48'),
(987655057, '00000163', 'Atiqah Nurul Asri,S.Pd., M.Pd.', 'vusada@example.net', 66, NULL, '$2y$12$Kj7.v/U8R6A6Abc1qbwabemmc1n5Y0x4ySLtqtg5DKm0jAKPK4EbW', NULL, NULL, '2025-06-22 04:37:49', '2025-06-22 04:37:49'),
(987655058, '00000164', 'Dr. Drs. Moh. Hartono M.T.', 'eka98@example.net', 67, NULL, '$2y$12$rQdJJ2rfdCBKnnqcS1GlnuiGBr4NATwhOouaVHvxkzRkCeIUSAFua', NULL, NULL, '2025-06-22 04:37:49', '2025-06-22 04:37:49'),
(987655059, '00000166', 'Hadiwiyatno, S.T., M.T.', 'ruyainah@example.com', 19, NULL, '$2y$12$apBgVaSxVUqnADd9hs1vZ.2u2J4sNZ..4Igni2ldxD8y33uo6sx1q', NULL, NULL, '2025-06-22 04:37:49', '2025-06-22 04:37:49'),
(987655060, '00000167', 'Ayu Sulasari,S.E., M.M.', 'dalima.ardianto@example.org', 69, NULL, '$2y$12$aO0IAUjlNEBAlLwopepOi.BoXVaPYfQjQZZ8remSDjhIyEzOsuafu', NULL, NULL, '2025-06-22 04:37:49', '2025-06-22 04:37:49'),
(987655061, '00000168', 'Dr. Sugeng Hariyanto S.Pd., M.Pd.', 'ipalastri@example.org', 70, NULL, '$2y$12$rCrWugAwSjl9LCaHg3TOje4l0htfjxioFa6JKYRafMB8PwEW7i0q.', NULL, NULL, '2025-06-22 04:37:49', '2025-06-22 04:37:49'),
(987655062, '00000165', 'Dr. Eng. Haris Puspito Buwono S.T., M.T.', 'tanggriawan@example.net', 68, NULL, '$2y$12$o/vumi7qVBu.HN5ijWtku.nd8AZKQf8wLSVcNH2yfBib151kyqTcK', NULL, NULL, '2025-06-22 04:39:28', '2025-06-22 04:39:28'),
(987655063, '00000169', 'Achmad Suyono, S.Pd., M.S.', 'hutapea.putri@example.com', 3, NULL, '$2y$12$GnuQSHpiWv6AYOX1X8.tpOh/PQsLiXt1pah2PTQ4qmO9AVJFUDsI2', NULL, NULL, '2025-06-22 04:44:56', '2025-06-22 04:44:56'),
(987655064, '0000019', 'Maskur, S.Kom., M.Kom.', 'maskur@example.com', 11, NULL, '$2y$12$XcB2ftLMHOxszIOlcp9i3eI7Ixe4ArBUNic8PMn0858ZwkDinDcU6', NULL, NULL, '2025-06-22 05:23:22', '2025-06-22 05:23:22');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `assign_pengisians`
--
ALTER TABLE `assign_pengisians`
  ADD PRIMARY KEY (`id`),
  ADD KEY `assign_pengisians_unit_indikator_id_foreign` (`unit_indikator_id`),
  ADD KEY `assign_pengisians_periode_id_foreign` (`periode_id`),
  ADD KEY `assign_pengisians_validated_by_foreign` (`validated_by`),
  ADD KEY `assign_pengisians_created_by_foreign` (`created_by`);

--
-- Indexes for table `auditor_assignments`
--
ALTER TABLE `auditor_assignments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `auditor_assignments_assign_pengisian_id_foreign` (`assign_pengisian_id`),
  ADD KEY `auditor_assignments_auditor1_foreign` (`auditor1`),
  ADD KEY `auditor_assignments_auditor2_foreign` (`auditor2`);

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
-- Indexes for table `exports`
--
ALTER TABLE `exports`
  ADD PRIMARY KEY (`id`),
  ADD KEY `exports_user_id_foreign` (`user_id`);

--
-- Indexes for table `failed_import_rows`
--
ALTER TABLE `failed_import_rows`
  ADD PRIMARY KEY (`id`),
  ADD KEY `failed_import_rows_import_id_foreign` (`import_id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `imports`
--
ALTER TABLE `imports`
  ADD PRIMARY KEY (`id`),
  ADD KEY `imports_user_id_foreign` (`user_id`);

--
-- Indexes for table `indikators`
--
ALTER TABLE `indikators`
  ADD PRIMARY KEY (`id`),
  ADD KEY `indikators_sub_standar_id_foreign` (`sub_standar_id`),
  ADD KEY `indikators_validated_by_foreign` (`validated_by`),
  ADD KEY `indikators_created_by_foreign` (`created_by`);

--
-- Indexes for table `isi_indikators`
--
ALTER TABLE `isi_indikators`
  ADD PRIMARY KEY (`id`),
  ADD KEY `isi_indikators_indikator_id_foreign` (`indikator_id`);

--
-- Indexes for table `isi_standars`
--
ALTER TABLE `isi_standars`
  ADD PRIMARY KEY (`id`),
  ADD KEY `isi_standars_validated_by_foreign` (`validated_by`),
  ADD KEY `isi_standars_created_by_foreign` (`created_by`);

--
-- Indexes for table `jadwal`
--
ALTER TABLE `jadwal`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jadwal_validated_by_foreign` (`validated_by`),
  ADD KEY `jadwal_created_by_foreign` (`created_by`),
  ADD KEY `jadwal_start_date_end_date_index` (`start_date`,`end_date`),
  ADD KEY `jadwal_periode_id_status_index` (`periode_id`,`status`);

--
-- Indexes for table `jadwal_assignments`
--
ALTER TABLE `jadwal_assignments`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `jadwal_assignments_jadwal_id_user_id_unique` (`jadwal_id`,`user_id`),
  ADD KEY `jadwal_assignments_user_id_foreign` (`user_id`);

--
-- Indexes for table `jadwal_units`
--
ALTER TABLE `jadwal_units`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `jadwal_units_jadwal_id_unit_id_unique` (`jadwal_id`,`unit_id`),
  ADD KEY `jadwal_units_unit_id_foreign` (`unit_id`);

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
-- Indexes for table `media`
--
ALTER TABLE `media`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `media_uuid_unique` (`uuid`),
  ADD KEY `media_model_type_model_id_index` (`model_type`,`model_id`),
  ADD KEY `media_order_column_index` (`order_column`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  ADD KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  ADD KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `notifications_notifiable_type_notifiable_id_index` (`notifiable_type`,`notifiable_id`);

--
-- Indexes for table `pengisian_indikators`
--
ALTER TABLE `pengisian_indikators`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pengisian_indikators_assign_pengisian_id_foreign` (`assign_pengisian_id`),
  ADD KEY `pengisian_indikators_ui_isi_indikator_id_foreign` (`ui_isi_indikator_id`);

--
-- Indexes for table `periodes`
--
ALTER TABLE `periodes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `periodes_periode_kode_unique` (`periode_kode`),
  ADD KEY `periodes_validated_by_foreign` (`validated_by`),
  ADD KEY `periodes_created_by_foreign` (`created_by`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indexes for table `review_auditor1s`
--
ALTER TABLE `review_auditor1s`
  ADD PRIMARY KEY (`id`),
  ADD KEY `review_auditor1s_pengisian_indikators_id_foreign` (`pengisian_indikators_id`);

--
-- Indexes for table `review_auditor2s`
--
ALTER TABLE `review_auditor2s`
  ADD PRIMARY KEY (`id`),
  ADD KEY `review_auditor2s_pengisian_indikators_id_foreign` (`pengisian_indikators_id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indexes for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `role_has_permissions_role_id_foreign` (`role_id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `standars`
--
ALTER TABLE `standars`
  ADD PRIMARY KEY (`id`),
  ADD KEY `standars_validated_by_foreign` (`validated_by`),
  ADD KEY `standars_created_by_foreign` (`created_by`);

--
-- Indexes for table `sub_standars`
--
ALTER TABLE `sub_standars`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sub_standars_standar_id_foreign` (`standar_id`),
  ADD KEY `sub_standars_validated_by_foreign` (`validated_by`),
  ADD KEY `sub_standars_created_by_foreign` (`created_by`);

--
-- Indexes for table `units`
--
ALTER TABLE `units`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `units_kode_unit_unique` (`kode_unit`),
  ADD KEY `units_validated_by_foreign` (`validated_by`),
  ADD KEY `units_created_by_foreign` (`created_by`);

--
-- Indexes for table `unit_indikators`
--
ALTER TABLE `unit_indikators`
  ADD PRIMARY KEY (`id`),
  ADD KEY `unit_indikators_unit_id_foreign` (`unit_id`),
  ADD KEY `unit_indikators_auditee_foreign` (`auditee`),
  ADD KEY `unit_indikators_validator_1_id_foreign` (`validator_1_id`),
  ADD KEY `unit_indikators_created_by_foreign` (`created_by`),
  ADD KEY `unit_indikators_periode_id_foreign` (`periode_id`);

--
-- Indexes for table `unit_indikator_indikators`
--
ALTER TABLE `unit_indikator_indikators`
  ADD PRIMARY KEY (`id`),
  ADD KEY `unit_indikator_indikators_unit_indikator_standar_id_foreign` (`unit_indikator_standar_id`),
  ADD KEY `unit_indikator_indikators_indikator_id_foreign` (`indikator_id`);

--
-- Indexes for table `unit_indikator_isi_indikators`
--
ALTER TABLE `unit_indikator_isi_indikators`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_uii_id` (`unit_indikator_indikator_id`),
  ADD KEY `unit_indikator_isi_indikators_isi_indikator_id_foreign` (`isi_indikator_id`);

--
-- Indexes for table `unit_indikator_standars`
--
ALTER TABLE `unit_indikator_standars`
  ADD PRIMARY KEY (`id`),
  ADD KEY `unit_indikator_standars_unit_indikator_id_foreign` (`unit_indikator_id`),
  ADD KEY `unit_indikator_standars_standar_id_foreign` (`standar_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_nip_unique` (`nip`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD KEY `users_unit_id_foreign` (`unit_id`),
  ADD KEY `users_created_by_foreign` (`created_by`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `assign_pengisians`
--
ALTER TABLE `assign_pengisians`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `auditor_assignments`
--
ALTER TABLE `auditor_assignments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `exports`
--
ALTER TABLE `exports`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `failed_import_rows`
--
ALTER TABLE `failed_import_rows`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2299;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `imports`
--
ALTER TABLE `imports`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `indikators`
--
ALTER TABLE `indikators`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `isi_indikators`
--
ALTER TABLE `isi_indikators`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=144;

--
-- AUTO_INCREMENT for table `isi_standars`
--
ALTER TABLE `isi_standars`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `jadwal`
--
ALTER TABLE `jadwal`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=70;

--
-- AUTO_INCREMENT for table `jadwal_assignments`
--
ALTER TABLE `jadwal_assignments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=198;

--
-- AUTO_INCREMENT for table `jadwal_units`
--
ALTER TABLE `jadwal_units`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=772;

--
-- AUTO_INCREMENT for table `media`
--
ALTER TABLE `media`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `pengisian_indikators`
--
ALTER TABLE `pengisian_indikators`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=140;

--
-- AUTO_INCREMENT for table `periodes`
--
ALTER TABLE `periodes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=156;

--
-- AUTO_INCREMENT for table `review_auditor1s`
--
ALTER TABLE `review_auditor1s`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=142;

--
-- AUTO_INCREMENT for table `review_auditor2s`
--
ALTER TABLE `review_auditor2s`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=142;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `standars`
--
ALTER TABLE `standars`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=987654932;

--
-- AUTO_INCREMENT for table `sub_standars`
--
ALTER TABLE `sub_standars`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `units`
--
ALTER TABLE `units`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=72;

--
-- AUTO_INCREMENT for table `unit_indikators`
--
ALTER TABLE `unit_indikators`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `unit_indikator_indikators`
--
ALTER TABLE `unit_indikator_indikators`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `unit_indikator_isi_indikators`
--
ALTER TABLE `unit_indikator_isi_indikators`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=140;

--
-- AUTO_INCREMENT for table `unit_indikator_standars`
--
ALTER TABLE `unit_indikator_standars`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=987655065;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `assign_pengisians`
--
ALTER TABLE `assign_pengisians`
  ADD CONSTRAINT `assign_pengisians_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `assign_pengisians_periode_id_foreign` FOREIGN KEY (`periode_id`) REFERENCES `periodes` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `assign_pengisians_unit_indikator_id_foreign` FOREIGN KEY (`unit_indikator_id`) REFERENCES `unit_indikators` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `assign_pengisians_validated_by_foreign` FOREIGN KEY (`validated_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `auditor_assignments`
--
ALTER TABLE `auditor_assignments`
  ADD CONSTRAINT `auditor_assignments_assign_pengisian_id_foreign` FOREIGN KEY (`assign_pengisian_id`) REFERENCES `assign_pengisians` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `auditor_assignments_auditor1_foreign` FOREIGN KEY (`auditor1`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `auditor_assignments_auditor2_foreign` FOREIGN KEY (`auditor2`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `exports`
--
ALTER TABLE `exports`
  ADD CONSTRAINT `exports_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `failed_import_rows`
--
ALTER TABLE `failed_import_rows`
  ADD CONSTRAINT `failed_import_rows_import_id_foreign` FOREIGN KEY (`import_id`) REFERENCES `imports` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `imports`
--
ALTER TABLE `imports`
  ADD CONSTRAINT `imports_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `indikators`
--
ALTER TABLE `indikators`
  ADD CONSTRAINT `indikators_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `indikators_sub_standar_id_foreign` FOREIGN KEY (`sub_standar_id`) REFERENCES `sub_standars` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `indikators_validated_by_foreign` FOREIGN KEY (`validated_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `isi_indikators`
--
ALTER TABLE `isi_indikators`
  ADD CONSTRAINT `isi_indikators_indikator_id_foreign` FOREIGN KEY (`indikator_id`) REFERENCES `indikators` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `isi_standars`
--
ALTER TABLE `isi_standars`
  ADD CONSTRAINT `isi_standars_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `isi_standars_validated_by_foreign` FOREIGN KEY (`validated_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `jadwal`
--
ALTER TABLE `jadwal`
  ADD CONSTRAINT `jadwal_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `jadwal_periode_id_foreign` FOREIGN KEY (`periode_id`) REFERENCES `periodes` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `jadwal_validated_by_foreign` FOREIGN KEY (`validated_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `jadwal_assignments`
--
ALTER TABLE `jadwal_assignments`
  ADD CONSTRAINT `jadwal_assignments_jadwal_id_foreign` FOREIGN KEY (`jadwal_id`) REFERENCES `jadwal` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `jadwal_assignments_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `jadwal_units`
--
ALTER TABLE `jadwal_units`
  ADD CONSTRAINT `jadwal_units_jadwal_id_foreign` FOREIGN KEY (`jadwal_id`) REFERENCES `jadwal` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `jadwal_units_unit_id_foreign` FOREIGN KEY (`unit_id`) REFERENCES `units` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `pengisian_indikators`
--
ALTER TABLE `pengisian_indikators`
  ADD CONSTRAINT `pengisian_indikators_assign_pengisian_id_foreign` FOREIGN KEY (`assign_pengisian_id`) REFERENCES `assign_pengisians` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `pengisian_indikators_ui_isi_indikator_id_foreign` FOREIGN KEY (`ui_isi_indikator_id`) REFERENCES `unit_indikator_isi_indikators` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `periodes`
--
ALTER TABLE `periodes`
  ADD CONSTRAINT `periodes_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `periodes_validated_by_foreign` FOREIGN KEY (`validated_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `review_auditor1s`
--
ALTER TABLE `review_auditor1s`
  ADD CONSTRAINT `review_auditor1s_pengisian_indikators_id_foreign` FOREIGN KEY (`pengisian_indikators_id`) REFERENCES `pengisian_indikators` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `review_auditor2s`
--
ALTER TABLE `review_auditor2s`
  ADD CONSTRAINT `review_auditor2s_pengisian_indikators_id_foreign` FOREIGN KEY (`pengisian_indikators_id`) REFERENCES `pengisian_indikators` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `standars`
--
ALTER TABLE `standars`
  ADD CONSTRAINT `standars_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `standars_validated_by_foreign` FOREIGN KEY (`validated_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `sub_standars`
--
ALTER TABLE `sub_standars`
  ADD CONSTRAINT `sub_standars_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `sub_standars_standar_id_foreign` FOREIGN KEY (`standar_id`) REFERENCES `standars` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `sub_standars_validated_by_foreign` FOREIGN KEY (`validated_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `units`
--
ALTER TABLE `units`
  ADD CONSTRAINT `units_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `units_validated_by_foreign` FOREIGN KEY (`validated_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `unit_indikators`
--
ALTER TABLE `unit_indikators`
  ADD CONSTRAINT `unit_indikators_auditee_foreign` FOREIGN KEY (`auditee`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `unit_indikators_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `unit_indikators_periode_id_foreign` FOREIGN KEY (`periode_id`) REFERENCES `periodes` (`id`),
  ADD CONSTRAINT `unit_indikators_unit_id_foreign` FOREIGN KEY (`unit_id`) REFERENCES `units` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `unit_indikators_validator_1_id_foreign` FOREIGN KEY (`validator_1_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `unit_indikator_indikators`
--
ALTER TABLE `unit_indikator_indikators`
  ADD CONSTRAINT `unit_indikator_indikators_indikator_id_foreign` FOREIGN KEY (`indikator_id`) REFERENCES `indikators` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `unit_indikator_indikators_unit_indikator_standar_id_foreign` FOREIGN KEY (`unit_indikator_standar_id`) REFERENCES `unit_indikator_standars` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `unit_indikator_isi_indikators`
--
ALTER TABLE `unit_indikator_isi_indikators`
  ADD CONSTRAINT `fk_uii_id` FOREIGN KEY (`unit_indikator_indikator_id`) REFERENCES `unit_indikator_indikators` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `unit_indikator_isi_indikators_isi_indikator_id_foreign` FOREIGN KEY (`isi_indikator_id`) REFERENCES `isi_indikators` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `unit_indikator_standars`
--
ALTER TABLE `unit_indikator_standars`
  ADD CONSTRAINT `unit_indikator_standars_standar_id_foreign` FOREIGN KEY (`standar_id`) REFERENCES `standars` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `unit_indikator_standars_unit_indikator_id_foreign` FOREIGN KEY (`unit_indikator_id`) REFERENCES `unit_indikators` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `users_unit_id_foreign` FOREIGN KEY (`unit_id`) REFERENCES `units` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
