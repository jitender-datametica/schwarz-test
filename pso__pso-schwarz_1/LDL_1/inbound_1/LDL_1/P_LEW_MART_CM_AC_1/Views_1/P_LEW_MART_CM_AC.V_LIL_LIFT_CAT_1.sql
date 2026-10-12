CREATE OR REPLACE VIEW P_LEW_MART_CM_AC.V_LIL_LIFT_CAT_1
(
  lift_cat_id
, lift_cat_text
, lift_cat_text_EN
, gfk_cat_name_EN
, gfk_cat_name_DE
, gfk_cat_short_name
, cat_lvl
, cat_lvl_desc
, cat_lvl_desc_EN
, gfk_cat_type_id
, "level"
) AS
SELECT
  lift_cat_id
, lift_cat_text
, lift_cat_text_EN
, gfk_cat_name_EN
, gfk_cat_name_DE
, gfk_cat_short_name
, cat_lvl
, cat_lvl_desc
, cat_lvl_desc_EN
, gfk_cat_type_id
, "level"
FROM P_LEW_MART_CM.V_LIL_LIFT_CAT_1;
