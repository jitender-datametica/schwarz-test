CREATE OR REPLACE FUNCTION SNOWCONVERT.PUBLIC.TIME_PART_TO_VARIANT("TS_INTERVAL" NUMBER(38,0))
RETURNS OBJECT
LANGUAGE SQL
AS '
select OBJECT_CONSTRUCT(
''YEAR'',SNOWCONVERT.PUBLIC.extract_from_time_part(ts_interval,''YEAR''),
''MONTH'',SNOWCONVERT.PUBLIC.extract_from_time_part(ts_interval,''MONTH''),
''DAY'',SNOWCONVERT.PUBLIC.extract_from_time_part(ts_interval,''DAY''),
''HOUR'',SNOWCONVERT.PUBLIC.extract_from_time_part(ts_interval,''HOUR''),
''MINUTE'',SNOWCONVERT.PUBLIC.extract_from_time_part(ts_interval,''MINUTE''),
''SECOND'',SNOWCONVERT.PUBLIC.extract_from_time_part(ts_interval,''SECOND'')
) 
';