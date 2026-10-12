CREATE TABLE IF NOT EXISTS ldl_dig_etl.t_gdpr_2 (
kunnr STRING(20) NOT NULL,
adrnr STRING(20) NOT NULL,
origin STRING(12) NOT NULL,
kna1_dele STRING(2) NOT NULL,
knvv_dele STRING(2) NOT NULL,
but000_dele STRING(2) NOT NULL,
odq_changemode STRING(2) NOT NULL,
odq_entitycntr BIGNUMERIC(38) NOT NULL,
sap_sys_name STRING(20) NOT NULL,
sap_client_id STRING(20) NOT NULL,
tmsp_insert DATETIME,
tmsp_update DATETIME
);