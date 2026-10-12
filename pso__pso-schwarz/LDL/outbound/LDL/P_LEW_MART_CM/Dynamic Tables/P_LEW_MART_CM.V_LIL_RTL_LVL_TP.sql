
CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_cm.v_lil_rtl_lvl_tp
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true) AS
SELECT CAST(RLT.rtl_lvl AS BIGNUMERIC) AS rtl_lvl,
 CAST(COALESCE(TRDE.trans_text, LVL.rtl_lvl_desc) AS STRING) AS rtl_lvl_desc,
 CAST(COALESCE(TREN.trans_text, LVL.rtl_lvl_desc) AS STRING) AS rtl_lvl_desc_en,
 CAST(RLT.rtl_tp_id AS BIGNUMERIC) AS rtl_tp_id
FROM ldl_p_lew_process_mstr_ac.v_lil_rtl_lvl_tp AS RLT
 INNER JOIN ldl_p_lew_process_mstr_ac.v_lil_retailer_level AS LVL ON RLT.rtl_lvl = LVL.rtl_lvl
 LEFT JOIN ldl_p_lew_process_mstr_ac.v_lil_translation AS TRDE ON TRDE.context = 'RTL_LVL_DESC' AND RLT.rtl_lvl = TRDE.trans_id
      AND TRDE.lang_cd = 'DE' AND TRDE.active_fg = 1
 LEFT JOIN ldl_p_lew_process_mstr_ac.v_lil_translation AS TREN ON TREN.context = 'RTL_LVL_DESC' AND RLT.rtl_lvl = TREN.trans_id
      AND TREN.lang_cd = 'EN' AND TREN.active_fg = 1;


