CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_internal_organisation_1 (int_org_sid, int_org_type_cd, int_org_nr, int_org_name
, int_org_descr, dwh_load_id, dwh_created, dwh_updated) AS SELECT int_org_sid,
 int_org_type_cd,
 int_org_nr,
 int_org_name,
 int_org_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_internal_organisation_1;