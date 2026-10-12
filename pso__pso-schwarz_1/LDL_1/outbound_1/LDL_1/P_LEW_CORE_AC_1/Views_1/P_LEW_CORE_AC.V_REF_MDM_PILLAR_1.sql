CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_mdm_pillar_1 (mdm_pillar_sid, mdm_pillar_name, dwh_load_id, dwh_created,
dwh_updated) AS SELECT mdm_pillar_sid,
 mdm_pillar_name,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_mdm_pillar_1;