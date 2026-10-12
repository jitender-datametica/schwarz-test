CREATE TABLE IF NOT EXISTS ldl_dig_etl.t_lgk_tran_2 (
vbeln STRING(10) NOT NULL,
lgkcardnum STRING(30) NOT NULL,
lgkcardean STRING(13) NOT NULL,
lgkcardtype STRING(8) NOT NULL,
lgkcardtypeid STRING(3) NOT NULL,
lgkvalue NUMERIC(18,2) NOT NULL,
lgktranref STRING(30) NOT NULL,
vkorg STRING(4) NOT NULL,
erdat DATE,
odq_changemode STRING(1) NOT NULL,
odq_entitycntr NUMERIC(20) NOT NULL,
sap_sys_name STRING(20) NOT NULL,
sap_client_id STRING(20) NOT NULL,
tmsp_insert DATETIME,
tmsp_update DATETIME
);