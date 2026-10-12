CREATE TABLE IF NOT EXISTS ldl_dig_etl.t_t179t (
spras STRING(2) NOT NULL,
prodh STRING(36) NOT NULL,
vtext STRING(80) NOT NULL,
odq_changemode STRING(2) NOT NULL,
odq_entitycntr BIGNUMERIC(38) NOT NULL,
sap_sys_name STRING(20) NOT NULL,
sap_client_id STRING(20) NOT NULL,
tmsp_insert DATETIME,
tmsp_update DATETIME
);