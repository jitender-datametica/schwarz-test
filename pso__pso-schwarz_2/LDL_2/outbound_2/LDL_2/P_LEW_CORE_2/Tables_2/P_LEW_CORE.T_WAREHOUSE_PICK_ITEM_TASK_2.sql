/* --------------------------------------------------------------------------------
   DDL for table: t_warehouse_pick_item_task_2
   generated from Powerdesigner on Mittwoch, 5. Juni 2024 16:06:56
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_warehouse_pick_item_task_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_2; FK auf CLIENT'),
wh_loc_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warehouse; FK auf LOCATION_2'),
wh_task_nr STRING(100) NOT NULL OPTIONS(description='Identifier of the work task.'),
wh_sub_task_nr STRING(100) NOT NULL
OPTIONS(description='Additional identifier if the task is split further should full picking not be possible.'),
work_package_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate identifier to be created (country_2, warehouse and warehouse work package_2 (WHO)).'),
wh_task_process_nr STRING(100) OPTIONS(description='Identifier for the of process the work task is for.'),
wh_task_activity_type_cd STRING(100)
OPTIONS(description='Activity type of the work task, like pick, replenishment, stock change, internal move or putaway. Denormalized from t_ref_warehouse_process_type.'),
wh_task_status_cd STRING(100) OPTIONS(description='Status_2 of the work task: open, confirmed, cancelled, etc.'),
wh_task_create_dt DATE OPTIONS(description='Date when the work pick task was created.'),
wh_task_create_tmsp DATETIME OPTIONS(description='The point in time when the work pick task was created.'),
wh_task_start_dt DATE OPTIONS(description='Date when the work pick task was started to be worked on.'),
wh_task_start_tmsp DATETIME
OPTIONS(description='The point in time when the work pick task was started to be worked on.'),
wh_task_confirm_dt DATE OPTIONS(description='Date when the work pick task was confirmed.'),
wh_task_confirm_tmsp DATETIME OPTIONS(description='The point in time when the work pick task was confirmed.'),
wh_task_grp_nr STRING(100)
OPTIONS(description='Task Queue identifier, which is the basis for the work task in resource assignent.'),
item_sid BIGNUMERIC(38,0) OPTIONS(description='Surrogate Key ITEM_2 (eindeutig ueber alle Laender/Mandanten hinweg).'),
pick_case_qty BIGNUMERIC(38,5) OPTIONS(description='Pick quantity in cases.'),
src_handling_unit_nr STRING(100) OPTIONS(description='Source handling unit_2 identifier.'),
dest_handling_unit_nr STRING(100) OPTIONS(description='Destination handling unit_2 identifier.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The identifier of the last load run which inserted or updated this row.'),
dwh_created DATETIME NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (wh_loc_sid, wh_task_nr, wh_sub_task_nr) NOT ENFORCED
) OPTIONS(description='SAP EWM WH picking task, which encompasses all the PICK+ tasks.');