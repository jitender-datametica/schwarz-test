CREATE OR REPLACE FUNCTION snowconvert_public.seconds_to_intervall(Number_of_seconds NUMERIC) RETURNS STRING
AS (
CASE WHEN SIGN(Number_of_seconds) >= 0 -- Number of seconds is positive
            THEN CONCAT(
             CAST(FLOOR(Number_of_seconds/(60*60*24)) AS INT64)                                             , ' ' , -- days
             IF(FLOOR(MOD(CAST(Number_of_seconds/(60*60) AS NUMERIC),24)) < 10, 
                 CAST(CONCAT('0' , CAST(FLOOR(MOD(CAST(Number_of_seconds/(60*60) AS NUMERIC),24)) AS INT64)) AS STRING),                         -- add zero if hour < 10
                 CAST(             CAST(FLOOR(MOD(CAST(Number_of_seconds/(60*60) AS NUMERIC),24)) AS INT64)  AS STRING))             , ':' , -- hours
             IF(FLOOR(MOD(CAST(Number_of_seconds/(60) AS NUMERIC),60)) < 10,
                 CAST(CONCAT('0' , CAST(FLOOR(MOD(CAST(Number_of_seconds/(60) AS NUMERIC),60)) AS INT64)) AS STRING),                            -- add zero if min < 10
                 CAST(             CAST(FLOOR(MOD(CAST(Number_of_seconds/(60) AS NUMERIC),60)) AS INT64)  AS STRING))                , ':' , -- minutes
             IF(MOD(Number_of_seconds,60) < 10,
                 CAST(CONCAT('0' , CAST(FLOOR(MOD(Number_of_seconds,60)) AS INT64)) AS STRING),                                        -- add zero if sec < 10
                 CAST(             CAST(FLOOR(MOD(Number_of_seconds,60)) AS INT64)  AS STRING))                                        -- seconds
            )
         WHEN SIGN(Number_of_seconds) = -1 -- datediff is negative
            THEN CONCAT('-' ,
             CAST(FLOOR(Number_of_seconds/(60*60*24)) AS INT64)                                             , ' ' , -- days
             IF(FLOOR(MOD(CAST(Number_of_seconds/(60*60) AS NUMERIC),24)) < 10, 
                 CAST(CONCAT('0' , CAST(FLOOR(MOD(CAST(Number_of_seconds/(60*60) AS NUMERIC),24)) AS INT64)) AS STRING),                         -- add zero if hour < 10
                 CAST(             CAST(FLOOR(MOD(CAST(Number_of_seconds/(60*60) AS NUMERIC),24)) AS INT64)  AS STRING))             , ':' , -- hours
             IF(FLOOR(MOD(CAST(Number_of_seconds/(60) AS NUMERIC),60)) < 10,
                 CAST(CONCAT('0' , CAST(FLOOR(MOD(CAST(Number_of_seconds/(60) AS NUMERIC),60)) AS INT64)) AS STRING),                            -- add zero if min < 10
                 CAST(             CAST(FLOOR(MOD(CAST(Number_of_seconds/(60) AS NUMERIC),60)) AS INT64)  AS STRING))                , ':' , -- minutes
             IF(MOD(Number_of_seconds,60) < 10,
                 CAST(CONCAT('0' , CAST(FLOOR(MOD(Number_of_seconds,60)) AS INT64)) AS STRING),                                        -- add zero if sec < 10
                 CAST(             CAST(FLOOR(MOD(Number_of_seconds,60)) AS INT64)  AS STRING))                                        -- seconds
            )
    END
);