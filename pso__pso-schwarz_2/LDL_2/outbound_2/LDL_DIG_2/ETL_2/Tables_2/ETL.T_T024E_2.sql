CREATE TABLE IF NOT EXISTS ldl_dig_etl.t_t024e_2 (
ekorg STRING(8) NOT NULL,
ekotx STRING(40) NOT NULL,
bukrs STRING(8) NOT NULL,
txadr STRING(140) NOT NULL,
txkop STRING(140) NOT NULL,
txfus STRING(140) NOT NULL,
txgru STRING(140) NOT NULL,
kalse STRING(8) NOT NULL,
mkals STRING(12) NOT NULL,
bpeff STRING(2) NOT NULL,
bukrsntr STRING(8) NOT NULL,
odq_changemode STRING(2) NOT NULL,
odq_entitycntr BIGNUMERIC(38) NOT NULL,
sap_sys_name STRING(20) NOT NULL,
sap_client_id STRING(20) NOT NULL,
tmsp_insert DATETIME,
tmsp_update DATETIME
);