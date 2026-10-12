CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_org_wh_skey (client_id, gl_region_id, wh_loc_sid, aspect_id, load_id) AS
SELECT client_id,
 gl_region_id,
 wh_loc_sid,
 aspect_id,
 load_id
FROM ldl_p_lew_core.t_wawi_org_wh_skey;