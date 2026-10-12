CREATE OR REPLACE VIEW szd_fe_mstr_lifecycle.v_l_lifecycle_time_hour (time_hour) AS SELECT DISTINCT hr_id AS time_hour
FROM szd_core.t_dim_hour;