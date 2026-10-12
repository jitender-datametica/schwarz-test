CREATE OR REPLACE FUNCTION SNOWCONVERT.PUBLIC.INT_TO_TIME_UDF("INPUT_1" NUMBER(38,0))
RETURNS TIME(9)
LANGUAGE SQL
AS '
SELECT to_time(concat(substr(to_varchar(INPUT_1,''FM000000''),1,2), '':'' ,substr(to_varchar(INPUT_1,''FM000000''),3,2),'':'',substr(to_varchar(INPUT_1,''FM000000''),5,2)))
';