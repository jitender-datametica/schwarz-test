CREATE OR REPLACE TABLE ldl_dig_production_etl.t_t002 (
spras STRING(2) NOT NULL,
laspez STRING(2) NOT NULL,
lahq STRING(2) NOT NULL,
laiso STRING(4) NOT NULL,
odq_changemode STRING(2) NOT NULL,
odq_entitycntr INTEGER NOT NULL,
sap_sys_name STRING(20) NOT NULL,
sap_client_id STRING(20) NOT NULL,
tmsp_insert DATETIME,
tmsp_update DATETIME
);