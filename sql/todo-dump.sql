-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Erstellungszeit: 03. Okt 2017 um 15:17
-- Server-Version: 5.7.19
-- PHP-Version: 7.1.9

SET FOREIGN_KEY_CHECKS=0;
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `todo`
--
CREATE DATABASE IF NOT EXISTS `todo` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `todo`;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `categories`
--

DROP TABLE IF EXISTS `categories`;
CREATE TABLE IF NOT EXISTS `categories` (
  `categories_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`categories_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `categories`
--

INSERT INTO `categories` (`categories_id`, `name`) VALUES
(2, 'backend'),
(1, 'frontend'),
(3, 'organisation');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `todos`
--

DROP TABLE IF EXISTS `todos`;
CREATE TABLE IF NOT EXISTS `todos` (
  `todos_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `datum` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `text` text NOT NULL,
  `active` bit(1) NOT NULL DEFAULT b'1',
  PRIMARY KEY (`todos_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `todos`
--

INSERT INTO `todos` (`todos_id`, `user_id`, `datum`, `text`, `active`) VALUES
(1, 1, '2017-09-26 14:25:14', 'PHP lernen', b'1'),
(2, 6, '2017-09-26 14:25:14', 'Javascript lernen', b'1'),
(3, 1, '2017-09-26 14:25:19', 'HTML lernen', b'1'),
(4, 4, '2017-09-26 14:25:19', 'CSS lernen', b'1'),
(5, 6, '2017-10-02 14:45:07', 'Test Todo', b'1'),
(6, 6, '2017-10-02 14:46:28', 'Test Todo', b'1'),
(7, 1, '2017-10-02 14:47:32', 'Jipie, es funktioniert', b'1'),
(8, 4, '2017-10-02 15:30:28', 'Noch eines', b'1'),
(9, 10, '2017-10-02 15:32:41', 'Falsche \"AnfÃ¼hrungszeichen\" ', b'1'),
(10, 10, '2017-10-02 15:39:33', 'Escape ; bla \"', b'1'),
(11, 6, '2017-10-02 15:43:08', 'AnfÃ¼hrungszeichen escapen', b'1'),
(12, 10, '2017-10-02 15:44:25', 'Ã¼Ã¤Ã¶', b'1'),
(13, 10, '2017-10-02 15:44:41', 'Ã¼Ã¤Ã¶', b'1'),
(14, 10, '2017-10-02 15:48:23', 'Ã¤Ã¤Ã¶Ã¶Ã¼Ã¼', b'1'),
(15, 6, '2017-10-03 14:58:26', 'Vhosts anlegen', b'1'),
(16, 4, '2017-10-03 14:59:08', 'Demo', b'1');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `todos_categories`
--

DROP TABLE IF EXISTS `todos_categories`;
CREATE TABLE IF NOT EXISTS `todos_categories` (
  `todos_id` int(11) NOT NULL,
  `categories_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `todos_categories`
--

INSERT INTO `todos_categories` (`todos_id`, `categories_id`) VALUES
(1, 1),
(1, 3),
(2, 2),
(3, 2),
(3, 3),
(4, 1),
(4, 2),
(5, 6);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `user`
--

INSERT INTO `user` (`user_id`, `name`, `email`) VALUES
(1, 'Pipi Langstrumpf', 'pipi@langstrumpf.at'),
(4, 'Räuber Hotzenplotz', 'rh@gangster.at'),
(6, 'Jean Genie', 'jg@db.com'),
(10, 'Harry Potter', 'hp@hogwarts.com');

--
-- Constraints der exportierten Tabellen
--

--
-- Constraints der Tabelle `todos`
--
ALTER TABLE `todos`
  ADD CONSTRAINT `todos_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`);
SET FOREIGN_KEY_CHECKS=1;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
