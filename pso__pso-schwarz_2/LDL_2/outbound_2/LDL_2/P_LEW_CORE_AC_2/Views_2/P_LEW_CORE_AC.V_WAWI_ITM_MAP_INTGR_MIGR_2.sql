CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_itm_map_intgr_migr_2 (ec_cd, itm_sid, itm_id, client_id, item_mis_id,
orig_item_nr, case_size, itm_dat_valid_from, itm_origin_cd, match_dat, new_itm_sid, log_var_id, intgr_fg, core_load_id)
AS SELECT ec_cd,
 itm_sid,
 itm_id,
 client_id,
 item_mis_id,
 orig_item_nr,
 case_size,
 itm_dat_valid_from,
 itm_origin_cd,
 match_dat,
 new_itm_sid,
 log_var_id,
 intgr_fg,
 core_load_id
FROM ldl_p_lew_core.t_wawi_itm_map_intgr_migr_2;