CREATE OR REPLACE VIEW FE_MSTR_MASTER.V_CAL_CUM_WEEK_TO_DATE (
cal_dt COMMENT 'The date for which the week-to-date interval is defined.'
,incl_cal_dt COMMENT 'The date that needs to be included in the week-to-date interval'
,dwh_created_tmsp COMMENT 'The point in time when this record was created in the data warehouse.'
,dwh_updated_tmsp COMMENT 'The point in time when this record was created or last updated.'
) COMMENT = 'This table relates a calendar date to all dates that form the week-to-date interval for this date. E.g. for Wednesday, July 24th 2019, this is Monday, July 22nd 2019, Tuesday, July 23rd 2019, and Wednesday, July 24th 2019.' AS SELECT
main.cal_dt AS cal_dt
,main.incl_cal_dt AS incl_cal_dt
,main.dwh_created_tmsp AS dwh_created_tmsp
,main.dwh_updated_tmsp AS dwh_updated_tmsp 
FROM CORE_REL.T_CAL_CUM_WEEK_TO_DATE main;