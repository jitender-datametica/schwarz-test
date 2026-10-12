CREATE OR REPLACE VIEW ldl_p_lew_process_mstr_ac.v_ref_dsbrd_blk_phy_meas_fmt_1 (dsbrd_id, blk_id, phy_doc_type_id,
meas_id, dsbrd_meas_ord, pg_meas_ord, pg_no, meas_fmt_id) AS SELECT *
FROM ldl_p_lew_process_mstr.v_ref_dsbrd_blk_phy_meas_fmt_1;