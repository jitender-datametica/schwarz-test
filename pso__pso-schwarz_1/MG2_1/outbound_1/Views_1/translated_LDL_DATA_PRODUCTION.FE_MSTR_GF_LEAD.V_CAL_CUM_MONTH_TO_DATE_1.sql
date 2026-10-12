CREATE OR REPLACE VIEW ldl_data_production_fe_mstr_gf_lead.v_cal_cum_month_to_date_1 (cal_dt
OPTIONS(description='The date for which the year-to-date interval is defined.'), incl_cal_dt
OPTIONS(description='The date that needs to be included in the year-to-date interval'), dwh_created_tmsp
OPTIONS(description='The point in time when this record was created in the data warehouse.'), dwh_updated_tmsp
OPTIONS(description='The point in time when this record was created or last updated.'))
OPTIONS(DESCRIPTION = `THIS TABLE RELATES A CALENDAR_1 DATE TO ALL DATES THAT FORM THE MONTH-TO-DATE INTERVAL FOR THIS DATE. E.G. FOR FEBRUARY 15TH 2019 THIS IS ALL DATES FROM FEBRUARY 1ST 2019 TO FEBRUARY 15TH, INCLUSIVELY.`)
AS SELECT cal_dt,
 incl_cal_dt,
 dwh_created_tmsp,
 dwh_updated_tmsp
FROM ldl_data_production_core_rel.t_cal_cum_month_to_date_1 AS main;