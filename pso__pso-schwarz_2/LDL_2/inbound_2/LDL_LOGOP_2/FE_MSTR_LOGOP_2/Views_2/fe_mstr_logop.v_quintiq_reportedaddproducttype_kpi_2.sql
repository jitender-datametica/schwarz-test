/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_quintiq_reportedaddproducttype_kpi_2
Description		|	QUINTIQ - view with final KPIs for FE
====================================================================================================
*/

CREATE OR REPLACE VIEW fe_mstr_logop.v_quintiq_reportedaddproducttype_kpi_2 (
	client_id COMMENT 'Client id - calculated based on the country_2 code'
	,lidl_country COMMENT 'Country_2 code. Original field name bic_zmlila'
	,source_system COMMENT 'Source system'
	,wh_id COMMENT 'Warehouse ID'
	,address_id COMMENT 'Which address_2 belongs to this entry'
	,picklist_zero_out_val COMMENT 'Amount of picklist for this product type with ordered quantity 1 below minimum value'
	,delivery_dt COMMENT 'End of the delivery day to optimize for (max 24hrs after start).'
	,day_of_week COMMENT 'Stores the weekday of this delivery day'
	,qty_zero_fg COMMENT 'Indicator if there are picklists for this product type which have the ordered quantity 1 below the minimum value'
	,product_type_id COMMENT 'Which productType belongs to this entry'
	,fixed_picked_share COMMENT 'Share fixed pallets of the picked pallets'
	,created_ordered_share COMMENT 'Share picked and created pallets of ordered pallets'
	,picked_ordered_share COMMENT 'Share picked pallets of the ordered pallets'
	,fixed_pal_sum COMMENT 'Total forecasted floorspaces in WAMAS per store and product type'
	,zeroed_floorspace_sum COMMENT 'The sum of all floor spaced which were zeroed by the parameter Min value set to zero.'
	,manual_pallet_sum COMMENT 'Manually created shipmentlegs for this day'
	,ordered_pallet_sum COMMENT 'All pallets which are created in Quintiq for all picklists'
	,picked_pallet_sum COMMENT 'Amount of pallets which were picked within the current delivery day excluding manual created shipment legs'
	,shipped_pallet_sum COMMENT 'Amount of pallets from WaWi with status_2 departure at the end of the delivery day for this product type'
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
	,address_id
	,picklist_zero_out_val
	,delivery_dt
	,day_of_week
	,qty_zero_fg
	,product_type_id
	,fixed_picked_share
	,created_ordered_share
	,picked_ordered_share
	,fixed_pal_sum
	,zeroed_floorspace_sum
	,manual_pallet_sum
	,ordered_pallet_sum
	,picked_pallet_sum
	,shipped_pallet_sum
	,dwh_load_id
	,dwh_created
	,dwh_updated
	,dwh_valid_from
	,dwh_valid_to
	,deleted_fg
	,IFF(dwh_valid_to = '9999-12-30', 1, 0) AS active_fg
FROM fe_mstr_logop.v_quintiq_reportedaddproducttype_2
;