/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	etl_process
DB table/view	|	t_quintiq_reportedaddressstate_deleted_2
Description		|	QUINTIQ - Temporary table
====================================================================================================
*/

CREATE TABLE ETL_PROCESS.t_quintiq_reportedaddressstate_deleted_2 (
client_id               	NUMBER(38,0)    NOT NULL,
lidl_country            	VARCHAR(40)     NOT NULL,
source_system           	VARCHAR(30)     NOT NULL,
wh_id                   	VARCHAR(5)      NOT NULL,
pallet_pos_additional_dist 	NUMBER(38,10)	NULL,
address_id 					VARCHAR(512) 	NOT NULL,
calendar_week 				NUMBER(38,0)	NULL,
delivery_dt 				DATE 			NOT NULL,
oneway_fg 					BOOLEAN			NULL,
temp_fg 					BOOLEAN			NULL,
pallet_pos_dlv_cnt 			NUMBER(38,10)	NULL,
tour_dist_without_addr 		NUMBER(38,10)	NULL,
reportedtourgid 			VARCHAR(512) 	NOT NULL,
reportedtourid 				VARCHAR(512)	NULL,
arrivalactualtelematics		TIMESTAMP  		NULL,
arrivalestimatedtelematics	TIMESTAMP  		NULL,
departureactualtelematics	TIMESTAMP  		NULL,
deleted_fg              	NUMBER(38,0)    NOT NULL,
update_mode             	VARCHAR(2)      NULL,
extraction_dt           	DATE            NOT NULL,
extraction_ts           	TIMESTAMP       NOT NULL,
dwh_mapping_dt          	DATE            NOT NULL,
tf_error_fg             	NUMBER(1,0)     NOT NULL,
record_id               	NUMBER(10,0)    NOT NULL,
filename                	VARCHAR(1000)   NOT NULL
) COMMENT = 'QUINTIQ - Temporary table';