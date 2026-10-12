
CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_cm.v_lil_retailer_type
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true) AS
SELECT CAST(RTY.rtl_tp_id AS BIGNUMERIC) AS rtl_tp_id,
 CAST(COALESCE(TDSCDE.trans_text, RTY.rtl_tp_desc) AS STRING) AS rtl_tp_desc,
 CAST(COALESCE(TDSCEN.trans_text, RTY.rtl_tp_desc) AS STRING) AS rtl_tp_desc_en,
 CAST(COALESCE(TOTHDE.trans_text, 'Other Retailers') AS STRING) AS rtl_tp_other,
 CAST(COALESCE(TOTHEN.trans_text, 'Other Retailers') AS STRING) AS rtl_tp_other_en,
 CAST(COALESCE(TTOTSELDE.trans_text, 'Total of Selected') AS STRING) AS rtl_tp_total_of_selected,
 CAST(COALESCE(TTOTSELEN.trans_text, 'Total of Selected') AS STRING) AS rtl_tp_total_of_selected_en
FROM ldl_p_lew_process_mstr_ac.v_lil_retailer_type AS RTY
 LEFT JOIN ldl_p_lew_process_mstr_ac.v_lil_translation AS TDSCDE ON TDSCDE.context = 'RTL_TP_DESC' AND RTY.rtl_tp_id =
     TDSCDE.trans_id AND TDSCDE.lang_cd = 'DE' AND TDSCDE.active_fg = 1
 LEFT JOIN ldl_p_lew_process_mstr_ac.v_lil_translation AS TDSCEN ON TDSCEN.context = 'RTL_TP_DESC' AND RTY.rtl_tp_id =
     TDSCEN.trans_id AND TDSCEN.lang_cd = 'EN' AND TDSCEN.active_fg = 1
 LEFT JOIN ldl_p_lew_process_mstr_ac.v_lil_translation AS TOTHDE ON TOTHDE.context = 'RTL_TP_OTHER' AND TOTHDE.trans_id
     = 0 AND TOTHDE.lang_cd = 'DE' AND TOTHDE.active_fg = 1
 LEFT JOIN ldl_p_lew_process_mstr_ac.v_lil_translation AS TOTHEN ON TOTHEN.context = 'RTL_TP_OTHER' AND TOTHEN.trans_id
     = 0 AND TOTHEN.lang_cd = 'EN' AND TOTHEN.active_fg = 1
 LEFT JOIN ldl_p_lew_process_mstr_ac.v_lil_translation AS TTOTSELDE ON TTOTSELDE.context = 'RTL_TP_TOTSEL' AND TTOTSELDE
     .trans_id = 0 AND TTOTSELDE.lang_cd = 'DE' AND TTOTSELDE.active_fg = 1
 LEFT JOIN ldl_p_lew_process_mstr_ac.v_lil_translation AS TTOTSELEN ON TTOTSELEN.context = 'RTL_TP_TOTSEL' AND TTOTSELEN
     .trans_id = 0 AND TTOTSELEN.lang_cd = 'EN' AND TTOTSELEN.active_fg = 1;


