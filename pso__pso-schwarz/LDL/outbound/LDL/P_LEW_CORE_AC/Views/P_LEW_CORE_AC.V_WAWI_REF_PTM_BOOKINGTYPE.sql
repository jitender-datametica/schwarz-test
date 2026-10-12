CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_ref_ptm_bookingtype (client_id, wh_loc_sid, bookingtype_id,
bookingtype_desc, dat_dayend, load_id) AS SELECT client_id,
 wh_loc_sid,
 bookingtype_id,
 bookingtype_desc,
 dat_dayend,
 load_id
FROM ldl_p_lew_core.t_wawi_ref_ptm_bookingtype;