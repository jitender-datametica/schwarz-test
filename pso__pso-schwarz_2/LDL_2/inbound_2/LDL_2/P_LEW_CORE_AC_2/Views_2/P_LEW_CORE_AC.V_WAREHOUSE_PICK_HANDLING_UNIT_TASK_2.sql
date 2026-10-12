CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_WAREHOUSE_PICK_HANDLING_UNIT_TASK_2 (
   client_id                                COMMENT 'DWH-Mandant_2; FK auf CLIENT'
  ,wh_loc_sid                               COMMENT 'Warehouse; FK auf LOCATION_2'
  ,pick_handling_unit_task_nr               COMMENT 'Business identifier for the work task.'
  ,pick_handling_unit_sub_task_nr           COMMENT 'Additional identifier if the task is split further should full picking not be possible.'
  ,work_package_sid                         COMMENT 'Surrogate identifier to be created (country_2, warehouse and warehouse work package_2 (WHO)).'
  ,wh_task_process_nr                       COMMENT 'Identifier for the process the work task is for.'
  ,wh_task_activity_type_cd                 COMMENT 'Activity type of the work task like pick, replenishment, stock change, internal move or putaway. Denormalized from t_ref_warehouse_process_type.'
  ,wh_task_status_cd                        COMMENT 'Status_2 of the work task: open, confirmed, cancelled, etc.'
  ,wh_task_create_dt                        COMMENT 'Date when the work pick task was created.'
  ,wh_task_create_tmsp                      COMMENT 'The point in time when the work pick task was created.'
  ,wh_task_start_dt                         COMMENT 'Date when the work pick task was started to be worked on.'
  ,wh_task_start_tmsp                       COMMENT 'The point in time when the work pick task was started to be worked on.'
  ,wh_task_confirm_dt                       COMMENT 'Date when the work pick task was confirmed.'
  ,wh_task_confirm_tmsp                     COMMENT 'The point in time when the work pick task was confirmed.'
  ,wh_task_grp_nr                           COMMENT 'Task Queue identifier, which is the basis for the work task in resource assignent.'
  ,dest_handling_unit_nr                    COMMENT 'Destination handling unit_2 identifier.'
  ,dest_wh_storage_space_nr                 COMMENT 'Destination storage space in the WH where the pallet is placed, e.g. bin, lane, door, etc.'
  ,handling_unit_type_cd                    COMMENT 'Type of the handling unit_2, euro pallet, duesseldorfer, box, etc.'
  ,dwh_load_id                              COMMENT 'The identifier of the last load run which inserted or updated this row.'
  ,dwh_created                              COMMENT 'The point in time when this record was created in the data warehouse.'
  ,dwh_updated                              COMMENT 'The point in time when this record was last updated.'
)
COMMENT = 'SAP EWM WH picking HU specific task, which encompasses all the PICK+INTL task.'
AS SELECT
   client_id
  ,wh_loc_sid
  ,pick_handling_unit_task_nr
  ,pick_handling_unit_sub_task_nr
  ,work_package_sid
  ,wh_task_process_nr
  ,wh_task_activity_type_cd
  ,wh_task_status_cd
  ,wh_task_create_dt
  ,wh_task_create_tmsp
  ,wh_task_start_dt
  ,wh_task_start_tmsp
  ,wh_task_confirm_dt
  ,wh_task_confirm_tmsp
  ,wh_task_grp_nr
  ,dest_handling_unit_nr
  ,dest_wh_storage_space_nr
  ,handling_unit_type_cd
  ,dwh_load_id
  ,dwh_created
  ,dwh_updated
FROM P_LEW_CORE.T_WAREHOUSE_PICK_HANDLING_UNIT_TASK_2;