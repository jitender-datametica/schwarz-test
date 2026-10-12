/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_quintiq_addressproducttypedur_1
Description		|	QUINTIQ - prepared view on raw data
====================================================================================================
*/

CREATE OR REPLACE VIEW fe_mstr_logop.v_quintiq_addressproducttypedur_1 (
	client_id COMMENT 'Client ID'
	,lidl_country COMMENT 'Country_1 code'
	,source_system COMMENT 'Source system'
	,wh_id COMMENT 'Warehouse ID'
	,address_id COMMENT 'Identifier of the address_1'
	,wildcard_fg COMMENT 'Return true if the record imported was send the product type with wildcard'
	,loadtime_pallet COMMENT 'Loading time per pallet position of a certain product type at a store'
	,product_type_id COMMENT 'Product type ID'
	,unloadtime_pallet COMMENT 'Unloading time per pallet position of a certain product type at a store'
	,storage_temp_zone COMMENT 'This should match a Temperature Area ID'
	,dwh_load_id COMMENT 'Load ID'
	,dwh_created COMMENT 'Record created at'
	,dwh_updated COMMENT 'Record updated at'
	,dwh_valid_from COMMENT 'Valid from date'
	,dwh_valid_to COMMENT 'Valid to date'
	,deleted_fg COMMENT 'Flag if record is deleted'
	)
COMMENT = 'QUINTIQ - prepared view on raw data'
AS 
SELECT
	client_id
	,lidl_country
	,source_system
	,wh_id
	,address_id
	,wildcard_fg
	,loadtime_pallet
	,product_type_id
	,unloadtime_pallet
	,storage_temp_zone
	,dwh_load_id
	,dwh_created
	,dwh_updated
	,dwh_valid_from
	,dwh_valid_to
	,deleted_fg
FROM DATA.t_quintiq_addressproducttypedur_1
;