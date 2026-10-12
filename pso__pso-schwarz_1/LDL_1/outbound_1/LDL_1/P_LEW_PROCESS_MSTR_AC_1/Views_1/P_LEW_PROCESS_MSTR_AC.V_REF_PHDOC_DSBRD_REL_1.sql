CREATE OR REPLACE VIEW ldl_p_lew_process_mstr_ac.v_ref_phdoc_dsbrd_rel_1 (dsbrd_id, phy_doc_id, deleted_fg, dwh_valid_from
, dwh_valid_to, dwh_load_id, dwh_created, dwh_updated) AS SELECT dsbrd_id,
 phy_doc_id,
 deleted_fg,
 dwh_valid_from,
 dwh_valid_to,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_process_mstr.t_ref_phdoc_dsbrd_rel_1;