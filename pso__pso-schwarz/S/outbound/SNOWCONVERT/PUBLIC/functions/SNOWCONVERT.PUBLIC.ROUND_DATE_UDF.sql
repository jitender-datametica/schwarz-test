CREATE OR REPLACE FUNCTION snowconvert_public.round_date_udf(input TIMESTAMP, fmt STRING) RETURNS DATE
AS (
CASE 
    WHEN fmt IN ('CC','SCC') THEN 
        CASE 
            WHEN CAST(SUBSTR(CAST(EXTRACT(YEAR FROM input) AS STRING), -2) AS INT64) >= 51 
                THEN DATE(CAST(CONCAT(SUBSTR(CAST(EXTRACT(YEAR FROM input) AS STRING), 1, 2), '01') AS INT64) + 100, 1, 1)
            ELSE DATE(CAST(CONCAT(SUBSTR(CAST(EXTRACT(YEAR FROM input) AS STRING), 1, 2), '01') AS INT64), 1, 1)
        END    
    WHEN fmt IN ('SYYYY','YYYY','YEAR','SYEAR','YYY','YY','Y') THEN 
        CASE WHEN EXTRACT(MONTH FROM input) >= 7 THEN DATE(EXTRACT(YEAR FROM input) + 1, 1, 1)
             ELSE DATE(EXTRACT(YEAR FROM input), 1, 1)
        END
    WHEN fmt IN ('IYYY','IYY','IY','I') THEN 
        CASE WHEN EXTRACT(MONTH FROM input) >= 7 THEN 
             CASE (EXTRACT(DAYOFWEEK FROM DATE(EXTRACT(YEAR FROM input), 12, 31)) - 1)
                  WHEN 0 THEN DATE_ADD(DATE(EXTRACT(YEAR FROM input), 12, 31), INTERVAL 1 DAY)
                  WHEN 1 THEN DATE_ADD(DATE(EXTRACT(YEAR FROM input), 12, 31), INTERVAL 0 DAY)
                  WHEN 2 THEN DATE_ADD(DATE(EXTRACT(YEAR FROM input), 12, 31), INTERVAL -1 DAY)
                  WHEN 3 THEN DATE_ADD(DATE(EXTRACT(YEAR FROM input), 12, 31), INTERVAL -2 DAY)
                  WHEN 4 THEN DATE_ADD(DATE(EXTRACT(YEAR FROM input), 12, 31), INTERVAL -3 DAY)
                  WHEN 5 THEN DATE_ADD(DATE(EXTRACT(YEAR FROM input), 12, 31), INTERVAL 3 DAY)
                  WHEN 6 THEN DATE_ADD(DATE(EXTRACT(YEAR FROM input), 12, 31), INTERVAL 2 DAY)
             END
             ELSE 
             CASE (EXTRACT(DAYOFWEEK FROM DATE(EXTRACT(YEAR FROM input), 1, 1)) - 1)
                  WHEN 0 THEN DATE_ADD(DATE(EXTRACT(YEAR FROM input), 1, 1), INTERVAL 1 DAY)
                  WHEN 1 THEN DATE_ADD(DATE(EXTRACT(YEAR FROM input), 1, 1), INTERVAL 0 DAY)
                  WHEN 2 THEN DATE_ADD(DATE(EXTRACT(YEAR FROM input), 1, 1), INTERVAL -1 DAY)
                  WHEN 3 THEN DATE_ADD(DATE(EXTRACT(YEAR FROM input), 1, 1), INTERVAL -2 DAY)
                  WHEN 4 THEN DATE_ADD(DATE(EXTRACT(YEAR FROM input), 1, 1), INTERVAL -3 DAY)
                  WHEN 5 THEN DATE_ADD(DATE(EXTRACT(YEAR FROM input), 1, 1), INTERVAL 3 DAY)
                  WHEN 6 THEN DATE_ADD(DATE(EXTRACT(YEAR FROM input), 1, 1), INTERVAL 2 DAY)
             END  
        END
    WHEN fmt IN ('MONTH','MON','MM','RM') THEN 
        CASE WHEN EXTRACT(DAY FROM input) > 15 THEN DATE_ADD(DATE(EXTRACT(YEAR FROM input), EXTRACT(MONTH FROM input), 1), INTERVAL 1 MONTH)
             ELSE DATE(EXTRACT(YEAR FROM input), EXTRACT(MONTH FROM input), 1)
        END
    WHEN fmt IN ('Q') THEN 
        CASE WHEN (MOD(EXTRACT(MONTH FROM input), 3) = 2 AND EXTRACT(DAY FROM input) > 15) OR MOD(EXTRACT(MONTH FROM input), 3) = 0 
             THEN DATE_ADD(DATE(EXTRACT(YEAR FROM input), (EXTRACT(QUARTER FROM input) - 1) * 3 + 1, 1), INTERVAL 3 MONTH)
             ELSE DATE(EXTRACT(YEAR FROM input), (EXTRACT(QUARTER FROM input) - 1) * 3 + 1, 1)
        END
    WHEN fmt IN ('WW') THEN 
        CASE WHEN MOD(DATE_DIFF(CAST(input AS DATE), DATE(EXTRACT(YEAR FROM input), 1, 1), DAY), 7) < 4 
             THEN DATE_ADD(CAST(input AS DATE), INTERVAL (0 - MOD(DATE_DIFF(CAST(input AS DATE), DATE(EXTRACT(YEAR FROM input), 1, 1), DAY), 7)) DAY)
             ELSE DATE_ADD(CAST(input AS DATE), INTERVAL (7 - MOD(DATE_DIFF(CAST(input AS DATE), DATE(EXTRACT(YEAR FROM input), 1, 1), DAY), 7)) DAY)
        END
    WHEN fmt IN ('IW') THEN 
        CASE WHEN MOD(DATE_DIFF(CAST(input AS DATE), 
                                CASE (EXTRACT(DAYOFWEEK FROM DATE(EXTRACT(YEAR FROM input), 1, 1)) - 1)
                                     WHEN 0 THEN DATE_ADD(DATE(EXTRACT(YEAR FROM input), 1, 1), INTERVAL 1 DAY)
                                     WHEN 1 THEN DATE_ADD(DATE(EXTRACT(YEAR FROM input), 1, 1), INTERVAL 0 DAY)
                                     WHEN 2 THEN DATE_ADD(DATE(EXTRACT(YEAR FROM input), 1, 1), INTERVAL -1 DAY)
                                     WHEN 3 THEN DATE_ADD(DATE(EXTRACT(YEAR FROM input), 1, 1), INTERVAL -2 DAY)
                                     WHEN 4 THEN DATE_ADD(DATE(EXTRACT(YEAR FROM input), 1, 1), INTERVAL -3 DAY)
                                     WHEN 5 THEN DATE_ADD(DATE(EXTRACT(YEAR FROM input), 1, 1), INTERVAL 3 DAY)
                                     WHEN 6 THEN DATE_ADD(DATE(EXTRACT(YEAR FROM input), 1, 1), INTERVAL 2 DAY)
                                END, DAY), 7) >= 4 
             THEN DATE_ADD(CAST(input AS DATE), INTERVAL (7 - MOD(DATE_DIFF(CAST(input AS DATE), 
                                CASE (EXTRACT(DAYOFWEEK FROM DATE(EXTRACT(YEAR FROM input), 1, 1)) - 1)
                                     WHEN 0 THEN DATE_ADD(DATE(EXTRACT(YEAR FROM input), 1, 1), INTERVAL 1 DAY)
                                     WHEN 1 THEN DATE_ADD(DATE(EXTRACT(YEAR FROM input), 1, 1), INTERVAL 0 DAY)
                                     WHEN 2 THEN DATE_ADD(DATE(EXTRACT(YEAR FROM input), 1, 1), INTERVAL -1 DAY)
                                     WHEN 3 THEN DATE_ADD(DATE(EXTRACT(YEAR FROM input), 1, 1), INTERVAL -2 DAY)
                                     WHEN 4 THEN DATE_ADD(DATE(EXTRACT(YEAR FROM input), 1, 1), INTERVAL -3 DAY)
                                     WHEN 5 THEN DATE_ADD(DATE(EXTRACT(YEAR FROM input), 1, 1), INTERVAL 3 DAY)
                                     WHEN 6 THEN DATE_ADD(DATE(EXTRACT(YEAR FROM input), 1, 1), INTERVAL 2 DAY)
                                END, DAY), 7)) DAY)
             ELSE DATE_ADD(CAST(input AS DATE), INTERVAL (0 - MOD(DATE_DIFF(CAST(input AS DATE), 
                                CASE (EXTRACT(DAYOFWEEK FROM DATE(EXTRACT(YEAR FROM input), 1, 1)) - 1)
                                     WHEN 0 THEN DATE_ADD(DATE(EXTRACT(YEAR FROM input), 1, 1), INTERVAL 1 DAY)
                                     WHEN 1 THEN DATE_ADD(DATE(EXTRACT(YEAR FROM input), 1, 1), INTERVAL 0 DAY)
                                     WHEN 2 THEN DATE_ADD(DATE(EXTRACT(YEAR FROM input), 1, 1), INTERVAL -1 DAY)
                                     WHEN 3 THEN DATE_ADD(DATE(EXTRACT(YEAR FROM input), 1, 1), INTERVAL -2 DAY)
                                     WHEN 4 THEN DATE_ADD(DATE(EXTRACT(YEAR FROM input), 1, 1), INTERVAL -3 DAY)
                                     WHEN 5 THEN DATE_ADD(DATE(EXTRACT(YEAR FROM input), 1, 1), INTERVAL 3 DAY)
                                     WHEN 6 THEN DATE_ADD(DATE(EXTRACT(YEAR FROM input), 1, 1), INTERVAL 2 DAY)
                                END, DAY), 7)) DAY)
        END
    WHEN fmt IN ('W') THEN 
        CASE WHEN MOD(DATE_DIFF(CAST(input AS DATE), DATE(EXTRACT(YEAR FROM input), EXTRACT(MONTH FROM input), 1), DAY), 7) < 4 
             THEN DATE_ADD(CAST(input AS DATE), INTERVAL (0 - MOD(DATE_DIFF(CAST(input AS DATE), DATE(EXTRACT(YEAR FROM input), EXTRACT(MONTH FROM input), 1), DAY), 7)) DAY)
             ELSE DATE_ADD(CAST(input AS DATE), INTERVAL (7 - MOD(DATE_DIFF(CAST(input AS DATE), DATE(EXTRACT(YEAR FROM input), EXTRACT(MONTH FROM input), 1), DAY), 7)) DAY)
        END
    WHEN fmt IN ('DDD', 'DD','J') THEN CAST(input AS DATE)
    WHEN fmt IN ('DAY', 'DY','D') THEN 
        CASE WHEN (EXTRACT(DAYOFWEEK FROM input) - 1) > 3 THEN DATE_ADD(CAST(input AS DATE), INTERVAL (7 - (EXTRACT(DAYOFWEEK FROM input) - 1)) DAY)
             ELSE DATE_ADD(CAST(input AS DATE), INTERVAL (0 - (EXTRACT(DAYOFWEEK FROM input) - 1)) DAY)
        END
    WHEN fmt IN ('HH', 'HH12','HH24') THEN CAST(input AS DATE)
    WHEN fmt IN ('MI') THEN CAST(input AS DATE)
  END
);