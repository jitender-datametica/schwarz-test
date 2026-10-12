/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_quintiq_reporteddimachangelog
Description		|	QUINTIQ - prepared view on raw data
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_quintiq_reporteddimachangelog (client_id
OPTIONS(description='Client id - calculated based on the country code'), lidl_country
OPTIONS(description='Country code. Original field name bic_zmlila'), source_system OPTIONS(description='Source system'),
wh_id OPTIONS(description='Warehouse ID'), changed_attr OPTIONS(description='The attribute that was changed'),
changed_tmsp OPTIONS(description='Time when the ok button was pressed to trigger the change'), delivery_dt
OPTIONS(description='End of the delivery day to optimize for (max 24hrs after start).'), change_id
OPTIONS(description='Combination of AddressFrom, To, ResourceType and timeProfile'), new_val
OPTIONS(description='The new value of the attribute'), old_val OPTIONS(description='The old value of the attribute'),
user_nr OPTIONS(description='Employee number of the user that made the change'), dwh_load_id
OPTIONS(description='Load id'), dwh_created OPTIONS(description='Record created at'), dwh_updated
OPTIONS(description='Record updated at'), dwh_valid_from OPTIONS(description='Valid from date'), dwh_valid_to
OPTIONS(description='Valid to date'), deleted_fg OPTIONS(description='Flag if record is deleted'))
OPTIONS(DESCRIPTION = `QUINTIQ - PREPARED VIEW ON RAW DATA`) AS SELECT *
FROM ldl_logop_data.t_quintiq_reporteddimachangelog;