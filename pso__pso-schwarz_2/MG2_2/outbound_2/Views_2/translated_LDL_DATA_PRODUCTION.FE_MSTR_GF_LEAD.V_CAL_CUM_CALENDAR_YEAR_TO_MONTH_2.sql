CREATE OR REPLACE VIEW ldl_data_production_fe_mstr_gf_lead.v_cal_cum_calendar_year_to_month_2 (cal_month
OPTIONS(description='The calendar_2 month for which the calendar_2-year-to-month interval is defined.'), incl_cal_month
OPTIONS(description='The calendar_2 month that needs to be included in the calendar_2-year-to-month interval.'),
dwh_created_tmsp OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp OPTIONS(description='The point in time when this record was created or last updated.'))
OPTIONS(DESCRIPTION = `THIS TABLE RELATES A MONTH TO ALL MONTHS THAT FORM THE CALENDAR_2-YEAR-TO-MONTH INTERVAL OF THIS MONTH. E.G. FOR MAY 2019 THIS IS JANUARY, FEBRUARY, MARCH, APRIL AND MAY 2019.`)
AS SELECT cal_month,
 incl_cal_month,
 dwh_created_tmsp,
 dwh_updated_tmsp
FROM ldl_data_production_core_rel.t_cal_cum_calendar_year_to_month_2 AS main;