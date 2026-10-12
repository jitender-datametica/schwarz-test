CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_fact_nps_quote_2 (wshop_cd, cal_dt, person_cnt_val, positive_cnt_val
, negative_cnt_val) AS SELECT wshop_cd,
 cal_dt,
 person_cnt_val,
 positive_cnt_val,
 negative_cnt_val
FROM ldl_dig_lec_share.v_fact_nps_quote_2;