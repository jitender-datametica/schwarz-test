CREATE OR REPLACE VIEW ldl_p_lew_bil_ac.v_org_store_merge (loc_sid_store, client_id, country_cd, dat_opening,
dat_real_opening, dat_closing, dat_valid_from, region_cd, object_nr, licence_nr, pst_lang_cd, mde_print_cd, closed_fg,
mde_lang_cd, ord_unit_valid_store_cd, test_store_fg, transfer_fg, store_desc, src_orig_store_nr, loc_sid_wh,
cnt_open_days, qty_min_dflt, dat_calc_start_py, dat_calc_end_py, dat_calc_start_ppy, dat_opening_ovis, dat_closing_ovis
, objectstatus_id, mis_store_active_fg, loc_sid_store_move_to, move_fg, aspect_id) AS SELECT *
FROM ldl_p_lew_bil.v_org_store_merge;