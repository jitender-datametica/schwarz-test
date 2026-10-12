/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table/view	|	t_zfm_warehouses
Description		|	ZFM table
====================================================================================================
*/

CREATE TABLE DATA.t_zfm_warehouses (
client_id 						NUMBER(38,0) 	NOT NULL 	COMMENT 'Client id - calculated based on the country code',
lidl_country 					VARCHAR(4) 		NOT NULL 	COMMENT 'Country code.',
wh_id 							NUMBER(38,0) 	NOT NULL	COMMENT 'Warehouse ID. Subset of Warehouse Number.',
warehouse_id					NUMBER(38,0)    NOT NULL 	COMMENT '',
NAME							VARCHAR(450)	NULL 	 	COMMENT '',
short_name                      VARCHAR(50)     NULL 	 	COMMENT '',
warehouse_number                VARCHAR(10)     NULL 	 	COMMENT '',
address                         VARCHAR(200)    NULL 	 	COMMENT '',
post_code                       VARCHAR(50)     NULL 	 	COMMENT '',
city                            VARCHAR(50)     NULL 	 	COMMENT '',
country                         VARCHAR(100)    NULL 	 	COMMENT '',
close_expired_bookings          VARCHAR(5)      NULL 	 	COMMENT '',
dsci_only                       BOOLEAN         NULL 	 	COMMENT '',
country_id						NUMBER(38,0)    NULL	 	COMMENT '',
dwh_load_id 					NUMBER(38,0) 	NOT NULL 	COMMENT 'Load id',
dwh_created 					TIMESTAMP 		NOT NULL 	COMMENT 'Record created at',
dwh_updated 					TIMESTAMP 		NOT NULL 	COMMENT 'Record updated at',
dwh_valid_from 					DATE 			NOT NULL 	COMMENT 'Valid from date',
dwh_valid_to 					DATE 			NOT NULL 	COMMENT 'Valid to date',
deleted_fg 						BOOLEAN 		NOT NULL 	COMMENT 'Flag if record is deleted',
PRIMARY KEY (client_id, wh_id, warehouse_id, dwh_valid_from)
) COMMENT = 'ZFM - Warehouses'
; 