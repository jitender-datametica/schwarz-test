/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_quintiq_reportedchangelog_2
Description		|	QUINTIQ - prepared view on raw data
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_quintiq_reportedchangelog_2 (client_id
OPTIONS(description='Client id - calculated based on the country_2 code'), lidl_country
OPTIONS(description='Country_2 code. Original field name bic_zmlila'), source_system OPTIONS(description='Source system'),
wh_id OPTIONS(description='Warehouse ID'), changed_attr OPTIONS(description='attribute which has been changed'),
change_tmsp OPTIONS(description='date and time user have made change'), delivery_dt
OPTIONS(description='End of the delivery day to optimize for (max 24hrs after start).'), new_val
OPTIONS(description='new value of attribute'), old_val OPTIONS(description='old value of attribute'), change_reason
OPTIONS(description='reason to change the value'), route_gid
OPTIONS(description='GID is to have a unique identifier of a Route across different delivery days for the same RDC.'),
tour_gid
OPTIONS(description='GID is to have a unique identifier of a tour_2 across different delivery days for the same RDC.'),
user_name OPTIONS(description='user name'), dwh_load_id OPTIONS(description='Load id'), dwh_created
OPTIONS(description='Record created at'), dwh_updated OPTIONS(description='Record updated at'), dwh_valid_from
OPTIONS(description='Valid from date'), dwh_valid_to OPTIONS(description='Valid to date'), deleted_fg
OPTIONS(description='Flag if record is deleted'), changedobject
OPTIONS(description='The name of the object that was changed'), changedobjectid
OPTIONS(description='The ID of the object that has been changed'), hauliername
OPTIONS(description='The name of the haulier which is set when a tour_2 was changed'))
OPTIONS(DESCRIPTION = `QUINTIQ - PREPARED VIEW ON RAW DATA`) AS SELECT client_id,
 lidl_country,
 source_system,
 wh_id,
 changed_attr,
 change_tmsp,
 delivery_dt,
 new_val,
 old_val,
 change_reason,
 route_gid,
 tour_gid,
 user_name,
 dwh_load_id,
 dwh_created,
 dwh_updated,
 dwh_valid_from,
 dwh_valid_to,
 deleted_fg,
 changedobject,
 changedobjectid,
 hauliername
FROM ldl_logop_data.t_quintiq_reportedchangelog_2;