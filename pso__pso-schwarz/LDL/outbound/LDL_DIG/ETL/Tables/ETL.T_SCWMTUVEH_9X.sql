CREATE TABLE IF NOT EXISTS ldl_dig_etl.t_scwmtuveh_9x (
tunum STRING(36) NOT NULL,
tusractnum NUMERIC(20) NOT NULL,
vehnum STRING(40) NOT NULL,
vehsractnum NUMERIC(20) NOT NULL,
seqnum STRING(22) NOT NULL,
startactual BIGNUMERIC(32) NOT NULL,
endactual BIGNUMERIC(32) NOT NULL,
loadpos NUMERIC(6) NOT NULL,
odq_changemode STRING(2) NOT NULL,
odq_entitycntr BIGNUMERIC(38) NOT NULL,
sap_sys_name STRING(20) NOT NULL,
sap_client_id STRING(20) NOT NULL,
tmsp_insert DATETIME,
tmsp_update DATETIME
);