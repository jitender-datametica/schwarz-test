CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_store_form_type (client_id, sfo_type_id, sfo_type_descr, dwh_load_id,
dwh_created, dwh_updated) AS SELECT client_id,
 sfo_type_id,
 sfo_type_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_store_form_type;