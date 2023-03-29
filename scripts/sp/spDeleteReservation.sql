USE `Bowlingcentrum`;

DROP PROCEDURE IF EXISTS spDeleteReservation;

DELIMITER //

CREATE PROCEDURE spDeleteReservation(
	id			INT
)

BEGIN

	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
    	ROLLBACK;
    	SELECT 'An error has occurred, operation rollbacked and the stored procedure was terminated';
	END;
            
	START TRANSACTION;
		DELETE FROM reservation
        WHERE Id = id;
	COMMIT;
END //
        
