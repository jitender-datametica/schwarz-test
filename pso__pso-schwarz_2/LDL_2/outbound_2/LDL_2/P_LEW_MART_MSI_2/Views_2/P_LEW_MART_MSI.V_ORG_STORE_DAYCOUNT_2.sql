CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_org_store_daycount_2 AS SELECT st_loc_sid AS store_id,
 client_id,
 dat_formdate,
 dat_last_update,
 wawi_data_fg,
 ejr_data_fg,
 txj_data_fg,
 art_data_fg
FROM ldl_p_lew_core_ac.v_wawi_org_store_daycount_2;