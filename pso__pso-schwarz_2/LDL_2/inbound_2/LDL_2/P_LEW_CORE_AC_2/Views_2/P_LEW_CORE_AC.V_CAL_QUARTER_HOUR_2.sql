CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_CAL_QUARTER_HOUR_2 
(
   qtr_hr                               COMMENT 'The unique identifier for a quarter-hour interval. Format: hhmm, indicating the begin time of the quarter-hour interval, with hh being the hour component and mm_2 the minute component. '
   ,half_hr                             COMMENT 'The unique identifier for a half-hour interval. Format: hhmm, indicating the begin time of the half-hour interval, with hh being the hour component and mm_2 the minute component. '
   ,hr                                  COMMENT 'The hour of day, i.e. a number in the range from 0 to 23.'
   ,qtr_hr_begin_tm                     COMMENT 'The start time (inclusive) of the quarter-hour interval. E.g. 00:00:00 for the interval from 00:00:00 to 00:14:59.'
   ,qtr_hr_end_tm                       COMMENT 'The end time (inclusive) of the quarter-hour interval. E.g. 00:14:59 for the interval from 00:00:00 to 00:14:59.'
   ,dwh_load_id                         COMMENT 'Identifier of the last run that inserted or updated this row.'
   ,dwh_created                         COMMENT 'Creation timestamp of the record in the DWH.'
   ,dwh_updated                         COMMENT 'Timestamp of the last update of the record in the DWH.'
) COMMENT = 'This table contains the 96 quarter-hour intervals of a day.'
AS 
    SELECT 
		qtr_hr                     
		,half_hr                   
		,hr                        
		,qtr_hr_begin_tm           
		,qtr_hr_end_tm             
		,dwh_load_id               
		,dwh_created               
		,dwh_updated               
		
FROM P_LEW_CORE.T_CAL_QUARTER_HOUR_2 ;