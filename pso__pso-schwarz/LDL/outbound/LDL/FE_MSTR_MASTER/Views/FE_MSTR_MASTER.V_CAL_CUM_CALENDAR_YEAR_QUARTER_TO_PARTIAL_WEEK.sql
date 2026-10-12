CREATE OR REPLACE VIEW fe_mstr_master.v_cal_cum_calendar_year_quarter_to_partial_week (part_week
OPTIONS(description='The partial week for which the calendar-year-quarter-to-partial-week interval is defined'),
incl_part_week
OPTIONS(description='The partial week that needs to be included in the calendar-year-quarter-to-partial-week interval.'),
dwh_created_tmsp OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp OPTIONS(description='The point in time when this record was created or last updated.'))
OPTIONS(DESCRIPTION = `THIS TABLE RELATES A PARTIAL WEEK TO ALL PARTIAL WEEKS THAT FORM ITS CALENDAR-YEAR-QUARTER-TO-PARTIAL-WEEK INTERVAL.`)
AS SELECT part_week,
 incl_part_week,
 dwh_created_tmsp,
 dwh_updated_tmsp
FROM ldl_data_core_rel.t_cal_cum_calendar_year_quarter_to_partial_week AS MAIN;