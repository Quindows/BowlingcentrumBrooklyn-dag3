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


            
	
	
