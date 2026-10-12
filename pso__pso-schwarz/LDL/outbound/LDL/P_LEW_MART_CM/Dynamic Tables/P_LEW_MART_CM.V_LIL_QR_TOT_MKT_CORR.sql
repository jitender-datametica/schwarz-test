CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_cm.v_lil_qr_tot_mkt_corr
OPTIONS(enable_refresh = true, refresh_interval_minutes = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true) AS
SELECT
  datm.client_id,
  rtl.rtl_id1 AS rtl_id,
  datm.per_id,
  datm.currency_iso_cd,
  CAST(CASE 
    WHEN rtl.rtl_id1 = datm.rtl_id THEN 0 
    ELSE -SUM(datm.val) 
  END AS NUMERIC) AS corr_val_k,
  CAST(CASE 
    WHEN rtl.rtl_id1 = datm.rtl_id THEN 0 
    ELSE -SUM(datm.py_val) 
  END AS NUMERIC) AS corr_py_val_k
FROM ldl_p_lew_mart_cm.v_lil_lift_data_act AS datm
CROSS JOIN (
  SELECT
    SAFE_CAST(val AS INT64) AS rtl_id1
  FROM ldl_p_lew_process_mstr_ac.v_lil_code
  WHERE main_code = 'QR_TOT_MKT_CORR'
    AND sub_code = 'FLTR_RTL_ID'
) AS rtl
LEFT JOIN (
  SELECT
    da_i.client_id,
    da_i.rtl_id,
    da_i.per_id,
    da_i.currency_iso_cd
  FROM ldl_p_lew_mart_cm.v_lil_lift_data_act AS da_i
  WHERE da_i.meas_id = (SELECT SAFE_CAST(val AS INT64) FROM ldl_p_lew_process_mstr_ac.v_lil_code WHERE main_code='QR_TOT_MKT_CORR' AND sub_code='PARAM' AND key_field='MEAS_ID')
    AND da_i.prom_id = (SELECT SAFE_CAST(val AS INT64) FROM ldl_p_lew_process_mstr_ac.v_lil_code WHERE main_code='QR_TOT_MKT_CORR' AND sub_code='PARAM' AND key_field='PROM_ID')
    AND da_i.lift_cat_id = (SELECT SAFE_CAST(val AS INT64) FROM ldl_p_lew_process_mstr_ac.v_lil_code WHERE main_code='QR_TOT_MKT_CORR' AND sub_code='PARAM' AND key_field='LIFT_CAT_ID')
    AND COALESCE(da_i.val, 0) >= 1
    AND da_i.rtl_id <> (SELECT SAFE_CAST(val AS INT64) FROM ldl_p_lew_process_mstr_ac.v_lil_code WHERE main_code='QR_TOT_MKT_CORR' AND sub_code='PARAM' AND key_field='TOT_MKT_RTL_ID')
  GROUP BY 1, 2, 3, 4
) AS da
  ON  da.client_id = datm.client_id
  AND da.rtl_id = rtl.rtl_id1
  AND da.per_id = datm.per_id
  AND da.currency_iso_cd = datm.currency_iso_cd
WHERE datm.meas_id = (SELECT SAFE_CAST(val AS INT64) FROM ldl_p_lew_process_mstr_ac.v_lil_code WHERE main_code='QR_TOT_MKT_CORR' AND sub_code='PARAM' AND key_field='MEAS_ID')
  AND datm.rtl_id = (SELECT SAFE_CAST(val AS INT64) FROM ldl_p_lew_process_mstr_ac.v_lil_code WHERE main_code='QR_TOT_MKT_CORR' AND sub_code='PARAM' AND key_field='TOT_MKT_RTL_ID')
  AND da.rtl_id IS NULL  /* This ensures the "No selected retailer present" logic */
  AND datm.prom_id = (SELECT SAFE_CAST(val AS INT64) FROM ldl_p_lew_process_mstr_ac.v_lil_code WHERE main_code='QR_TOT_MKT_CORR' AND sub_code='PARAM' AND key_field='PROM_ID')
  AND datm.lift_cat_id = (SELECT SAFE_CAST(val AS INT64) FROM ldl_p_lew_process_mstr_ac.v_lil_code WHERE main_code='QR_TOT_MKT_CORR' AND sub_code='PARAM' AND key_field='LIFT_CAT_ID')
GROUP BY 1, 2, 3, 4, datm.rtl_id;
