CREATE OR REPLACE VIEW ldl_p_lew_process_mstr_ac.v_lil_period_type_2 (period_type_id, period_type_desc,
ltst_pseudo_period_id, dwh_load_id, dwh_created, dwh_updated) AS SELECT period_type_id,
 period_type_desc,
 ltst_pseudo_period_id,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_process_mstr.t_lil_period_type_2;