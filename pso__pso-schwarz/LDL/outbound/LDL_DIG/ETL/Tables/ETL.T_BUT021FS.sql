CREATE TABLE IF NOT EXISTS ldl_dig_etl.t_but021fs (
partner STRING(20) NOT NULL,
validto BIGNUMERIC(32) NOT NULL,
adrkind STRING(20) NOT NULL,
addrnumber STRING(20) NOT NULL,
validfrom BIGNUMERIC(32) NOT NULL,
xdfadu STRING(2) NOT NULL,
odq_changemode STRING(2) NOT NULL,
odq_entitycntr BIGNUMERIC(38) NOT NULL,
sap_sys_name STRING(20) NOT NULL,
sap_client_id STRING(20) NOT NULL,
tmsp_insert DATETIME,
tmsp_update DATETIME
);