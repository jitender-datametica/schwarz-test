CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_item_rel_type_2 (item_rel_type_cd, item_rel_type, dwh_load_id, dwh_created
, dwh_updated) AS SELECT item_rel_type_cd,
 item_rel_type,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_item_rel_type_2;