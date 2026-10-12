CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_cal_cum_business_year_to_date_2 (cal_dt, incl_cal_dt) AS SELECT
 cal_dt,
 incl_cal_dt
FROM ldl_dig_lec_share.v_cal_cum_business_year_to_date_2;