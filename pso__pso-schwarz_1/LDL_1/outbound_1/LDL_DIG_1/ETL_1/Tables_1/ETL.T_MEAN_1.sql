CREATE TABLE IF NOT EXISTS ldl_dig_etl.t_mean_1 (
matnr STRING(80) NOT NULL,
sap_sys_name STRING(20),
sap_client_id STRING(20),
tmsp_insert DATETIME,
tmsp_update DATETIME,
meinh STRING(6) NOT NULL,
lfnum STRING(10) NOT NULL,
ean11 STRING(36) NOT NULL,
eantp STRING(4) NOT NULL,
hpean STRING(2) NOT NULL,
sgtcatv STRING(80) NOT NULL,
`_slash_sttpec_slash_sergtin` STRING(2) NOT NULL,
lastchangedat DATE,
odq_changemode STRING(2) NOT NULL,
odq_entitycntr BIGNUMERIC(38,0) NOT NULL
);