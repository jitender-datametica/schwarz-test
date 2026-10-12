CREATE OR REPLACE VIEW ldl_p_lew_process_mstr.v_ref_phdoc_typ_act_2 (phy_doc_type_id, phy_doc_type_desc, phy_doc_type_ord
, deleted_fg, dwh_valid_from, dwh_valid_to, dwh_load_id, dwh_created, dwh_updated) AS SELECT phy_doc_type_id,
 phy_doc_type_desc,
 phy_doc_type_ord,
 deleted_fg,
 dwh_valid_from,
 dwh_valid_to,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_process_mstr.t_ref_phdoc_typ_2
WHERE CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
 AND deleted_fg = 0;