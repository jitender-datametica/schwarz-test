create or replace view LDL_DATA_PRODUCTION.FE_MSTR_GF_LEAD.V_DIM_HOUR_1(
	HR COMMENT 'The hour of day, i.e.a number in the range from 0 to 23.',
	HR_BEGIN_TM COMMENT 'The start time (inclusive) of the one-hour interval. E.g. 00:00:00 for the interval from 00:00:00 to 00:59:59.',
	HR_END_TM COMMENT 'The end time (inclusive) of the one-hour interval. E.g. 00:59:59 for the interval from 00:00:00 to 00:59:59.',
	DWH_CREATED_TMSP COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP COMMENT 'The point in time when this record was created or last updated.'
) COMMENT='This minor dimension contains the 24 hours of a day.'
 as SELECT
main.hr AS hr
,main.hr_begin_tm AS hr_begin_tm
,main.hr_end_tm AS hr_end_tm
,main.dwh_created_tmsp AS dwh_created_tmsp
,main.dwh_updated_tmsp AS dwh_updated_tmsp 
FROM CORE_DIM.T_DIM_HOUR_1 main;