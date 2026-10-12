CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_lil_retailer (client_id, retailer_sid, src_retailer_cd, retailer_type_cd,
retailer_name, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 retailer_sid,
 src_retailer_cd,
 retailer_type_cd,
 retailer_name,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_lil_retailer;