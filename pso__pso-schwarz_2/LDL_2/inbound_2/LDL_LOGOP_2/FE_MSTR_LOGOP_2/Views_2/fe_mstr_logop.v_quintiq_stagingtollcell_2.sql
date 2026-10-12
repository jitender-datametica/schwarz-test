/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_quintiq_stagingtollcell_2
Description		|	QUINTIQ - prepared view on raw data
====================================================================================================
*/

CREATE OR REPLACE VIEW fe_mstr_logop.v_quintiq_stagingtollcell_2 (
	client_id COMMENT 'Client id - calculated based on the country_2 code'
	,lidl_country COMMENT 'Country_2 code. Original field name bic_zmlila'
	,source_system COMMENT 'Source system'
	,wh_id COMMENT 'Warehouse ID'
	,src_address_id COMMENT 'Identifier of the origin address_2'
	,new_mod_fg COMMENT 'Indicator whether it\"s newly imported/created or it has fields updated'
	,soft_dlv_fg COMMENT 'True if the instance is removed from external system\"'
	,time_profile_id COMMENT 'Identifier of time profile'
	,tgt_address_id COMMENT 'Identifier of the destination address_2'
	,toll_cat_id COMMENT 'The identifier for toll category'
	,toll_cost COMMENT 'The toll cost from origin to destination address_2'
	,dwh_load_id COMMENT 'Load id'
	,dwh_created COMMENT 'Record created at'
	,dwh_updated COMMENT 'Record updated at'
	,dwh_valid_from COMMENT 'Valid from date'
	,dwh_valid_to COMMENT 'Valid to date'
	,deleted_fg COMMENT 'Flag if record is deleted'
	)
COMMENT = 'QUINTIQ - prepared view on raw data'
AS 
SELECT
	client_id
	,lidl_country
	,source_system
	,wh_id
	,src_address_id
	,new_mod_fg
	,soft_dlv_fg
	,time_profile_id
	,tgt_address_id
	,toll_cat_id
	,toll_cost
	,dwh_load_id
	,dwh_created
	,dwh_updated
	,dwh_valid_from
	,dwh_valid_to
	,deleted_fg
FROM DATA.t_quintiq_stagingtollcell_2
;