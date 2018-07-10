CREATE TABLE `status` (
  `idstatus` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`idstatus`),
  UNIQUE KEY `idstatus_UNIQUE` (`idstatus`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

CREATE TABLE `notifications` (
  `idnotifications` int(11) NOT NULL AUTO_INCREMENT,
  `idUserFrom` varchar(45) NOT NULL,
  `idUserTo` varchar(45) DEFAULT NULL COMMENT 'if public = 1 (is public) then there is not idUserTo',
  `message` mediumtext NOT NULL,
  `public` bit(1) DEFAULT b'0' COMMENT 'Public = 0 (false or private) Public = 1 (Public message then all users may read it)',
  `creationDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` int(11) NOT NULL DEFAULT '1' COMMENT 'stauts, see sttus table (read, not Read). By default = 1 -> Not read',
  `readDate` datetime DEFAULT NULL,
  PRIMARY KEY (`idnotifications`),
  UNIQUE KEY `idnotifications_UNIQUE` (`idnotifications`),
  KEY `notifications_status_idx` (`status`),
  CONSTRAINT `notifications_status` FOREIGN KEY (`status`) REFERENCES `status` (`idstatus`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

INSERT INTO `status`
(`idstatus`,
`name`,
`description`)
VALUES
(1,'Not Read', 'Not Read');

INSERT INTO `status`
(`idstatus`,
`name`,
`description`)
VALUES
(2,'Read', 'Read');
