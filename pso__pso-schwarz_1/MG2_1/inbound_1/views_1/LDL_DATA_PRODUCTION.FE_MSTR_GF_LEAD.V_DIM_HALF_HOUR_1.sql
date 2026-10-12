create or replace view LDL_DATA_PRODUCTION.FE_MSTR_GF_LEAD.V_DIM_HALF_HOUR_1(
	HALF_HR COMMENT 'The unique identifier for a half-hour interval. Format: hhmm, indicating the begin time of the half-hour interval, with hh being the hour component and mm_1 the minute component. ',
	HALF_HR_BEGIN_TM COMMENT 'The start time (inclusive) of the half-hour interval. E.g. 00:00:00 for the interval from 00:00:00 to 00:29:59.',
	HALF_HR_END_TM COMMENT 'The end time (inclusive) of the half-hour interval. E.g. 00:29:59 for the interval from 00:00:00 to 00:29:59.',
	HR COMMENT 'The hour of day, i.e.a number in the range from 0 to 23.',
	DWH_CREATED_TMSP COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP COMMENT 'The point in time when this record was created or last updated.'
) COMMENT='This minor dimension contains the 48 half-hour intrvals of a day.'
 as SELECT
main.half_hr AS half_hr
,main.half_hr_begin_tm AS half_hr_begin_tm
,main.half_hr_end_tm AS half_hr_end_tm
,main.hr AS hr
,main.dwh_created_tmsp AS dwh_created_tmsp
,main.dwh_updated_tmsp AS dwh_updated_tmsp 
FROM CORE_DIM.T_DIM_HALF_HOUR_1 main;