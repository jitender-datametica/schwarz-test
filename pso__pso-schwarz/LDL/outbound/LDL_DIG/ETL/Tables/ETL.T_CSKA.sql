CREATE TABLE IF NOT EXISTS ldl_dig_etl.t_cska (
ktopl STRING(8) NOT NULL,
kstar STRING(20) NOT NULL,
ersda DATE,
usnam STRING(24) NOT NULL,
stekz STRING(2) NOT NULL,
zahkz STRING(2) NOT NULL,
kstsn STRING(20) NOT NULL,
funcarea STRING(32) NOT NULL,
odq_changemode STRING(2) NOT NULL,
odq_entitycntr BIGNUMERIC(38) NOT NULL,
sap_sys_name STRING(20) NOT NULL,
sap_client_id STRING(20) NOT NULL,
tmsp_insert DATETIME,
tmsp_update DATETIME
);