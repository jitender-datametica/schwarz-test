CREATE OR REPLACE FUNCTION SNOWCONVERT.PUBLIC.TERADATA_INTERVAL_TO_SECONDS("TD_INTERVAL" VARCHAR(50))
RETURNS NUMBER(38,5)
LANGUAGE SQL
AS 'CASE WHEN substr(TD_INTERVAL, 1,1) != ''-''
    THEN 
        CASE WHEN LENGTH(TD_INTERVAL) = 10 --Bsp. 0 10:15:15
                THEN (((substr(TD_INTERVAL,1,1)*86400) + hour(to_time(right(TD_INTERVAL,8)))*3600 + minute(to_time(right(TD_INTERVAL,8)))*60 + second(to_time(right(TD_INTERVAL,8)))))
             WHEN LENGTH(TD_INTERVAL) = 11 --Bsp. 10 10:15:15
                THEN ((substr(TD_INTERVAL,1,2)*86400) + hour(to_time(right(TD_INTERVAL,8)))*3600 + minute(to_time(right(TD_INTERVAL,8)))*60 + second(to_time(right(TD_INTERVAL,8))))
             WHEN LENGTH(TD_INTERVAL) = 12 --Bsp. 100 10:15:15
                THEN ((substr(TD_INTERVAL,1,3)*86400) + hour(to_time(right(TD_INTERVAL,8)))*3600 + minute(to_time(right(TD_INTERVAL,8)))*60 + second(to_time(right(TD_INTERVAL,8))))
        END
    ELSE
        CASE WHEN LENGTH(TD_INTERVAL) = 11 --Bsp. -0 10:15:15
                THEN -1*(((substr(TD_INTERVAL,2,1)*86400) + hour(to_time(right(TD_INTERVAL,8)))*3600 + minute(to_time(right(TD_INTERVAL,8)))*60 + second(to_time(right(TD_INTERVAL,8)))))
             WHEN LENGTH(TD_INTERVAL) = 12 --Bsp. -10 10:15:15
                THEN -1* ((substr(TD_INTERVAL,2,2)*86400) + hour(to_time(right(TD_INTERVAL,8)))*3600 + minute(to_time(right(TD_INTERVAL,8)))*60 + second(to_time(right(TD_INTERVAL,8))))
             WHEN LENGTH(TD_INTERVAL) = 13 --Bsp. -100 10:15:15
                THEN -1* ((substr(TD_INTERVAL,2,3)*86400) + hour(to_time(right(TD_INTERVAL,8)))*3600 + minute(to_time(right(TD_INTERVAL,8)))*60 + second(to_time(right(TD_INTERVAL,8))))
        END
   END';