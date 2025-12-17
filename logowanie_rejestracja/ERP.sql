-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Dec 15, 2025 at 07:45 PM
-- Wersja serwera: 10.4.28-MariaDB
-- Wersja PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ERP`
--

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `invoices`
--

CREATE TABLE `invoices` (
  `invoice_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `invoice_number` varchar(50) NOT NULL,
  `issue_date` date NOT NULL,
  `sale_date` date DEFAULT NULL,
  `seller_name` varchar(255) NOT NULL,
  `seller_address` varchar(255) NOT NULL,
  `buyer_name` varchar(255) NOT NULL,
  `buyer_address` varchar(255) NOT NULL,
  `total_net` decimal(10,2) NOT NULL,
  `total_vat` decimal(10,2) NOT NULL,
  `total_gross` decimal(10,2) NOT NULL,
  `payment_method` varchar(50) NOT NULL,
  `due_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `invoices`
--

INSERT INTO `invoices` (`invoice_id`, `user_id`, `invoice_number`, `issue_date`, `sale_date`, `seller_name`, `seller_address`, `buyer_name`, `buyer_address`, `total_net`, `total_vat`, `total_gross`, `payment_method`, `due_date`) VALUES
(1, 1, 'FV/2025/001', '2025-01-10', '2025-01-10', 'ACME Ltd.', 'ul. Przykładowa 1, 00-001 Warszawa', 'John Doe', 'ul. Klienta 10, 00-002 Warszawa', 3100.00, 713.00, 3813.00, 'Transfer', '2025-01-24'),
(2, 2, 'FV/2025/002', '2025-01-11', '2025-01-11', 'ACME Ltd.', 'ul. Przykładowa 1, 00-001 Warszawa', 'Jane Smith', 'ul. Klienta 20, 00-003 Warszawa', 2000.00, 460.00, 2460.00, 'Cash', '2025-01-25');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `invoice_items`
--

CREATE TABLE `invoice_items` (
  `item_id` int(11) NOT NULL,
  `invoice_id` int(11) NOT NULL,
  `item_name` varchar(255) NOT NULL,
  `quantity` decimal(10,2) NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `vat_rate` decimal(5,2) DEFAULT NULL,
  `net_amount` decimal(10,2) DEFAULT NULL,
  `vat_amount` decimal(10,2) DEFAULT NULL,
  `gross_amount` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `invoice_items`
--

INSERT INTO `invoice_items` (`item_id`, `invoice_id`, `item_name`, `quantity`, `unit_price`, `vat_rate`, `net_amount`, `vat_amount`, `gross_amount`) VALUES
(1, 1, 'Laptop', 1.00, 3000.00, 23.00, 3000.00, 690.00, 3690.00),
(2, 1, 'Mouse', 2.00, 50.00, 23.00, 100.00, 23.00, 123.00),
(3, 2, 'Website development', 1.00, 2000.00, 23.00, 2000.00, 460.00, 2460.00);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `role` varchar(20) DEFAULT 'user',
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `username`, `email`, `password_hash`, `role`, `created_at`) VALUES
(1, 'admin', 'admin@example.com', 'hashed_pass_123', 'admin', '2025-12-15 19:44:52'),
(2, 'john', 'john@example.com', 'hashed_pass_456', 'user', '2025-12-15 19:44:52');

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `invoices`
--
ALTER TABLE `invoices`
  ADD PRIMARY KEY (`invoice_id`),
  ADD KEY `fk_user` (`user_id`);

--
-- Indeksy dla tabeli `invoice_items`
--
ALTER TABLE `invoice_items`
  ADD PRIMARY KEY (`item_id`),
  ADD KEY `fk_invoice` (`invoice_id`);

--
-- Indeksy dla tabeli `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `invoices`
--
ALTER TABLE `invoices`
  MODIFY `invoice_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `invoice_items`
--
ALTER TABLE `invoice_items`
  MODIFY `item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `invoices`
--
ALTER TABLE `invoices`
  ADD CONSTRAINT `fk_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `invoice_items`
--
ALTER TABLE `invoice_items`
  ADD CONSTRAINT `fk_invoice` FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`invoice_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
