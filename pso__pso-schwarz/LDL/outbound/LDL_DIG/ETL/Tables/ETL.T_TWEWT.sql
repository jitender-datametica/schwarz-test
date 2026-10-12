CREATE TABLE IF NOT EXISTS ldl_dig_etl.t_twewt (
spras STRING(2) NOT NULL,
extwg STRING(36) NOT NULL,
ewbez STRING(40) NOT NULL,
odq_changemode STRING(2) NOT NULL,
odq_entitycntr BIGNUMERIC(38) NOT NULL,
sap_sys_name STRING(20) NOT NULL,
sap_client_id STRING(20) NOT NULL,
tmsp_insert DATETIME,
tmsp_update DATETIME
);