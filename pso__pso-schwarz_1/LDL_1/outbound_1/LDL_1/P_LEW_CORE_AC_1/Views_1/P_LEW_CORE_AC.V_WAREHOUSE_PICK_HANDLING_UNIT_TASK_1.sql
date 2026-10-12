CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_warehouse_pick_handling_unit_task_1 (client_id
OPTIONS(description='DWH-Mandant_1; FK auf CLIENT'), wh_loc_sid OPTIONS(description='Warehouse; FK auf LOCATION_1'),
pick_handling_unit_task_nr OPTIONS(description='Business identifier for the work task.'), pick_handling_unit_sub_task_nr
OPTIONS(description='Additional identifier if the task is split further should full picking not be possible.'),
work_package_sid
OPTIONS(description='Surrogate identifier to be created (country_1, warehouse and warehouse work package_1 (WHO)).'),
wh_task_process_nr OPTIONS(description='Identifier for the process the work task is for.'), wh_task_activity_type_cd
OPTIONS(description='Activity type of the work task like pick, replenishment, stock change, internal move or putaway. Denormalized from t_ref_warehouse_process_type.'),
wh_task_status_cd OPTIONS(description='Status_1 of the work task: open, confirmed, cancelled, etc.'), wh_task_create_dt
OPTIONS(description='Date when the work pick task was created.'), wh_task_create_tmsp
OPTIONS(description='The point in time when the work pick task was created.'), wh_task_start_dt
OPTIONS(description='Date when the work pick task was started to be worked on.'), wh_task_start_tmsp
OPTIONS(description='The point in time when the work pick task was started to be worked on.'), wh_task_confirm_dt
OPTIONS(description='Date when the work pick task was confirmed.'), wh_task_confirm_tmsp
OPTIONS(description='The point in time when the work pick task was confirmed.'), wh_task_grp_nr
OPTIONS(description='Task Queue identifier, which is the basis for the work task in resource assignent.'),
dest_handling_unit_nr OPTIONS(description='Destination handling unit_1 identifier.'), dest_wh_storage_space_nr
OPTIONS(description='Destination storage space in the WH where the pallet is placed, e.g. bin, lane, door, etc.'),
handling_unit_type_cd OPTIONS(description='Type of the handling unit_1, euro pallet, duesseldorfer, box, etc.'),
dwh_load_id OPTIONS(description='The identifier of the last load run which inserted or updated this row.'), dwh_created
OPTIONS(description='The point in time when this record was created in the data warehouse.'), dwh_updated
OPTIONS(description='The point in time when this record was last updated.'))
OPTIONS(DESCRIPTION = `SAP EWM WH PICKING HU SPECIFIC TASK, WHICH ENCOMPASSES ALL THE PICK+INTL TASK.`) AS SELECT
 client_id,
 wh_loc_sid,
 pick_handling_unit_task_nr,
 pick_handling_unit_sub_task_nr,
 work_package_sid,
 wh_task_process_nr,
 wh_task_activity_type_cd,
 wh_task_status_cd,
 wh_task_create_dt,
 wh_task_create_tmsp,
 wh_task_start_dt,
 wh_task_start_tmsp,
 wh_task_confirm_dt,
 wh_task_confirm_tmsp,
 wh_task_grp_nr,
 dest_handling_unit_nr,
 dest_wh_storage_space_nr,
 handling_unit_type_cd,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_warehouse_pick_handling_unit_task_1;