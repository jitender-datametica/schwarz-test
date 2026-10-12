CREATE OR REPLACE VIEW ldl_data_production_fe_mstr_gf_lead.v_cal_cum_calendar_half_year_to_partial_week (part_week
OPTIONS(description='The partial week for which the calendar-half-year-to-partial-week interval is defined'),
incl_part_week
OPTIONS(description='The partial week that needs to be included in the calendar-half-year-to-partial-week interval.'),
dwh_created_tmsp OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp OPTIONS(description='The point in time when this record was created or last updated.'))
OPTIONS(DESCRIPTION = `THIS TABLE RELATES A PARTIAL WEEK TO ALL PARTIAL WEEKS THAT FORM ITS CALENDAR-HALF-YEAR-TO-PARTIAL-WEEK INTERVAL.`)
AS SELECT part_week,
 incl_part_week,
 dwh_created_tmsp,
 dwh_updated_tmsp
FROM ldl_data_production_core_rel.t_cal_cum_calendar_half_year_to_partial_week AS main;