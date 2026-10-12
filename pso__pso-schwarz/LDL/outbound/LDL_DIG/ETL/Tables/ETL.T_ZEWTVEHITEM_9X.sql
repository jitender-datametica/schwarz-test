CREATE TABLE IF NOT EXISTS ldl_dig_etl.t_zewtvehitem_9x (
lgnum STRING(8) NOT NULL,
vehid STRING(40) NOT NULL,
huident STRING(40) NOT NULL,
vbeln STRING(20) NOT NULL,
traid STRING(80) NOT NULL,
loadingdate DATE,
loadingtime NUMERIC(12) NOT NULL,
odq_changemode STRING(2) NOT NULL,
odq_entitycntr BIGNUMERIC(38) NOT NULL,
sap_sys_name STRING(20) NOT NULL,
sap_client_id STRING(20) NOT NULL,
tmsp_insert DATETIME,
tmsp_update DATETIME
);