CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_ejr_store_day_cashier_stat_1 AS SELECT client_id,
 loc_sid AS store_id,
 FARM_FINGERPRINT(CAST(cashier_id AS STRING)) AS cashier_id,
 dat_formdate,
 MAX(CASE
   WHEN recordtype_id = 201
   THEN val_stat_amount
   ELSE 0
   END) AS val_shouldbe_turnover,
 MAX(CASE
   WHEN recordtype_id = 202
   THEN stat_count
   ELSE 0
   END) AS cnt_customer,
 MAX(CASE
   WHEN recordtype_id = 203
   THEN val_stat_amount
   ELSE 0
   END) AS val_avg_purchase,
 MAX(CASE
   WHEN recordtype_id = 204
   THEN stat_count
   ELSE 0
   END) AS cnt_pos_total,
 MAX(CASE
   WHEN recordtype_id = 205
   THEN val_stat_amount
   ELSE 0
   END) AS val_pos_per_minute,
 MAX(CASE
   WHEN recordtype_id = 206
   THEN val_stat_amount
   ELSE 0
   END) AS val_pos_per_purchase,
 MAX(CASE
   WHEN recordtype_id = 301
   THEN stat_count
   ELSE 0
   END) AS val_servicetime
FROM (SELECT client_id,
    loc_sid,
    cashier_id,
    dwh_cal_dt AS dat_formdate,
    statistic_id AS recordtype_id,
    statistic_cnt AS stat_count,
    statistic_val AS val_stat_amount
   FROM ldl_p_lew_core_ac.v_pos_ctrl_statistic_1 AS SL
   WHERE statistic_id BETWEEN 201 AND 206
   UNION ALL
   SELECT client_id,
    loc_sid,
    cashier_id,
    dwh_cal_dt AS dat_formdate,
    ROUND(CAST(ti_cd AS BIGNUMERIC), 0) AS recordtype_id,
    ROUND(CAST(ti_cnt AS BIGNUMERIC), 0) AS ti_count,
    CAST(NULL AS NUMERIC)
   FROM ldl_p_lew_core_ac.v_pos_ctrl_time_list_1 AS TI
   WHERE CAST(ti_cd AS FLOAT64) = 301) AS slti
WHERE cashier_id >= 0
GROUP BY client_id,
 store_id,
 cashier_id,
 dat_formdate;