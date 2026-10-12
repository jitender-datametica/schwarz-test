/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table/view	|	t_zfm_bookings_2
Description		|	ZFM table
====================================================================================================
*/

CREATE TABLE DATA.t_zfm_bookings_2 (
client_id 					NUMBER(38,0) 	NOT NULL 	COMMENT 'Client id - calculated based on the country_2 code',
lidl_country 				VARCHAR(4) 		NOT NULL 	COMMENT 'Country_2 code.',
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
supplier_2                    VARCHAR(700)    NULL 	 	COMMENT '',
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
country_2                     VARCHAR(100)    NULL 	 	COMMENT '',
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
dwh_load_id 				NUMBER(38,0) 	NOT NULL 	COMMENT 'Load id',
dwh_created 				TIMESTAMP 		NOT NULL 	COMMENT 'Record created at',
dwh_updated 				TIMESTAMP 		NOT NULL 	COMMENT 'Record updated at',
dwh_valid_from 				DATE 			NOT NULL 	COMMENT 'Valid from date',
dwh_valid_to 				DATE 			NOT NULL 	COMMENT 'Valid to date',
deleted_fg 					BOOLEAN 		NOT NULL 	COMMENT 'Flag if record is deleted',
PRIMARY KEY (client_id, wh_id, booking_id, dwh_valid_from)
) COMMENT = 'ZFM - Booking Details (time slot information)'
; 