CREATE OR REPLACE VIEW ldl_data_production_fe_mstr_gf_lead.v_cal_cum_calendar_year_to_half_year_1 (cal_half_year
OPTIONS(description='The calendar_1 half year for which the calendar_1-year-to-half-year interval is defined.'),
incl_cal_half_year
OPTIONS(description='The calendar_1 half year that needs to be included in the calendar_1-year-to-half-year interval.'),
dwh_created_tmsp OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp OPTIONS(description='The point in time when this record was created or last updated.'))
OPTIONS(DESCRIPTION = `THIS TABLE RELATES A CALENDAR_1 HALF YEAR TO ALL CALENDAR_1 HALF YEARS THAT FORM THE CALENDAR_1-HALF-YEAR-TO-YEAR INTERVAL OF THIS BUSINESS HALF YEAR. E.G. FOR THE20211 THIS IS 20211 AND 20212.`)
AS SELECT cal_half_year,
 incl_cal_half_year,
 dwh_created_tmsp,
 dwh_updated_tmsp
FROM ldl_data_production_core_rel.t_cal_cum_calendar_year_to_half_year_1 AS main;