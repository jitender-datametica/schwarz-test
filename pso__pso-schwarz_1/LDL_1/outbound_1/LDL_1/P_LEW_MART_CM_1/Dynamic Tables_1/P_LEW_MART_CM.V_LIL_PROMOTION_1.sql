CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_cm.v_lil_promotion_1
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true
) AS
SELECT PROMC.promotion_brand_id as prom_id,
 CAST(COALESCE(TRDE.trans_text, PROMP.promotion_brand_descr) AS STRING) AS prom_desc,
 CAST(COALESCE(TREN.trans_text, PROMP.promotion_brand_descr) AS STRING) AS prom_desc_en,
 CAST(COALESCE(DSDE.promotion_brand_short_descr, PROMC.promotion_brand_short_descr) AS STRING) AS prom_short_desc,
 CAST(COALESCE(DSEN.promotion_brand_short_descr, PROMC.promotion_brand_short_descr) AS STRING) AS prom_short_desc_en,
 CAST(PROMC.promotion_brand_level AS BIGNUMERIC) AS prom_lvl,
 PROMP.liam1_srt_cd,
 PROMP.lift1_srt_cd
FROM ldl_p_lew_core_ac.v_ref_lil_promotion_brand_1 AS PROMC
 INNER JOIN ldl_p_lew_process_mstr_ac.v_ref_lil_promotion_brand_1 AS PROMP ON PROMC.promotion_brand_id = PROMP.promotion_brand_id
  
 LEFT JOIN ldl_p_lew_process_mstr_ac.v_lil_translation_1 AS TRDE ON TRDE.context = 'PROM_IND_DESC' AND PROMC.promotion_brand_id
      = TRDE.trans_id AND TRDE.lang_cd = 'DE' AND TRDE.active_fg = 1
 LEFT JOIN ldl_p_lew_process_mstr_ac.v_lil_translation_1 AS TREN ON TREN.context = 'PROM_IND_DESC' AND PROMC.promotion_brand_id
      = TREN.trans_id AND TREN.lang_cd = 'EN' AND TREN.active_fg = 1
 LEFT JOIN ldl_p_lew_core_ac.v_ref_lil_promotion_brand_descr_1 AS DSDE ON PROMC.promotion_brand_id = DSDE.promotion_brand_id
    AND DSDE.lang_cd = 'DE'
 LEFT JOIN ldl_p_lew_core_ac.v_ref_lil_promotion_brand_descr_1 AS DSEN ON PROMC.promotion_brand_id = DSEN.promotion_brand_id
    AND DSEN.lang_cd = 'EN';

