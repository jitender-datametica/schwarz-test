CREATE OR REPLACE VIEW smp_production_fe_mstr_smp.v_dim_cal_month (cy_month, month_id, month_descr, month_of_year,
cy_month_seq, busyear) AS SELECT MON.cy_month,
 MON.month_id,
 DESCR.month_descr,
 CONCAT(DESCR.month_descr, ' ', SUBSTR(SUBSTR(CAST(MON.cy_month AS STRING), 1, 39), 0, 4)) AS month_of_year,
 MON.cy_month_seq,
 MON.busyear
FROM smp_production_data_shared_ldl.p_lew_core_t_cal_month AS MON
 INNER JOIN smp_production_data_shared_ldl.p_lew_core_t_cal_month_descr AS DESCR ON MON.month_id = DESCR.month_id AND
   DESCR.lang_sid = 9;