/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_quintiq_reportedaddproducttype
Description		|	QUINTIQ - prepared view on raw data
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_quintiq_reportedaddproducttype (client_id
OPTIONS(description='Client id - calculated based on the country code'), lidl_country
OPTIONS(description='Country code. Original field name bic_zmlila'), source_system OPTIONS(description='Source system'),
wh_id OPTIONS(description='Warehouse ID'), address_id OPTIONS(description='Which address belongs to this entry'),
picklist_zero_out_val
OPTIONS(description='Amount of picklist for this product type with ordered quantity 1 below minimum value'), delivery_dt
OPTIONS(description='End of the delivery day to optimize for (max 24hrs after start).'), day_of_week
OPTIONS(description='Stores the weekday of this delivery day'), qty_zero_fg
OPTIONS(description='Indicator if there are picklists for this product type which have the ordered quantity 1 below the minimum value'),
product_type_id OPTIONS(description='Which productType belongs to this entry'), fixed_picked_share
OPTIONS(description='Share fixed pallets of the picked pallets'), created_ordered_share
OPTIONS(description='Share picked and created pallets of ordered pallets'), picked_ordered_share
OPTIONS(description='Share picked pallets of the ordered pallets'), fixed_pal_sum
OPTIONS(description='Total forecasted floorspaces in WAMAS per store and product type'), zeroed_floorspace_sum
OPTIONS(description='The sum of all floor spaced which were zeroed by the parameter Min value set to zero.'),
manual_pallet_sum OPTIONS(description='Manually created shipmentlegs for this day'), ordered_pallet_sum
OPTIONS(description='All pallets which are created in Quintiq for all picklists'), picked_pallet_sum
OPTIONS(description='Amount of pallets which were picked within the current delivery day excluding manual created shipment legs'),
shipped_pallet_sum
OPTIONS(description='Amount of pallets from WaWi with status departure at the end of the delivery day for this product type'),
dwh_load_id OPTIONS(description='Load id'), dwh_created OPTIONS(description='Record created at'), dwh_updated
OPTIONS(description='Record updated at'), dwh_valid_from OPTIONS(description='Valid from date'), dwh_valid_to
OPTIONS(description='Valid to date'), deleted_fg OPTIONS(description='Flag if record is deleted'))
OPTIONS(DESCRIPTION = `QUINTIQ - PREPARED VIEW ON RAW DATA`) AS SELECT *
FROM ldl_logop_data.t_quintiq_reportedaddproducttype;