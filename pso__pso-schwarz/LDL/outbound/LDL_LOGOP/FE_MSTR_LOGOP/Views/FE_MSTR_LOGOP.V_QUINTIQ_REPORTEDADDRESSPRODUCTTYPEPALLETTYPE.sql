/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	V_QUINTIQ_REPORTEDADDRESSPRODUCTTYPEPALLETTYPE
Description	|	QUINTIQ - prepared view on raw data
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_quintiq_reportedaddressproducttypepallettype (client_id
OPTIONS(description='Client id - calculated based on the country code'), lidl_country
OPTIONS(description='Country code. Original field name bic_zmlila'), wh_id OPTIONS(description='Warehouse ID'),
address_id OPTIONS(description='Delivery address ID of the shipment leg'), product_type_id
OPTIONS(description='Product type ID of the shipment leg'), delivery_dt
OPTIONS(description='End of the delivery day to optimize for (max 24hrs after start)'), total_quantity
OPTIONS(description='Sum of non-forecast shipment legs which are planned on a non-dummy route'), total_pre_delivery
OPTIONS(description='Sum of shipment legs which have IsPredelivery = true'), total_post_delivery
OPTIONS(description='Sum of shipment legs which have IsPostDelivery = true'), pallet_type
OPTIONS(description='Pallet type or derived pallet type of the shipment leg'), package_numbers
OPTIONS(description='String of package numbers of the shipment legs'), dwh_load_id OPTIONS(description='Load id'),
dwh_created OPTIONS(description='Record created at'), dwh_updated OPTIONS(description='Record updated at'),
dwh_valid_from OPTIONS(description='Valid from date'), dwh_valid_to OPTIONS(description='Valid to date'), deleted_fg
OPTIONS(description='Flag if record is deleted'))
OPTIONS(DESCRIPTION = `QUINTIQ - PREPARED VIEW ON RAW DATA - ON ADDRESS PRODUCT TYPE PALLET TYPE THERE ARE SOME KPIS THAT HAVE TO BE REPORTED`)
AS SELECT *
FROM ldl_logop_data.t_quintiq_reportedaddressproducttypepallettype;