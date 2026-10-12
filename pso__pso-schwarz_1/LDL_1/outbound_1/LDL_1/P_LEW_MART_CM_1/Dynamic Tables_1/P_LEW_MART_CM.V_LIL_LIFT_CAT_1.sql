CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_cm.v_lil_lift_cat_1
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true
) AS
SELECT GFKP.gfk_cat_id,
  CASE
  WHEN GFKC.gfk_cat_type_cd = 'All'
  THEN 0
  WHEN GFKC.gfk_cat_type_cd = 'Vers1'
  THEN 1
  WHEN GFKC.gfk_cat_type_cd = 'Vers2'
  THEN 2
  ELSE NULL
  END AS gfk_cat_type_id,
 CAST(CASE
   WHEN GFKC.gfk_cat_level = 1 AND CASE
      WHEN GFKC.gfk_cat_type_cd = 'All'
      THEN 0
      WHEN GFKC.gfk_cat_type_cd = 'Vers1'
      THEN 1
      WHEN GFKC.gfk_cat_type_cd = 'Vers2'
      THEN 2
      ELSE NULL
      END = 0
   THEN GFKP.gfk_cat_name_de
   WHEN GFKC.gfk_cat_level = 2 AND CASE
      WHEN GFKC.gfk_cat_type_cd = 'All'
      THEN 0
      WHEN GFKC.gfk_cat_type_cd = 'Vers1'
      THEN 1
      WHEN GFKC.gfk_cat_type_cd = 'Vers2'
      THEN 2
      ELSE NULL
      END = 1
   THEN '   ' || GFKP.gfk_cat_name_de
   WHEN GFKC.gfk_cat_level = 3 AND CASE
      WHEN GFKC.gfk_cat_type_cd = 'All'
      THEN 0
      WHEN GFKC.gfk_cat_type_cd = 'Vers1'
      THEN 1
      WHEN GFKC.gfk_cat_type_cd = 'Vers2'
      THEN 2
      ELSE NULL
      END = 1
   THEN '      ' || GFKP.gfk_cat_name_de
   WHEN GFKC.gfk_cat_level = 2 AND CASE
      WHEN GFKC.gfk_cat_type_cd = 'All'
      THEN 0
      WHEN GFKC.gfk_cat_type_cd = 'Vers1'
      THEN 1
      WHEN GFKC.gfk_cat_type_cd = 'Vers2'
      THEN 2
      ELSE NULL
      END = 2
   THEN GFKP.gfk_cat_short_name || ' ' || GFKP.gfk_cat_name_de
   ELSE NULL
   END AS STRING) AS lift_cat_text,
 CAST(CASE
   WHEN GFKC.gfk_cat_level = 1 AND CASE
      WHEN GFKC.gfk_cat_type_cd = 'All'
      THEN 0
      WHEN GFKC.gfk_cat_type_cd = 'Vers1'
      THEN 1
      WHEN GFKC.gfk_cat_type_cd = 'Vers2'
      THEN 2
      ELSE NULL
      END = 0
   THEN GFKP.gfk_cat_name_en
   WHEN GFKC.gfk_cat_level = 2 AND CASE
      WHEN GFKC.gfk_cat_type_cd = 'All'
      THEN 0
      WHEN GFKC.gfk_cat_type_cd = 'Vers1'
      THEN 1
      WHEN GFKC.gfk_cat_type_cd = 'Vers2'
      THEN 2
      ELSE NULL
      END = 1
   THEN '   ' || GFKP.gfk_cat_name_en
   WHEN GFKC.gfk_cat_level = 3 AND CASE
      WHEN GFKC.gfk_cat_type_cd = 'All'
      THEN 0
      WHEN GFKC.gfk_cat_type_cd = 'Vers1'
      THEN 1
      WHEN GFKC.gfk_cat_type_cd = 'Vers2'
      THEN 2
      ELSE NULL
      END = 1
   THEN '      ' || GFKP.gfk_cat_name_en
   WHEN GFKC.gfk_cat_level = 2 AND CASE
      WHEN GFKC.gfk_cat_type_cd = 'All'
      THEN 0
      WHEN GFKC.gfk_cat_type_cd = 'Vers1'
      THEN 1
      WHEN GFKC.gfk_cat_type_cd = 'Vers2'
      THEN 2
      ELSE NULL
      END = 2
   THEN GFKP.gfk_cat_short_name || ' ' || GFKP.gfk_cat_name_en
   ELSE NULL
   END AS STRING) AS lift_cat_text_en,
 GFKP.gfk_cat_name_en,
 GFKP.gfk_cat_name_de,
 GFKP.gfk_cat_short_name,
 CAST(GFKC.gfk_cat_level AS BIGNUMERIC) AS cat_lvl,
 COALESCE(TRDE.trans_text, 'LEVEL' || CAST(GFKC.gfk_cat_level AS STRING)) AS cat_lvl_desc,
 COALESCE(TREN.trans_text, 'LEVEL' || CAST(GFKC.gfk_cat_level AS STRING)) AS cat_lvl_desc_en,
 CAST(NULL AS BIGNUMERIC) AS level
FROM ldl_p_lew_process_mstr_ac.v_lil_gfk_category_1 AS GFKP
 INNER JOIN ldl_p_lew_core_ac.v_lil_gfk_category_1 AS GFKC ON GFKP.client_id = GFKC.client_id AND GFKP.gfk_cat_sid = GFKC
   .gfk_cat_sid
 LEFT JOIN ldl_p_lew_process_mstr_ac.v_lil_translation_1 AS TRDE ON TRDE.context = 'CAT_LVL_DESC' AND GFKC.gfk_cat_level =
     TRDE.trans_id AND TRDE.lang_cd = 'DE' AND TRDE.active_fg = 1
 LEFT JOIN ldl_p_lew_process_mstr_ac.v_lil_translation_1 AS TREN ON TREN.context = 'CAT_LVL_DESC' AND GFKC.gfk_cat_level =
     TREN.trans_id AND TREN.lang_cd = 'EN' AND TREN.active_fg = 1
WHERE GFKC.client_id = (SELECT COALESCE(MIN(client_id), 1) AS client_id
   FROM ldl_p_lew_core_ac.v_lil_gfk_category_1);
