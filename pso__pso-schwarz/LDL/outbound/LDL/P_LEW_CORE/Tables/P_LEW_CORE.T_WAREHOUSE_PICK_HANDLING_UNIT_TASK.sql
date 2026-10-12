/* --------------------------------------------------------------------------------
   DDL for table: t_warehouse_pick_handling_unit_task
   generated from Powerdesigner on Mittwoch, 5. Juni 2024 16:05:18
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_warehouse_pick_handling_unit_task (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant; FK auf CLIENT'),
wh_loc_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warehouse; FK auf LOCATION'),
pick_handling_unit_task_nr STRING(100) NOT NULL OPTIONS(description='Business identifier for the work task.'),
pick_handling_unit_sub_task_nr STRING(100) NOT NULL
OPTIONS(description='Additional identifier if the task is split further should full picking not be possible.'),
work_package_sid BIGNUMERIC(38,0)
OPTIONS(description='Surrogate identifier to be created (country, warehouse and warehouse work package (WHO)).'),
wh_task_process_nr STRING(100) OPTIONS(description='Identifier for the process the work task is for.'),
wh_task_activity_type_cd STRING(100)
OPTIONS(description='Activity type of the work task like pick, replenishment, stock change, internal move or putaway. Denormalized from t_ref_warehouse_process_type.'),
wh_task_status_cd STRING(100) OPTIONS(description='Status of the work task: open, confirmed, cancelled, etc.'),
wh_task_create_dt DATE OPTIONS(description='Date when the work pick task was created.'),
wh_task_create_tmsp DATETIME OPTIONS(description='The point in time when the work pick task was created.'),
wh_task_start_dt DATE OPTIONS(description='Date when the work pick task was started to be worked on.'),
wh_task_start_tmsp DATETIME
OPTIONS(description='The point in time when the work pick task was started to be worked on.'),
wh_task_confirm_dt DATE OPTIONS(description='Date when the work pick task was confirmed.'),
wh_task_confirm_tmsp DATETIME OPTIONS(description='The point in time when the work pick task was confirmed.'),
wh_task_grp_nr STRING(100)
OPTIONS(description='Task Queue identifier, which is the basis for the work task in resource assignent.'),
dest_handling_unit_nr STRING(100) OPTIONS(description='Destination handling unit identifier.'),
dest_wh_storage_space_nr STRING(100)
OPTIONS(description='Destination storage space in the WH where the pallet is placed, e.g. bin, lane, door, etc.'),
handling_unit_type_cd STRING(100)
OPTIONS(description='Type of the handling unit, euro pallet, duesseldorfer, box, etc.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The identifier of the last load run which inserted or updated this row.'),
dwh_created DATETIME NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (wh_loc_sid, pick_handling_unit_task_nr, pick_handling_unit_sub_task_nr) NOT ENFORCED
) OPTIONS(description='SAP EWM WH picking HU specific task, which encompasses all the PICK+INTL task.');