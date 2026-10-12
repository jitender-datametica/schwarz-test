create or replace view LDL_DATA_PRODUCTION.FE_MSTR_GF_LEAD.V_CAL_CUM_CALENDAR_HALF_YEAR_TO_QUARTER(
	CAL_YEAR_QTR COMMENT 'The calendar year quarter for which the calendar-half-year-to-quarter interval is defined.',
	INCL_CAL_YEAR_QTR COMMENT 'The calendar year quarter that needs to be included in the calendar-half-year-to-quarter interval.',
	DWH_CREATED_TMSP COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP COMMENT 'The point in time when this record was created or last updated.'
) COMMENT='This table relates a calendar year quarter to all calendar year quarters that form the calendar-half-year-to-quarter interval of this quarter. E.g. for Q2/2021 this is Q1/2021 and Q2/2021.'
 as SELECT
main.cal_year_qtr AS cal_year_qtr
,main.incl_cal_year_qtr AS incl_cal_year_qtr
,main.dwh_created_tmsp AS dwh_created_tmsp
,main.dwh_updated_tmsp AS dwh_updated_tmsp 
FROM CORE_REL.T_CAL_CUM_CALENDAR_HALF_YEAR_TO_QUARTER main;