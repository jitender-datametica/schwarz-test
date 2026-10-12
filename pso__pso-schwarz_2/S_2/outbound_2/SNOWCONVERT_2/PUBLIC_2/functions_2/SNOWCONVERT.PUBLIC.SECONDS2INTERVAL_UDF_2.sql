CREATE OR REPLACE FUNCTION snowconvert_public.seconds2interval_udf(input_part STRING, input_value INT64) RETURNS STRING
AS (
CASE input_part
    WHEN 'DAY' THEN 
        CAST(CAST(TRUNC(input_value / 86400) AS INT64) AS STRING)
        
    WHEN 'DAY TO HOUR' THEN 
        CONCAT(
            CAST(CAST(TRUNC(input_value / 86400) AS INT64) AS STRING), ' ',
            CASE 
                WHEN ABS(CAST(TRUNC(MOD(input_value, 86400) / 3600) AS INT64)) = 0 THEN '00' 
                WHEN ABS(CAST(TRUNC(MOD(input_value, 86400) / 3600) AS INT64)) > -10 AND ABS(CAST(TRUNC(MOD(input_value, 86400) / 3600) AS INT64)) < 10 THEN '0' 
                ELSE '' 
            END,
            CAST(ABS(CAST(TRUNC(MOD(input_value, 86400) / 3600) AS INT64)) AS STRING)
        )
        
    WHEN 'DAY TO MINUTE' THEN 
        CONCAT(
            CAST(CAST(TRUNC(input_value / 86400) AS INT64) AS STRING), ' ',
            CASE 
                WHEN ABS(CAST(TRUNC(MOD(input_value, 86400) / 3600) AS INT64)) = 0 THEN '00' 
                WHEN ABS(CAST(TRUNC(MOD(input_value, 86400) / 3600) AS INT64)) > -10 AND ABS(CAST(TRUNC(MOD(input_value, 86400) / 3600) AS INT64)) < 10 THEN '0' 
                ELSE '' 
            END,
            CAST(ABS(CAST(TRUNC(MOD(input_value, 86400) / 3600) AS INT64)) AS STRING), ':',
            CASE 
                WHEN ABS(CAST(TRUNC(MOD(input_value, 3600) / 60) AS INT64)) = 0 THEN '00' 
                WHEN ABS(CAST(TRUNC(MOD(input_value, 3600) / 60) AS INT64)) > -10 AND ABS(CAST(TRUNC(MOD(input_value, 3600) / 60) AS INT64)) < 10 THEN '0' 
                ELSE '' 
            END,
            CAST(ABS(CAST(TRUNC(MOD(input_value, 3600) / 60) AS INT64)) AS STRING)
        )
        
    WHEN 'DAY TO SECOND' THEN 
        CONCAT(
            CAST(CAST(TRUNC(input_value / 86400) AS INT64) AS STRING), ' ',
            CASE 
                WHEN ABS(CAST(TRUNC(MOD(input_value, 86400) / 3600) AS INT64)) = 0 THEN '00' 
                WHEN ABS(CAST(TRUNC(MOD(input_value, 86400) / 3600) AS INT64)) > -10 AND ABS(CAST(TRUNC(MOD(input_value, 86400) / 3600) AS INT64)) < 10 THEN '0' 
                ELSE '' 
            END,
            CAST(ABS(CAST(TRUNC(MOD(input_value, 86400) / 3600) AS INT64)) AS STRING), ':',
            CASE 
                WHEN ABS(CAST(TRUNC(MOD(input_value, 3600) / 60) AS INT64)) = 0 THEN '00' 
                WHEN ABS(CAST(TRUNC(MOD(input_value, 3600) / 60) AS INT64)) > -10 AND ABS(CAST(TRUNC(MOD(input_value, 3600) / 60) AS INT64)) < 10 THEN '0' 
                ELSE '' 
            END,
            CAST(ABS(CAST(TRUNC(MOD(input_value, 3600) / 60) AS INT64)) AS STRING), ':',
            CASE 
                WHEN ABS(MOD(input_value, 60)) = 0 THEN '00' 
                WHEN ABS(MOD(input_value, 60)) > -10 AND ABS(MOD(input_value, 60)) < 10 THEN '0' 
                ELSE '' 
            END,
            CAST(ABS(MOD(input_value, 60)) AS STRING)
        )
        
    WHEN 'HOUR' THEN 
        CAST(CAST(TRUNC(input_value / 3600) AS INT64) AS STRING)
        
    WHEN 'HOUR TO MINUTE' THEN 
        CONCAT(
            CAST(CAST(TRUNC(input_value / 3600) AS INT64) AS STRING), ':',
            CASE 
                WHEN ABS(CAST(TRUNC(MOD(input_value, 3600) / 60) AS INT64)) = 0 THEN '00' 
                WHEN ABS(CAST(TRUNC(MOD(input_value, 3600) / 60) AS INT64)) > -10 AND ABS(CAST(TRUNC(MOD(input_value, 3600) / 60) AS INT64)) < 10 THEN '0' 
                ELSE '' 
            END,
            CAST(ABS(CAST(TRUNC(MOD(input_value, 3600) / 60) AS INT64)) AS STRING)
        )
        
    WHEN 'HOUR TO SECOND' THEN 
        CONCAT(
            CAST(CAST(TRUNC(input_value / 3600) AS INT64) AS STRING), ':',
            CASE 
                WHEN ABS(CAST(TRUNC(MOD(input_value, 3600) / 60) AS INT64)) = 0 THEN '00' 
                WHEN ABS(CAST(TRUNC(MOD(input_value, 3600) / 60) AS INT64)) > -10 AND ABS(CAST(TRUNC(MOD(input_value, 3600) / 60) AS INT64)) < 10 THEN '0' 
                ELSE '' 
            END,
            CAST(ABS(CAST(TRUNC(MOD(input_value, 3600) / 60) AS INT64)) AS STRING), ':',
            CASE 
                WHEN ABS(MOD(input_value, 60)) = 0 THEN '00' 
                WHEN ABS(MOD(input_value, 60)) > -10 AND ABS(MOD(input_value, 60)) < 10 THEN '0' 
                ELSE '' 
            END,
            CAST(ABS(MOD(input_value, 60)) AS STRING)
        )
        
    WHEN 'MINUTE' THEN 
        CAST(CAST(TRUNC(input_value / 60) AS INT64) AS STRING)
        
    WHEN 'MINUTE TO SECOND' THEN 
        CONCAT(
            CAST(CAST(TRUNC(input_value / 60) AS INT64) AS STRING), ':',
            CASE 
                WHEN ABS(MOD(input_value, 60)) = 0 THEN '00' 
                WHEN ABS(MOD(input_value, 60)) > -10 AND ABS(MOD(input_value, 60)) < 10 THEN '0' 
                ELSE '' 
            END,
            CAST(ABS(MOD(input_value, 60)) AS STRING)
        )
        
    WHEN 'SECOND' THEN 
        CAST(input_value AS STRING)
  END
);