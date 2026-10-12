
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_CM.V_LIL_LIFT_CAT
 (
  lift_cat_id
, gfk_cat_type_id
, lift_cat_text
, lift_cat_text_EN
, gfk_cat_name_EN
, gfk_cat_name_DE
, gfk_cat_short_name
, cat_lvl
, cat_lvl_desc
, cat_lvl_desc_EN
, "LEVEL"
 )
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_CM
 AS
 SELECT
  gfkp.gfk_cat_id
, CASE gfkc.gfk_cat_type_cd
        WHEN 'All' THEN 0
        WHEN 'Vers1' THEN 1
        WHEN 'Vers2' THEN 2
        ELSE NULL
        END AS gfk_cat_type_id
, CAST(CASE
        WHEN gfkc.gfk_cat_level = 1 AND gfk_cat_type_id = 0
        THEN gfkp.gfk_cat_name_de
        WHEN gfkc.gfk_cat_level = 2 AND gfk_cat_type_id = 1
        THEN ('   ' || gfkp.gfk_cat_name_de)
        WHEN gfkc.gfk_cat_level = 3 AND gfk_cat_type_id = 1
        THEN ('      ' || gfkp.gfk_cat_name_de)
        WHEN gfkc.gfk_cat_level = 2 AND gfk_cat_type_id = 2
        THEN gfkp.gfk_cat_short_name || ' ' || gfkp.gfk_cat_name_de
        ELSE NULL
        END AS VARCHAR(128)) AS lift_cat_text
, CAST(CASE
        WHEN gfkc.gfk_cat_level = 1 AND gfk_cat_type_id = 0
        THEN gfkp.gfk_cat_name_en
        WHEN gfkc.gfk_cat_level = 2 AND gfk_cat_type_id = 1
        THEN ('   ' || gfkp.gfk_cat_name_en)
        WHEN gfkc.gfk_cat_level = 3 AND gfk_cat_type_id = 1
        THEN ('      ' || gfkp.gfk_cat_name_en)
        WHEN gfkc.gfk_cat_level = 2 AND gfk_cat_type_id = 2
        THEN gfkp.gfk_cat_short_name || ' ' || gfkp.gfk_cat_name_en
        ELSE NULL
        END AS VARCHAR(128)) AS lift_cat_text_EN
, gfkp.gfk_cat_name_en
, gfkp.gfk_cat_name_de
, gfkp.gfk_cat_short_name
, CAST(gfkc.gfk_cat_level AS SMALLINT) AS cat_lvl
, CAST(COALESCE(trde.trans_text, 'LEVEL'||CAST(gfkc.gfk_cat_level AS VARCHAR(10))) AS VARCHAR(256)) AS cat_lvl_desc
, CAST(COALESCE(tren.trans_text, 'LEVEL'||CAST(gfkc.gfk_cat_level AS VARCHAR(10))) AS VARCHAR(256)) AS cat_lvl_desc_EN
, CAST(NULL AS SMALLINT) AS "LEVEL"
FROM p_lew_process_mstr_ac.v_lil_gfk_category AS gfkp
INNER JOIN p_lew_core_ac.v_lil_gfk_category AS gfkc
        ON gfkc.client_id = gfkp.client_id
        AND gfkc.gfk_cat_sid = gfkp.gfk_cat_sid
LEFT OUTER JOIN p_lew_process_mstr_ac.v_lil_translation AS trde
  ON trde.context = 'CAT_LVL_DESC'
 AND trde.trans_id = gfkc.gfk_cat_level
 AND trde.lang_cd = 'DE'
 AND trde.active_fg = 1
 LEFT OUTER JOIN p_lew_process_mstr_ac.v_lil_translation AS tren
  ON tren.context = 'CAT_LVL_DESC'
 AND tren.trans_id =  gfkc.gfk_cat_level
 AND tren.lang_cd = 'EN'
 AND tren.active_fg = 1
WHERE gfkc.client_id = (
  SELECT COALESCE(MIN(client_id),1) FROM p_lew_core_ac.v_lil_gfk_category
 );
