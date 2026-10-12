/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	etl_process
DB table/view	|	t_quintiq_reportedprodtypestop_deleted_1
Description		|	QUINTIQ - Temporary table
====================================================================================================
*/

CREATE TABLE ETL_PROCESS.t_quintiq_reportedprodtypestop_deleted_1 (
client_id 			NUMBER(38,0) 	NOT NULL,
lidl_country 		VARCHAR(40) 	NOT NULL,
source_system 		VARCHAR(30) 	NOT NULL,
wh_id 				VARCHAR(5) 		NOT NULL,
address_id 			VARCHAR(512) 	NOT NULL,
delivery_dt 		DATE 			NOT NULL,
temp_fg 			BOOLEAN			NULL,
product_type_id 	VARCHAR(512) 	NOT NULL,
stop_state_qty 		NUMBER(38,10)	NULL,
start_tmsp 			TIMESTAMP		NULL,
stop_state_type 	VARCHAR(512)	NULL,
addresscomment 		VARCHAR(512)	NULL,
addressiddelivery 	VARCHAR(512)	NULL,
addressidpickup 	VARCHAR(512)	NULL,
reportedtourgid 	VARCHAR(512) 	NOT NULL,
reportedtourid 		VARCHAR(512)	NULL,
transfercomment 	VARCHAR(512)	NULL,
transferreason 		VARCHAR(512)	NULL,
deleted_fg          NUMBER(38,0)    NOT NULL,
update_mode         VARCHAR(2)      NULL,
extraction_dt       DATE            NOT NULL,
extraction_ts       TIMESTAMP       NOT NULL,
dwh_mapping_dt      DATE            NOT NULL,
tf_error_fg         NUMBER(1,0)     NOT NULL,
record_id           NUMBER(10,0)    NOT NULL,
filename            VARCHAR(1000)   NOT NULL
) COMMENT = 'QUINTIQ - Temporary table';