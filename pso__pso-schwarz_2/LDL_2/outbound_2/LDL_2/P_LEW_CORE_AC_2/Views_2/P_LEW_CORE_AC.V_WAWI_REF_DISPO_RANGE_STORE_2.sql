CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_ref_dispo_range_store_2 (client_id, wh_loc_sid, st_loc_sid, order_area_cd
, range_group, range_zone_id, dat_days, range_fg, range_dbl_fg, active_int_fg, dat_dayend, load_id) AS SELECT client_id
 ,
 wh_loc_sid,
 st_loc_sid,
 order_area_cd,
 range_group,
 range_zone_id,
 dat_days,
 range_fg,
 range_dbl_fg,
 active_int_fg,
 dat_dayend,
 load_id
FROM ldl_p_lew_core.t_wawi_ref_dispo_range_store_2;