CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_itm_item_skey_2 (client_id, item_sid, dat_rec_start, dat_rec_end,
orig_item_nr, old_orig_item_nr, case_size, reused_nr, dat_deleted, deleted_rmi_fg, load_id) AS SELECT client_id,
 item_sid,
 dat_rec_start,
 dat_rec_end,
 orig_item_nr,
 old_orig_item_nr,
 case_size,
 reused_nr,
 dat_deleted,
 deleted_rmi_fg,
 load_id
FROM ldl_p_lew_core.t_wawi_itm_item_skey_2;