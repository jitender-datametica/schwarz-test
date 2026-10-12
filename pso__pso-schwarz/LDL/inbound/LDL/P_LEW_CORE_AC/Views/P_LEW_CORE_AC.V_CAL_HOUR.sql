CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_CAL_HOUR
(
   hr                                   COMMENT 'The hour of day, i.e. a number in the range from 0 to 23.'
   ,hr_begin_tm                         COMMENT 'The start time (inclusive) of the one-hour interval. E.g. 00:00:00 for the interval from 00:00:00 to 00:59:59'
   ,hr_end_tm                           COMMENT 'The end time (inclusive) of the one-hour interval. E.g. 00:59:59 for the interval from 00:00:00 to 00:59:59.'
   ,dwh_load_id                         COMMENT 'Identifier of the last run that inserted or updated this row.'
   ,dwh_created                         COMMENT 'Creation timestamp of the record in the DWH.'
   ,dwh_updated                         COMMENT 'Timestamp of the last update of the record in the DWH.'
) COMMENT = 'This table contains the 24 hours of a day.'
AS 
    SELECT 
		hr           
		,hr_begin_tm 
		,hr_end_tm   
		,dwh_load_id 
		,dwh_created 
		,dwh_updated 
		
FROM P_LEW_CORE.T_CAL_HOUR ;