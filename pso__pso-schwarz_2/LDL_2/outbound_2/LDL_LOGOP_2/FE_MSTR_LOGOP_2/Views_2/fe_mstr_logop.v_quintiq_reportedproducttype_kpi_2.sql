/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_quintiq_reportedproducttype_kpi_2
Description		|	QUINTIQ - view with final KPIs for FE
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_quintiq_reportedproducttype_kpi_2 (client_id
OPTIONS(description='Client id - calculated based on the country_2 code'), lidl_country
OPTIONS(description='Country_2 code. Original field name bic_zmlila'), source_system OPTIONS(description='Source system'),
wh_id OPTIONS(description='Warehouse ID'), picklist_zero_out_val
OPTIONS(description='Amount of picklist for this product type with ordered quantity 1 below minimum value'), delivery_dt
OPTIONS(description='End of the delivery day to optimize for (max 24hrs after start).'), product_type_id
OPTIONS(description='Id of product type'), qty_zero_fg
OPTIONS(description='Indicator if there are picklists for this product type which have the ordered quantity 1 below the minimum value'),
product_type_name OPTIONS(description='product type name'), fixed_picked_share
OPTIONS(description='Share fixed pallets of the picked pallets'), created_ordered_share
OPTIONS(description='Share picked and created pallets of ordered pallets'), picked_ordered_share
OPTIONS(description='Share picked pallets of the ordered pallets'), fixed_pallet_sum
OPTIONS(description='total forecasted floorspaces in WAMAS per store and product type'), zeroed_floorspace_sum
OPTIONS(description='The sum of all floor spaced which were zeroed by the parameter Min value set to zero.'),
manual_picked_pallet_sum OPTIONS(description='Manual created shipmentlegs that are considered picked'),
ordered_pallet_sum OPTIONS(description='All pallets which are created in Quintiq for all picklists'),
picked_created_pallet_sum
OPTIONS(description='Amount of pallets which were picked within the current delivery day for this product type'),
picked_pallet_sum
OPTIONS(description='Amount of pallets which were picked within the current delivery day excluding manual created shipment legs'),
dwh_load_id OPTIONS(description='Load id'), dwh_created OPTIONS(description='Record created at'), dwh_updated
OPTIONS(description='Record updated at'), dwh_valid_from OPTIONS(description='Valid from date'), dwh_valid_to
OPTIONS(description='Valid to date'), deleted_fg OPTIONS(description='Flag if record is deleted'), active_fg
OPTIONS(description='Flag if record is active')) OPTIONS(DESCRIPTION = `QUINTIQ - VIEW WITH FINAL KPIS FOR FE`) AS
SELECT client_id,
 lidl_country,
 source_system,
 wh_id,
 picklist_zero_out_val,
 delivery_dt,
 product_type_id,
 qty_zero_fg,
 product_type_name,
 fixed_picked_share,
 created_ordered_share,
 picked_ordered_share,
 fixed_pallet_sum,
 zeroed_floorspace_sum,
 manual_picked_pallet_sum,
 ordered_pallet_sum,
 picked_created_pallet_sum,
 picked_pallet_sum,
 dwh_load_id,
 dwh_created,
 dwh_updated,
 dwh_valid_from,
 dwh_valid_to,
 deleted_fg,
 IF(dwh_valid_to = SAFE_CAST('9999-12-30' as DATE), 1, 0) AS active_fg
FROM ldl_logop_fe_mstr_logop.v_quintiq_reportedproducttype_2;