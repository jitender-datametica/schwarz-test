CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_lil_period (client_id, period_sid, src_period_cd, period_name, period_type_id
, period_type_name, period_year, period_sid_py, period_sid_pq, dwh_load_id, dwh_created, dwh_updated) AS SELECT
 client_id,
 period_sid,
 src_period_cd,
 period_name,
 period_type_id,
 period_type_name,
 period_year,
 period_sid_py,
 period_sid_pq,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_lil_period;