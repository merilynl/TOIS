-- phpMyAdmin SQL Dump
-- version 5.2.0-1.el9
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jun 20, 2023 at 12:26 PM
-- Server version: 10.5.16-MariaDB
-- PHP Version: 8.0.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `if22_TOIS_toolaud`
--

-- --------------------------------------------------------

--
-- Table structure for table `Arve`
--

CREATE TABLE `Arve` (
  `ID` int(11) NOT NULL,
  `Arve_number` varchar(100) COLLATE utf8mb4_estonian_ci NOT NULL,
  `Maksumus` varchar(100) COLLATE utf8mb4_estonian_ci NOT NULL,
  `Koostaja` varchar(100) COLLATE utf8mb4_estonian_ci NOT NULL,
  `Koostamise_kuupaev` date NOT NULL,
  `Maksetahtaeg` date NOT NULL,
  `Staatus` varchar(100) COLLATE utf8mb4_estonian_ci NOT NULL,
  `Opilane_ID` int(11) NOT NULL,
  `Kursus_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_estonian_ci;

--
-- Dumping data for table `Arve`
--

INSERT INTO `Arve` (`ID`, `Arve_number`, `Maksumus`, `Koostaja`, `Koostamise_kuupaev`, `Maksetahtaeg`, `Staatus`, `Opilane_ID`, `Kursus_ID`) VALUES
(1, '12345678', '154€', 'Kersti Maidra', '2023-06-11', '2023-06-13', 'Maksmata', 1, 1),
(2, '1239678', '233€', 'Kersti Maidra', '2022-06-14', '2022-06-15', 'Makstud', 1, 7),
(3, '18394728', '110€', 'Kersti Maidra', '2023-05-10', '2023-05-13', 'Maksmata', 2, 1),
(4, '182930473', '90€', 'Kersti Maidra', '2023-06-02', '2023-06-13', 'Makstud', 3, 5),
(5, '29303728', '175€', 'Kersti Maidra', '2023-05-05', '2023-05-17', 'Makstud', 4, 8),
(6, '84927364', '242€', 'Kersti Maidra', '2023-05-25', '2023-06-13', 'Maksmata', 5, 1),
(7, '74282937', '133€', 'Kersti Maidra', '2023-05-22', '2023-06-11', 'Makstud', 6, 11),
(8, '38293472', '115€', 'Kersti Maidra', '2023-05-30', '2023-06-13', 'Maksmata', 7, 1),
(9, '12837283', '188€', 'Kersti Maidra', '2023-06-07', '2023-06-13', 'Makstud', 8, 5),
(10, '12384736', '79€', 'Kersti Maidra', '2023-05-15', '2023-06-10', 'Makstud', 9, 3),
(11, '177869072', '225€', 'Kersti Maidra', '2023-05-03', '2023-05-13', 'Maksmata', 8, 1),
(12, '90382744', '120€', 'Kersti Maidra', '2023-06-08', '2023-06-23', 'Makstud', 14, 10),
(13, '09384838', '120€', 'Kersti Maidra', '2023-06-14', '2023-05-23', 'Maksmata', 12, 10),
(14, '9928372633', '202€', 'Kersti Maidra', '2023-05-17', '2023-06-01', 'Maksmata', 15, 5),
(15, '27388261', '86€', 'Kersti Maidra', '2023-05-15', '2023-06-21', 'Maksmata', 11, 11),
(16, '38827264', '130€', 'Kersti Maidra', '2023-05-30', '2023-06-08', 'Maksmata', 10, 8),
(17, '299384473', '99€', 'Kersti Maidra', '2023-06-01', '2023-06-16', 'Makstud', 6, 3),
(18, '27738293', '140€', 'Kersti Maidra', '2023-05-19', '2023-06-07', 'Makstud', 5, 16),
(19, '38827299', '100€', 'Kersti Maidra', '2023-05-24', '2023-06-05', 'Maksmata', 1, 15),
(20, '33939477', '111€', 'Kersti Maidra', '2023-05-19', '2023-06-08', 'Maksmata', 12, 18);

-- --------------------------------------------------------

--
-- Table structure for table `Kasutajakonto`
--

CREATE TABLE `Kasutajakonto` (
  `ID` int(11) NOT NULL,
  `Kasutajanimi` varchar(100) COLLATE utf8mb4_estonian_ci NOT NULL,
  `Parool_hash` varchar(100) COLLATE utf8mb4_estonian_ci NOT NULL,
  `Loomise_aeg` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_estonian_ci;

--
-- Dumping data for table `Kasutajakonto`
--

INSERT INTO `Kasutajakonto` (`ID`, `Kasutajanimi`, `Parool_hash`, `Loomise_aeg`) VALUES
(1, 'kleenmaa', '$2y$10$E1rfz5Mr6vzcDCxdfRy.Ke0he3sSAi7eDnAxUzo3/eBvcaq5wgPuy', '2023-06-08 10:24:00'),
(2, 'test', '$2y$10$iaxv5noYSfLNGOCDYnVXGeFzsC9E41fyL5ifJfjmr8p/1zQYUqn9i', '2023-06-09 12:56:42');

-- --------------------------------------------------------

--
-- Table structure for table `Kursus`
--

CREATE TABLE `Kursus` (
  `ID` int(11) NOT NULL,
  `Nimetus` varchar(100) COLLATE utf8mb4_estonian_ci NOT NULL,
  `Kursuse_kood` varchar(100) COLLATE utf8mb4_estonian_ci NOT NULL,
  `Alguse_aeg` date NOT NULL,
  `Loppemise_aeg` date NOT NULL,
  `Hind` varchar(100) COLLATE utf8mb4_estonian_ci NOT NULL,
  `Teenus_ID` int(11) NOT NULL,
  `Oppejoud_ID` int(11) NOT NULL,
  `Oppekava_ID` int(11) NOT NULL,
  `MAX_osalejad` int(11) NOT NULL,
  `Koostaja` varchar(100) COLLATE utf8mb4_estonian_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_estonian_ci;

--
-- Dumping data for table `Kursus`
--

INSERT INTO `Kursus` (`ID`, `Nimetus`, `Kursuse_kood`, `Alguse_aeg`, `Loppemise_aeg`, `Hind`, `Teenus_ID`, `Oppejoud_ID`, `Oppekava_ID`, `MAX_osalejad`, `Koostaja`) VALUES
(1, 'Digitaalne õpiamps:Canva keskkond', 'DTC0160', '2023-06-13', '2023-06-30', '300€', 1, 1, 1, 5, 'Kersti Maidra'),
(2, '3D modelleerimine algajatele', 'DTC9283', '2023-07-03', '2023-07-12', '250€', 1, 1, 1, 15, 'Kersti Maidra'),
(3, 'Andmeanalüüs MS Excel baasil', 'DTC0287', '2023-06-12', '2023-06-16', '120€', 1, 1, 1, 35, 'Kersti Maidra'),
(4, 'Pilvepõhine tekstitöötlus algajatele', 'DTC0273', '2023-08-02', '2023-08-08', '170€', 1, 1, 1, 22, 'Kersti Maidra'),
(5, 'MS Office Word algajatele', 'DTC0937', '2023-06-13', '2023-06-20', '95€', 1, 1, 1, 25, 'Kersti Maidra'),
(6, 'Andmebaasi päringukeele SQL kasutamine', 'DTC8392', '2023-07-03', '2023-07-14', '230€', 1, 1, 1, 15, 'Kersti Maidra'),
(7, 'Sissejuhatus teksti- ja tabelitöötlusesse', 'DTC6729', '2023-06-14', '2023-06-21', '187€', 1, 1, 1, 10, 'Kersti Maidra'),
(8, 'Google Drive keskkonna kasutamine kontoritöös', 'DTC4829', '2023-06-17', '2023-07-12', '320€', 1, 1, 1, 30, 'Kersti Maidra'),
(9, 'Digiturundus väikeettevõtjale', 'DTC2839', '2023-07-10', '2023-07-24', '460€', 1, 1, 1, 20, 'Kersti Maidra'),
(10, 'Dokumentide vormistamine arvutis', 'DTC5839', '2023-06-19', '2023-06-23', '99€', 1, 1, 1, 20, 'Tiina Tikker'),
(11, 'Digioskuste alused', 'DTC8327', '2023-06-11', '2023-06-30', '100€', 1, 2, 1, 17, 'Kersti Maidra'),
(12, 'Bürootöötajate digioskused', 'DTC1293', '2023-06-04', '2023-06-14', '120€', 1, 3, 1, 19, 'Kersti Maidra'),
(13, 'Arvuti- ja nutiseadme kasutuse algõpe', 'DTC1128', '2023-06-26', '2023-07-10', '99€', 1, 4, 1, 25, 'Kersti Maidra'),
(14, 'Arvutipõhine menüüde ja kalkulatsiooni koostamine', 'DTC2981', '2023-06-07', '2023-06-14', '170€', 1, 5, 1, 40, 'Kersti Maidra'),
(15, 'Noorte juhendamine', 'DTC2525/2', '2023-06-01', '2023-06-08', '225€', 1, 1, 2, 20, 'Kersti Maidra'),
(16, 'Digitarkus algkursus', 'DTC0101', '2023-06-04', '2023-06-07', '89€', 1, 5, 5, 15, 'Kersti Maidra'),
(17, 'Teadmisi Hiina toidukultuurist', 'DTC0012/7', '2023-06-09', '2023-06-06', '100€', 1, 4, 5, 10, 'Kersti Maidra'),
(18, 'BE- kategooria mootorsõidukijuhi õpetaja erikursus', 'DTC0208/1', '2023-05-30', '2023-06-08', '92€', 1, 5, 1, 30, 'Kersti Maidra'),
(19, 'Kübertarkus', 'DTC5552', '2023-06-05', '2023-06-06', '110€', 1, 2, 5, 5, 'Kersti Maidra');

-- --------------------------------------------------------

--
-- Table structure for table `Opilane`
--

CREATE TABLE `Opilane` (
  `ID` int(11) NOT NULL,
  `Nimi` varchar(100) COLLATE utf8mb4_estonian_ci NOT NULL,
  `Sunniaeg` date NOT NULL,
  `Sugu` varchar(100) COLLATE utf8mb4_estonian_ci NOT NULL,
  `Aadress` varchar(100) COLLATE utf8mb4_estonian_ci NOT NULL,
  `Telefon` varchar(100) COLLATE utf8mb4_estonian_ci NOT NULL,
  `Email` varchar(100) COLLATE utf8mb4_estonian_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_estonian_ci;

--
-- Dumping data for table `Opilane`
--

INSERT INTO `Opilane` (`ID`, `Nimi`, `Sunniaeg`, `Sugu`, `Aadress`, `Telefon`, `Email`) VALUES
(1, 'Kerli Loop', '2000-05-04', 'Naine', 'Oksa 6, Keila, 123456', '+372 55467432', 'kerli.loop@gmail.com'),
(2, 'Maali Mets', '1998-03-21', 'Naine', 'Metsa 2, Paide, 22332', '+372 53728392', 'maali.mets@mail.ee'),
(3, 'Raul Raud', '1980-09-12', 'Mees', 'Karja 3, Lihula, 30229', '+372 56839201', 'raul.raud@mail.ee'),
(4, 'Kalle Kauss', '1999-07-22', 'Mees', 'Mai 3, Tartu, 33339', '+372 58392093', 'kalle.kauss@mail.ee'),
(5, 'Kaie Tall', '2001-04-29', 'Naine', 'Siili 4, Tallinn, 00329', '+372 58390398', 'kaie.tall@gmail.com'),
(6, 'Meribel Triik', '1997-11-19', 'Naine', 'Savi 11, Võru, 39201', '+372 53928376', 'merib.trii@gmail.com'),
(7, 'Siim Simonen', '1978-12-23', 'Mees', 'Tähe 8, Tallinn, 29210', '+372 53492837', 'siim.simonen@hotmail.ee'),
(8, 'Tiia Kruus', '1994-08-25', 'Naine', 'Kerava 89, Põltsamaa, 39084', '+372 58029387', 'tiia.kruus@yahoo.ee'),
(9, 'Marina Kall', '2001-02-11', 'Naine', 'Ravi 8, Paide, 21897', '+372 56829374', 'marina.kall@gmail.com'),
(10, 'Oliver Oks', '2000-01-27', 'Mees', 'Kauba 3, Rapla, 33829', '+372 56728394', 'oliver.oks@gmail.com'),
(11, 'Kiki Miki', '2000-07-01', 'Naine', 'Pikk tänav 17, Tallinn, 12234', '+372 54901234', 'kikimiki@gmail.com'),
(12, 'Milvi Sai', '1984-06-07', 'Naine', 'Liiva 1, Salme, Saaremaa', '+372 53980076', 'milvisai@hot.ee'),
(13, 'Andrus Viira', '2001-03-15', 'Mees', 'Majaka põik 18, Tallinn, 19908', '+372 5487690', 'andrus.viira@hotmail.com'),
(14, 'Mihkel Uim', '1997-02-01', 'Mees', 'Vilde tee 198, Tallinn, 12349', '+372 5112278', 'mihkeluim@gmail.com'),
(15, 'Jaana Karu', '2020-10-27', 'Naine', 'Pikri 54, Tallinn, 19008', '+372 59073466', 'jaanakaru@tlu.ee');

-- --------------------------------------------------------

--
-- Table structure for table `Opilane_kursus`
--

CREATE TABLE `Opilane_kursus` (
  `ID` int(11) NOT NULL,
  `Kursus_ID` int(11) NOT NULL,
  `Opilane_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_estonian_ci;

--
-- Dumping data for table `Opilane_kursus`
--

INSERT INTO `Opilane_kursus` (`ID`, `Kursus_ID`, `Opilane_ID`) VALUES
(1, 1, 1),
(2, 6, 2),
(3, 4, 8),
(4, 2, 7),
(5, 3, 10),
(6, 10, 3),
(7, 7, 6),
(8, 3, 9),
(9, 5, 4),
(10, 9, 5),
(11, 1, 3),
(12, 2, 3),
(13, 11, 3),
(14, 12, 3),
(15, 6, 4),
(16, 14, 4),
(17, 13, 3),
(18, 14, 3),
(19, 13, 4),
(20, 12, 4),
(21, 15, 5),
(22, 19, 1),
(23, 19, 2),
(24, 17, 4),
(25, 17, 6),
(26, 17, 3),
(27, 17, 1),
(28, 17, 10),
(29, 17, 5),
(30, 17, 7),
(31, 19, 3),
(32, 19, 4),
(33, 19, 5),
(34, 1, 6),
(35, 1, 7),
(36, 1, 4),
(37, 15, 11),
(38, 15, 12),
(39, 15, 13),
(40, 15, 14),
(41, 15, 15),
(42, 16, 3),
(43, 16, 1),
(44, 16, 2),
(45, 16, 13),
(46, 16, 9),
(47, 18, 1),
(48, 18, 2),
(49, 18, 3),
(50, 18, 4),
(51, 18, 5),
(53, 18, 6),
(54, 18, 7),
(55, 18, 8),
(56, 18, 9),
(57, 18, 10),
(58, 18, 11),
(59, 18, 12),
(60, 18, 13),
(61, 18, 14),
(62, 18, 15),
(63, 5, 6),
(64, 5, 7),
(65, 5, 15),
(66, 7, 1),
(67, 15, 1),
(68, 1, 2),
(69, 5, 3),
(70, 8, 4),
(71, 1, 5),
(72, 16, 5),
(73, 11, 6),
(74, 3, 6),
(75, 5, 11),
(76, 1, 8),
(77, 8, 10),
(78, 11, 11),
(79, 10, 12),
(80, 10, 14),
(81, 5, 1),
(82, 5, 2),
(83, 5, 5),
(84, 5, 8);

-- --------------------------------------------------------

--
-- Table structure for table `Oppejoud`
--

CREATE TABLE `Oppejoud` (
  `ID` int(11) NOT NULL,
  `Nimi` varchar(100) COLLATE utf8mb4_estonian_ci NOT NULL,
  `Sunniaeg` date NOT NULL,
  `Sugu` varchar(100) COLLATE utf8mb4_estonian_ci NOT NULL,
  `Aadress` varchar(100) COLLATE utf8mb4_estonian_ci NOT NULL,
  `Telefon` varchar(100) COLLATE utf8mb4_estonian_ci NOT NULL,
  `Email` varchar(100) COLLATE utf8mb4_estonian_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_estonian_ci;

--
-- Dumping data for table `Oppejoud`
--

INSERT INTO `Oppejoud` (`ID`, `Nimi`, `Sunniaeg`, `Sugu`, `Aadress`, `Telefon`, `Email`) VALUES
(1, 'Peeter Paan', '1968-09-24', 'Mees', 'Asunduse 6, Tallinn, 155555', '+372 55445467', 'peeter.paan@tlu.ee'),
(2, 'Jaana Jaam', '1970-05-13', 'Naine', 'Majaka 5, Keila, Harju, 39482', '+372 57382938', 'jaana.jaam@tlu.ee'),
(3, 'Kaarel Mets', '1977-09-03', 'Mees', 'Uus 5, Rapla, 64536', '+372 56039872', 'kaarel.mets@tlu.ee'),
(4, 'Kristel Oks', '1987-02-02', 'Naine', 'Viive 3, Tartu, 32473', '+372 55837263', 'kristel.oks@tlu.ee'),
(5, 'Jaan Karu', '1988-12-25', 'Mees', 'Aia 11, Tallinn, 23492', '+372 58938263', 'jaan.karu@tlu.ee'),
(6, 'Tiia Lepp', '1971-03-23', 'Naine', 'Metsa 8a, Nõmme, 38204', '+372 39472930', 'tiia.lepp@tlu.ee'),
(7, 'Rauno Hell', '1995-07-16', 'Mees', 'Oksa 17, Kohila, 22935', '+372 59922639', 'Rauno.hell@tlu.ee');

-- --------------------------------------------------------

--
-- Table structure for table `Oppekava`
--

CREATE TABLE `Oppekava` (
  `ID` int(11) NOT NULL,
  `Nimetus` varchar(100) COLLATE utf8mb4_estonian_ci NOT NULL,
  `Oppekava_kood` varchar(100) COLLATE utf8mb4_estonian_ci NOT NULL,
  `Koostaja` varchar(100) COLLATE utf8mb4_estonian_ci NOT NULL,
  `Sisestamise_kuupaev` date NOT NULL,
  `Staatus` varchar(100) COLLATE utf8mb4_estonian_ci NOT NULL,
  `Teenus_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_estonian_ci;

--
-- Dumping data for table `Oppekava`
--

INSERT INTO `Oppekava` (`ID`, `Nimetus`, `Oppekava_kood`, `Koostaja`, `Sisestamise_kuupaev`, `Staatus`, `Teenus_ID`) VALUES
(1, 'Digitaalne Õpiamps', 'DTC0025', 'Kersti Maidra', '2022-12-12', 'Lukustatud', 1),
(2, 'Noorteprojekti koostamine', 'DTC0026', 'Kersti Maidra', '2023-05-01', 'Lukustatud', 1),
(3, 'MS Office Excel algajale', 'DTC2993', 'Kersti Maidra', '2023-06-07', 'Sisestamisel', 1),
(4, 'Tööalased digioskused', 'DTC7382', 'Kersti Maidra', '2023-06-05', 'Kinnitamisel', 1),
(5, 'DigiTarkus', 'DTC2224', 'Kersti Maidra', '2023-05-24', 'Lukustatud', 1);

-- --------------------------------------------------------

--
-- Table structure for table `Peakasutaja`
--

CREATE TABLE `Peakasutaja` (
  `ID` int(11) NOT NULL,
  `Nimi` varchar(100) COLLATE utf8mb4_estonian_ci NOT NULL,
  `Sunniaeg` date NOT NULL,
  `Sugu` varchar(100) COLLATE utf8mb4_estonian_ci NOT NULL,
  `Aadress` varchar(100) COLLATE utf8mb4_estonian_ci NOT NULL,
  `Telefon` varchar(100) COLLATE utf8mb4_estonian_ci NOT NULL,
  `Email` varchar(100) COLLATE utf8mb4_estonian_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_estonian_ci;

--
-- Dumping data for table `Peakasutaja`
--

INSERT INTO `Peakasutaja` (`ID`, `Nimi`, `Sunniaeg`, `Sugu`, `Aadress`, `Telefon`, `Email`) VALUES
(1, 'Malle Kivi', '1983-07-24', 'Naine', 'Liivaoja 4', '56619456', 'malle@tlu.ee');

-- --------------------------------------------------------

--
-- Table structure for table `Taienduskoolituse_juht`
--

CREATE TABLE `Taienduskoolituse_juht` (
  `ID` int(11) NOT NULL,
  `Nimi` varchar(100) COLLATE utf8mb4_estonian_ci NOT NULL,
  `Sunniaeg` date NOT NULL,
  `Sugu` varchar(100) COLLATE utf8mb4_estonian_ci NOT NULL,
  `Aadress` varchar(100) COLLATE utf8mb4_estonian_ci NOT NULL,
  `Telefon` varchar(100) COLLATE utf8mb4_estonian_ci NOT NULL,
  `Email` varchar(100) COLLATE utf8mb4_estonian_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_estonian_ci;

--
-- Dumping data for table `Taienduskoolituse_juht`
--

INSERT INTO `Taienduskoolituse_juht` (`ID`, `Nimi`, `Sunniaeg`, `Sugu`, `Aadress`, `Telefon`, `Email`) VALUES
(1, 'Kersti Maidra', '1965-05-21', 'Naine', 'Narva mnt 36', '6409379', 'kersti@tlu.ee');

-- --------------------------------------------------------

--
-- Table structure for table `Tallinna_Ulikool_Avatud_ulikool`
--

CREATE TABLE `Tallinna_Ulikool_Avatud_ulikool` (
  `ID` int(11) NOT NULL,
  `Aadress` varchar(100) COLLATE utf8mb4_estonian_ci NOT NULL,
  `Kontaktisik` varchar(100) COLLATE utf8mb4_estonian_ci NOT NULL,
  `Telefon` varchar(100) COLLATE utf8mb4_estonian_ci NOT NULL,
  `Email` varchar(100) COLLATE utf8mb4_estonian_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_estonian_ci;

--
-- Dumping data for table `Tallinna_Ulikool_Avatud_ulikool`
--

INSERT INTO `Tallinna_Ulikool_Avatud_ulikool` (`ID`, `Aadress`, `Kontaktisik`, `Telefon`, `Email`) VALUES
(1, 'Narva mnt 25', 'Mari Maasikas', '6409101', 'info@tlu.ee');

-- --------------------------------------------------------

--
-- Table structure for table `Teated`
--

CREATE TABLE `Teated` (
  `ID` int(11) NOT NULL,
  `Liik` varchar(100) COLLATE utf8_estonian_ci NOT NULL,
  `Sisu` varchar(400) COLLATE utf8_estonian_ci NOT NULL,
  `Loetud` tinyint(1) DEFAULT 0,
  `Lisamise_aeg` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_estonian_ci;

--
-- Dumping data for table `Teated`
--

INSERT INTO `Teated` (`ID`, `Liik`, `Sisu`, `Loetud`, `Lisamise_aeg`) VALUES
(1, 'Õppekava', 'Lisati õppekava Digitaalne Õpiamps', 1, '2023-06-14 13:47:43'),
(2, 'Õppekava', 'Lisati õppekava Noorteprojekti koostamine', 0, '2023-06-14 13:47:43'),
(3, 'Õppekava', 'Lisati õppekava MS Office Excel algajale', 0, '2023-06-14 13:47:43'),
(4, 'Õppekava', 'Lisati õppekava Tööalased digioskused', 0, '2023-06-14 13:47:43'),
(5, 'Õppekava', 'Lisati õppekava DigiTarkus', 1, '2023-06-14 13:47:43'),
(6, 'Kursus', 'Lisati kursus Digitaalne õpiamps:Canva keskkond', 0, '2023-06-14 13:47:43'),
(7, 'Kursus', 'Lisati kursus 3D modelleerimine algajatele', 0, '2023-06-14 13:47:43'),
(8, 'Kursus', 'Lisati kursus Andmeanalüüs MS Excel baasil', 0, '2023-06-14 13:47:43'),
(9, 'Kursus', 'Lisati kursus Pilvepõhine tekstitöötlus algajatele', 0, '2023-06-14 13:47:43'),
(10, 'Kursus', 'Lisati kursus MS Office Word algajatele', 1, '2023-06-14 13:47:43'),
(11, 'Kursus', 'Lisati kursus Andmebaasi päringukeele SQL kasutamine', 1, '2023-06-14 13:47:43'),
(12, 'Kursus', 'Lisati kursus Sissejuhatus teksti- ja tabelitöötlusesse', 1, '2023-06-14 13:47:43'),
(13, 'Kursus', 'Lisati kursus Google Drive keskkonna kasutamine kontoritöös', 1, '2023-06-14 13:47:43'),
(14, 'Kursus', 'Lisati kursus Digiturundus väikeettevõtjale', 1, '2023-06-14 13:47:43'),
(15, 'Kursus', 'Lisati kursus Dokumentide vormistamine arvutis', 1, '2023-06-14 13:47:43'),
(16, 'Kursus', 'Lisati kursus Digioskuste alused', 1, '2023-06-14 13:47:43'),
(17, 'Kursus', 'Lisati kursus Bürootöötajate digioskused', 1, '2023-06-14 13:47:43'),
(18, 'Kursus', 'Lisati kursus Arvuti- ja nutiseadme kasutuse algõpe', 1, '2023-06-14 13:47:43'),
(19, 'Kursus', 'Lisati kursus Arvutipõhine menüüde ja kalkulatsiooni koostamine', 1, '2023-06-14 13:47:43'),
(20, 'Kursus', 'Lisati kursus Noorte juhendamine', 1, '2023-06-14 13:47:43'),
(21, 'Kursus', 'Lisati kursus Digitarkus algkursus', 1, '2023-06-14 13:47:43'),
(22, 'Kursus', 'Lisati kursus Teadmisi Hiina toidukultuurist', 1, '2023-06-14 13:47:43'),
(23, 'Kursus', 'Lisati kursus BE- kategooria mootorsõidukijuhi õpetaja erikursus', 1, '2023-06-14 13:47:43'),
(24, 'Kursus', 'Lisati kursus Kübertarkus', 1, '2023-06-14 13:47:43');

-- --------------------------------------------------------

--
-- Table structure for table `Teenus`
--

CREATE TABLE `Teenus` (
  `ID` int(11) NOT NULL,
  `Nimetus` varchar(100) COLLATE utf8mb4_estonian_ci NOT NULL,
  `Tallinna_Ulikool_Avatud_ulikool_ID` int(11) NOT NULL,
  `Peakasutaja_ID` int(11) NOT NULL,
  `Taienduskoolituse_juht_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_estonian_ci;

--
-- Dumping data for table `Teenus`
--

INSERT INTO `Teenus` (`ID`, `Nimetus`, `Tallinna_Ulikool_Avatud_ulikool_ID`, `Peakasutaja_ID`, `Taienduskoolituse_juht_ID`) VALUES
(1, 'Täienduskoolituse osutamine', 1, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `Toend_tunnistus`
--

CREATE TABLE `Toend_tunnistus` (
  `ID` int(11) NOT NULL,
  `Number` varchar(100) COLLATE utf8mb4_estonian_ci NOT NULL,
  `Vaartus` varchar(100) COLLATE utf8mb4_estonian_ci NOT NULL,
  `Trukkimise_kuupaev` date NOT NULL DEFAULT current_timestamp(),
  `Opilane_ID` int(11) DEFAULT NULL,
  `Kursus_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_estonian_ci;

--
-- Dumping data for table `Toend_tunnistus`
--

INSERT INTO `Toend_tunnistus` (`ID`, `Number`, `Vaartus`, `Trukkimise_kuupaev`, `Opilane_ID`, `Kursus_ID`) VALUES
(1, '123459', 'Tõend', '2023-06-08', 4, 17),
(2, '122348', 'Tõend', '2023-06-08', 6, 17),
(3, '133476', 'Tõend', '2023-06-09', 3, 17),
(4, '134578', 'Tõend', '2023-06-09', 1, 17),
(5, '133256', 'Tõend', '2023-06-09', 10, 17),
(6, '355678', 'Tõend', '2023-06-09', 1, 19),
(7, '325647', 'Tõend', '2023-06-09', 2, 19),
(8, '327890', 'Tõend', '2023-06-09', 3, 19),
(9, '333378', 'Tõend', '2023-06-09', 4, 19),
(10, '313435', 'Tõend', '2023-06-09', 5, 19);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Arve`
--
ALTER TABLE `Arve`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `Arve_Opilane` (`Opilane_ID`),
  ADD KEY `Arve_Kursus` (`Kursus_ID`);

--
-- Indexes for table `Kasutajakonto`
--
ALTER TABLE `Kasutajakonto`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `Kursus`
--
ALTER TABLE `Kursus`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `Kursus_Oppejoud` (`Oppejoud_ID`),
  ADD KEY `Kursus_Oppekava` (`Oppekava_ID`),
  ADD KEY `Kursus_Teenus` (`Teenus_ID`);

--
-- Indexes for table `Opilane`
--
ALTER TABLE `Opilane`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `Opilane_kursus`
--
ALTER TABLE `Opilane_kursus`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `Opilane_kursus_Kursus` (`Kursus_ID`),
  ADD KEY `Opilane_kursus_Opilane` (`Opilane_ID`);

--
-- Indexes for table `Oppejoud`
--
ALTER TABLE `Oppejoud`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `Oppekava`
--
ALTER TABLE `Oppekava`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `Oppekava_Teenus` (`Teenus_ID`);

--
-- Indexes for table `Peakasutaja`
--
ALTER TABLE `Peakasutaja`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `Taienduskoolituse_juht`
--
ALTER TABLE `Taienduskoolituse_juht`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `Tallinna_Ulikool_Avatud_ulikool`
--
ALTER TABLE `Tallinna_Ulikool_Avatud_ulikool`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `Tallinna_Ulikool_Avatud_ulikool_ak_1` (`ID`);

--
-- Indexes for table `Teated`
--
ALTER TABLE `Teated`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `Teenus`
--
ALTER TABLE `Teenus`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `Teenus_Peakasutaja` (`Peakasutaja_ID`),
  ADD KEY `Teenus_Taienduskoolituse_juht` (`Taienduskoolituse_juht_ID`),
  ADD KEY `Teenus_Tallinna_Ulikool_Avatud_ulikool` (`Tallinna_Ulikool_Avatud_ulikool_ID`);

--
-- Indexes for table `Toend_tunnistus`
--
ALTER TABLE `Toend_tunnistus`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `Toend_tunnistus_Opilane` (`Opilane_ID`),
  ADD KEY `Toend_tunnistus_Kursus` (`Kursus_ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Kasutajakonto`
--
ALTER TABLE `Kasutajakonto`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `Tallinna_Ulikool_Avatud_ulikool`
--
ALTER TABLE `Tallinna_Ulikool_Avatud_ulikool`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `Teated`
--
ALTER TABLE `Teated`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Arve`
--
ALTER TABLE `Arve`
  ADD CONSTRAINT `Arve_Kursus` FOREIGN KEY (`Kursus_ID`) REFERENCES `Kursus` (`ID`),
  ADD CONSTRAINT `Arve_Opilane` FOREIGN KEY (`Opilane_ID`) REFERENCES `Opilane` (`ID`);

--
-- Constraints for table `Kursus`
--
ALTER TABLE `Kursus`
  ADD CONSTRAINT `Kursus_Oppejoud` FOREIGN KEY (`Oppejoud_ID`) REFERENCES `Oppejoud` (`ID`),
  ADD CONSTRAINT `Kursus_Oppekava` FOREIGN KEY (`Oppekava_ID`) REFERENCES `Oppekava` (`ID`),
  ADD CONSTRAINT `Kursus_Teenus` FOREIGN KEY (`Teenus_ID`) REFERENCES `Teenus` (`ID`);

--
-- Constraints for table `Opilane_kursus`
--
ALTER TABLE `Opilane_kursus`
  ADD CONSTRAINT `Opilane_kursus_Kursus` FOREIGN KEY (`Kursus_ID`) REFERENCES `Kursus` (`ID`),
  ADD CONSTRAINT `Opilane_kursus_Opilane` FOREIGN KEY (`Opilane_ID`) REFERENCES `Opilane` (`ID`);

--
-- Constraints for table `Oppekava`
--
ALTER TABLE `Oppekava`
  ADD CONSTRAINT `Oppekava_Teenus` FOREIGN KEY (`Teenus_ID`) REFERENCES `Teenus` (`ID`);

--
-- Constraints for table `Teenus`
--
ALTER TABLE `Teenus`
  ADD CONSTRAINT `Teenus_Peakasutaja` FOREIGN KEY (`Peakasutaja_ID`) REFERENCES `Peakasutaja` (`ID`),
  ADD CONSTRAINT `Teenus_Taienduskoolituse_juht` FOREIGN KEY (`Taienduskoolituse_juht_ID`) REFERENCES `Taienduskoolituse_juht` (`ID`),
  ADD CONSTRAINT `Teenus_Tallinna_Ulikool_Avatud_ulikool` FOREIGN KEY (`Tallinna_Ulikool_Avatud_ulikool_ID`) REFERENCES `Tallinna_Ulikool_Avatud_ulikool` (`ID`);

--
-- Constraints for table `Toend_tunnistus`
--
ALTER TABLE `Toend_tunnistus`
  ADD CONSTRAINT `Toend_tunnistus_Kursus` FOREIGN KEY (`Kursus_ID`) REFERENCES `Kursus` (`ID`),
  ADD CONSTRAINT `Toend_tunnistus_Opilane` FOREIGN KEY (`Opilane_ID`) REFERENCES `Opilane` (`ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
