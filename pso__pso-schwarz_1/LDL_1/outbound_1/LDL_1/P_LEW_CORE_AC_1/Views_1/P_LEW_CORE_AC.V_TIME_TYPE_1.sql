CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_time_type_1 (client_id, time_type_sid, src_wh_id, src_time_type_id,
src_time_type_cd, source_system, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 time_type_sid,
 src_wh_id,
 src_time_type_id,
 src_time_type_cd,
 source_system,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_time_type_1;