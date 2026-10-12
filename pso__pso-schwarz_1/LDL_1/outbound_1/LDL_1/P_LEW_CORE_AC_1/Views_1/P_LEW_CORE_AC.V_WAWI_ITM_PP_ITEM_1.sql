CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_itm_pp_item_1 (client_id, wh_loc_sid_pp, orig_item_nr_pp, case_size_pp,
item_sid, dat_sys, timestamp_from_pp, timestamp_until_pp, picking_area_nr_pp, end_cd_pp, item_status_pp, load_id) AS
SELECT client_id,
 wh_loc_sid_pp,
 orig_item_nr_pp,
 case_size_pp,
 item_sid,
 dat_sys,
 timestamp_from_pp,
 timestamp_until_pp,
 picking_area_nr_pp,
 end_cd_pp,
 item_status_pp,
 load_id
FROM ldl_p_lew_core.t_wawi_itm_pp_item_1;