/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_quintiq_reportedprodtypestop
Description		|	QUINTIQ - prepared view on raw data
====================================================================================================
*/

CREATE OR REPLACE VIEW fe_mstr_logop.v_quintiq_reportedprodtypestop (
	CLIENT_ID COMMENT 'Client id - calculated based on the country code',
	LIDL_COUNTRY COMMENT 'Country code. Original field name bic_zmlila',
	SOURCE_SYSTEM COMMENT 'Source system',
	WH_ID COMMENT 'Warehouse ID',
	ADDRESS_ID COMMENT 'ID of the address of the stop state',
	DELIVERY_DT COMMENT 'Delivery date of the dataset',
	TEMP_FG COMMENT 'Indicates if this is a temporary reported product type stop',
	PRODUCT_TYPE_ID COMMENT 'ID of the product type',
	STOP_STATE_QTY COMMENT 'Quantity 1 of the product type stop state',
	START_TMSP COMMENT 'Start time of the stop state',
	STOP_STATE_TYPE COMMENT 'Type of the stop state',
	REPORTEDTOURGID COMMENT 'GID of the reported tour',
	DWH_LOAD_ID COMMENT 'Load id',
	DWH_CREATED COMMENT 'Record created at',
	DWH_UPDATED COMMENT 'Record updated at',
	DWH_VALID_FROM COMMENT 'Valid from date',
	DWH_VALID_TO COMMENT 'Valid to date',
	DELETED_FG COMMENT 'Flag if record is deleted'
) COMMENT='QUINTIQ - prepared view on raw data'
 AS 
SELECT
	client_id
	,lidl_country
	,source_system
	,wh_id
	,address_id
	,delivery_dt
	,temp_fg
	,product_type_id
	,stop_state_qty
	,start_tmsp
	,stop_state_type
	,reportedtourgid
	,dwh_load_id
	,dwh_created
	,dwh_updated
	,dwh_valid_from
	,dwh_valid_to
	,deleted_fg
FROM DATA.t_quintiq_reportedprodtypestop;