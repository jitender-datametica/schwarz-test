/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_quintiq_reportedprodtypestop_1
Description		|	QUINTIQ - prepared view on raw data
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_quintiq_reportedprodtypestop_1 (client_id
OPTIONS(description='Client id - calculated based on the country_1 code'), lidl_country
OPTIONS(description='Country_1 code. Original field name bic_zmlila'), source_system OPTIONS(description='Source system'),
wh_id OPTIONS(description='Warehouse ID'), address_id OPTIONS(description='ID of the address_1 of the stop state'),
delivery_dt OPTIONS(description='Delivery date of the dataset'), temp_fg
OPTIONS(description='Indicates if this is a temporary reported product type stop'), product_type_id
OPTIONS(description='ID of the product type'), stop_state_qty
OPTIONS(description='Quantity 1 of the product type stop state'), start_tmsp
OPTIONS(description='Start time of the stop state'), stop_state_type OPTIONS(description='Type of the stop state'),
reportedtourgid OPTIONS(description='GID of the reported tour_1'), dwh_load_id OPTIONS(description='Load id'), dwh_created
OPTIONS(description='Record created at'), dwh_updated OPTIONS(description='Record updated at'), dwh_valid_from
OPTIONS(description='Valid from date'), dwh_valid_to OPTIONS(description='Valid to date'), deleted_fg
OPTIONS(description='Flag if record is deleted')) OPTIONS(DESCRIPTION = `QUINTIQ - PREPARED VIEW ON RAW DATA`) AS SELECT
 client_id,
 lidl_country,
 source_system,
 wh_id,
 address_id,
 delivery_dt,
 temp_fg,
 product_type_id,
 stop_state_qty,
 start_tmsp,
 stop_state_type,
 reportedtourgid,
 dwh_load_id,
 dwh_created,
 dwh_updated,
 dwh_valid_from,
 dwh_valid_to,
 deleted_fg
FROM ldl_logop_data.t_quintiq_reportedprodtypestop_1;