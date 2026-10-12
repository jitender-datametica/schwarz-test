CREATE TABLE IF NOT EXISTS ldl_dig_etl.t_a910_2 (
kappl STRING(4) NOT NULL,
kschl STRING(8) NOT NULL,
aland STRING(6) NOT NULL,
lland STRING(6) NOT NULL,
taxk1 STRING(2) NOT NULL,
taxm2 STRING(2) NOT NULL,
datbi DATE,
datab DATE,
knumh STRING(20) NOT NULL,
odq_changemode STRING(2) NOT NULL,
odq_entitycntr BIGNUMERIC(38) NOT NULL,
sap_sys_name STRING(20) NOT NULL,
sap_client_id STRING(20) NOT NULL,
tmsp_insert DATETIME,
tmsp_update DATETIME
);