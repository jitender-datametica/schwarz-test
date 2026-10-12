/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	V_QUINTIQ_REPORTEDADDRESSPRODUCTTYPEPALLETTYPE_KPI_1
Description	|	QUINTIQ - view with final KPIs for FE
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_quintiq_reportedaddressproducttypepallettype_kpi_1 (client_id
OPTIONS(description='Client id - calculated based on the country_1 code'), lidl_country
OPTIONS(description='Country_1 code. Original field name bic_zmlila'), wh_id OPTIONS(description='Warehouse ID'),
address_id OPTIONS(description='Delivery address_1 ID of the shipment leg'), product_type_id
OPTIONS(description='Product type ID of the shipment leg'), delivery_dt
OPTIONS(description='End of the delivery day to optimize for (max 24hrs after start)'), total_quantity
OPTIONS(description='Sum of non-forecast shipment legs which are planned on a non-dummy_1 route'), total_pre_delivery
OPTIONS(description='Sum of shipment legs which have IsPredelivery = true'), total_post_delivery
OPTIONS(description='Sum of shipment legs which have IsPostDelivery = true'), pallet_type
OPTIONS(description='Pallet type or derived pallet type of the shipment leg'), package_numbers
OPTIONS(description='String of package_1 numbers of the shipment legs'), dwh_load_id OPTIONS(description='Load id'),
dwh_created OPTIONS(description='Record created at'), dwh_updated OPTIONS(description='Record updated at'),
dwh_valid_from OPTIONS(description='Valid from date'), dwh_valid_to OPTIONS(description='Valid to date'), deleted_fg
OPTIONS(description='Flag if record is deleted'), active_fg OPTIONS(description='Flag if record is active'))
OPTIONS(DESCRIPTION = `QUINTIQ - VIEW WITH FINAL KPIS FOR FE - ON ADDRESS_1 PRODUCT TYPE PALLET TYPE THERE ARE SOME KPIS THAT HAVE TO BE REPORTED`)
AS SELECT client_id,
 lidl_country,
 wh_id,
 address_id,
 product_type_id,
 delivery_dt,
 total_quantity,
 total_pre_delivery,
 total_post_delivery,
 pallet_type,
 package_numbers,
 dwh_load_id,
 dwh_created,
 dwh_updated,
 dwh_valid_from,
 dwh_valid_to,
 deleted_fg,
 IF(dwh_valid_to = SAFE_CAST('9999-12-30' as DATE), 1, 0) AS active_fg
FROM ldl_logop_fe_mstr_logop.v_quintiq_reportedaddressproducttypepallettype_1;