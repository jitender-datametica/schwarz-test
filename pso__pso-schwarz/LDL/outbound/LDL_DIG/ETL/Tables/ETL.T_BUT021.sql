CREATE TABLE IF NOT EXISTS ldl_dig_etl.t_but021 (
partner STRING(20) NOT NULL,
adrkind STRING(20) NOT NULL,
addrnumber STRING(20) NOT NULL,
xdfadu STRING(2) NOT NULL,
lastchangedat DATE,
odq_changemode STRING(2) NOT NULL,
odq_entitycntr BIGNUMERIC(38,0) NOT NULL,
sap_sys_name STRING(16777216),
sap_client_id STRING(16777216),
tmsp_insert DATETIME,
tmsp_update DATETIME
);