CREATE OR REPLACE VIEW szd_production_fe_mstr_lifecycle.v_l_lifecycle_time_hour_1 (time_hour) AS SELECT DISTINCT hr_id AS
 time_hour
FROM szd_production_core.t_dim_hour_1;