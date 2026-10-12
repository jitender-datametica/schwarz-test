CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_org_store_skey (client_id, st_loc_sid, dat_rec_start, dat_rec_end,
wh_loc_sid, orig_store_nr, load_id) AS SELECT client_id,
 st_loc_sid,
 dat_rec_start,
 dat_rec_end,
 wh_loc_sid,
 orig_store_nr,
 load_id
FROM ldl_p_lew_core.t_wawi_org_store_skey;