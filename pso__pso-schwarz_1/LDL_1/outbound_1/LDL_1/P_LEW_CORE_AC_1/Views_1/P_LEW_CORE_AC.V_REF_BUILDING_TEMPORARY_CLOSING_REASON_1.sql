CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_building_temporary_closing_reason_1 (client_id, temporary_closing_reason_id
, temporary_closing_reason_descr, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 temporary_closing_reason_id,
 temporary_closing_reason_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_building_temporary_closing_reason_1;