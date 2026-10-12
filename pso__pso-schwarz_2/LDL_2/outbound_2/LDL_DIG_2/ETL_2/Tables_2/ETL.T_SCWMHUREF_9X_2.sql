CREATE TABLE IF NOT EXISTS ldl_dig_etl.t_scwmhuref_9x_2 (
guidhu STRING(64) NOT NULL,
doccat STRING(6) NOT NULL,
docid STRING(64) NOT NULL,
gi STRING(2) NOT NULL,
odq_changemode STRING(2) NOT NULL,
odq_entitycntr BIGNUMERIC(38) NOT NULL,
sap_sys_name STRING(20) NOT NULL,
sap_client_id STRING(20) NOT NULL,
tmsp_insert DATETIME,
tmsp_update DATETIME
);