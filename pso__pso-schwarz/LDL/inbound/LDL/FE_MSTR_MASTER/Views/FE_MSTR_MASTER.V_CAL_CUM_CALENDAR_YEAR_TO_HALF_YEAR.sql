CREATE OR REPLACE VIEW FE_MSTR_MASTER.V_CAL_CUM_CALENDAR_YEAR_TO_HALF_YEAR (
cal_half_year COMMENT 'The calendar half year for which the calendar-year-to-half-year interval is defined.'
,incl_cal_half_year COMMENT 'The calendar half year that needs to be included in the calendar-year-to-half-year interval.'
,dwh_created_tmsp COMMENT 'The point in time when this record was created in the data warehouse.'
,dwh_updated_tmsp COMMENT 'The point in time when this record was created or last updated.'
) COMMENT = 'This table relates a calendar half year to all calendar half years that form the calendar-half-year-to-year interval of this business half year. E.g. for the20211 this is 20211 and 20212.' AS SELECT
main.cal_half_year AS cal_half_year
,main.incl_cal_half_year AS incl_cal_half_year
,main.dwh_created_tmsp AS dwh_created_tmsp
,main.dwh_updated_tmsp AS dwh_updated_tmsp 
FROM CORE_REL.T_CAL_CUM_CALENDAR_YEAR_TO_HALF_YEAR main;