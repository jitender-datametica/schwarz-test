/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table/view	|	t_zfm_warehouses_tog_1
Description		|	ZFM table
====================================================================================================
*/

CREATE TABLE DATA.t_zfm_warehouses_tog_1 (
client_id 						NUMBER(38,0) 	NOT NULL 	COMMENT 'Client id - calculated based on the country_1 code',
lidl_country 					VARCHAR(4) 		NOT NULL 	COMMENT 'Country_1 code.',
wh_id 							NUMBER(38,0) 	NOT NULL	COMMENT 'Warehouse ID. Subset of Warehouse Number.',
warehouse_id					NUMBER(38,0)    NOT NULL 	COMMENT '',
type_of_goods_id				NUMBER(38,0)    NOT NULL	COMMENT '',
description                     VARCHAR(200)    NULL 	 	COMMENT '',
main_type_of_goods              VARCHAR(200)    NULL 	 	COMMENT '',
hours_in_advance                NUMBER(38,0)    NULL 	 	COMMENT '',
max_purchase_order_booking      NUMBER(38,0)    NULL 	 	COMMENT '',
max_articles_booking            NUMBER(38,0)    NULL 	 	COMMENT '',
setup_time                      NUMBER(38,0)    NULL 	 	COMMENT '',
pallets_per_booking             NUMBER(38,0)    NULL 	 	COMMENT '',
pdf_required                    BOOLEAN         NULL 	 	COMMENT '',
use_inbound_outbound            BOOLEAN         NULL 	 	COMMENT '',
purchase_order_relevance        VARCHAR(25)     NULL 	 	COMMENT '',
article_description_required	BOOLEAN         NULL 	 	COMMENT '',
dwh_load_id 					NUMBER(38,0) 	NOT NULL 	COMMENT 'Load id',
dwh_created 					TIMESTAMP 		NOT NULL 	COMMENT 'Record created at',
dwh_updated 					TIMESTAMP 		NOT NULL 	COMMENT 'Record updated at',
dwh_valid_from 					DATE 			NOT NULL 	COMMENT 'Valid from date',
dwh_valid_to 					DATE 			NOT NULL 	COMMENT 'Valid to date',
deleted_fg 						BOOLEAN 		NOT NULL 	COMMENT 'Flag if record is deleted',
PRIMARY KEY (client_id, wh_id, warehouse_id, type_of_goods_id, dwh_valid_from)
) COMMENT = 'ZFM - Warehouses, TypeOfGoods subrecord'
; 