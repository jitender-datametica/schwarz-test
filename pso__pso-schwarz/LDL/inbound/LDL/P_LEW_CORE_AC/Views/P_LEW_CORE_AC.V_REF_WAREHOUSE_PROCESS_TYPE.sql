CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_REF_WAREHOUSE_PROCESS_TYPE (
   client_id                                COMMENT 'DWH-Mandant; FK auf CLIENT'
  ,wh_loc_sid                               COMMENT 'Warehouse; FK auf LOCATION'
  ,wh_process_nr                            COMMENT 'Identifier for the process in the WH.'
  ,wh_activity_type_cd                      COMMENT 'Activity type of the work task, like pick, replenishment, stock change, internal move or putaway.'
  ,wh_process_descr                         COMMENT 'Description of the process type in the WH.'
  ,dwh_load_id                              COMMENT 'The identifier of the last load run which inserted or updated this row.'
  ,dwh_created                              COMMENT 'The point in time when this record was created in the data warehouse.'
  ,dwh_updated                              COMMENT 'The point in time when this record was last updated.'
)
COMMENT = 'Reference table for all the process types for a task performed in WH.'
AS SELECT
   client_id
  ,wh_loc_sid
  ,wh_process_nr
  ,wh_activity_type_cd
  ,wh_process_descr
  ,dwh_load_id
  ,dwh_created
  ,dwh_updated
FROM P_LEW_CORE.T_REF_WAREHOUSE_PROCESS_TYPE;