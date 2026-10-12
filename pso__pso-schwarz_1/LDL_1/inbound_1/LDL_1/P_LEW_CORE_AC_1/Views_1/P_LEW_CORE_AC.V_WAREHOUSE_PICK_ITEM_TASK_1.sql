CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_WAREHOUSE_PICK_ITEM_TASK_1 (
   client_id                                COMMENT 'DWH-Mandant_1; FK auf CLIENT'
  ,wh_loc_sid                               COMMENT 'Warehouse; FK auf LOCATION_1'
  ,wh_task_nr                               COMMENT 'Identifier of the work task.'
  ,wh_sub_task_nr                           COMMENT 'Additional identifier if the task is split further should full picking not be possible.'
  ,work_package_sid                         COMMENT 'Surrogate identifier to be created (country_1, warehouse and warehouse work package_1 (WHO)).'
  ,wh_task_process_nr                       COMMENT 'Identifier for the of process the work task is for.'
  ,wh_task_activity_type_cd                 COMMENT 'Activity type of the work task, like pick, replenishment, stock change, internal move or putaway. Denormalized from t_ref_warehouse_process_type.'
  ,wh_task_status_cd                        COMMENT 'Status_1 of the work task: open, confirmed, cancelled, etc.'
  ,wh_task_create_dt                        COMMENT 'Date when the work pick task was created.'
  ,wh_task_create_tmsp                      COMMENT 'The point in time when the work pick task was created.'
  ,wh_task_start_dt                         COMMENT 'Date when the work pick task was started to be worked on.'
  ,wh_task_start_tmsp                       COMMENT 'The point in time when the work pick task was started to be worked on.'
  ,wh_task_confirm_dt                       COMMENT 'Date when the work pick task was confirmed.'
  ,wh_task_confirm_tmsp                     COMMENT 'The point in time when the work pick task was confirmed.'
  ,wh_task_grp_nr                           COMMENT 'Task Queue identifier, which is the basis for the work task in resource assignent.'
  ,item_sid                                 COMMENT 'Surrogate Key ITEM_1 (eindeutig ueber alle Laender/Mandanten hinweg).'
  ,pick_case_qty                            COMMENT 'Pick quantity in cases.'
  ,src_handling_unit_nr                     COMMENT 'Source handling unit_1 identifier.'
  ,dest_handling_unit_nr                    COMMENT 'Destination handling unit_1 identifier.'
  ,dwh_load_id                              COMMENT 'The identifier of the last load run which inserted or updated this row.'
  ,dwh_created                              COMMENT 'The point in time when this record was created in the data warehouse.'
  ,dwh_updated                              COMMENT 'The point in time when this record was last updated.'
)
COMMENT = 'SAP EWM WH picking task, which encompasses all the PICK+ tasks.'
AS SELECT
   client_id
  ,wh_loc_sid
  ,wh_task_nr
  ,wh_sub_task_nr
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
  ,item_sid
  ,pick_case_qty
  ,src_handling_unit_nr
  ,dest_handling_unit_nr
  ,dwh_load_id
  ,dwh_created
  ,dwh_updated
FROM P_LEW_CORE.T_WAREHOUSE_PICK_ITEM_TASK_1;