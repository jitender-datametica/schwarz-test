CREATE OR REPLACE VIEW ldl_p_lew_process_mstr_ac.v_lil_gfk_category (client_id, gfk_cat_sid, gfk_cat_id, gfk_cat_name_en
, gfk_cat_name_de, gfk_cat_short_name, active_fg, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 gfk_cat_sid,
 gfk_cat_id,
 gfk_cat_name_en,
 gfk_cat_name_de,
 gfk_cat_short_name,
 active_fg,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_process_mstr.t_lil_gfk_category;