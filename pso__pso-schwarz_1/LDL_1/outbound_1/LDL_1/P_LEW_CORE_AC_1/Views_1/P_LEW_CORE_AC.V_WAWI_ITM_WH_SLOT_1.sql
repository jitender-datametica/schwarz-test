CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_itm_wh_slot_1 (client_id, wh_loc_sid, item_sid, dat_rec_start, dat_rec_end
, wh_slot_case, wh_location_nr_case, wh_slot_pallet, wh_location_nr_pallet, wh_location_nr_dd, wh_slot_dd, inv_case_fg,
inv_euro_fg, inv_dd_fg, load_id) AS SELECT client_id,
 wh_loc_sid,
 item_sid,
 dat_rec_start,
 dat_rec_end,
 wh_slot_case,
 wh_location_nr_case,
 wh_slot_pallet,
 wh_location_nr_pallet,
 wh_location_nr_dd,
 wh_slot_dd,
 inv_case_fg,
 inv_euro_fg,
 inv_dd_fg,
 load_id
FROM ldl_p_lew_core.t_wawi_itm_wh_slot_1;