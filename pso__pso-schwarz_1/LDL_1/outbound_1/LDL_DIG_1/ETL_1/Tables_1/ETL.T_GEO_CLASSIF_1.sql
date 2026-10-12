CREATE TABLE IF NOT EXISTS ldl_dig_etl.t_geo_classif_1 (
matnr STRING(40) NOT NULL,
artgeoclass STRING(2) NOT NULL,
aedat DATE,
aenzt INTEGER,
odq_changemode STRING(1) NOT NULL,
odq_entitycntr NUMERIC(20) NOT NULL,
sap_sys_name STRING(20) NOT NULL,
sap_client_id STRING(20) NOT NULL,
tmsp_insert DATETIME,
tmsp_update DATETIME
);