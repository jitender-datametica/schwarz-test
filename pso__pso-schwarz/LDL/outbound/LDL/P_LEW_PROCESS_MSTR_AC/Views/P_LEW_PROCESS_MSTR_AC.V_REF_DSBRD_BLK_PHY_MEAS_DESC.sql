CREATE OR REPLACE VIEW ldl_p_lew_process_mstr_ac.v_ref_dsbrd_blk_phy_meas_desc (phy_doc_type_id, dsbrd_id, blk_meas_ord
, pg_no, blk_id, meas_id, meas_titl, meas_titl_2, tm_lvl_id, meas_grp_id, dsbrd_meas_ord, pg_meas_ord, meas_grp_titl,
blk_titl) AS SELECT *
FROM ldl_p_lew_process_mstr.v_ref_dsbrd_blk_phy_meas_desc;