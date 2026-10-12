/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	etl_process
DB table		|	t_zfm_bookings_stage_1
Description		|	ZFM - stage table
====================================================================================================
*/

CREATE TABLE ETL_PROCESS.t_zfm_bookings_stage_1 (
client_id 					NUMBER(38,0) 	NOT NULL 	COMMENT 'Client id - calculated based on the country_1 code',
lidl_country 				VARCHAR(4) 		NOT NULL 	COMMENT 'Country_1 code.',
wh_id 						NUMBER(38,0) 	NOT NULL	COMMENT 'Warehouse ID. Subset of Warehouse Number.',
booking_id                  NUMBER(38,0)    NOT NULL 	COMMENT '',
created_by					VARCHAR(100)	NULL 	 	COMMENT '',
haulier_id                  NUMBER(38,0)    NULL 	 	COMMENT '',
haulier                     VARCHAR(200)    NULL 	 	COMMENT '',
booking_date                DATE 		    NULL 	 	COMMENT '',
type_of_goods               VARCHAR(200)    NULL 	 	COMMENT '',
booking_state               VARCHAR(25)     NULL 	 	COMMENT '',
booking_start_time          TIME(0)    		NULL 	 	COMMENT '',
reference_number            VARCHAR(100)    NULL 	 	COMMENT '',
order_number                VARCHAR(250)    NULL 	 	COMMENT '',
order_numbers               VARCHAR(2500)   NULL 	 	COMMENT '',
timestamp_signed_in         TIMESTAMP       NULL 	 	COMMENT '',
timestamp_at_gate           TIMESTAMP       NULL 	 	COMMENT '',
timestamp_signed_out        TIMESTAMP       NULL 	 	COMMENT '',
timestamp_not_arrived       TIMESTAMP       NULL 	 	COMMENT '',
timestamp_deleted           TIMESTAMP       NULL 	 	COMMENT '',
supplier_1                    VARCHAR(700)    NULL 	 	COMMENT '',
ep_count                    NUMBER(38,0)    NULL 	 	COMMENT '',
dd_count                    NUMBER(38,0)    NULL 	 	COMMENT '',
lpr_count                   NUMBER(38,0)    NULL 	 	COMMENT '',
chep_count                  NUMBER(38,0)    NULL 	 	COMMENT '',
attachments                 BOOLEAN         NULL 	 	COMMENT '',
article_description         VARCHAR(700)    NULL 	 	COMMENT '',
articles                    VARCHAR(2500)   NULL 	 	COMMENT '',
pallet_exchange             VARCHAR(50)     NULL 	 	COMMENT '',
swap_body                   BOOLEAN         NULL 	 	COMMENT '',
type_of_process             VARCHAR(20)     NULL 	 	COMMENT '',
country_1                     VARCHAR(100)    NULL 	 	COMMENT '',
WAREHOUSE                   VARCHAR(450)    NULL 	 	COMMENT '',
warehouse_short_name        VARCHAR(50)     NULL 	 	COMMENT '',
warehouse_number            VARCHAR(10)     NULL 	 	COMMENT '',
gate                        VARCHAR(20)     NULL 	 	COMMENT '',
not_arrived                 BOOLEAN         NULL 	 	COMMENT '',
deleted                     BOOLEAN         NULL 	 	COMMENT '',
reason_deleted              VARCHAR(250)    NULL 	 	COMMENT '',
comment_txt                 VARCHAR(250)    NULL 	 	COMMENT '',
type_of_goods_id            NUMBER(38,0)    NULL 	 	COMMENT '',
country_id                  NUMBER(38,0)    NULL 	 	COMMENT '',
warehouse_id                NUMBER(38,0)    NULL 	 	COMMENT '',
booking_datetime            TIMESTAMP	    NULL 	 	COMMENT 'Combination of booking_date + booking_start_time',
modified_tmsp         		TIMESTAMP       NOT NULL 	COMMENT ''
) COMMENT = 'ZFM - Booking Details (time slot information)'
; 