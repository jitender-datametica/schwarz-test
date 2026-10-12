CREATE TABLE IF NOT EXISTS ldl_dig_etl.t_tj01t_2 (
vrgng STRING(8) NOT NULL,
spras STRING(2) NOT NULL,
txt STRING(60) NOT NULL,
shorttxt STRING(20) NOT NULL,
odq_changemode STRING(2) NOT NULL,
odq_entitycntr BIGNUMERIC(38) NOT NULL,
sap_sys_name STRING(20) NOT NULL,
sap_client_id STRING(20) NOT NULL,
tmsp_insert DATETIME,
tmsp_update DATETIME
);