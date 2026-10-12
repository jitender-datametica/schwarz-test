CREATE OR REPLACE VIEW fe_mstr_master.v_cal_cum_calendar_year_to_quarter_2 (cal_year_qtr
OPTIONS(description='The calendar_2 year quarter for which the calendar_2-year-to-quarter interval is defined.'),
incl_cal_year_qtr
OPTIONS(description='The calendar_2 year quarter that needs to be included in the calendar_2-year-to-quarter interval.'),
dwh_created_tmsp OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp OPTIONS(description='The point in time when this record was created or last updated.'))
OPTIONS(DESCRIPTION = `THIS TABLE RELATES A CALENDAR_2 YEAR QUARTER TO ALL CALENDAR_2 YEAR QUARTERS THAT FORM THE CALENDAR_2-YEAR-TO-QUARTER INTERVAL OF THIS QUARTER. E.G. FOR Q3/2021 THIS IS Q1/2021, Q2/2021 AND Q3/2021.`)
AS SELECT cal_year_qtr,
 incl_cal_year_qtr,
 dwh_created_tmsp,
 dwh_updated_tmsp
FROM ldl_data_core_rel.t_cal_cum_calendar_year_to_quarter_2 AS MAIN;