CREATE TABLE IF NOT EXISTS ldl_dig_etl.t_t005t_2 (
spras STRING(2) NOT NULL,
land1 STRING(6) NOT NULL,
landx STRING(30) NOT NULL,
natio STRING(30) NOT NULL,
landx50 STRING(100) NOT NULL,
natio50 STRING(100) NOT NULL,
prqspregt STRING(60) NOT NULL,
odq_changemode STRING(2) NOT NULL,
odq_entitycntr BIGNUMERIC(38) NOT NULL,
sap_sys_name STRING(20) NOT NULL,
sap_client_id STRING(20) NOT NULL,
tmsp_insert DATETIME,
tmsp_update DATETIME
);