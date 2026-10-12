/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_quintiq_addressproducttypedur_kpi_2
Description		|	QUINTIQ - view with final KPIs for FE
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_quintiq_addressproducttypedur_kpi_2 (client_id
OPTIONS(description='Client ID'), lidl_country OPTIONS(description='Country_2 code'), source_system
OPTIONS(description='Source system'), wh_id OPTIONS(description='Warehouse ID'), address_id
OPTIONS(description='Identifier of the address_2'), wildcard_fg
OPTIONS(description='Return true if the record imported was send the product type with wildcard'), loadtime_pallet
OPTIONS(description='Loading time per pallet position of a certain product type at a store'), product_type_id
OPTIONS(description='Product type ID'), unloadtime_pallet
OPTIONS(description='Unloading time per pallet position of a certain product type at a store'), storage_temp_zone
OPTIONS(description='This should match a Temperature Area ID'), dwh_load_id OPTIONS(description='Load ID'), dwh_created
OPTIONS(description='Record created at'), dwh_updated OPTIONS(description='Record updated at'), dwh_valid_from
OPTIONS(description='Valid from date'), dwh_valid_to OPTIONS(description='Valid to date'), deleted_fg
OPTIONS(description='Flag if record is deleted'), active_fg OPTIONS(description='Flag if record is active'))
OPTIONS(DESCRIPTION = `QUINTIQ - VIEW WITH FINAL KPIS FOR FE`) AS SELECT client_id,
 lidl_country,
 source_system,
 wh_id,
 address_id,
 wildcard_fg,
 loadtime_pallet,
 product_type_id,
 unloadtime_pallet,
 storage_temp_zone,
 dwh_load_id,
 dwh_created,
 dwh_updated,
 dwh_valid_from,
 dwh_valid_to,
 deleted_fg,
 IF(dwh_valid_to = SAFE_CAST('9999-12-30' as DATE), 1, 0) AS active_fg
FROM ldl_logop_fe_mstr_logop.v_quintiq_addressproducttypedur_2;