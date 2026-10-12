CREATE TABLE IF NOT EXISTS ldl_dig_etl.t_a004 (
kappl STRING(4) NOT NULL,
kschl STRING(8) NOT NULL,
vkorg STRING(8) NOT NULL,
vtweg STRING(4) NOT NULL,
matnr STRING(80) NOT NULL,
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