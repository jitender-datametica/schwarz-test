CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_org_all_store_merge_1 (aspect_id, client_id, move_to_store_id,
move_store_desc, wh_id, wh_id_exp, loc_sid_wh, sales_manager_id, dat_closing_ovis, dat_opening_ovis, mis_store_active_fg
, dat_opening, dat_closing, orig_store_nr, dat_calc_start_py, dat_calc_end_py, objectstatus_id, dat_calc_start_ppy,
move_fg, street, zipcode, city, phone, longitude, latitude, dat_modernization_from, dat_modernization_to) AS SELECT *
FROM ldl_p_lew_mart_lead.v_org_all_store_merge_1;