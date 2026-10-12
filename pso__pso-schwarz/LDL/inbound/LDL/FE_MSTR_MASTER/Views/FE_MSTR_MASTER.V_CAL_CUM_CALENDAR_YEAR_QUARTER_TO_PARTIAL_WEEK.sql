CREATE OR REPLACE VIEW FE_MSTR_MASTER.V_CAL_CUM_CALENDAR_YEAR_QUARTER_TO_PARTIAL_WEEK (
part_week COMMENT 'The partial week for which the calendar-year-quarter-to-partial-week interval is defined'
,incl_part_week COMMENT 'The partial week that needs to be included in the calendar-year-quarter-to-partial-week interval.'
,dwh_created_tmsp COMMENT 'The point in time when this record was created in the data warehouse.'
,dwh_updated_tmsp COMMENT 'The point in time when this record was created or last updated.'
) COMMENT = 'This table relates a partial week to all partial weeks that form its calendar-year-quarter-to-partial-week interval.' AS SELECT
main.part_week AS part_week
,main.incl_part_week AS incl_part_week
,main.dwh_created_tmsp AS dwh_created_tmsp
,main.dwh_updated_tmsp AS dwh_updated_tmsp 
FROM CORE_REL.T_CAL_CUM_CALENDAR_YEAR_QUARTER_TO_PARTIAL_WEEK main;