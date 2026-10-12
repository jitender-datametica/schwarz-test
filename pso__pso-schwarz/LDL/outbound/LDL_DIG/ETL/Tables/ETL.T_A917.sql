CREATE TABLE IF NOT EXISTS ldl_dig_etl.t_a917 (
kappl STRING(4) NOT NULL,
kschl STRING(8) NOT NULL,
ekorg STRING(8) NOT NULL,
werks STRING(8) NOT NULL,
lifnr STRING(20) NOT NULL,
matnr STRING(80) NOT NULL,
kfrst STRING(2) NOT NULL,
datbi DATE,
datab DATE,
kbstat STRING(4) NOT NULL,
knumh STRING(20) NOT NULL,
odq_changemode STRING(2) NOT NULL,
odq_entitycntr BIGNUMERIC(38) NOT NULL,
sap_sys_name STRING(20) NOT NULL,
sap_client_id STRING(20) NOT NULL,
tmsp_insert DATETIME,
tmsp_update DATETIME
);