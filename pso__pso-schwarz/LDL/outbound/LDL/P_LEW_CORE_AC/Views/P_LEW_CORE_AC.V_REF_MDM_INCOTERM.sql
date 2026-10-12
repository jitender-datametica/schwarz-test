CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_mdm_incoterm (market_sid, mdm_incoterm_cd, mdm_incoterm_name, dwh_load_id
, dwh_created, dwh_updated) AS SELECT market_sid,
 mdm_incoterm_cd,
 mdm_incoterm_name,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_mdm_incoterm;