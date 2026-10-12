CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tcache_warehouse_receiving_count_task_pos_gmhuhdr_1 (
client_id BIGNUMERIC(38,0) NOT NULL,
lgnum STRING(4) NOT NULL,
guid_hu STRING(32) NOT NULL,
huident STRING(32) NOT NULL,
tanum STRING(100),
letyp STRING(10),
dwh_load_id BIGNUMERIC(38,0),
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);