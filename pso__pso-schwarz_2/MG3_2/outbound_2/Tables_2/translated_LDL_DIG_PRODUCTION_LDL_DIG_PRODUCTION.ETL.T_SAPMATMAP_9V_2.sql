CREATE OR REPLACE TABLE ldl_dig_production_etl.t_sapmatmap_9v_2 (
extmatnr STRING(80) NOT NULL,
producttype STRING(4) NOT NULL,
logqs STRING(16) NOT NULL,
matid STRING(44) NOT NULL,
matnr STRING(80) NOT NULL,
logsys STRING(20) NOT NULL,
matvers STRING(20) NOT NULL,
matnrlong STRING(80) NOT NULL,
odq_changemode STRING(2) NOT NULL,
odq_entitycntr INTEGER NOT NULL,
sap_sys_name STRING(20) NOT NULL,
sap_client_id STRING(20) NOT NULL,
tmsp_insert DATETIME,
tmsp_update DATETIME
);