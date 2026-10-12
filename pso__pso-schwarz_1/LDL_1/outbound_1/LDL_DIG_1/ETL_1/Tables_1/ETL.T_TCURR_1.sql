CREATE TABLE IF NOT EXISTS ldl_dig_etl.t_tcurr_1 (
kurst STRING(8) NOT NULL,
fcurr STRING(10) NOT NULL,
tcurr STRING(10) NOT NULL,
gdatu STRING(16) NOT NULL,
ukurs BIGNUMERIC(38,5) NOT NULL,
ffact NUMERIC(20) NOT NULL,
tfact NUMERIC(20) NOT NULL,
odq_changemode STRING(2) NOT NULL,
odq_entitycntr BIGNUMERIC(38) NOT NULL,
sap_sys_name STRING(20) NOT NULL,
sap_client_id STRING(20) NOT NULL,
tmsp_insert DATETIME,
tmsp_update DATETIME
);