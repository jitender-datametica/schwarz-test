/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	etl_process
DB table		|	t_zfm_bookingorders_stage_2
Description		|	ZFM - stage table
====================================================================================================
*/

CREATE TABLE ETL_PROCESS.t_zfm_bookingorders_stage_2 (
client_id 					NUMBER(38,0) 	NOT NULL 	COMMENT 'Client id - calculated based on the country_2 code',
lidl_country 				VARCHAR(4) 		NOT NULL 	COMMENT 'Country_2 code.',
booking_id                  NUMBER(38,0)    NOT NULL 	COMMENT '',
booking_order_guid			VARCHAR(100)	NULL 	 	COMMENT '',
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
modified_tmsp         		TIMESTAMP       NOT NULL 	COMMENT ''
) COMMENT = 'ZFM - Booking Orders'
; 