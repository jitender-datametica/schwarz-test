CREATE OR REPLACE VIEW FE_MSTR_GF_LEAD.V_CAL_CUM_CALENDAR_YEAR_QUARTER_TO_DATE_1 (
cal_dt COMMENT 'The date for which the calendar_1-year-quarter-to-date interval is defined.'
,incl_cal_dt COMMENT 'The date that needs to be included in the calendar_1-year-quarter-to-date interval.'
,dwh_created_tmsp COMMENT 'The point in time when this record was created in the data warehouse.'
,dwh_updated_tmsp COMMENT 'The point in time when this record was created or last updated.'
) COMMENT = 'This table relates a calendar_1 date to all dates that form the calendar_1-year-quarter-to-date interval for this date. E.g. for August 15th 2021 this is all dates from July 1st 2021 to August 15th, inclusively.' AS SELECT
main.cal_dt AS cal_dt
,main.incl_cal_dt AS incl_cal_dt
,main.dwh_created_tmsp AS dwh_created_tmsp
,main.dwh_updated_tmsp AS dwh_updated_tmsp 
FROM CORE_REL.T_CAL_CUM_CALENDAR_YEAR_QUARTER_TO_DATE_1 main;