CREATE OR REPLACE VIEW ldl_p_lew_process_mstr_ac.v_lil_region_per_latest_1 (client_id, region_sid, per_tp_id, class_cd,
ltst_per_id, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 region_sid,
 per_tp_id,
 class_cd,
 ltst_per_id,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_process_mstr.t_lil_region_per_latest_1;