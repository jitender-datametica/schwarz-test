CREATE OR REPLACE VIEW ldl_p_lew_mart_analytics.v_ftm_customer (client_id, country_code, dat_formdate, cy_week, store_id
, orig_store_nr, cnt_cust) AS SELECT AGG_EJR.client_id,
 RCTRY.country_iso_cd AS country_code,
 AGG_EJR.dat_formdate,
 TAG.cy_week,
 AGG_EJR.store_id,
 AGG_EJR.orig_store_nr,
 SUM(AGG_EJR.cnt_customer_asis) AS cnt_cust
FROM ldl_p_lew_mart_msi_ac.v_agg_str_day_ejr_txj_ww_asis AS AGG_EJR
 INNER JOIN ldl_p_lew_mart_msi_ac.v_ref_country AS RCTRY ON AGG_EJR.client_id = RCTRY.country_id
 INNER JOIN ldl_p_lew_mart_msi_ac.v_cal_calendarday AS TAG ON AGG_EJR.dat_formdate = TAG.dat_calendar
WHERE AGG_EJR.currency_iso_cd = 'EUR'
GROUP BY AGG_EJR.client_id,
 country_code,
 AGG_EJR.dat_formdate,
 TAG.cy_week,
 AGG_EJR.store_id,
 AGG_EJR.orig_store_nr;