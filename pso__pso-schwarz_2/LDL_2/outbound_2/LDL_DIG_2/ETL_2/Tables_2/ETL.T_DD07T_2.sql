CREATE TABLE IF NOT EXISTS ldl_dig_etl.t_dd07t_2 (
domname STRING(60) NOT NULL,
ddlanguage STRING(2) NOT NULL,
as4local STRING(2) NOT NULL,
valpos NUMERIC(8) NOT NULL,
as4vers NUMERIC(8) NOT NULL,
ddtext STRING(120) NOT NULL,
domvalld STRING(20) NOT NULL,
domvalhd STRING(20) NOT NULL,
domvaluel STRING(20) NOT NULL,
odq_changemode STRING(2) NOT NULL,
odq_entitycntr BIGNUMERIC(38) NOT NULL,
sap_sys_name STRING(20) NOT NULL,
sap_client_id STRING(20) NOT NULL,
tmsp_insert DATETIME,
tmsp_update DATETIME
);