CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_cm.v_lil_period_type_2
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true
) AS
SELECT CAST(PETY.period_type_id AS BIGNUMERIC) AS per_tp_id,
 CAST(COALESCE(TRDE.trans_text, PETY.period_type_desc) AS STRING) AS per_tp_desc,
 CAST(COALESCE(TREN.trans_text, PETY.period_type_desc) AS STRING) AS per_tp_desc_en
FROM ldl_p_lew_process_mstr_ac.v_lil_period_type_2 AS PETY
 LEFT JOIN ldl_p_lew_process_mstr_ac.v_lil_translation_2 AS TRDE ON TRDE.context = 'PER_TP_DESC' AND PETY.period_type_id =
     TRDE.trans_id AND TRDE.lang_cd = 'DE' AND TRDE.active_fg = 1
 LEFT JOIN ldl_p_lew_process_mstr_ac.v_lil_translation_2 AS TREN ON TREN.context = 'PER_TP_DESC' AND PETY.period_type_id =
     TREN.trans_id AND TREN.lang_cd = 'EN' AND TREN.active_fg = 1;