/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	etl_process
DB table		|	t_zfm_warehouses_tog_stage_1
Description		|	ZFM - stage table
====================================================================================================
*/


CREATE TABLE IF NOT EXISTS ldl_logop_etl_process.t_zfm_warehouses_tog_stage_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country_1 code'),
lidl_country STRING(4) NOT NULL OPTIONS(description='Country_1 code.'),
wh_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warehouse ID. Subset of Warehouse Number.'),
warehouse_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description=''),
type_of_goods_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description=''),
description STRING(200) OPTIONS(description=''),
main_type_of_goods STRING(200) OPTIONS(description=''),
hours_in_advance BIGNUMERIC(38,0) OPTIONS(description=''),
max_purchase_order_booking BIGNUMERIC(38,0) OPTIONS(description=''),
max_articles_booking BIGNUMERIC(38,0) OPTIONS(description=''),
setup_time BIGNUMERIC(38,0) OPTIONS(description=''),
pallets_per_booking BIGNUMERIC(38,0) OPTIONS(description=''),
pdf_required BOOL OPTIONS(description=''),
use_inbound_outbound BOOL OPTIONS(description=''),
purchase_order_relevance STRING(25) OPTIONS(description=''),
article_description_required BOOL OPTIONS(description=''),
modified_tmsp DATETIME NOT NULL OPTIONS(description='')
) OPTIONS(description='ZFM - Warehouses, TypeOfGoods subrecord');