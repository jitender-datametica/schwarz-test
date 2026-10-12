CREATE TABLE IF NOT EXISTS ldl_dig_etl.t_srtstmount_9x_1 (
lgnum STRING(4) NOT NULL,
sortstation STRING(4) NOT NULL,
ptlframe NUMERIC(1) NOT NULL,
sortshelf STRING(18) NOT NULL,
odq_changemode STRING(1) NOT NULL,
odq_entitycntr NUMERIC(20) NOT NULL,
sap_sys_name STRING(20) NOT NULL,
sap_client_id STRING(20) NOT NULL,
tmsp_insert DATETIME,
tmsp_update DATETIME
);