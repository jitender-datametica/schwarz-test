CREATE TABLE IF NOT EXISTS ldl_dig_etl.t_mstb_2 (
matnr STRING(80) NOT NULL,
werks STRING(8) NOT NULL,
charg STRING(20) NOT NULL,
sobkz STRING(2) NOT NULL,
bwtar STRING(20) NOT NULL,
lfgja NUMERIC(8) NOT NULL,
lfmon NUMERIC(4) NOT NULL,
cwesb BIGNUMERIC(38,3) NOT NULL,
ersda DATE,
tbrue STRING(2) NOT NULL,
`_slash_cwm_slash_cwesb` BIGNUMERIC(38,3) NOT NULL,
odq_changemode STRING(2) NOT NULL,
odq_entitycntr BIGNUMERIC(38) NOT NULL,
sap_sys_name STRING(20) NOT NULL,
sap_client_id STRING(20) NOT NULL,
tmsp_insert DATETIME,
tmsp_update DATETIME
);