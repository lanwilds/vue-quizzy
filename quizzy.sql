-- phpMyAdmin SQL Dump
-- version 4.7.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jun 05, 2018 at 03:54 PM
-- Server version: 10.1.21-MariaDB
-- PHP Version: 7.1.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `quiz-draft`
--

-- --------------------------------------------------------

--
-- Table structure for table `choices`
--

CREATE TABLE `choices` (
  `id` int(10) UNSIGNED NOT NULL,
  `question_id` int(10) UNSIGNED NOT NULL,
  `right_choice` tinyint(1) NOT NULL,
  `choice` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `choices`
--

INSERT INTO `choices` (`id`, `question_id`, `right_choice`, `choice`, `created_at`, `updated_at`) VALUES
(46, 16, 0, 'song', '2018-05-28 11:28:20', '2018-05-28 11:28:20'),
(47, 16, 0, 'sound', '2018-05-28 11:28:20', '2018-05-28 11:28:20'),
(48, 16, 1, 'both', '2018-05-28 11:28:20', '2018-05-28 11:28:20'),
(49, 17, 0, 'music', '2018-05-28 11:28:20', '2018-05-28 11:28:20'),
(50, 17, 0, 'none', '2018-05-28 11:28:20', '2018-05-28 11:28:20'),
(51, 17, 1, 'both', '2018-05-28 11:28:21', '2018-05-28 11:28:21'),
(52, 18, 0, 'test', '2018-05-28 11:28:21', '2018-05-28 11:28:21'),
(53, 18, 1, 'quest', '2018-05-28 11:28:21', '2018-05-28 11:28:21'),
(54, 18, 0, 'just', '2018-05-28 11:28:21', '2018-05-28 11:28:21'),
(55, 19, 1, 'server side', '2018-05-28 11:28:21', '2018-05-28 11:28:21'),
(56, 19, 0, 'client side', '2018-05-28 11:28:21', '2018-05-28 11:28:21'),
(57, 19, 0, 'both', '2018-05-28 11:28:21', '2018-05-28 11:28:21'),
(58, 20, 1, 'client side', '2018-05-28 11:28:21', '2018-05-28 11:28:21'),
(59, 20, 0, 'server side', '2018-05-28 11:28:21', '2018-05-28 11:28:21'),
(60, 20, 0, 'both', '2018-05-28 11:28:21', '2018-05-28 11:28:21'),
(61, 21, 0, 'view', '2018-05-28 11:28:21', '2018-05-28 11:28:21'),
(62, 21, 1, 'javascript library', '2018-05-28 11:28:21', '2018-05-28 11:28:21'),
(63, 21, 0, 'java library', '2018-05-28 11:28:22', '2018-05-28 11:28:22'),
(64, 22, 0, 'java', '2018-05-28 11:28:22', '2018-05-28 11:28:22'),
(65, 22, 1, 'javascript library', '2018-05-28 11:28:22', '2018-05-28 11:28:22'),
(66, 22, 0, 'GOogle', '2018-05-28 11:28:22', '2018-05-28 11:28:22'),
(67, 23, 0, 'java', '2018-05-28 11:28:22', '2018-05-28 11:28:22'),
(68, 23, 1, 'javascript library', '2018-05-28 11:28:22', '2018-05-28 11:28:22'),
(69, 23, 0, 'none', '2018-05-28 11:28:22', '2018-05-28 11:28:22'),
(70, 24, 0, 'kickout', '2018-05-28 11:28:22', '2018-05-28 11:28:22'),
(71, 24, 1, 'javascript library', '2018-05-28 11:28:22', '2018-05-28 11:28:22'),
(72, 24, 0, 'none', '2018-05-28 11:28:22', '2018-05-28 11:28:22'),
(73, 25, 0, 'server side', '2018-05-28 11:28:22', '2018-05-28 11:28:22'),
(74, 25, 0, 'none', '2018-05-28 11:28:22', '2018-05-28 11:28:22'),
(75, 25, 1, 'javascript library', '2018-05-28 11:28:22', '2018-05-28 11:28:22'),
(76, 26, 1, 'PHP library', '2018-05-28 11:28:22', '2018-05-28 11:28:22'),
(77, 26, 0, 'none', '2018-05-28 11:28:22', '2018-05-28 11:28:22'),
(78, 26, 0, 'java library', '2018-05-28 11:28:22', '2018-05-28 11:28:22'),
(79, 27, 0, 'python', '2018-05-28 11:28:22', '2018-05-28 11:28:22'),
(80, 27, 0, 'none', '2018-05-28 11:28:22', '2018-05-28 11:28:22'),
(81, 27, 1, 'PHP library', '2018-05-28 11:28:22', '2018-05-28 11:28:22'),
(82, 28, 0, 'PHP library', '2018-05-28 11:28:23', '2018-05-28 11:28:23'),
(83, 28, 0, 'java library', '2018-05-28 11:28:23', '2018-05-28 11:28:23'),
(84, 28, 1, 'python library', '2018-05-28 11:28:23', '2018-05-28 11:28:23'),
(85, 29, 0, 'IDE', '2018-05-28 11:28:23', '2018-05-28 11:28:23'),
(86, 29, 0, 'Text editor', '2018-05-28 11:28:23', '2018-05-28 11:28:23'),
(87, 29, 1, 'java IDE', '2018-05-28 11:28:23', '2018-05-28 11:28:23'),
(88, 30, 1, 'Scott lang', '2018-05-31 04:53:35', '2018-05-31 04:53:35'),
(89, 30, 0, 'Chriss lynn', '2018-05-31 04:53:36', '2018-05-31 04:53:36'),
(90, 30, 0, 'scott miller', '2018-05-31 04:53:36', '2018-05-31 04:53:36'),
(91, 31, 0, 'WB', '2018-05-31 04:53:36', '2018-05-31 04:53:36'),
(92, 31, 1, 'Marvel', '2018-05-31 04:53:36', '2018-05-31 04:53:36'),
(93, 31, 0, 'Disney', '2018-05-31 04:53:36', '2018-05-31 04:53:36');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2018_05_17_152430_create_quizzes_table', 1),
(4, '2018_05_17_152348_create_questions_table', 2),
(6, '2018_05_17_152411_create_choices_table', 3);

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `questions`
--

CREATE TABLE `questions` (
  `id` int(10) UNSIGNED NOT NULL,
  `question` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(1) NOT NULL,
  `quiz_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `questions`
--

INSERT INTO `questions` (`id`, `question`, `status`, `quiz_id`, `user_id`, `created_at`, `updated_at`) VALUES
(16, 'What is music?', 1, 9, 2, '2018-05-28 11:28:20', '2018-05-28 11:28:20'),
(17, 'What is sound?', 1, 9, 2, '2018-05-28 11:28:20', '2018-05-28 11:28:20'),
(18, 'Something test quest', 1, 9, 2, '2018-05-28 11:28:21', '2018-05-28 11:28:21'),
(19, 'PHP is', 1, 9, 2, '2018-05-28 11:28:21', '2018-05-28 11:28:21'),
(20, 'Javascript is', 1, 9, 2, '2018-05-28 11:28:21', '2018-05-28 11:28:21'),
(21, 'Vue JS is', 1, 9, 2, '2018-05-28 11:28:21', '2018-05-28 11:28:21'),
(22, 'Angular is', 1, 9, 2, '2018-05-28 11:28:22', '2018-05-28 11:28:22'),
(23, 'Ember JS is', 1, 9, 2, '2018-05-28 11:28:22', '2018-05-28 11:28:22'),
(24, 'knockout is', 1, 9, 2, '2018-05-28 11:28:22', '2018-05-28 11:28:22'),
(25, 'Socket IO', 1, 9, 2, '2018-05-28 11:28:22', '2018-05-28 11:28:22'),
(26, 'Laravel is', 1, 9, 2, '2018-05-28 11:28:22', '2018-05-28 11:28:22'),
(27, 'SLim 3 is', 1, 9, 2, '2018-05-28 11:28:22', '2018-05-28 11:28:22'),
(28, 'Django is', 1, 9, 2, '2018-05-28 11:28:22', '2018-05-28 11:28:22'),
(29, 'Eclipse is', 1, 9, 2, '2018-05-28 11:28:23', '2018-05-28 11:28:23'),
(30, 'Who is antman?', 1, 10, 1, '2018-05-31 04:53:35', '2018-05-31 04:53:35'),
(31, 'Creator of AntMan?', 1, 10, 1, '2018-05-31 04:53:36', '2018-05-31 04:53:36');

-- --------------------------------------------------------

--
-- Table structure for table `quizzes`
--

CREATE TABLE `quizzes` (
  `id` int(10) UNSIGNED NOT NULL,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `time_period` int(15) NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `quizzes`
--

INSERT INTO `quizzes` (`id`, `title`, `time_period`, `user_id`, `created_at`, `updated_at`) VALUES
(9, 'Programming Quiz', 60, 2, '2018-05-28 11:28:20', '2018-05-28 11:28:20'),
(10, 'Ant Quiz', 1, 1, '2018-05-31 04:53:35', '2018-05-31 04:53:35');

-- --------------------------------------------------------

--
-- Table structure for table `scores`
--

CREATE TABLE `scores` (
  `id` int(10) UNSIGNED NOT NULL,
  `score` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `quiz_id` int(10) NOT NULL,
  `attempt` int(11) NOT NULL,
  `time` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(10) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `scores`
--

INSERT INTO `scores` (`id`, `score`, `quiz_id`, `attempt`, `time`, `user_id`, `created_at`, `updated_at`) VALUES
(28, '8', 9, 1, '59:38', 2, '2018-05-28 20:35:23', '2018-05-28 20:35:23'),
(29, '5', 9, 1, '59:34', 1, '2018-05-28 22:23:23', '2018-05-28 22:23:23'),
(30, '5', 9, 2, '59:45', 1, '2018-05-28 22:33:08', '2018-05-28 22:33:08'),
(31, '1', 10, 1, '59:53', 1, '2018-06-01 04:23:49', '2018-06-01 04:23:49'),
(32, '0', 10, 2, '59:54', 1, '2018-06-01 04:25:11', '2018-06-01 04:25:11'),
(33, '0', 10, 3, '0:56', 1, '2018-06-01 04:25:41', '2018-06-01 04:25:41'),
(34, '0', 10, 4, '0:56', 1, '2018-06-05 08:04:37', '2018-06-05 08:04:37');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` enum('admin','normal') COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `role`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Hacker', 'lanwil@quizzy.com', '$2y$10$MMSueuptfXNU0NIfAthuT.oNsLlL8/f8T/zqR6Say/IAqzaezt5Ke', 'admin', NULL, '2018-05-24 21:22:33', '2018-06-05 08:04:54'),
(2, 'John Doe', 'jdoe@gmail.com', '$2y$10$zqBEp9M8Jk93nLIubcaHHepbWbiGOrN.8/sJ7TFGtUWLAUMA6TnuC', 'normal', NULL, '2018-05-24 21:26:23', '2018-05-25 00:34:44');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `choices`
--
ALTER TABLE `choices`
  ADD PRIMARY KEY (`id`),
  ADD KEY `choices_question_id_foreign` (`question_id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `questions`
--
ALTER TABLE `questions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `questions_user_id_foreign` (`user_id`),
  ADD KEY `questions_quiz_id_foreign` (`quiz_id`);

--
-- Indexes for table `quizzes`
--
ALTER TABLE `quizzes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `quizzes_user_id_foreign` (`user_id`);

--
-- Indexes for table `scores`
--
ALTER TABLE `scores`
  ADD PRIMARY KEY (`id`),
  ADD KEY `quiz_id` (`quiz_id`),
  ADD KEY `user_id` (`user_id`);

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
-- AUTO_INCREMENT for table `choices`
--
ALTER TABLE `choices`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=94;
--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `questions`
--
ALTER TABLE `questions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;
--
-- AUTO_INCREMENT for table `quizzes`
--
ALTER TABLE `quizzes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT for table `scores`
--
ALTER TABLE `scores`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `choices`
--
ALTER TABLE `choices`
  ADD CONSTRAINT `choices_question_id_foreign` FOREIGN KEY (`question_id`) REFERENCES `questions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `questions`
--
ALTER TABLE `questions`
  ADD CONSTRAINT `questions_quiz_id_foreign` FOREIGN KEY (`quiz_id`) REFERENCES `quizzes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `questions_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `quizzes`
--
ALTER TABLE `quizzes`
  ADD CONSTRAINT `quizzes_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
