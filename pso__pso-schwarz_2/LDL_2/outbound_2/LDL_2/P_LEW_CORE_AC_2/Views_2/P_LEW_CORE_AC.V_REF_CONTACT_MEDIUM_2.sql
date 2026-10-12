CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_contact_medium_2 (contact_medium_cd, contact_medium_descr, dwh_load_id,
dwh_created, dwh_updated) AS SELECT contact_medium_cd,
 contact_medium_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_contact_medium_2;