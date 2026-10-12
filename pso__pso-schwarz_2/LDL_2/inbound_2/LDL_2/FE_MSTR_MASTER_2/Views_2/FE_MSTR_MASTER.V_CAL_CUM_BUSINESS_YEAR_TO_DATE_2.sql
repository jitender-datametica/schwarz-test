CREATE OR REPLACE VIEW FE_MSTR_MASTER.V_CAL_CUM_BUSINESS_YEAR_TO_DATE_2 (
cal_dt COMMENT 'The date for which the business-year-to-date interval is defined.'
,incl_cal_dt COMMENT 'The date that needs to be included in the business-year-to-date interval.'
,dwh_created_tmsp COMMENT 'The point in time when this record was created in the data warehouse.'
,dwh_updated_tmsp COMMENT 'The point in time when this record was created or last updated.'
) COMMENT = 'This table relates a calendar_2 date to all dates that form the business-year-to-date interval for this date. E.g. for April 15th 2019 this is all dates from March 1st 2019 to April 15th, inclusively.' AS SELECT
main.cal_dt AS cal_dt
,main.incl_cal_dt AS incl_cal_dt
,main.dwh_created_tmsp AS dwh_created_tmsp
,main.dwh_updated_tmsp AS dwh_updated_tmsp 
FROM CORE_REL.T_CAL_CUM_BUSINESS_YEAR_TO_DATE_2 main;