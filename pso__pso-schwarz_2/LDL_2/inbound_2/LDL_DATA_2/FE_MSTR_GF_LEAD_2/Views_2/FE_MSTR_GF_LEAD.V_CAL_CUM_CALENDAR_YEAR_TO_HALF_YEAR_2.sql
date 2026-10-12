CREATE OR REPLACE VIEW FE_MSTR_GF_LEAD.V_CAL_CUM_CALENDAR_YEAR_TO_HALF_YEAR_2 (
cal_half_year COMMENT 'The calendar_2 half year for which the calendar_2-year-to-half-year interval is defined.'
,incl_cal_half_year COMMENT 'The calendar_2 half year that needs to be included in the calendar_2-year-to-half-year interval.'
,dwh_created_tmsp COMMENT 'The point in time when this record was created in the data warehouse.'
,dwh_updated_tmsp COMMENT 'The point in time when this record was created or last updated.'
) COMMENT = 'This table relates a calendar_2 half year to all calendar_2 half years that form the calendar_2-half-year-to-year interval of this business half year. E.g. for the20211 this is 20211 and 20212.' AS SELECT
main.cal_half_year AS cal_half_year
,main.incl_cal_half_year AS incl_cal_half_year
,main.dwh_created_tmsp AS dwh_created_tmsp
,main.dwh_updated_tmsp AS dwh_updated_tmsp 
FROM CORE_REL.T_CAL_CUM_CALENDAR_YEAR_TO_HALF_YEAR_2 main;