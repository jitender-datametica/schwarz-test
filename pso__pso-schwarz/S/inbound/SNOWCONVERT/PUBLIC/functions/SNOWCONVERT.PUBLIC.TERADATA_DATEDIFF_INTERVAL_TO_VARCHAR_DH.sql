CREATE OR REPLACE FUNCTION SNOWCONVERT.PUBLIC.TERADATA_DATEDIFF_INTERVAL_TO_VARCHAR_DH("TS1" TIMESTAMP_NTZ(9), "TS2" TIMESTAMP_NTZ(9))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
AS 'CASE WHEN sign(datediff(''second'', TS2, TS1)) >= 0 -- datediff is positive
     THEN
         floor(DATEDIFF(''second'',   TS2, TS1)/(60*60*24))                                            || '' '' || -- days
         to_varchar(floor(mod(DATEDIFF(''second'',   TS2, TS1)/(60*60),24)))                                       -- hours
     ELSE -- datediff is negative
         ''-'' ||
         floor(DATEDIFF(''second'',   TS1, TS2)/(60*60*24))                                            || '' '' || -- days
         to_varchar(floor(mod(DATEDIFF(''second'',   TS1, TS2)/(60*60),24)))                                       -- hours
END';