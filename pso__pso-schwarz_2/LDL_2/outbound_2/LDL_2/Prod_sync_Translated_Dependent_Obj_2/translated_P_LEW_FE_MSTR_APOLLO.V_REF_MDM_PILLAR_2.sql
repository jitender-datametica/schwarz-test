CREATE OR REPLACE VIEW ldl_p_lew_fe_mstr_apollo.v_ref_mdm_pillar_2 (mdm_pillar_sid, mdm_pillar_name, dwh_load_id,
dwh_created, dwh_updated) AS SELECT *
FROM ldl_p_lew_core.t_ref_mdm_pillar_2;