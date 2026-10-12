
CREATE OR REPLACE VIEW ldl_production_p_lew_core_ac.v_client_2 (client_id, src_client_id, src_country_lidl_cd,
src_country_cbx_cd, client_name, country_sid, country_cd, curr_sid, curr_cd, client_online_fg, lob_cd, dwh_load_id,
dwh_created, dwh_updated) AS SELECT client_id,
 src_client_id,
 src_country_lidl_cd,
 src_country_cbx_cd,
 client_name,
 country_sid,
 country_cd,
 curr_sid,
 curr_cd,
 client_online_fg,
 lob_cd,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_production_p_lew_core.t_client_2;