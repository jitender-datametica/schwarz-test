CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_mdm_guarantee_type (client_id, guarantee_type_cd, guarantee_type_descr,
dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 guarantee_type_cd,
 guarantee_type_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_mdm_guarantee_type;