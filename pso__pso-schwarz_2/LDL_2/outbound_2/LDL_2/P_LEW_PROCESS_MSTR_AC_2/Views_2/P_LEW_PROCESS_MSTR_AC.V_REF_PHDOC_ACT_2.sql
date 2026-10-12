CREATE OR REPLACE VIEW ldl_p_lew_process_mstr_ac.v_ref_phdoc_act_2 (phy_doc_id, phy_doc_desc, mstr_phy_doc_guid,
phy_doc_type_id, deleted_fg, dwh_valid_from, dwh_valid_to, dwh_load_id, dwh_created, dwh_updated) AS SELECT *
FROM ldl_p_lew_process_mstr.v_ref_phdoc_act_2;