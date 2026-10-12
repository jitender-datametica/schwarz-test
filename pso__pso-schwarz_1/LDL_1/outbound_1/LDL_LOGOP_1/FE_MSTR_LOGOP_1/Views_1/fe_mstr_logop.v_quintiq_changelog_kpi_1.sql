/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_quintiq_changelog_kpi_1
Description		|	QUINTIQ - view with final KPIs for FE
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_quintiq_changelog_kpi_1 (client_id
OPTIONS(description='Client id - calculated based on the country_1 code'), lidl_country
OPTIONS(description='Country_1 code. Original field name bic_zmlila'), source_system OPTIONS(description='Source system'),
wh_id OPTIONS(description='Warehouse ID'), changed_attr OPTIONS(description='The attribute that was changed'),
change_tmsp OPTIONS(description='Time when the ok button was pressed to trigger the change'), new_val
OPTIONS(description='The new value of the attribute'), old_val OPTIONS(description='The old value of the attribute'),
change_reason OPTIONS(description='Reason for the change'), route_gid
OPTIONS(description='GID of the route this change corresponds to'), tour_gid
OPTIONS(description='GID of the tour_1 corrosponding to this change'), user_nr
OPTIONS(description='Employee_1 number of the user that made the change'), changedobject
OPTIONS(description='the object that was changed'), changedobjectid OPTIONS(description='the id of the changed object'),
datasetname OPTIONS(description='name of the dataset'), dwh_load_id OPTIONS(description='Load id'), dwh_created
OPTIONS(description='Record created at'), dwh_updated OPTIONS(description='Record updated at'), dwh_valid_from
OPTIONS(description='Valid from date'), dwh_valid_to OPTIONS(description='Valid to date'), deleted_fg
OPTIONS(description='Flag if record is deleted'), active_fg OPTIONS(description='Flag if record is active'))
OPTIONS(DESCRIPTION = `QUINTIQ - VIEW WITH FINAL KPIS FOR FE`) AS SELECT client_id,
 lidl_country,
 source_system,
 wh_id,
 changed_attr,
 change_tmsp,
 new_val,
 old_val,
 change_reason,
 route_gid,
 tour_gid,
 user_nr,
 changedobject,
 changedobjectid,
 datasetname,
 dwh_load_id,
 dwh_created,
 dwh_updated,
 dwh_valid_from,
 dwh_valid_to,
 deleted_fg,
 IF(dwh_valid_to = SAFE_CAST('9999-12-30' as DATE), 1, 0) AS active_fg
FROM ldl_logop_fe_mstr_logop.v_quintiq_changelog_1;