/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table		|	t_quintiq_addressproducttypedur_2
Description		|	QUINTIQ table for raw data
====================================================================================================
*/


CREATE TABLE IF NOT EXISTS ldl_logop_data.t_quintiq_addressproducttypedur_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client ID'),
lidl_country STRING(3) NOT NULL OPTIONS(description='Country_2 code'),
source_system STRING(30) NOT NULL OPTIONS(description='Source system'),
wh_id STRING(5) NOT NULL OPTIONS(description='Warehouse ID'),
address_id STRING(512) NOT NULL OPTIONS(description='Identifier of the address_2'),
wildcard_fg BOOL OPTIONS(description='Return true if the record imported was send the product type with wildcard'),
loadtime_pallet STRING(512) OPTIONS(description='Loading time per pallet position of a certain product type at a store'),
product_type_id STRING(512) NOT NULL OPTIONS(description='Product type ID'),
unloadtime_pallet STRING(512)
OPTIONS(description='Unloading time per pallet position of a certain product type at a store'),
storage_temp_zone STRING(512) OPTIONS(description='This should match a Temperature Area ID'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load ID'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at'),
dwh_valid_from DATE NOT NULL OPTIONS(description='Valid from date'),
dwh_valid_to DATE NOT NULL OPTIONS(description='Valid to date'),
deleted_fg BOOL NOT NULL OPTIONS(description='Flag if record is deleted'),
PRIMARY KEY (client_id, wh_id, address_id, product_type_id, dwh_valid_from) NOT ENFORCED
) OPTIONS(description='QUINTIQ - Object type in quintiq is AddressProductTypeDuration');