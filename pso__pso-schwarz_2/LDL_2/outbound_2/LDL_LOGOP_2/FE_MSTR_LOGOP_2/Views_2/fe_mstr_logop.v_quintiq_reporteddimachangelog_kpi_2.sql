/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_quintiq_reporteddimachangelog_kpi_2
Description		|	QUINTIQ - view with final KPIs for FE
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_quintiq_reporteddimachangelog_kpi_2 (client_id
OPTIONS(description='Client id - calculated based on the country_2 code'), lidl_country
OPTIONS(description='Country_2 code. Original field name bic_zmlila'), source_system OPTIONS(description='Source system'),
wh_id OPTIONS(description='Warehouse ID'), changed_attr OPTIONS(description='The attribute that was changed'),
changed_tmsp OPTIONS(description='Time when the ok button was pressed to trigger the change'), delivery_dt
OPTIONS(description='End of the delivery day to optimize for (max 24hrs after start).'), change_id
OPTIONS(description='Combination of AddressFrom To ResourceType and timeProfile'), new_val
OPTIONS(description='The new value of the attribute'), old_val OPTIONS(description='The old value of the attribute'),
user_nr OPTIONS(description='Employee_2 number of the user that made the change'), dwh_load_id
OPTIONS(description='Load id'), dwh_created OPTIONS(description='Record created at'), dwh_updated
OPTIONS(description='Record updated at'), dwh_valid_from OPTIONS(description='Valid from date'), dwh_valid_to
OPTIONS(description='Valid to date'), deleted_fg OPTIONS(description='Flag if record is deleted'), active_fg
OPTIONS(description='Flag if record is active')) OPTIONS(DESCRIPTION = `QUINTIQ - VIEW WITH FINAL KPIS FOR FE`) AS
SELECT client_id,
 lidl_country,
 source_system,
 wh_id,
 changed_attr,
 changed_tmsp,
 delivery_dt,
 change_id,
 new_val,
 old_val,
 user_nr,
 dwh_load_id,
 dwh_created,
 dwh_updated,
 dwh_valid_from,
 dwh_valid_to,
 deleted_fg,
 IF(dwh_valid_to = SAFE_CAST('9999-12-30' as DATE), 1, 0) AS active_fg
FROM ldl_logop_fe_mstr_logop.v_quintiq_reporteddimachangelog_2;