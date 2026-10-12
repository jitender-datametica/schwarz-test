CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_org_store_reloc_2 (client_id, st_loc_sid, dat_close, move_from_st_loc_sid
, load_id) AS SELECT client_id,
 st_loc_sid,
 dat_close,
 move_from_st_loc_sid,
 load_id
FROM ldl_p_lew_core.t_wawi_org_store_reloc_2;