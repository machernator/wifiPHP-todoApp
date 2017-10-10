-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Erstellungszeit: 10. Okt 2017 um 16:44
-- Server-Version: 5.7.19
-- PHP-Version: 7.1.9

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

-- --------------------------------------------------------

--
-- Stellvertreter-Struktur des Views `all_todos`
-- (Siehe unten für die tatsächliche Ansicht)
--
DROP VIEW IF EXISTS `all_todos`;
CREATE TABLE IF NOT EXISTS `all_todos` (
`todos_id` int(11)
,`user_id` int(11)
,`datum` datetime
,`text` text
,`active` bit(1)
);

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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `categories`
--

INSERT INTO `categories` (`categories_id`, `name`) VALUES
(2, 'backend'),
(1, 'frontend'),
(3, 'organisation'),
(4, 'test');

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
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `todos`
--

INSERT INTO `todos` (`todos_id`, `user_id`, `datum`, `text`, `active`) VALUES
(2, 6, '2017-09-26 14:25:14', 'Javascript lernen', b'1'),
(3, 1, '2017-09-26 14:25:19', 'HTML lernen', b'1'),
(4, 4, '2017-09-26 14:25:19', 'CSS lernen', b'1'),
(6, 6, '2017-10-02 14:46:28', 'Test Todo', b'1'),
(8, 4, '2017-10-02 15:30:28', 'Noch eines', b'1'),
(9, 10, '2017-10-02 15:32:41', 'Falsche \"AnfÃ¼hrungszeichen\" ', b'0'),
(10, 10, '2017-10-02 15:39:33', 'Escape ; bla \"', b'1'),
(11, 6, '2017-10-02 15:43:08', 'AnfÃ¼hrungszeichen escapen', b'0'),
(12, 10, '2017-10-02 15:44:25', 'Ã¼Ã¤Ã¶', b'1'),
(13, 10, '2017-10-02 15:44:41', 'Ã¼Ã¤Ã¶', b'0'),
(14, 10, '2017-10-02 15:48:23', 'Ã¤Ã¤Ã¶Ã¶Ã¼Ã¼', b'1'),
(15, 6, '2017-10-03 14:58:26', 'Vhosts anlegen', b'1'),
(16, 4, '2017-10-03 14:59:08', 'Demo', b'1'),
(19, 6, '2017-10-03 15:48:27', 'jodeln', b'1'),
(20, 6, '2017-10-03 15:49:03', 'jodeln', b'1'),
(23, 1, '2017-10-03 15:52:25', 'hello wie gehts', b'1');

--
-- Trigger `todos`
--
DROP TRIGGER IF EXISTS `backupTodo`;
DELIMITER $$
CREATE TRIGGER `backupTodo` BEFORE DELETE ON `todos` FOR EACH ROW BEGIN
	INSERT INTO todos_backup (text, user_id) VALUES (OLD.text, OLD.user_id);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `todos_backup`
--

DROP TABLE IF EXISTS `todos_backup`;
CREATE TABLE IF NOT EXISTS `todos_backup` (
  `todo_backup_id` int(11) NOT NULL AUTO_INCREMENT,
  `text` text NOT NULL,
  `user_id` int(11) NOT NULL,
  `delete_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`todo_backup_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `todos_backup`
--

INSERT INTO `todos_backup` (`todo_backup_id`, `text`, `user_id`, `delete_date`) VALUES
(1, 'Wieder ein Eintrag', 10, '2017-10-10 14:52:43');

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
(10, 1),
(12, 4),
(7, 4),
(6, 2),
(6, 3);

-- --------------------------------------------------------

--
-- Stellvertreter-Struktur des Views `todos_cats`
-- (Siehe unten für die tatsächliche Ansicht)
--
DROP VIEW IF EXISTS `todos_cats`;
CREATE TABLE IF NOT EXISTS `todos_cats` (
`text` text
,`name` varchar(255)
);

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

-- --------------------------------------------------------

--
-- Struktur des Views `all_todos`
--
DROP TABLE IF EXISTS `all_todos`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `all_todos`  AS  select `todos`.`todos_id` AS `todos_id`,`todos`.`user_id` AS `user_id`,`todos`.`datum` AS `datum`,`todos`.`text` AS `text`,`todos`.`active` AS `active` from `todos` ;

-- --------------------------------------------------------

--
-- Struktur des Views `todos_cats`
--
DROP TABLE IF EXISTS `todos_cats`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `todos_cats`  AS  select `t`.`text` AS `text`,`c`.`name` AS `name` from ((`todos` `t` join `todos_categories` `tc` on((`t`.`todos_id` = `tc`.`todos_id`))) join `categories` `c` on((`c`.`categories_id` = `tc`.`categories_id`))) ;

--
-- Constraints der exportierten Tabellen
--

--
-- Constraints der Tabelle `todos`
--
ALTER TABLE `todos`
  ADD CONSTRAINT `todos_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
