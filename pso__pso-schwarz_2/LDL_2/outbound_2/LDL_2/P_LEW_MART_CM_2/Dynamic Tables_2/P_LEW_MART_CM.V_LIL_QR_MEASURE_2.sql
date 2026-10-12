
CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_cm.v_lil_qr_measure_2
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true) AS
SELECT ROUND(CAST(qrm.key_field AS BIGNUMERIC), 0) AS qr_meas_id,
 CAST(COALESCE(TRDE.trans_text, qrm.val) AS STRING) AS qr_meas_desc,
 CAST(COALESCE(TREN.trans_text, qrm.val) AS STRING) AS qr_meas_desc_en
FROM (SELECT key_field,
   val
  FROM ldl_p_lew_process_mstr_ac.v_lil_code_2
  WHERE main_code = 'QR_MEASURE'
   AND sub_code = 'QR_MEAS_DESC') AS qrm
 LEFT JOIN ldl_p_lew_process_mstr_ac.v_lil_translation_2 AS TRDE ON TRDE.context = 'QR_MEAS_DESC' AND TRDE.trans_id =
     ROUND(CAST(qrm.key_field AS BIGNUMERIC), 0) AND TRDE.lang_cd = 'DE' AND TRDE.active_fg = 1
 LEFT JOIN ldl_p_lew_process_mstr_ac.v_lil_translation_2 AS TREN ON TREN.context = 'QR_MEAS_DESC' AND TREN.trans_id =
     ROUND(CAST(qrm.key_field AS BIGNUMERIC), 0) AND TREN.lang_cd = 'EN' AND TREN.active_fg = 1;

