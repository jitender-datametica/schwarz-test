/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	etl_process
DB table		|	t_zfm_warehouses_tog_stage_1
Description		|	ZFM - stage table
====================================================================================================
*/

CREATE TABLE ETL_PROCESS.t_zfm_warehouses_tog_stage_1 (
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
modified_tmsp         			TIMESTAMP       NOT NULL 	COMMENT ''
) COMMENT = 'ZFM - Warehouses, TypeOfGoods subrecord'
; 