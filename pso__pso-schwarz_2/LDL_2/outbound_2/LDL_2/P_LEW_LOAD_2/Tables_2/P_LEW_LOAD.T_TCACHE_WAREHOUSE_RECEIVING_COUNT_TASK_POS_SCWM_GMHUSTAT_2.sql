CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tcache_warehouse_receiving_count_task_pos_scwm_gmhustat_2 (
client_id BIGNUMERIC(38,0) NOT NULL,
mandt STRING(20) NOT NULL,
objnr STRING(32) NOT NULL,
stat STRING(20) NOT NULL,
log STRING(32) NOT NULL,
dwh_load_id BIGNUMERIC(38,0),
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);