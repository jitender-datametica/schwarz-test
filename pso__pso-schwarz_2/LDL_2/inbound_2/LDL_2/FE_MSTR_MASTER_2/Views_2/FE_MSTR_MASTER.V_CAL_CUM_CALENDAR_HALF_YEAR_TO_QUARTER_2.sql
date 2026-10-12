CREATE OR REPLACE VIEW FE_MSTR_MASTER.V_CAL_CUM_CALENDAR_HALF_YEAR_TO_QUARTER_2 (
cal_year_qtr COMMENT 'The calendar_2 year quarter for which the calendar_2-half-year-to-quarter interval is defined.'
,incl_cal_year_qtr COMMENT 'The calendar_2 year quarter that needs to be included in the calendar_2-half-year-to-quarter interval.'
,dwh_created_tmsp COMMENT 'The point in time when this record was created in the data warehouse.'
,dwh_updated_tmsp COMMENT 'The point in time when this record was created or last updated.'
) COMMENT = 'This table relates a calendar_2 year quarter to all calendar_2 year quarters that form the calendar_2-half-year-to-quarter interval of this quarter. E.g. for Q2/2021 this is Q1/2021 and Q2/2021.' AS SELECT
main.cal_year_qtr AS cal_year_qtr
,main.incl_cal_year_qtr AS incl_cal_year_qtr
,main.dwh_created_tmsp AS dwh_created_tmsp
,main.dwh_updated_tmsp AS dwh_updated_tmsp 
FROM CORE_REL.T_CAL_CUM_CALENDAR_HALF_YEAR_TO_QUARTER_2 main;