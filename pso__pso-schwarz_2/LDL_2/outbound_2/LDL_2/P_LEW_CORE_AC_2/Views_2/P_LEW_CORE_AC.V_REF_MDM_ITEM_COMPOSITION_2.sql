CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_mdm_item_composition_2 (mdm_item_composition_cd, mdm_item_composition_txt,
dwh_load_id, dwh_created, dwh_updated) AS SELECT mdm_item_composition_cd,
 mdm_item_composition_txt,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_mdm_item_composition_2;