CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_itm_item_int (client_id, orig_item_nr_int, dat_rec_start, dat_rec_end,
case_size_int, item_sid, item_desc_int, active_int_fg, load_id) AS SELECT client_id,
 orig_item_nr_int,
 dat_rec_start,
 dat_rec_end,
 case_size_int,
 item_sid,
 item_desc_int,
 active_int_fg,
 load_id
FROM ldl_p_lew_core.t_wawi_itm_item_int;