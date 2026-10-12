create or replace view LDL_DATA_PRODUCTION.FE_MSTR_GF_LEAD.V_CAL_CUM_CALENDAR_HALF_YEAR_TO_MONTH_2(
	CAL_MONTH COMMENT 'The calendar_2 month for which the calendar_2-half-year-to-month interval is defined.',
	INCL_CAL_MONTH COMMENT 'The calendar_2 month that needs to be included in the calendar_2-half-year-to-month interval.',
	DWH_CREATED_TMSP COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP COMMENT 'The point in time when this record was created or last updated.'
) COMMENT='This table relates a month to all months that form the calendar_2-half-year-to-month interval of this month. E.g. for May 2019 this is January, February, March, April and May 2019.'
 as SELECT
main.cal_month AS cal_month
,main.incl_cal_month AS incl_cal_month
,main.dwh_created_tmsp AS dwh_created_tmsp
,main.dwh_updated_tmsp AS dwh_updated_tmsp 
FROM CORE_REL.T_CAL_CUM_CALENDAR_HALF_YEAR_TO_MONTH_2 main;