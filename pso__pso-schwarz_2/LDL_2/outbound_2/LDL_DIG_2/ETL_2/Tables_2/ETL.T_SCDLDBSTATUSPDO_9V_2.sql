CREATE TABLE IF NOT EXISTS ldl_dig_etl.t_scdldbstatuspdo_9v_2 (
docid STRING(32) NOT NULL,
itemid STRING(32) NOT NULL,
statustype STRING(5) NOT NULL,
doccat STRING(3) NOT NULL,
statusvalue STRING(1) NOT NULL,
tzone STRING(6) NOT NULL,
tstfr NUMERIC(16) NOT NULL,
tstto NUMERIC(16) NOT NULL,
chgusr STRING(12) NOT NULL,
odq_changemode STRING(1) NOT NULL,
odq_entitycntr NUMERIC(20) NOT NULL,
sap_sys_name STRING(20) NOT NULL,
sap_client_id STRING(20) NOT NULL,
tmsp_insert DATETIME,
tmsp_update DATETIME
);