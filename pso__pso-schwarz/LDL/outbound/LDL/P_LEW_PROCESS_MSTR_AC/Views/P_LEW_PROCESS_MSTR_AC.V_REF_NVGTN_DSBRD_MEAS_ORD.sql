CREATE OR REPLACE VIEW ldl_p_lew_process_mstr_ac.v_ref_nvgtn_dsbrd_meas_ord (dsbrd_id, blk_id, phy_doc_type_id,
dsbrd_blk_ord, meas_grp_id, meas_grp_cnt, hd_row_ind, blk_meas_titl_text_id, blk_meas_titl2_text_id, meas_id,
mstr_mtrc_guid, tot_meas_id, tot_mstr_mtrc_guid, blk_meas_ord, dsbrd_meas_ord) AS SELECT *
FROM ldl_p_lew_process_mstr.v_ref_nvgtn_dsbrd_meas_ord;