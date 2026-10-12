/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table/view	|	t_zfm_bookingorders
Description		|	ZFM table
====================================================================================================
*/

CREATE TABLE DATA.t_zfm_bookingorders (
client_id 					NUMBER(38,0) 	NOT NULL 	COMMENT 'Client id - calculated based on the country code',
lidl_country 				VARCHAR(4) 		NOT NULL 	COMMENT 'Country code.',
booking_id                  NUMBER(38,0)    NOT NULL 	COMMENT '',
booking_order_guid			VARCHAR(100)	NOT NULL 	COMMENT '',
order_number				VARCHAR(100)	NULL 	 	COMMENT '',
collection_number			VARCHAR(100)	NULL 	 	COMMENT '',
supplier_name				VARCHAR(100)	NULL 	 	COMMENT '',
supplier_number				VARCHAR(100)	NULL 	 	COMMENT '',
article_description			VARCHAR(110)	NULL 	 	COMMENT '',
ep_count                  	NUMBER(38,0)    NULL 	 	COMMENT '',
dd_count                  	NUMBER(38,0)    NULL 	 	COMMENT '',
lpr_count                  	NUMBER(38,0)    NULL 	 	COMMENT '',
chep_count                  NUMBER(38,0)    NULL 	 	COMMENT '',
ep_count_out                NUMBER(38,0)    NULL 	 	COMMENT '',
dd_count_out                NUMBER(38,0)    NULL 	 	COMMENT '',
lpr_count_out               NUMBER(38,0)    NULL 	 	COMMENT '',
chep_count_out              NUMBER(38,0)    NULL 	 	COMMENT '',
dwh_load_id 				NUMBER(38,0) 	NOT NULL 	COMMENT 'Load id',
dwh_created 				TIMESTAMP 		NOT NULL 	COMMENT 'Record created at',
dwh_updated 				TIMESTAMP 		NOT NULL 	COMMENT 'Record updated at',
dwh_valid_from 				DATE 			NOT NULL 	COMMENT 'Valid from date',
dwh_valid_to 				DATE 			NOT NULL 	COMMENT 'Valid to date',
deleted_fg 					BOOLEAN 		NOT NULL 	COMMENT 'Flag if record is deleted',
PRIMARY KEY (client_id, booking_id, booking_order_guid, dwh_valid_from)
) COMMENT = 'ZFM - Booking Orders'
; 