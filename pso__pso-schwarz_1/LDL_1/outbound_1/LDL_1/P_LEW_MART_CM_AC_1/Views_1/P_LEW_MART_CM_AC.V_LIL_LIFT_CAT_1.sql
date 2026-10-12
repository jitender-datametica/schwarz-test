CREATE OR REPLACE VIEW ldl_p_lew_mart_cm_ac.v_lil_lift_cat_1 (lift_cat_id, lift_cat_text, lift_cat_text_en,
gfk_cat_name_en, gfk_cat_name_de, gfk_cat_short_name, cat_lvl, cat_lvl_desc, cat_lvl_desc_en, gfk_cat_type_id, level) AS
SELECT gfk_cat_id,
 lift_cat_text,
 lift_cat_text_en,
 gfk_cat_name_en,
 gfk_cat_name_de,
 gfk_cat_short_name,
 cat_lvl,
 cat_lvl_desc,
 cat_lvl_desc_en,
 gfk_cat_type_id,
 level
FROM ldl_p_lew_mart_cm.v_lil_lift_cat_1;
