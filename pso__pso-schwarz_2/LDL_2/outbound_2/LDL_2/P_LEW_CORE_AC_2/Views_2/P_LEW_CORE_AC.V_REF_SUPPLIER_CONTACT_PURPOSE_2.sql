CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_supplier_contact_purpose_2 (sup_contact_purpose_sid,
sup_contact_purpose_descr, dwh_load_id, dwh_created, dwh_updated) AS SELECT sup_contact_purpose_sid,
 sup_contact_purpose_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_supplier_contact_purpose_2;