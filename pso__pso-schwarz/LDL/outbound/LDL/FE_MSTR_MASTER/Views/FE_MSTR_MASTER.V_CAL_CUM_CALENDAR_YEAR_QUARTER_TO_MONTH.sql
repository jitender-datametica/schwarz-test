CREATE OR REPLACE VIEW fe_mstr_master.v_cal_cum_calendar_year_quarter_to_month (cal_month
OPTIONS(description='The calendar month for which the calendar-year-quarter-to-month interval is defined.'),
incl_cal_month
OPTIONS(description='The calendar month that needs to be included in the calendar-year-quarter-to-month interval.'),
dwh_created_tmsp OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp OPTIONS(description='The point in time when this record was created or last updated.'))
OPTIONS(DESCRIPTION = `THIS TABLE RELATES A MONTH TO ALL MONTHS THAT FORM THE CALENDAR-YEAR-QUARTER-TO-MONTH INTERVAL OF THIS MONTH. E.G. FOR MAY 2019 THIS IS APRIL AND MAY 2019.`)
AS SELECT cal_month,
 incl_cal_month,
 dwh_created_tmsp,
 dwh_updated_tmsp
FROM ldl_data_core_rel.t_cal_cum_calendar_year_quarter_to_month AS MAIN;