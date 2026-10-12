CREATE TABLE IF NOT EXISTS ldl_dig_etl.t_sapmatmap_9v_1 (
extmatnr STRING(80) NOT NULL,
producttype STRING(4) NOT NULL,
logqs STRING(16) NOT NULL,
matid STRING(44) NOT NULL,
matnr STRING(80) NOT NULL,
logsys STRING(20) NOT NULL,
matvers STRING(20) NOT NULL,
matnrlong STRING(80) NOT NULL,
odq_changemode STRING(2) NOT NULL,
odq_entitycntr BIGNUMERIC(38) NOT NULL,
sap_sys_name STRING(20) NOT NULL,
sap_client_id STRING(20) NOT NULL,
tmsp_insert DATETIME,
tmsp_update DATETIME
);