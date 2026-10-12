CREATE OR REPLACE VIEW FE_MSTR_LIFECYCLE.MV_L_LIFECYCLE_RVM_TIME_HOUR 
AS SELECT 
core.t_dim_time_hour.time_hour
FROM 
core.t_dim_time_hour
;