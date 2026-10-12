/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_quintiq_changelog_kpi_1
Description		|	QUINTIQ - view with final KPIs for FE
====================================================================================================
*/

CREATE OR REPLACE VIEW fe_mstr_logop.v_quintiq_changelog_kpi_1 (
	client_id COMMENT 'Client id - calculated based on the country_1 code'
	,lidl_country COMMENT 'Country_1 code. Original field name bic_zmlila'
	,source_system COMMENT 'Source system'
	,wh_id COMMENT 'Warehouse ID'
	,changed_attr COMMENT 'The attribute that was changed'
	,change_tmsp COMMENT 'Time when the ok button was pressed to trigger the change'
	,new_val COMMENT 'The new value of the attribute'
	,old_val COMMENT 'The old value of the attribute'
	,change_reason COMMENT 'Reason for the change'
	,route_gid COMMENT 'GID of the route this change corresponds to'
	,tour_gid COMMENT 'GID of the tour_1 corrosponding to this change'
	,user_nr COMMENT 'Employee_1 number of the user that made the change'
	,changedobject COMMENT 'the object that was changed'
	,changedobjectid COMMENT 'the id of the changed object'
	,datasetname COMMENT 'name of the dataset'
	,dwh_load_id COMMENT 'Load id'
	,dwh_created COMMENT 'Record created at'
	,dwh_updated COMMENT 'Record updated at'
	,dwh_valid_from COMMENT 'Valid from date'
	,dwh_valid_to COMMENT 'Valid to date'
	,deleted_fg COMMENT 'Flag if record is deleted'
	,active_fg COMMENT 'Flag if record is active'
	) 
COMMENT = 'QUINTIQ - view with final KPIs for FE'
AS 
SELECT
	client_id
	,lidl_country
	,source_system
	,wh_id
	,changed_attr
	,change_tmsp
	,new_val
	,old_val
	,change_reason
	,route_gid
	,tour_gid
	,user_nr
	,changedobject
	,changedobjectid
	,datasetname
	,dwh_load_id
	,dwh_created
	,dwh_updated
	,dwh_valid_from
	,dwh_valid_to
	,deleted_fg
	,IFF(dwh_valid_to = '9999-12-30', 1, 0) AS active_fg
FROM fe_mstr_logop.v_quintiq_changelog_1
;