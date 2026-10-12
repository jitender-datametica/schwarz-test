CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_mdm_market (client_id, market_sid, market_cd, market, dwh_load_id,
dwh_created, dwh_updated) AS SELECT client_id,
 market_sid,
 market_cd,
 market,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_mdm_market;