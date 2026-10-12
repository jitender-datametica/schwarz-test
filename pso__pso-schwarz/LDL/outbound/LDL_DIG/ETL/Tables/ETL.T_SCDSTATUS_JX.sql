CREATE TABLE IF NOT EXISTS ldl_dig_etl.t_scdstatus_jx (
docid STRING(64) NOT NULL,
itemid STRING(64) NOT NULL,
statustype STRING(10) NOT NULL,
doccat STRING(6) NOT NULL,
statusvalue STRING(2) NOT NULL,
tzone STRING(12) NOT NULL,
tstfr BIGNUMERIC(32) NOT NULL,
tstto BIGNUMERIC(32) NOT NULL,
chgusr STRING(24) NOT NULL,
odq_changemode STRING(2) NOT NULL,
odq_entitycntr BIGNUMERIC(38) NOT NULL,
sap_sys_name STRING(20) NOT NULL,
sap_client_id STRING(20) NOT NULL,
tmsp_insert DATETIME,
tmsp_update DATETIME
);