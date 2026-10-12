/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	etl_process
DB table		|	t_zfm_warehouses_stage_1
Description		|	ZFM - stage table
====================================================================================================
*/

CREATE TABLE ETL_PROCESS.t_zfm_warehouses_stage_1 (
client_id 						NUMBER(38,0) 	NOT NULL 	COMMENT 'Client id - calculated based on the country_1 code',
lidl_country 					VARCHAR(4) 		NOT NULL 	COMMENT 'Country_1 code.',
wh_id 							NUMBER(38,0) 	NOT NULL	COMMENT 'Warehouse ID. Subset of Warehouse Number.',
warehouse_id					NUMBER(38,0)    NOT NULL 	COMMENT '',
NAME							VARCHAR(450)	NULL 	 	COMMENT '',
short_name                      VARCHAR(50)     NULL 	 	COMMENT '',
warehouse_number                VARCHAR(10)     NULL 	 	COMMENT '',
address_1                         VARCHAR(200)    NULL 	 	COMMENT '',
post_code                       VARCHAR(50)     NULL 	 	COMMENT '',
city                            VARCHAR(50)     NULL 	 	COMMENT '',
country_1                         VARCHAR(100)    NULL 	 	COMMENT '',
close_expired_bookings          VARCHAR(5)      NULL 	 	COMMENT '',
dsci_only                       BOOLEAN         NULL 	 	COMMENT '',
country_id						NUMBER(38,0)    NULL	 	COMMENT '',
modified_tmsp         			TIMESTAMP       NOT NULL 	COMMENT ''
) COMMENT = 'ZFM - Warehouses'
; 