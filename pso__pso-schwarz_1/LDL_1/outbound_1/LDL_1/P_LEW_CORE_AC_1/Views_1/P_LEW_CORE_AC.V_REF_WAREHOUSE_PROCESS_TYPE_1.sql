CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_warehouse_process_type_1 (client_id
OPTIONS(description='DWH-Mandant_1; FK auf CLIENT'), wh_loc_sid OPTIONS(description='Warehouse; FK auf LOCATION_1'),
wh_process_nr OPTIONS(description='Identifier for the process in the WH.'), wh_activity_type_cd
OPTIONS(description='Activity type of the work task, like pick, replenishment, stock change, internal move or putaway.'),
wh_process_descr OPTIONS(description='Description of the process type in the WH.'), dwh_load_id
OPTIONS(description='The identifier of the last load run which inserted or updated this row.'), dwh_created
OPTIONS(description='The point in time when this record was created in the data warehouse.'), dwh_updated
OPTIONS(description='The point in time when this record was last updated.'))
OPTIONS(DESCRIPTION = `REFERENCE TABLE FOR ALL THE PROCESS TYPES FOR A TASK PERFORMED IN WH.`) AS SELECT client_id,
 wh_loc_sid,
 wh_process_nr,
 wh_activity_type_cd,
 wh_process_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_warehouse_process_type_1;