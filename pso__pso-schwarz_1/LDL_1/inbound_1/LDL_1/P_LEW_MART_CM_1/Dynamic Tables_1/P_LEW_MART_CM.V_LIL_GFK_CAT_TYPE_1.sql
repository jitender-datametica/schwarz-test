
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_CM.V_LIL_GFK_CAT_TYPE_1
(
      gfk_cat_type_id
    ,gfk_cat_type_name
    ,gfk_cat_type_name_EN
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_CM
AS
SELECT
      CASE gfk_cat_type_cd
      WHEN 'All' THEN 0
      WHEN 'Vers1' THEN 1
      WHEN 'Vers2' THEN 2
      ELSE NULL
      END AS gfk_cat_type_id
    ,CAST(COALESCE(trde.trans_text, gcty.gfk_cat_type_name) AS VARCHAR(128)) AS gfk_cat_type_name
    ,CAST(COALESCE(tren.trans_text, gcty.gfk_cat_type_name) AS VARCHAR(128)) AS gfk_cat_type_name_EN
FROM P_LEW_CORE_AC.v_ref_lil_gfk_cat_type_1 AS gcty
LEFT OUTER JOIN P_LEW_PROCESS_MSTR_AC.v_lil_translation_1 AS trde
  ON trde.context = 'GFK_CAT_TYPE_NAME'
 AND trde.src_trans_cd = gcty.gfk_cat_type_cd
 AND trde.lang_cd = 'DE'
 AND trde.active_fg = 1
 LEFT OUTER JOIN P_LEW_PROCESS_MSTR_AC.v_lil_translation_1 AS tren
  ON tren.context = 'GFK_CAT_TYPE_NAME'
 AND tren.src_trans_cd = gcty.gfk_cat_type_cd
 AND tren.lang_cd = 'EN'
 AND tren.active_fg = 1;
