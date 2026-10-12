/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	V_QUINTIQ_REPORTEDADDRESSPRODUCTTYPEPALLETTYPE
Description	|	QUINTIQ - prepared view on raw data
====================================================================================================
*/

CREATE OR REPLACE VIEW FE_MSTR_LOGOP.V_QUINTIQ_REPORTEDADDRESSPRODUCTTYPEPALLETTYPE(
   CLIENT_ID COMMENT 'Client id - calculated based on the country code'
 , LIDL_COUNTRY COMMENT 'Country code. Original field name bic_zmlila'
 , WH_ID COMMENT 'Warehouse ID'
 , ADDRESS_ID COMMENT 'Delivery address ID of the shipment leg'
 , PRODUCT_TYPE_ID COMMENT 'Product type ID of the shipment leg'
 , DELIVERY_DT COMMENT 'End of the delivery day to optimize for (max 24hrs after start)'
 , TOTAL_QUANTITY COMMENT 'Sum of non-forecast shipment legs which are planned on a non-dummy route'
 , TOTAL_PRE_DELIVERY COMMENT 'Sum of shipment legs which have IsPredelivery = true'
 , TOTAL_POST_DELIVERY COMMENT 'Sum of shipment legs which have IsPostDelivery = true'
 , PALLET_TYPE COMMENT 'Pallet type or derived pallet type of the shipment leg'
 , PACKAGE_NUMBERS COMMENT 'String of package numbers of the shipment legs'
 , DWH_LOAD_ID COMMENT 'Load id'
 , DWH_CREATED COMMENT 'Record created at'
 , DWH_UPDATED COMMENT 'Record updated at'
 , DWH_VALID_FROM COMMENT 'Valid from date'
 , DWH_VALID_TO COMMENT 'Valid to date'
 , DELETED_FG COMMENT 'Flag if record is deleted'
)COMMENT='QUINTIQ - prepared view on raw data - On address product type pallet type there are some KPIs that have to be reported'
AS
SELECT
   CLIENT_ID
 , LIDL_COUNTRY
 , WH_ID
 , ADDRESS_ID
 , PRODUCT_TYPE_ID
 , DELIVERY_DT
 , TOTAL_QUANTITY
 , TOTAL_PRE_DELIVERY
 , TOTAL_POST_DELIVERY
 , PALLET_TYPE
 , PACKAGE_NUMBERS
 , DWH_LOAD_ID
 , DWH_CREATED
 , DWH_UPDATED
 , DWH_VALID_FROM
 , DWH_VALID_TO
 , DELETED_FG
FROM DATA.T_QUINTIQ_REPORTEDADDRESSPRODUCTTYPEPALLETTYPE
;