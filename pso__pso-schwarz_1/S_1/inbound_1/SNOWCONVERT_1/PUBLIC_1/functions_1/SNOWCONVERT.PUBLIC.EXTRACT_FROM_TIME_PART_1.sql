CREATE OR REPLACE FUNCTION SNOWCONVERT.PUBLIC.EXTRACT_FROM_TIME_PART("TS_INTERVAL" NUMBER(38,0), "TS_INTERVAL_PART" VARCHAR(16777216))
RETURNS NUMBER(38,0)
LANGUAGE SQL
AS '
select case 
when upper(ts_interval_part) in (''YEAR'') then
trunc(ts_interval/60/60/24/30/12)
when upper(ts_interval_part) in (''MONTH'') then
trunc(ts_interval/60/60/24) 
- trunc(ts_interval/60/60/24/30/12)*12*30
- (trunc(ts_interval/60/60/24/30) - trunc(ts_interval/60/60/24/30/12) *12)*30 


when upper(ts_interval_part) in (''DAY'') then

trunc(ts_interval/60/60/24) 
- trunc(ts_interval/60/60/24/30/12)*12*30
- (trunc(ts_interval/60/60/24/30) - trunc(ts_interval/60/60/24/30/12) *12)*30 

when upper(ts_interval_part) in (''HOUR'') then

trunc(ts_interval/60/60) 
- trunc(ts_interval/60/60/24/30/12)*12*30*24
- (trunc(ts_interval/60/60/24/30) - trunc(ts_interval/60/60/24/30/12) *12 )*30*24
- (trunc(ts_interval/60/60/24) - (trunc(ts_interval/60/60/24/30) - trunc(ts_interval/60/60/24/30/12) *12)*30 - trunc(ts_interval/60/60/24/30/12)*30*12)*24


when upper(ts_interval_part) in (''MINUTE'') then

trunc(ts_interval/60) 
- trunc(ts_interval/60/60/24/30/12)*12*30*24*60
- (trunc(ts_interval/60/60/24/30) - trunc(ts_interval/60/60/24/30/12) *12 )*30*24*60
- (trunc(ts_interval/60/60/24) - (trunc(ts_interval/60/60/24/30) - trunc(ts_interval/60/60/24/30/12) *12)*30 - trunc(ts_interval/60/60/24/30/12)*30*12)*24*60
- (trunc(ts_interval/60/60) - trunc(ts_interval/60/60/24/30/12)*12*30*24- (trunc(ts_interval/60/60/24/30) - trunc(ts_interval/60/60/24/30/12) *12 )*30*24- (trunc(ts_interval/60/60/24) - (trunc(ts_interval/60/60/24/30) - trunc(ts_interval/60/60/24/30/12) *12)*30 - trunc(ts_interval/60/60/24/30/12)*30*12)*24)*60


when upper(ts_interval_part) in (''SECOND'') then

trunc(ts_interval) 
- trunc(ts_interval/60/60/24/30/12)*12*30*24*60*60
- (trunc(ts_interval/60/60/24/30) - trunc(ts_interval/60/60/24/30/12) *12 )*30*24*60*60
- (trunc(ts_interval/60/60/24) - (trunc(ts_interval/60/60/24/30) - trunc(ts_interval/60/60/24/30/12) *12)*30 - trunc(ts_interval/60/60/24/30/12)*30*12)*24*60*60
- (trunc(ts_interval/60/60) - trunc(ts_interval/60/60/24/30/12)*12*30*24- (trunc(ts_interval/60/60/24/30) - trunc(ts_interval/60/60/24/30/12) *12 )*30*24- (trunc(ts_interval/60/60/24) - (trunc(ts_interval/60/60/24/30) - trunc(ts_interval/60/60/24/30/12) *12)*30 - trunc(ts_interval/60/60/24/30/12)*30*12)*24)*60*60
- (trunc(ts_interval/60) - trunc(ts_interval/60/60/24/30/12)*12*30*24*60- (trunc(ts_interval/60/60/24/30) - trunc(ts_interval/60/60/24/30/12) *12 )*30*24*60- (trunc(ts_interval/60/60/24) - (trunc(ts_interval/60/60/24/30) - trunc(ts_interval/60/60/24/30/12) *12)*30 - trunc(ts_interval/60/60/24/30/12)*30*12)*24*60- (trunc(ts_interval/60/60) - trunc(ts_interval/60/60/24/30/12)*12*30*24- (trunc(ts_interval/60/60/24/30) - trunc(ts_interval/60/60/24/30/12) *12 )*30*24- (trunc(ts_interval/60/60/24) - (trunc(ts_interval/60/60/24/30) - trunc(ts_interval/60/60/24/30/12) *12)*30 - trunc(ts_interval/60/60/24/30/12)*30*12)*24)*60)*60


else 
null
end
';