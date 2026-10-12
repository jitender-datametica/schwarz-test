
CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_cm.v_lil_currency_2
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true
) AS
SELECT SUBSTR(CAST(CUMS.currency_iso_cd AS STRING), 1, 3) AS currency_iso_cd,
 CAST(COALESCE(TRDE.trans_text, CUMS.currency_desc) AS STRING) AS currency_desc,
 CAST(COALESCE(TREN.trans_text, CUMS.currency_desc) AS STRING) AS currency_desc_en,
 CAST(CUMS.currency_srt_cd AS BIGNUMERIC) AS currency_srt_cd,
 CAST(CUMS.currency_srt_cd AS BIGNUMERIC) AS currency_srt
FROM ldl_p_lew_process_mstr_ac.v_lil_currency_2 AS CUMS
 LEFT JOIN ldl_p_lew_process_mstr_ac.v_lil_translation_2 AS TRDE ON TRDE.context = 'CURRENCY_DESC' AND CUMS.currency_iso_cd
      = TRDE.src_trans_cd AND TRDE.lang_cd = 'DE' AND TRDE.active_fg = 1
 LEFT JOIN ldl_p_lew_process_mstr_ac.v_lil_translation_2 AS TREN ON TREN.context = 'CURRENCY_DESC' AND CUMS.currency_iso_cd
      = TREN.src_trans_cd AND TREN.lang_cd = 'EN' AND TREN.active_fg = 1;