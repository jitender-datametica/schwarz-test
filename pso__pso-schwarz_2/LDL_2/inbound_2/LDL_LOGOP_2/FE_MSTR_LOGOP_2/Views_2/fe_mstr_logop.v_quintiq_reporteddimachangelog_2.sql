/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_quintiq_reporteddimachangelog_2
Description		|	QUINTIQ - prepared view on raw data
====================================================================================================
*/

CREATE OR REPLACE VIEW fe_mstr_logop.v_quintiq_reporteddimachangelog_2 (
	client_id COMMENT 'Client id - calculated based on the country_2 code'
	,lidl_country COMMENT 'Country_2 code. Original field name bic_zmlila'
	,source_system COMMENT 'Source system'
	,wh_id COMMENT 'Warehouse ID'
	,changed_attr COMMENT 'The attribute that was changed'
	,changed_tmsp COMMENT 'Time when the ok button was pressed to trigger the change'
	,delivery_dt COMMENT 'End of the delivery day to optimize for (max 24hrs after start).'
	,change_id COMMENT 'Combination of AddressFrom, To, ResourceType and timeProfile'
	,new_val COMMENT 'The new value of the attribute'
	,old_val COMMENT 'The old value of the attribute'
	,user_nr COMMENT 'Employee_2 number of the user that made the change'
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
	,changed_attr
	,changed_tmsp
	,delivery_dt
	,change_id
	,new_val
	,old_val
	,user_nr
	,dwh_load_id
	,dwh_created
	,dwh_updated
	,dwh_valid_from
	,dwh_valid_to
	,deleted_fg
FROM DATA.t_quintiq_reporteddimachangelog_2
;