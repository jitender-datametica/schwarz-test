CREATE TABLE IF NOT EXISTS ldl_dig_etl.t_t006a_2 (
spras STRING(2) NOT NULL,
msehi STRING(6) NOT NULL,
mseh3 STRING(6) NOT NULL,
mseh6 STRING(12) NOT NULL,
mseht STRING(20) NOT NULL,
msehl STRING(60) NOT NULL,
odq_changemode STRING(2) NOT NULL,
odq_entitycntr BIGNUMERIC(38) NOT NULL,
sap_sys_name STRING(20) NOT NULL,
sap_client_id STRING(20) NOT NULL,
tmsp_insert DATETIME,
tmsp_update DATETIME
);