CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tcache_warehouse_receiving_count_task_pos_refdoc_1 (
client_id BIGNUMERIC(38,0) NOT NULL,
docid STRING(32) NOT NULL,
itemid STRING(32) NOT NULL,
doccat STRING(10) NOT NULL,
refdoccat STRING(20) NOT NULL,
refdocno STRING(20) NOT NULL,
dwh_load_id BIGNUMERIC(38,0),
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);