CREATE TABLE IF NOT EXISTS ldl_dig_etl.t_tfk048at_1 (
spras STRING(1) NOT NULL,
abgrd STRING(2) NOT NULL,
abtxt STRING(50) NOT NULL,
odq_changemode STRING(1) NOT NULL,
odq_entitycntr NUMERIC(20) NOT NULL,
sap_sys_name STRING(20) NOT NULL,
sap_client_id STRING(20) NOT NULL,
tmsp_insert DATETIME,
tmsp_update DATETIME
);