drop database if exists `bowlingcentrum-dag3`;
create database `bowlingcentrum-dag3`;

use `bowlingcentrum-dag3`;

-- TypePersoon
drop table if exists `typepersoon`;
create table `typepersoon`(
	`Id`			INT 			NOT NULL 			AUTO_INCREMENT PRIMARY KEY,
	`Naam`			VARCHAR(20) 	NOT NULL,
	`IsActief` 		TINYINT(1) 		NOT NULL 			DEFAULT 1,
    `Opmerking` 	TEXT			NULL,
    `DatumAangemaakt`TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `DatumGewijzigd` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
)ENGINE=INNODB;

INSERT INTO `typepersoon`(
	`Naam`)
VALUES 
	('Klant'),
    ('Medewerker'),
    ('Gast');
    
    
-- PakketOptie
drop table if exists `pakketoptie`;
create table `pakketoptie`(
	`Id`			INT 			NOT NULL 			AUTO_INCREMENT PRIMARY KEY,
	`Naam`			VARCHAR(20) 	NOT NULL,
	`IsActief` 		TINYINT(1) 		NOT NULL 			DEFAULT 1,
    `Opmerking` 	TEXT			NULL,
    `DatumAangemaakt`TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `DatumGewijzigd` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
)ENGINE=INNODB;

INSERT INTO `pakketoptie`(
	`Naam`)
VALUES 
	('Snackpakketbasis'),
    ('Snackpakketluxe'),
    ('Kinderpartij'),
    ('Vrijgezellenfeest');
    

-- Persoon
drop table if exists `persoon`;
create table `persoon`(
	`Id`			INT 			NOT NULL 			AUTO_INCREMENT PRIMARY KEY,
	`TypePersoonId`	INT 		 	NOT NULL,
    `Voornaam`		VARCHAR(50) 	NOT NULL,
    `TussenVoegsel`	VARCHAR(20)     NULL,
    `Achternaam`	VARCHAR(50)		NOT NULL,
    `Roepnaam`		VARCHAR(50)		NULL,
    `IsVolwassen`	TINYINT			NULL,
	`IsActief` 		TINYINT(1) 		NOT NULL 			DEFAULT 1,
    `Opmerking` 	TEXT			NULL,
    `DatumAangemaakt`TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `DatumGewijzigd` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT TypePersoon_Persoon FOREIGN KEY (`TypePersoonId`) REFERENCES `typepersoon`(`Id`)
)ENGINE=INNODB;

INSERT INTO `persoon`(
	`TypePersoonId`,
    `Voornaam`,
    `Tussenvoegsel`,
    `Achternaam`,
    `Roepnaam`,
    `IsVolwassen`)
VALUES 
	(1, 'Mazin', null, 'Jamil', 'Mazin', 1),
    (1, 'Arjan', 'de', 'Ruijter', 'Arjan', 1),
    (1, 'Hans', null, 'Odijk', 'Hans', 1),
    (1, 'Dennis', 'van', 'Wakeren', 'Dennis', 1),
    (2, 'Wilco', 'Van de', 'Grift', 'Wilco', 1),
    (3, 'Tom', null, 'Sanders', 'Tom', 0),
    (3, 'Andrew', null, 'Sanders', 'Andrew', 0),
    (3, 'Julian', null, 'Kaldenheuvel', 'Julian', 1);
    
    
-- Reservering
drop table if exists `reservering`;
create table `reservering`(
	`Id`			INT 			NOT NULL 			AUTO_INCREMENT PRIMARY KEY,
	`PersoonId`		INT 		 	NOT NULL,
    `OpeningstijdId`INT 		 	NOT NULL,
    `TariefId`		INT 		 	NOT NULL,
    `BaanId`		INT 		 	NOT NULL,
    `PakketOptieId`	INT 		 	NULL,
    `ReserveringStatusId`	INT 	NOT NULL,
    `Reserveringsnummer` 	INT(13)	NOT NULL,
    `Datum`			DATE			NOT NULL,
    `AantalUren`	INT(1)			NOT NULL,
    `BeginTijd`		TIME			NOT NULL,
    `EindTijd` 		TIME			NOT NULL,
    `AantalVolwassen` 		INT(1)	NOT NULL,
    `AantalKinderen`		INT(1)	NULL,
	`IsActief` 		TINYINT(1) 		NOT NULL 			DEFAULT 1,
    `Opmerking` 	TEXT			NULL,
    `DatumAangemaakt`TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `DatumGewijzigd` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT Persoon_Reservering FOREIGN KEY (`PersoonId`) REFERENCES `persoon`(`Id`),
    CONSTRAINT PakketOptie_Persoon FOREIGN KEY (`PakketOptieId`) REFERENCES `pakketoptie`(`Id`)
)ENGINE=INNODB;

INSERT INTO `reservering`(
	`PersoonId`, 
    `OpeningstijdId`,
    `TariefId`, 
    `BaanId`,
    `PakketOptieId`, 
	`ReserveringStatusId`,
	`Reserveringsnummer`,
    `Datum`, 
    `AantalUren`,
    `BeginTijd`,
    `EindTijd`,
    `AantalVolwassen`,
    `AantalKinderen`)
VALUES 
	(1, 2, 1, 8, 1, 1, 2022122000001, '2022-12-20', 1, '15:00:00', '16:00:00', 4, 2),
    (2, 2, 1, 2, 3, 1, 2022122000002, '2022-12-20', 1, '17:00:00', '18:00:00', 4, null),
    (3, 7, 2, 3, 1, 1, 2022122400003, '2022-12-24', 2, '16:00:00', '18:00:00', 4, null),
    (1, 2, 1, 6, null, 1, 2022122700004, '2022-12-27', 2, '17:00:00', '19:00:00', 2, null),
    (4, 3, 1, 4, 4, 1, 2022122800005, '2022-12-28', 1, '14:00:00', '15:00:00', 3, null),
    (5, 10, 3, 5, 4, 1, 2022122800006, '2022-12-28', 2, '19:00:00', '21:00:00', 2, null);


    
    

    





