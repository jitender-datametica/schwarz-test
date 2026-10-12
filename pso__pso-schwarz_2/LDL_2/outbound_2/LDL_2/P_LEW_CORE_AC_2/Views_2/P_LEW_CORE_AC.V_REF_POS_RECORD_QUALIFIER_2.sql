CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_pos_record_qualifier_2 (client_id, record_qualifier_id,
record_qualifier_descr, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 record_qualifier_id,
 record_qualifier_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_pos_record_qualifier_2;