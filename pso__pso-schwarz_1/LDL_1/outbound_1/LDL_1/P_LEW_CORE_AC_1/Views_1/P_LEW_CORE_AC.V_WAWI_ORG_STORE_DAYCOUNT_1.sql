CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_org_store_daycount_1 (st_loc_sid, client_id, dat_formdate, dat_last_update
, art_data_fg, ejr_data_fg, txj_data_fg, wawi_data_fg, load_id) AS SELECT st_loc_sid,
 client_id,
 dat_formdate,
 dat_last_update,
 art_data_fg,
 ejr_data_fg,
 txj_data_fg,
 wawi_data_fg,
 load_id
FROM ldl_p_lew_core.t_wawi_org_store_daycount_1;