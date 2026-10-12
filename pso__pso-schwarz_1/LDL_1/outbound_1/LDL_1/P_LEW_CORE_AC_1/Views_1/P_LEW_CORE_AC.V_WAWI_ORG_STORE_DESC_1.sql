CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_org_store_desc_1 (st_loc_sid, client_id, orig_store_nr, store_desc,
load_id) AS SELECT st_loc_sid,
 client_id,
 orig_store_nr,
 store_desc,
 load_id
FROM ldl_p_lew_core.t_wawi_org_store_desc_1;