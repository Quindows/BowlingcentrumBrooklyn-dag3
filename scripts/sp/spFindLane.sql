USE Bowlingcentrum;

DROP PROCEDURE IF EXISTS spFindLane;

DELIMITER //

CREATE PROCEDURE spFindLane(
    guestCheck                    INT,
    childCheck                    INT,
    dateCheck                    VARCHAR(10),
    timeStartCheck                VARCHAR(8)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'An error has occurred, operation rollbacked and the stored procedure was terminated';
    END;
    
    START TRANSACTION;
    SELECT ban.Id
    FROM `banen` ban
    WHERE MaxVolwassenen >= guestCheck
        AND MaxKinderen >= childCheck
        AND Id NOT IN (    SELECT ban.Id
                        FROM `banen` ban
                        LEFT JOIN reservering res 
                        ON res.BaanId = ban.Id 
                        WHERE `Datum` = dateCheck
                            AND timeStartCheck BETWEEN DATE_SUB(`Tijd`, INTERVAL 2 HOUR) AND DATE_ADD(`Tijd`, INTERVAL 119 MINUTE))
    ORDER BY MaxVolwassenen ASC, MaxKinderen ASC LIMIT 1;
    COMMIT;
END //






