USE Bowlingcentrum;
DROP PROCEDURE IF EXISTS spCreateReservering;

DELIMITER //

CREATE PROCEDURE spCreateReservering(
	openingstijdId		INT,
	baanId				INT,
    persoonId			INT,
    tijd				TIME,
    kinderen			INT,
    volwassenen			INT,
    datum				DATE
)

BEGIN

	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
    	ROLLBACK;
    	SELECT 'An error has occurred, operation rollbacked and the stored procedure was terminated';
	END;
    
    START TRANSACTION;
		INSERT INTO reservering
        (
			OpeningsTijdId,
			BaanId,
			PersoonId,
			Tijd,
			Kinderen,
			Volwassenen,
            Datum
		)
        VALUES
        (
			openingstijdId,
			baanId,
			persoonId,
			tijd,
			kinderen,
			volwassenen,
            datum
		);
	COMMIT;
END //
