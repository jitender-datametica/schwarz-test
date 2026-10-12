CREATE TABLE IF NOT EXISTS ldl_dig_etl.t_sapmattxt_9x_1 (
matid STRING(44) NOT NULL,
langu STRING(2) NOT NULL,
maktx STRING(80) NOT NULL,
maktg STRING(80) NOT NULL,
odq_changemode STRING(2) NOT NULL,
odq_entitycntr BIGNUMERIC(38) NOT NULL,
sap_sys_name STRING(20) NOT NULL,
sap_client_id STRING(20) NOT NULL,
tmsp_insert DATETIME,
tmsp_update DATETIME
);