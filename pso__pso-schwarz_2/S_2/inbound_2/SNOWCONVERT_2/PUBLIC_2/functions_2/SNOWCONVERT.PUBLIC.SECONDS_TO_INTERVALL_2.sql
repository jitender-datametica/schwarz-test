CREATE OR REPLACE FUNCTION SNOWCONVERT.PUBLIC.SECONDS_TO_INTERVALL("NUMBER_OF_SECONDS" NUMBER(38,5))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
AS 'CASE WHEN sign(Number_of_seconds) >= 0 -- Number of seconds is positive
        THEN
         floor(Number_of_seconds/(60*60*24))                                            || '' '' || -- days
         iff(floor(mod(Number_of_seconds/(60*60),24)) < 10, 
             to_varchar(''0'' || floor(mod(Number_of_seconds/(60*60),24))),                         -- add zero if hour < 10
             to_varchar(       floor(mod(Number_of_seconds/(60*60),24))))             || '':'' || -- hours
         iff(floor(mod(Number_of_seconds/(60),60)) < 10,
             to_varchar(''0'' || floor(mod(Number_of_seconds/(60),60))),                            -- add zero if min < 10
             to_varchar(       floor(mod(Number_of_seconds/(60),60))))                || '':'' || -- minutes
         iff(mod(Number_of_seconds,60) < 10,
             to_varchar(''0'' || floor(mod(Number_of_seconds,60))),                                        -- add zero if sec < 10
             to_varchar(       floor(mod(Number_of_seconds,60))))                                        -- seconds
     WHEN sign(Number_of_seconds) = -1-- datediff is negative
        THEN  ''-'' ||
         floor(Number_of_seconds/(60*60*24))                                            || '' '' || -- days
         iff(floor(mod(Number_of_seconds/(60*60),24)) < 10, 
             to_varchar(''0'' || floor(mod(Number_of_seconds/(60*60),24))),                         -- add zero if hour < 10
             to_varchar(       floor(mod(Number_of_seconds/(60*60),24))))             || '':'' || -- hours
         iff(floor(mod(Number_of_seconds/(60),60)) < 10,
             to_varchar(''0'' || floor(mod(Number_of_seconds/(60),60))),                            -- add zero if min < 10
             to_varchar(       floor(mod(Number_of_seconds/(60),60))))                || '':'' || -- minutes
         iff(mod(Number_of_seconds,60) < 10,
             to_varchar(''0'' || floor(mod(Number_of_seconds,60))),                                        -- add zero if sec < 10
             to_varchar(       floor(mod(Number_of_seconds,60))))                                        -- seconds
END';