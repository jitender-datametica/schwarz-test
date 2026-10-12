CREATE OR REPLACE VIEW ldl_p_lew_process_mstr_ac.v_ref_dsbrd_blk_rel_act_2 (dsbrd_id, phy_doc_type_id, blk_id,
dsbrd_blk_ord, deleted_fg, dwh_valid_from, dwh_valid_to, dwh_load_id, dwh_created, dwh_updated) AS SELECT *
FROM ldl_p_lew_process_mstr.v_ref_dsbrd_blk_rel_act_2;