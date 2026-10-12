CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tcache_warehouse_receiving_count_task_pos_zewm_hustatus_1 (
client_id BIGNUMERIC(38,0) NOT NULL,
mandt STRING(20) NOT NULL,
lgnum STRING(4) NOT NULL,
estat STRING(20) NOT NULL,
hu_status_ind STRING(20) NOT NULL,
dwh_load_id BIGNUMERIC(38,0),
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);