CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_org_store_merge (store_id, client_id, country_cd, dat_opening,
dat_real_opening, dat_closing, dat_valid_from, region_cd, object_nr, licence_nr, pst_lang_cd, mde_print_cd, closed_fg,
mde_lang_cd, ord_unit_valid_store_cd, test_store_fg, transfer_fg, store_desc, orig_store_nr, wh_id, loc_sid_wh,
cnt_open_days, qty_min_dflt, dat_calc_start_py, dat_calc_end_py, dat_calc_start_ppy, dat_opening_ovis, dat_closing_ovis
, objectstatus_id, mis_store_active_fg, move_to_store_id, move_fg, aspect_id) AS SELECT *
FROM ldl_p_lew_mart_lead.v_org_store_merge;