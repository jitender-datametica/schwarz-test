CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tcache_warehouse_receiving_count_task_inbounddeliveryheader (
client_id BIGNUMERIC(38,0) NOT NULL,
lgnum BIGNUMERIC(38,0) NOT NULL,
task_nr NUMERIC(20,0) NOT NULL,
docno STRING(100) NOT NULL,
doctype STRING(10),
docid STRING(40),
tdeliverycredate DATE NOT NULL,
tdeliverycretime TIME,
zzgrcompl STRING(10),
dlvdate DATE,
dlvtime TIME,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);