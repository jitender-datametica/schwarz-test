CREATE OR REPLACE VIEW fe_mstr_master.v_cal_cum_calendar_year_to_date (cal_dt
OPTIONS(description='The date for which the calendar-year-to-date interval is defined.'), incl_cal_dt
OPTIONS(description='The date that needs to be included in the calendar-year-to-date interval.'), dwh_created_tmsp
OPTIONS(description='The point in time when this record was created in the data warehouse.'), dwh_updated_tmsp
OPTIONS(description='The point in time when this record was created or last updated.'))
OPTIONS(DESCRIPTION = `THIS TABLE RELATES A CALENDAR DATE TO ALL DATES THAT FORM THE CALENDAR-YEAR-TO-DATE INTERVAL FOR THIS DATE. E.G. FOR FEBRUARY 15TH 2019 THIS IS ALL DATES FROM JANUARY 1ST 2019 TO FEBRUARY 15TH, INCLUSIVELY.`)
AS SELECT cal_dt,
 incl_cal_dt,
 dwh_created_tmsp,
 dwh_updated_tmsp
FROM ldl_data_core_rel.t_cal_cum_calendar_year_to_date AS MAIN;