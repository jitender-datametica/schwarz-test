CREATE TABLE IF NOT EXISTS ldl_dig_etl.t_tfk001at_2 (
spras STRING(2) NOT NULL,
augrd STRING(4) NOT NULL,
txt50 STRING(100) NOT NULL,
odq_changemode STRING(2) NOT NULL,
odq_entitycntr BIGNUMERIC(38,0) NOT NULL,
sap_sys_name STRING(16777216),
sap_client_id STRING(16777216),
tmsp_insert DATETIME,
tmsp_update DATETIME
);