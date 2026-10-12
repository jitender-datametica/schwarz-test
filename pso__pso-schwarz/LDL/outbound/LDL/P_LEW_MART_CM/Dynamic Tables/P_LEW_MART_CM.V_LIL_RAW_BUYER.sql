
CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_cm.v_lil_raw_buyer
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true) AS
SELECT CAST(DCF.data_confidence_fg AS BIGNUMERIC) AS raw_buyer_id,
 CAST(COALESCE(TRDE.trans_text, DCF.data_confidence_desc) AS STRING) AS description,
 CAST(COALESCE(TREN.trans_text, DCF.data_confidence_desc) AS STRING) AS description_en
FROM ldl_p_lew_process_mstr_ac.v_lil_data_confidence AS DCF
 LEFT JOIN ldl_p_lew_process_mstr_ac.v_lil_translation AS TRDE ON TRDE.context = 'RAW_BUYER_DESC' AND DCF.data_confidence_fg
      = TRDE.trans_id AND TRDE.lang_cd = 'DE' AND TRDE.active_fg = 1
 LEFT JOIN ldl_p_lew_process_mstr_ac.v_lil_translation AS TREN ON TREN.context = 'RAW_BUYER_DESC' AND DCF.data_confidence_fg
      = TREN.trans_id AND TREN.lang_cd = 'EN' AND TREN.active_fg = 1;


