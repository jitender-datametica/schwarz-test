
CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_cm.v_lil_protection_2
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true) AS
SELECT CAST(PROT.prot_fg AS BIGNUMERIC) AS prot_fg,
 CAST(COALESCE(TRDE.trans_text, PROT.description) AS STRING) AS description,
 CAST(COALESCE(TREN.trans_text, PROT.description) AS STRING) AS description_en
FROM ldl_p_lew_process_mstr_ac.v_lil_protection_2 AS PROT
 LEFT JOIN ldl_p_lew_process_mstr_ac.v_lil_translation_2 AS TRDE ON TRDE.context = 'PROT_DESC' AND PROT.prot_fg = TRDE.trans_id
      AND TRDE.lang_cd = 'DE' AND TRDE.active_fg = 1
 LEFT JOIN ldl_p_lew_process_mstr_ac.v_lil_translation_2 AS TREN ON TREN.context = 'PROT_DESC' AND PROT.prot_fg = TREN.trans_id
      AND TREN.lang_cd = 'EN' AND TREN.active_fg = 1;

