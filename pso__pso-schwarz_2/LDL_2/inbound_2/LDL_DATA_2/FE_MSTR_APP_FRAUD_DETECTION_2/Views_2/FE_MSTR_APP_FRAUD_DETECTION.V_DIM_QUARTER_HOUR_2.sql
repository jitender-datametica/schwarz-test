CREATE OR REPLACE VIEW FE_MSTR_APP_FRAUD_DETECTION.V_DIM_QUARTER_HOUR_2 (
qtr_hr COMMENT 'The unique identifier for a quarter-hour interval. Format: hhmm, indicating the begin time of the quarter-hour interval, with hh being the hour component and mm_2 the minute component. '
,qtr_hr_begin_tm COMMENT 'The start time (inclusive) of the quarter-hour interval. E.g. 00:00:00 for the interval from 00:00:00 to 00:14:59.'
,qtr_hr_end_tm COMMENT 'The end time (inclusive) of the quarter-hour interval. E.g. 00:14:59 for the interval from 00:00:00 to 00:14:59.'
,hr COMMENT 'The hour of day, i.e.a number in the range from 0 to 23.'
,half_hr COMMENT 'The unique identifier for a half-hour interval. Format: hhmm, indicating the begin time of the half-hour interval, with hh being the hour component and mm_2 the minute component. '
,dwh_created_tmsp COMMENT 'The point in time when this record was created in the data warehouse.'
,dwh_updated_tmsp COMMENT 'The point in time when this record was created or last updated.'
) COMMENT = 'This minor dimension contains the 96 quarter-hour intervals of a day.' AS SELECT
main.qtr_hr AS qtr_hr
,main.qtr_hr_begin_tm AS qtr_hr_begin_tm
,main.qtr_hr_end_tm AS qtr_hr_end_tm
,main.hr AS hr
,main.half_hr AS half_hr
,main.dwh_created_tmsp AS dwh_created_tmsp
,main.dwh_updated_tmsp AS dwh_updated_tmsp 
FROM CORE_DIM.T_DIM_QUARTER_HOUR_2 main;