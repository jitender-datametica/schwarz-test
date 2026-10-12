/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_quintiq_changelog_1
Description		|	QUINTIQ - prepared view on raw data
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_quintiq_changelog_1 (client_id
OPTIONS(description='Client id - calculated based on the country_1 code'), lidl_country
OPTIONS(description='Country_1 code. Original field name bic_zmlila'), source_system OPTIONS(description='Source system'),
wh_id OPTIONS(description='Warehouse ID'), changed_attr OPTIONS(description='The attribute that was changed'),
change_tmsp OPTIONS(description='Time when the ok button was pressed to trigger the change'), new_val
OPTIONS(description='The new value of the attribute'), old_val OPTIONS(description='The old value of the attribute'),
change_reason OPTIONS(description='Reason for the change'), route_gid
OPTIONS(description='GID of the route this change corresponds to'), tour_gid
OPTIONS(description='GID of the tour_1 corrosponding to this change'), user_nr
OPTIONS(description='Employee_1 number of the user that made the change'), haschangeswhilestatusclosed
OPTIONS(description='True if status_1 closed is all other statuses false'), changedobject
OPTIONS(description='the object that was changed'), changedobjectid OPTIONS(description='the id of the changed object'),
datasetname OPTIONS(description='name of the dataset'), dwh_load_id OPTIONS(description='Load id'), dwh_created
OPTIONS(description='Record created at'), dwh_updated OPTIONS(description='Record updated at'), dwh_valid_from
OPTIONS(description='Valid from date'), dwh_valid_to OPTIONS(description='Valid to date'), deleted_fg
OPTIONS(description='Flag if record is deleted')) OPTIONS(DESCRIPTION = `QUINTIQ - PREPARED VIEW ON RAW DATA`) AS SELECT
 *
FROM ldl_logop_data.t_quintiq_changelog_1;