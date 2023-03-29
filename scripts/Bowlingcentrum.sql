DROP DATABASE IF EXISTS `Bowlingcentrum`;
CREATE DATABASE `Bowlingcentrum`;

USE `Bowlingcentrum`;
 
-- SCORE
DROP TABLE IF EXISTS `score`;
CREATE TABLE `score`(
	`Id`			INT 			NOT NULL 			AUTO_INCREMENT PRIMARY KEY,
	`Naam`			VARCHAR(100) 	NOT NULL,
    `Score`			INT				NOT NULL,
	`IsActief` 		TINYINT(1) 		NOT NULL 			DEFAULT 1,
    `Opmerking` 	TEXT			NULL,
    `DatumAangemaakt`TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `DatumGewijzigd` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
)ENGINE=INNODB;


-- CONTACT
DROP TABLE IF EXISTS `contact`;
CREATE TABLE `contact`(
	`Id` 				INT 			NOT NULL 		AUTO_INCREMENT PRIMARY KEY,
	`Mobiel`			VARCHAR(15)		NOT NULL,
    `Email`				VARCHAR(100)	NOT NULL,
	`IsActief` 		TINYINT(1) 			NOT NULL 			DEFAULT 1,
    `Opmerking` 	TEXT				NULL,
    `DatumAangemaakt`TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `DatumGewijzigd` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
)ENGINE=INNODB;

-- PERSOON
DROP TABLE IF EXISTS `persoon`;
CREATE TABLE `persoon`(
	`Id` 				INT 			NOT NULL 		AUTO_INCREMENT PRIMARY KEY,
    `ContactId`			INT				NOT NULL,
    `Voornaam`			VARCHAR(100)    NOT NULL,
    `TussenVoegsel`		VARCHAR(50)     NULL,
    `Achternaam`		VARCHAR(100)	NOT NULL,
    `IsVolwassen`		TINYINT			NULL,
	`IsActief` 		TINYINT(1) 			NOT NULL 			DEFAULT 1,
    `Opmerking` 	TEXT				NULL,
    `DatumAangemaakt`TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `DatumGewijzigd` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT ContactPerson FOREIGN KEY (`ContactId`) REFERENCES `contact`(`Id`)
)ENGINE=INNODB;

-- KOPPEL TABEL SCORE + PERSOON
DROP TABLE IF EXISTS `scoreperperson`;
CREATE TABLE `scoreperperson`(
	`Id` 				INT 			NOT NULL 		AUTO_INCREMENT PRIMARY KEY,
	`PersoonId`			INT				NOT NULL,
    `ScoreId`			INT 			NOT NULL,
    `ReserveringId`		INT 			NOT NULL,
	`IsActief` 		TINYINT(1) 			NOT NULL 			DEFAULT 1,
    `Opmerking` 	TEXT				NULL,
    `DatumAangemaakt`TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `DatumGewijzigd` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PersonScorePerPerson FOREIGN KEY (`PersoonId`) REFERENCES `persoon`(`Id`),
    CONSTRAINT ScoreScorePerPerson FOREIGN KEY (`PersoonId`) REFERENCES `score`(`Id`)
)ENGINE=INNODB;

-- USER
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
	`Id` 				INT 			NOT NULL 		AUTO_INCREMENT PRIMARY KEY,
	`PersoonId`			INT 			NOT NULL,
	`Gebruikersnaam`	VARCHAR(100) 	NOT NULL,
    `Wachtwoord`		VARCHAR(50)		NOT NULL,
	`IsActief` 		TINYINT(1) 			NOT NULL 			DEFAULT 1,
    `Opmerking` 	TEXT				NULL,
    `DatumAangemaakt`TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `DatumGewijzigd` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PersonUser FOREIGN KEY (`PersoonId`) REFERENCES `persoon`(`Id`)
)ENGINE=INNODB;

-- ROLE
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`(
	`Id`			INT 			NOT NULL 			AUTO_INCREMENT PRIMARY KEY,
    `Role`			ENUM('Werknemer', 'Gast') NOT NULL,
	`IsActief` 		TINYINT(1) 		NOT NULL 			DEFAULT 1,
    `Opmerking` 	TEXT			NULL,
    `DatumAangemaakt`TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `DatumGewijzigd` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
)ENGINE=INNODB;

-- KOPPEL TABEL USER + ROLE
DROP TABLE IF EXISTS `userperrole`;
CREATE TABLE `userperrole`(
	`Id` 				INT 			NOT NULL 		AUTO_INCREMENT PRIMARY KEY,
	`UserId`			INT				NOT NULL,
    `RoleId`			INT 			NOT NULL,
    `ReserveringId`		INT 			NOT NULL,
	`IsActief` 		TINYINT(1) 			NOT NULL 			DEFAULT 1,
    `Opmerking` 	TEXT				NULL,
    `DatumAangemaakt`TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `DatumGewijzigd` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT UserUserPerRole FOREIGN KEY (`UserId`) REFERENCES `User`(`Id`),
    CONSTRAINT RoleUserPerRole FOREIGN KEY (`RoleId`) REFERENCES `Role`(`Id`)
)ENGINE=INNODB;

-- BESTELLING
DROP TABLE IF EXISTS `bestelling`;
CREATE TABLE `bestelling`(
	`Id`			INT 			NOT NULL 			AUTO_INCREMENT PRIMARY KEY,
    `Bestelling`	ENUM('SnackpacketBasis', 'SnackpacketLuxe', 'Kinderpartij', 'Vrijgezellenfeest') NOT NULL,
	`IsActief` 		TINYINT(1) 		NOT NULL 			DEFAULT 1,
    `Opmerking` 	TEXT			NULL,
    `DatumAangemaakt`TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `DatumGewijzigd` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
)ENGINE=INNODB;

-- BANEN
DROP TABLE IF EXISTS `banen`;
CREATE TABLE `banen` (
	`Id`			INT 			NOT NULL 			AUTO_INCREMENT PRIMARY KEY,
	`MaxKinderen`	INT				NULL,
    `MaxVolwassenen`INT 			NOT NULL,
	`IsActief` 		TINYINT(1) 		NOT NULL 			DEFAULT 1,
    `Opmerking` 	TEXT			NULL,
    `DatumAangemaakt`TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `DatumGewijzigd` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
)ENGINE=INNODB;

-- TARIEF
DROP TABLE IF EXISTS `tarief`;
CREATE TABLE `tarief` (
	`Id`			INT 			NOT NULL 			AUTO_INCREMENT PRIMARY KEY,
	`Tarief`		DECIMAL(4,2)  	NOT NULL,
	`IsActief` 		TINYINT(1) 		NOT NULL 			DEFAULT 1,
    `Opmerking` 	TEXT			NULL,
    `DatumAangemaakt`TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `DatumGewijzigd` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
)ENGINE=INNODB;

-- OPENINGSTIJDEN
DROP TABLE IF EXISTS `openingstijden`;
CREATE TABLE `openingstijden` (
	`Id`			INT 			NOT NULL 			AUTO_INCREMENT PRIMARY KEY,
	`TariefId`		INT 			NOT NULL,
    `Dagen`			VARCHAR(10)		NOT NULL,
    `Openingstijd`	TIME			NOT NULL,
    `Sluitingstijd`	TIME 			NOT NULL,
 	`IsActief` 		TINYINT(1) 		NOT NULL 			DEFAULT 1,
    `Opmerking` 	TEXT			NULL,
    `DatumAangemaakt`TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `DatumGewijzigd` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	CONSTRAINT TariefOpeningstijden FOREIGN KEY (`TariefId`) REFERENCES `tarief`(`Id`)
)ENGINE=INNODB;   

-- RESERVERING
DROP TABLE IF EXISTS `reservering`;
CREATE TABLE `reservering`(
	`Id`			INT 			NOT NULL 			AUTO_INCREMENT PRIMARY KEY,
	`OpeningsTijdId`INT 			NOT NULL 			,
    `BaanId`		INT 			NOT NULL 			,
    `PersoonId`		INT 	        NOT NULL			,
    `Tijd`			TIME			NOT NULL,
    `Kinderen`		INT(1)			NULL,
    `Volwassenen`	INT(1)			NOT NULL,
    `Datum`			DATE			NOT NULL,	
	`IsActief` 		TINYINT(1) 		NOT NULL 			DEFAULT 1,
    `Opmerking` 	TEXT			NULL,
    `DatumAangemaakt`TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `DatumGewijzigd` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT OpeningtijdReservering FOREIGN KEY (`OpeningsTijdId`) REFERENCES openingstijden(`Id`),
    CONSTRAINT BaanReservering FOREIGN KEY (`BaanId`) REFERENCES banen(`Id`),
    CONSTRAINT PersoonReservering FOREIGN KEY (`PersoonId`) REFERENCES persoon(`Id`)
)ENGINE=INNODB;

-- KOPPEL TABEL BESTELLING + RESERVERING
DROP TABLE IF EXISTS `bestellingperreservering`;
CREATE TABLE `bestellingperreservering`(
	`Id`			INT 			NOT NULL 			AUTO_INCREMENT PRIMARY KEY,
	`BestellingId`	INT 			NOT NULL,
	`ReserveringId` INT 			NOT NULL,
    `IsActief` 		TINYINT(1) 		NOT NULL 			DEFAULT 1,
    `Opmerking` 	TEXT			NULL,
    `DatumAangemaakt`TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `DatumGewijzigd` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT BestellingBestellingPerReservering FOREIGN KEY (`BestellingId`) REFERENCES bestelling(`Id`),
	CONSTRAINT ReserveringBestellingPerReservering FOREIGN KEY (`ReserveringId`) REFERENCES reservering(`Id`)
)ENGINE=INNODB;

-- DEFAULT VALUES

INSERT INTO `banen`(
	`MaxKinderen`,
    `MaxVolwassenen`)
VALUES 
	(4, 6),
    (4, 6),
    (0, 8),
    (0, 8),
    (0, 8),
    (0, 8),
    (0, 8),
    (0, 8);
    
INSERT INTO `tarief`(
	`Tarief`)
VALUES 
	(24.00),
    (28.00),
    (33.50);
    
INSERT INTO `openingstijden`(
	`TariefId`,
    `Dagen`,
    `OpeningsTijd`,
    `SluitingsTijd`)
VALUES
	(1, 'Monday', '14:00', '22:00'),
    (1, 'Tuesday', '14:00', '22:00'),
    (1, 'Wednesday', '14:00', '22:00'),
    (1, 'Thursday', '14:00', '22:00'),
    (2, 'Friday', '14:00', '18:00'),
    (2, 'Saturday', '14:00', '18:00'),
    (2, 'Sunday', '14:00', '18:00'),
    (3, 'Friday', '18:00', '24:00'),
    (3, 'Saturday', '18:00', '24:00'),
    (3, 'Sunday', '18:00', '24:00');

-- STORED PROCEDURES
USE `Bowlingcentrum`;

DROP PROCEDURE IF EXISTS spReadReservering;

DELIMITER //

CREATE PROCEDURE spReadReservering()
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
    	ROLLBACK;
    	SELECT 'An error has occurred, operation rollbacked and the stored procedure was terminated';
	END;
            
	START TRANSACTION;
		SELECT
			res.Id			AS id,
			per.Voornaam 	AS voornaam,
            res.Tijd		AS tijd,
            res.Datum		AS datum,
            res.Volwassenen	AS volwassenen,
            res.Kinderen	AS kinderen
		FROM reservering res
        INNER JOIN persoon per
			ON per.Id = PersoonId;
		
	COMMIT;
END //