CREATE OR REPLACE VIEW ldl_p_lew_fe_mstr_apollo.v_mdm_item_set_2 (client_id, mdm_item_set_sid, src_item_doc_ref,
src_style_uniqids_cd, set_multipack_fg, mdm_item_sid, dwh_load_id, dwh_created, dwh_updated) AS SELECT *
FROM ldl_p_lew_core_ac.v_mdm_item_set_2;