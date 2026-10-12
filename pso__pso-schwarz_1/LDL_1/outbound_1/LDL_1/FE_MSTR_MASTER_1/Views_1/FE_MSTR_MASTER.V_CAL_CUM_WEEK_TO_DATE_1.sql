CREATE OR REPLACE VIEW fe_mstr_master.v_cal_cum_week_to_date_1 (cal_dt
OPTIONS(description='The date for which the week-to-date interval is defined.'), incl_cal_dt
OPTIONS(description='The date that needs to be included in the week-to-date interval'), dwh_created_tmsp
OPTIONS(description='The point in time when this record was created in the data warehouse.'), dwh_updated_tmsp
OPTIONS(description='The point in time when this record was created or last updated.'))
OPTIONS(DESCRIPTION = `THIS TABLE RELATES A CALENDAR_1 DATE TO ALL DATES THAT FORM THE WEEK-TO-DATE INTERVAL FOR THIS DATE. E.G. FOR WEDNESDAY, JULY 24TH 2019, THIS IS MONDAY, JULY 22ND 2019, TUESDAY, JULY 23RD 2019, AND WEDNESDAY, JULY 24TH 2019.`)
AS SELECT cal_dt,
 incl_cal_dt,
 dwh_created_tmsp,
 dwh_updated_tmsp
FROM ldl_data_core_rel.t_cal_cum_week_to_date_1 AS MAIN;