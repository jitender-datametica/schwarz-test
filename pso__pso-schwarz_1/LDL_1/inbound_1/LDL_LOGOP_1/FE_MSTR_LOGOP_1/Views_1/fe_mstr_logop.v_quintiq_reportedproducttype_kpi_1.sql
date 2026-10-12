/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_quintiq_reportedproducttype_kpi_1
Description		|	QUINTIQ - view with final KPIs for FE
====================================================================================================
*/

CREATE OR REPLACE VIEW fe_mstr_logop.v_quintiq_reportedproducttype_kpi_1 (
	client_id COMMENT 'Client id - calculated based on the country_1 code'
	,lidl_country COMMENT 'Country_1 code. Original field name bic_zmlila'
	,source_system COMMENT 'Source system'
	,wh_id COMMENT 'Warehouse ID'
	,picklist_zero_out_val COMMENT 'Amount of picklist for this product type with ordered quantity 1 below minimum value'
	,delivery_dt COMMENT 'End of the delivery day to optimize for (max 24hrs after start).'
	,product_type_id COMMENT 'Id of product type'
	,qty_zero_fg COMMENT 'Indicator if there are picklists for this product type which have the ordered quantity 1 below the minimum value'
	,product_type_name COMMENT 'product type name'
	,fixed_picked_share COMMENT 'Share fixed pallets of the picked pallets'
	,created_ordered_share COMMENT 'Share picked and created pallets of ordered pallets'
	,picked_ordered_share COMMENT 'Share picked pallets of the ordered pallets'
	,fixed_pallet_sum COMMENT 'total forecasted floorspaces in WAMAS per store and product type'
	,zeroed_floorspace_sum COMMENT 'The sum of all floor spaced which were zeroed by the parameter Min value set to zero.'
	,manual_picked_pallet_sum COMMENT 'Manual created shipmentlegs that are considered picked'
	,ordered_pallet_sum COMMENT 'All pallets which are created in Quintiq for all picklists'
	,picked_created_pallet_sum COMMENT 'Amount of pallets which were picked within the current delivery day for this product type'
	,picked_pallet_sum COMMENT 'Amount of pallets which were picked within the current delivery day excluding manual created shipment legs'
	,dwh_load_id COMMENT 'Load id'
	,dwh_created COMMENT 'Record created at'
	,dwh_updated COMMENT 'Record updated at'
	,dwh_valid_from COMMENT 'Valid from date'
	,dwh_valid_to COMMENT 'Valid to date'
	,deleted_fg COMMENT 'Flag if record is deleted'
	,active_fg COMMENT 'Flag if record is active'
	)
COMMENT = 'QUINTIQ - view with final KPIs for FE'
AS 
SELECT
	client_id
	,lidl_country
	,source_system
	,wh_id
	,picklist_zero_out_val
	,delivery_dt
	,product_type_id
	,qty_zero_fg
	,product_type_name
	,fixed_picked_share
	,created_ordered_share
	,picked_ordered_share
	,fixed_pallet_sum
	,zeroed_floorspace_sum
	,manual_picked_pallet_sum
	,ordered_pallet_sum
	,picked_created_pallet_sum
	,picked_pallet_sum
	,dwh_load_id
	,dwh_created
	,dwh_updated
	,dwh_valid_from
	,dwh_valid_to
	,deleted_fg
	,IFF(dwh_valid_to = '9999-12-30', 1, 0) AS active_fg
FROM fe_mstr_logop.v_quintiq_reportedproducttype_1
;