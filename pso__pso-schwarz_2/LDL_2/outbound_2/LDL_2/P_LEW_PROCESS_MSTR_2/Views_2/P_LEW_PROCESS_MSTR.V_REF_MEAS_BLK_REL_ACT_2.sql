CREATE OR REPLACE VIEW ldl_p_lew_process_mstr.v_ref_meas_blk_rel_act_2 (meas_id, blk_id, tot_meas_id, hd_row_ind,
blk_meas_ord, blk_meas_titl_text_id, blk_meas_titl2_text_id, deleted_fg, dwh_valid_from, dwh_valid_to, dwh_load_id,
dwh_created, dwh_updated) AS SELECT meas_id,
 blk_id,
 tot_meas_id,
 hd_row_ind,
 blk_meas_ord,
 blk_meas_titl_text_id,
 blk_meas_titl2_text_id,
 deleted_fg,
 dwh_valid_from,
 dwh_valid_to,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_process_mstr.t_ref_meas_blk_rel_2
WHERE CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
 AND deleted_fg = 0;