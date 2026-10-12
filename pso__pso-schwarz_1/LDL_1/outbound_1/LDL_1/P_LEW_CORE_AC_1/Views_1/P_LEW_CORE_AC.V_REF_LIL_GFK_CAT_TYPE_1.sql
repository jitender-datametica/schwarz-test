CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_lil_gfk_cat_type_1 (gfk_cat_type_cd, gfk_cat_type_name, dwh_load_id,
dwh_created, dwh_updated) AS SELECT gfk_cat_type_cd,
 gfk_cat_type_name,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_lil_gfk_cat_type_1;