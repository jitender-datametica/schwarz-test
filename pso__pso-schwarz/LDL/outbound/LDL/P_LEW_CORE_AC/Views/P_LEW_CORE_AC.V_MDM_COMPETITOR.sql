CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_mdm_competitor (client_id, competitor_sid, src_competitor_cd, competitor_name
, competitor_short_name, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 competitor_sid,
 src_competitor_cd,
 competitor_name,
 competitor_short_name,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_mdm_competitor;