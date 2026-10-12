CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_cm.v_lil_client_2
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true
) AS
SELECT CAST(RM.region_id AS BIGNUMERIC) AS client_id,
 LEFT(RM.src_region_cd, 3) AS country_iso_cd,
 CAST(COALESCE(DSDE.region_name, RM.region_name_de, RM.region_name_en) AS STRING) AS client_desc,
 CAST(COALESCE(DSEN.region_name, RM.region_name_en) AS STRING) AS client_desc_en,
 CAST(RM.region_short_desc AS STRING) AS client_short_desc,
 CAST(COALESCE(DSDE.region_long_descr, RM.region_long_desc) AS STRING) AS client_long_desc,
 CAST(COALESCE(DSEN.region_long_descr, RM.region_long_desc) AS STRING) AS client_long_desc_en,
 CAST(RM.region_srt_cd AS BIGNUMERIC) AS client_srt_cd,
 CAST(RM.qr_srt_cd AS BIGNUMERIC) AS qr_srt_cd,
  CASE
  WHEN CAST(RM.region_id AS BIGNUMERIC) = 7
  THEN 0
  ELSE CAST(RM.region_srt_cd AS BIGNUMERIC)
  END AS cc_srt_cd,
 CAST(RM.region_lvl AS BIGNUMERIC) AS client_lvl,
 SUBSTR(CAST(CL.curr_cd AS STRING), 1, 3) AS currency_iso_cd,
 CAST(REPLACE(RM.sd_chld_below_12, BLDE.src_trans_cd, BLDE.trans_text) AS STRING) AS sd_chld_below_12,
 CAST(RM.sd_chld_below_12 AS STRING) AS sd_chld_below_12_en,
 CAST(REPLACE(RM.sd_chld_over_12, OVDE.src_trans_cd, OVDE.trans_text) AS STRING) AS sd_chld_over_12,
 CAST(RM.sd_chld_over_12 AS STRING) AS sd_chld_over_12_en
FROM ldl_p_lew_process_mstr_ac.v_lil_region_2 AS RM
 INNER JOIN ldl_p_lew_core_ac.v_lil_region_2 AS RC ON RM.region_sid = RC.region_sid
 INNER JOIN ldl_p_lew_core_ac.v_client_2 AS CL ON RC.client_id = CL.client_id AND RC.country_sid = CL.country_sid
 LEFT JOIN ldl_p_lew_core_ac.v_lil_region_descr_2 AS DSDE ON RC.client_id = DSDE.client_id AND RC.region_sid = DSDE.region_sid
     AND DSDE.lang_cd = 'DE'
 LEFT JOIN ldl_p_lew_core_ac.v_lil_region_descr_2 AS DSEN ON RC.client_id = DSEN.client_id AND RC.region_sid = DSEN.region_sid
     AND DSEN.lang_cd = 'EN'
 LEFT JOIN ldl_p_lew_process_mstr_ac.v_lil_translation_2 AS BLDE ON BLDE.context = 'SD_CHLD' AND RM.sd_chld_below_12 LIKE
     BLDE.src_trans_cd || '%' AND BLDE.lang_cd = 'DE'
 LEFT JOIN ldl_p_lew_process_mstr_ac.v_lil_translation_2 AS OVDE ON OVDE.context = 'SD_CHLD' AND RM.sd_chld_over_12 LIKE
     OVDE.src_trans_cd || '%' AND OVDE.lang_cd = 'DE'
WHERE RM.region_lvl IN (3, 6, 9);