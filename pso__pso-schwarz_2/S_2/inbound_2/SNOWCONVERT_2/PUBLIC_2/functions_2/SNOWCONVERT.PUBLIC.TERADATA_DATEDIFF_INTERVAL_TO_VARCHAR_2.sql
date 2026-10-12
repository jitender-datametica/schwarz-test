CREATE OR REPLACE FUNCTION SNOWCONVERT.PUBLIC.TERADATA_DATEDIFF_INTERVAL_TO_VARCHAR("TS1" TIMESTAMP_NTZ(9), "TS2" TIMESTAMP_NTZ(9))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
AS 'CASE WHEN sign(datediff(''second'', TS2, TS1)) >= 0 -- datediff is positive
     THEN
         floor(DATEDIFF(''second'',   TS2, TS1)/(60*60*24))                                            || '' '' || -- days
         iff(floor(mod(DATEDIFF(''second'',   TS2, TS1)/(60*60),24)) < 10, 
             to_varchar(''0'' || floor(mod(DATEDIFF(''second'',   TS2, TS1)/(60*60),24))),                         -- add zero if hour < 10
             to_varchar(         floor(mod(DATEDIFF(''second'',   TS2, TS1)/(60*60),24))))             || '':'' || -- hours
         iff(floor(mod(DATEDIFF(''second'',   TS2, TS1)/(60),60)) < 10,
             to_varchar(''0'' || floor(mod(DATEDIFF(''second'',   TS2, TS1)/(60),60))),                            -- add zero if min < 10
             to_varchar(         floor(mod(DATEDIFF(''second'',   TS2, TS1)/(60),60))))                || '':'' || -- minutes
         iff(mod(DATEDIFF(''second'',   TS2, TS1),60) < 10,
             to_varchar(''0'' || mod(DATEDIFF(''second'',   TS2, TS1),60)),                                        -- add zero if sec < 10
             to_varchar(         mod(DATEDIFF(''second'',   TS2, TS1),60)))                                        -- seconds
     ELSE -- datediff is negative
         ''-'' ||
         floor(DATEDIFF(''second'',   TS1, TS2)/(60*60*24))                                            || '' '' || -- days
         iff(floor(mod(DATEDIFF(''second'',   TS1, TS2)/(60*60),24)) < 10, 
             to_varchar(''0'' || floor(mod(DATEDIFF(''second'',   TS1, TS2)/(60*60),24))),                         -- add zero if hour < 10
             to_varchar(         floor(mod(DATEDIFF(''second'',   TS1, TS2)/(60*60),24))))             || '':'' || -- hours
         iff(floor(mod(DATEDIFF(''second'',   TS1, TS2)/(60),60)) < 10,
             to_varchar(''0'' || floor(mod(DATEDIFF(''second'',   TS1, TS2)/(60),60))),                            -- add zero if min < 10
             to_varchar(         floor(mod(DATEDIFF(''second'',   TS1, TS2)/(60),60))))                || '':'' || -- minutes
         iff(mod(DATEDIFF(''second'',   TS1, TS2),60) < 10,
             to_varchar(''0'' || mod(DATEDIFF(''second'',   TS1, TS2),60)),                                        -- add zero if sec < 10
             to_varchar(         mod(DATEDIFF(''second'',   TS1, TS2),60)))                                        -- seconds
END';