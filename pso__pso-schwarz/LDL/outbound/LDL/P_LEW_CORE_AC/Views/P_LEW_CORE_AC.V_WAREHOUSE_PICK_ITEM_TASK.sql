CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_warehouse_pick_item_task (client_id
OPTIONS(description='DWH-Mandant; FK auf CLIENT'), wh_loc_sid OPTIONS(description='Warehouse; FK auf LOCATION'),
wh_task_nr OPTIONS(description='Identifier of the work task.'), wh_sub_task_nr
OPTIONS(description='Additional identifier if the task is split further should full picking not be possible.'),
work_package_sid
OPTIONS(description='Surrogate identifier to be created (country, warehouse and warehouse work package (WHO)).'),
wh_task_process_nr OPTIONS(description='Identifier for the of process the work task is for.'), wh_task_activity_type_cd
OPTIONS(description='Activity type of the work task, like pick, replenishment, stock change, internal move or putaway. Denormalized from t_ref_warehouse_process_type.'),
wh_task_status_cd OPTIONS(description='Status of the work task: open, confirmed, cancelled, etc.'), wh_task_create_dt
OPTIONS(description='Date when the work pick task was created.'), wh_task_create_tmsp
OPTIONS(description='The point in time when the work pick task was created.'), wh_task_start_dt
OPTIONS(description='Date when the work pick task was started to be worked on.'), wh_task_start_tmsp
OPTIONS(description='The point in time when the work pick task was started to be worked on.'), wh_task_confirm_dt
OPTIONS(description='Date when the work pick task was confirmed.'), wh_task_confirm_tmsp
OPTIONS(description='The point in time when the work pick task was confirmed.'), wh_task_grp_nr
OPTIONS(description='Task Queue identifier, which is the basis for the work task in resource assignent.'), item_sid
OPTIONS(description='Surrogate Key ITEM (eindeutig ueber alle Laender/Mandanten hinweg).'), pick_case_qty
OPTIONS(description='Pick quantity in cases.'), src_handling_unit_nr
OPTIONS(description='Source handling unit identifier.'), dest_handling_unit_nr
OPTIONS(description='Destination handling unit identifier.'), dwh_load_id
OPTIONS(description='The identifier of the last load run which inserted or updated this row.'), dwh_created
OPTIONS(description='The point in time when this record was created in the data warehouse.'), dwh_updated
OPTIONS(description='The point in time when this record was last updated.'))
OPTIONS(DESCRIPTION = `SAP EWM WH PICKING TASK, WHICH ENCOMPASSES ALL THE PICK+ TASKS.`) AS SELECT client_id,
 wh_loc_sid,
 wh_task_nr,
 wh_sub_task_nr,
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
 item_sid,
 pick_case_qty,
 src_handling_unit_nr,
 dest_handling_unit_nr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_warehouse_pick_item_task;