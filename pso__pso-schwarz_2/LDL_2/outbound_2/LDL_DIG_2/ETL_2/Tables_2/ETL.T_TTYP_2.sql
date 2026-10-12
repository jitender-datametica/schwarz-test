CREATE TABLE IF NOT EXISTS ldl_dig_etl.t_ttyp_2 (
awtyp STRING(10) NOT NULL,
struc STRING(20) NOT NULL,
function STRING(60) NOT NULL,
remote STRING(2) NOT NULL,
odq_changemode STRING(2) NOT NULL,
odq_entitycntr BIGNUMERIC(38) NOT NULL,
sap_sys_name STRING(20) NOT NULL,
sap_client_id STRING(20) NOT NULL,
tmsp_insert DATETIME,
tmsp_update DATETIME
);