CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_ref_store_geo (client_id, st_loc_sid, longitude, latitude, load_id) AS
SELECT client_id,
 st_loc_sid,
 longitude,
 latitude,
 load_id
FROM ldl_p_lew_core.t_wawi_ref_store_geo;