/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table		|	t_quintiq_addressproducttypedur_2
Description		|	QUINTIQ table for raw data
====================================================================================================
*/

CREATE TABLE DATA.t_quintiq_addressproducttypedur_2 (
	client_id NUMBER(38,0) NOT NULL COMMENT 'Client ID',
	lidl_country VARCHAR(3) NOT NULL COMMENT 'Country_2 code',
	source_system VARCHAR(30) NOT NULL COMMENT 'Source system',
	wh_id VARCHAR(5) NOT NULL COMMENT 'Warehouse ID',
	address_id VARCHAR(512) NOT NULL COMMENT 'Identifier of the address_2',
	wildcard_fg BOOLEAN COMMENT 'Return true if the record imported was send the product type with wildcard',
	loadtime_pallet VARCHAR(512) COMMENT 'Loading time per pallet position of a certain product type at a store',
	product_type_id VARCHAR(512) NOT NULL COMMENT 'Product type ID',
	unloadtime_pallet VARCHAR(512) COMMENT 'Unloading time per pallet position of a certain product type at a store',
	storage_temp_zone VARCHAR(512) COMMENT 'This should match a Temperature Area ID',
	dwh_load_id NUMBER(38,0) NOT NULL COMMENT 'Load ID',
	dwh_created TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Record created at',
	dwh_updated TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Record updated at',
	dwh_valid_from DATE NOT NULL COMMENT 'Valid from date',
	dwh_valid_to DATE NOT NULL COMMENT 'Valid to date',
	deleted_fg BOOLEAN NOT NULL COMMENT 'Flag if record is deleted',
	PRIMARY KEY (client_id, wh_id, address_id, product_type_id, dwh_valid_from)
	)
COMMENT = 'QUINTIQ - Object type in quintiq is AddressProductTypeDuration'
;