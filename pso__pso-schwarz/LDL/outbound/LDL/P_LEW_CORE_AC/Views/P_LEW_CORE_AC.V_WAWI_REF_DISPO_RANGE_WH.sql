CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_ref_dispo_range_wh (client_id, wh_loc_sid, range_zone_id, range_plan_id
, range_desc, range_time_from, range_time_until, range_wh_day_0, range_wh_day_1, range_wh_day_2, range_wh_day_3,
range_wh_day_4, range_wh_day_5, range_wh_day_6, dat_dayend, load_id) AS SELECT client_id,
 wh_loc_sid,
 range_zone_id,
 range_plan_id,
 range_desc,
 range_time_from,
 range_time_until,
 range_wh_day_0,
 range_wh_day_1,
 range_wh_day_2,
 range_wh_day_3,
 range_wh_day_4,
 range_wh_day_5,
 range_wh_day_6,
 dat_dayend,
 load_id
FROM ldl_p_lew_core.t_wawi_ref_dispo_range_wh;