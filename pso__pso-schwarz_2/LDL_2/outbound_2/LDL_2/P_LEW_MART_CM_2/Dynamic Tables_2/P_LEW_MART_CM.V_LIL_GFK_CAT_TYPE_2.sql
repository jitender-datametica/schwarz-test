CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_cm.v_lil_gfk_cat_type_2
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true
) AS
SELECT CASE
  WHEN GCTY.gfk_cat_type_cd = 'All'
  THEN 0
  WHEN GCTY.gfk_cat_type_cd = 'Vers1'
  THEN 1
  WHEN GCTY.gfk_cat_type_cd = 'Vers2'
  THEN 2
  ELSE NULL
  END AS gfk_cat_type_id,
 CAST(COALESCE(TRDE.trans_text, GCTY.gfk_cat_type_name) AS STRING) AS gfk_cat_type_name,
 CAST(COALESCE(TREN.trans_text, GCTY.gfk_cat_type_name) AS STRING) AS gfk_cat_type_name_en
FROM ldl_p_lew_core_ac.v_ref_lil_gfk_cat_type_2 AS GCTY
 LEFT JOIN ldl_p_lew_process_mstr_ac.v_lil_translation_2 AS TRDE ON TRDE.context = 'GFK_CAT_TYPE_NAME' AND GCTY.gfk_cat_type_cd
      = TRDE.src_trans_cd AND TRDE.lang_cd = 'DE' AND TRDE.active_fg = 1
 LEFT JOIN ldl_p_lew_process_mstr_ac.v_lil_translation_2 AS TREN ON TREN.context = 'GFK_CAT_TYPE_NAME' AND GCTY.gfk_cat_type_cd
      = TREN.src_trans_cd AND TREN.lang_cd = 'EN' AND TREN.active_fg = 1;