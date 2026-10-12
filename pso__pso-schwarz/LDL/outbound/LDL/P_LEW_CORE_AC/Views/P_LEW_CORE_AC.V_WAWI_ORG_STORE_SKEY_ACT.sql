CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_org_store_skey_act (client_id, st_loc_sid, wh_loc_sid, orig_store_nr) AS
SELECT client_id,
 st_loc_sid,
 wh_loc_sid,
 orig_store_nr
FROM ldl_p_lew_core.t_wawi_org_store_skey_act;