CREATE OR REPLACE VIEW ldl_p_lew_process_mstr_ac.v_ref_nvgtn_meas_doc (dsbrd_id, phy_doc_id, meas_grp_id,
dsbrd_meas_grp_ord, phy_doc_desc, mstr_phy_doc_guid, phy_doc_type_id, url_mtrc, load_id, dwh_inserted, dwh_updated) AS
SELECT *
FROM ldl_p_lew_process_mstr.v_ref_nvgtn_meas_doc;