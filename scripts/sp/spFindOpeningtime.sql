USE Rocambolesque;
DROP PROCEDURE IF EXISTS spFindOpeningtime;

DELIMITER //
    
CREATE PROCEDURE spFindOpeningtime
(
	 dayName				varchar(10)
)

BEGIN
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
    	ROLLBACK;
    	SELECT 'An error has occurred, operation rollbacked and the stored procedure was terminated';
	END;
            
	START TRANSACTION;					
		SELECT ope.id AS Id
        FROM openingtime ope
        WHERE ope.day = dayName;
END //