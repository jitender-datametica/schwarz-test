
CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_cm.v_lil_qr_prom_measure_1 AS
SELECT qprm.meas_id,
 COALESCE(TRDE.trans_text, qprm.prom_meas_desc) AS prom_meas_desc,
 COALESCE(TREN.trans_text, qprm.prom_meas_desc) AS prom_meas_desc_en,
 qprm.srt_cd,
 qprm.prom_meas_id,
 MEAS.meas_tp_id
FROM (SELECT MIN(ROUND(CAST(TRUNC(CAST(CASE
         WHEN sub_code = 'MEAS_ID'
         THEN val
         ELSE NULL
         END AS BIGNUMERIC)) AS BIGNUMERIC), 0)) AS meas_id,
   MIN(CAST(CASE
      WHEN sub_code = 'PROM_MEAS_DESC'
      THEN val
      ELSE NULL
      END AS STRING)) AS prom_meas_desc,
   ROUND(CAST(TRUNC(CAST(key_field AS BIGNUMERIC)) AS BIGNUMERIC), 0) AS srt_cd,
   MIN(ROUND(CAST(TRUNC(CAST(CASE
         WHEN sub_code = 'PROM_MEAS_ID'
         THEN val
         ELSE NULL
         END AS BIGNUMERIC)) AS BIGNUMERIC), 0)) AS prom_meas_id
  FROM ldl_p_lew_process_mstr_ac.v_lil_code_1
  WHERE main_code = 'QR_PROM_MEASURE'
  GROUP BY srt_cd) AS qprm
 INNER JOIN ldl_p_lew_mart_cm.v_lil_measure_1 AS MEAS ON qprm.meas_id = MEAS.meas_id
 LEFT JOIN ldl_p_lew_process_mstr_ac.v_lil_translation_1 AS TRDE ON TRDE.context = 'PROM_MEAS_DESC' AND qprm.srt_cd = TRDE
     .trans_id AND TRDE.lang_cd = 'DE' AND TRDE.active_fg = 1
 LEFT JOIN ldl_p_lew_process_mstr_ac.v_lil_translation_1 AS TREN ON TREN.context = 'PROM_MEAS_DESC' AND qprm.srt_cd = TREN
     .trans_id AND TREN.lang_cd = 'EN' AND TREN.active_fg = 1;

