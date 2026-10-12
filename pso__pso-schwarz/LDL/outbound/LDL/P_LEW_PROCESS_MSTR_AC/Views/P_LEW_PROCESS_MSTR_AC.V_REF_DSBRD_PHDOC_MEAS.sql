CREATE OR REPLACE VIEW ldl_p_lew_process_mstr_ac.v_ref_dsbrd_phdoc_meas (phy_doc_type_id, dsbrd_id, meas_id,
phy_doc_dsbrd_meas_ord, meas_titl, tm_lvl_id, meas_fmt_id, meas_grp_titl, tot_fl, avg_fl) AS SELECT *
FROM ldl_p_lew_process_mstr.v_ref_dsbrd_phdoc_meas;