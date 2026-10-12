CREATE TABLE IF NOT EXISTS ldl_dig_etl.t_zmakt_2 (
matnr STRING(80) NOT NULL,
spras STRING(2) NOT NULL,
form1 STRING(142) NOT NULL,
form2 STRING(142) NOT NULL,
ewmtx STRING(80) NOT NULL,
odq_changemode STRING(2) NOT NULL,
odq_entitycntr BIGNUMERIC(38) NOT NULL,
sap_sys_name STRING(20) NOT NULL,
sap_client_id STRING(20) NOT NULL,
tmsp_insert DATETIME,
tmsp_update DATETIME
);