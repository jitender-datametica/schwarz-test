
CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_cm.v_lil_qr_retailer_2
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true) AS
SELECT qrtl.qr_rtl_id,
 qrtl.rtl_desc,
 COALESCE(RTL.rtl_desc_en, qrtl.rtl_desc) AS rtl_desc_en,
 qrtl.qr_rtl_srt_cd
FROM (SELECT ROUND(CAST(TRUNC(CAST(key_field AS BIGNUMERIC)) AS BIGNUMERIC), 0) AS qr_rtl_id,
   MIN(CAST(CASE
      WHEN sub_code = 'RTL_DESC'
      THEN val
      ELSE NULL
      END AS STRING)) AS rtl_desc,
   MIN(ROUND(CAST(TRUNC(CAST(CASE
         WHEN sub_code = 'QR_RTL_SRT_CD'
         THEN val
         ELSE NULL
         END AS BIGNUMERIC)) AS BIGNUMERIC), 0)) AS qr_rtl_srt_cd
  FROM ldl_p_lew_process_mstr_ac.v_lil_code_2
  WHERE main_code = 'QR_RETAILER'
  GROUP BY qr_rtl_id) AS qrtl
 LEFT JOIN ldl_p_lew_mart_cm.v_lil_retailer_2 AS RTL ON qrtl.qr_rtl_id = RTL.rtl_id;

