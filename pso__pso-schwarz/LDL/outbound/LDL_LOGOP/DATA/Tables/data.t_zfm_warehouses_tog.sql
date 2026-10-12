/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table/view	|	t_zfm_warehouses_tog
Description		|	ZFM table
====================================================================================================
*/


CREATE TABLE IF NOT EXISTS ldl_logop_data.t_zfm_warehouses_tog (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country code'),
lidl_country STRING(4) NOT NULL OPTIONS(description='Country code.'),
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
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at'),
dwh_valid_from DATE NOT NULL OPTIONS(description='Valid from date'),
dwh_valid_to DATE NOT NULL OPTIONS(description='Valid to date'),
deleted_fg BOOL NOT NULL OPTIONS(description='Flag if record is deleted'),
PRIMARY KEY (client_id, wh_id, warehouse_id, type_of_goods_id, dwh_valid_from) NOT ENFORCED
) OPTIONS(description='ZFM - Warehouses, TypeOfGoods subrecord');