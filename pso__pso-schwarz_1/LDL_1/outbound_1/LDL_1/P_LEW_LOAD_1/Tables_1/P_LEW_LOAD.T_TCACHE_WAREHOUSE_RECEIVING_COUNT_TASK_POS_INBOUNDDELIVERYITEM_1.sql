CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tcache_warehouse_receiving_count_task_pos_inbounddeliveryitem_1 (
client_id BIGNUMERIC(38,0) NOT NULL,
lgnum STRING(4),
docnoh STRING(35),
docid STRING(40),
itemno BIGNUMERIC(38,0),
itemid STRING(100),
door STRING(4),
productno STRING(40),
status_gr STRING(40),
dwh_load_id BIGNUMERIC(38,0),
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);