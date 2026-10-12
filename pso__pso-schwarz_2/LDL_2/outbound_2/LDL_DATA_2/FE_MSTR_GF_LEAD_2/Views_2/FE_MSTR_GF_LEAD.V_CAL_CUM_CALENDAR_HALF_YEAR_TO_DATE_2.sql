CREATE OR REPLACE VIEW ldl_data_fe_mstr_gf_lead.v_cal_cum_calendar_half_year_to_date_2 (cal_dt
OPTIONS(description='The date for which the calendar_2-half-year-to-date interval is defined.'), incl_cal_dt
OPTIONS(description='The date that needs to be included in the calendar_2-half-year-to-date interval.'), dwh_created_tmsp
OPTIONS(description='The point in time when this record was created in the data warehouse.'), dwh_updated_tmsp
OPTIONS(description='The point in time when this record was created or last updated.'))
OPTIONS(DESCRIPTION = `THIS TABLE RELATES A CALENDAR_2 DATE TO ALL DATES THAT FORM THE CALENDAR_2-HALF-YEAR-TO-DATE INTERVAL FOR THIS DATE. E.G. FOR AUGUST 15TH 2021 THIS IS ALL DATES FROM JULY 1ST 2021 TO AUGUST 15TH, INCLUSIVELY.`)
AS SELECT cal_dt,
 incl_cal_dt,
 dwh_created_tmsp,
 dwh_updated_tmsp
FROM ldl_data_core_rel.t_cal_cum_calendar_half_year_to_date_2 AS MAIN;