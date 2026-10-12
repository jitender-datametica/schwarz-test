/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_quintiq_stagingtollcell_1
Description		|	QUINTIQ - prepared view on raw data
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_quintiq_stagingtollcell_1 (client_id
OPTIONS(description='Client id - calculated based on the country_1 code'), lidl_country
OPTIONS(description='Country_1 code. Original field name bic_zmlila'), source_system OPTIONS(description='Source system'),
wh_id OPTIONS(description='Warehouse ID'), src_address_id OPTIONS(description='Identifier of the origin address_1'),
new_mod_fg OPTIONS(description='Indicator whether it\"s newly imported/created or it has fields updated'), soft_dlv_fg
OPTIONS(description='True if the instance is removed from external system\"'), time_profile_id
OPTIONS(description='Identifier of time profile'), tgt_address_id
OPTIONS(description='Identifier of the destination address_1'), toll_cat_id
OPTIONS(description='The identifier for toll category'), toll_cost
OPTIONS(description='The toll cost from origin to destination address_1'), dwh_load_id OPTIONS(description='Load id'),
dwh_created OPTIONS(description='Record created at'), dwh_updated OPTIONS(description='Record updated at'),
dwh_valid_from OPTIONS(description='Valid from date'), dwh_valid_to OPTIONS(description='Valid to date'), deleted_fg
OPTIONS(description='Flag if record is deleted')) OPTIONS(DESCRIPTION = `QUINTIQ - PREPARED VIEW ON RAW DATA`) AS SELECT
 *
FROM ldl_logop_data.t_quintiq_stagingtollcell_1;