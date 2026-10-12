create or replace view LDL_DATA_PRODUCTION.FE_MSTR_GF_LEAD.V_CAL_CUM_CALENDAR_YEAR_TO_DATE(
	CAL_DT COMMENT 'The date for which the calendar-year-to-date interval is defined.',
	INCL_CAL_DT COMMENT 'The date that needs to be included in the calendar-year-to-date interval.',
	DWH_CREATED_TMSP COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP COMMENT 'The point in time when this record was created or last updated.'
) COMMENT='This table relates a calendar date to all dates that form the calendar-year-to-date interval for this date. E.g. for February 15th 2019 this is all dates from January 1st 2019 to February 15th, inclusively.'
 as SELECT
main.cal_dt AS cal_dt
,main.incl_cal_dt AS incl_cal_dt
,main.dwh_created_tmsp AS dwh_created_tmsp
,main.dwh_updated_tmsp AS dwh_updated_tmsp 
FROM CORE_REL.T_CAL_CUM_CALENDAR_YEAR_TO_DATE main;