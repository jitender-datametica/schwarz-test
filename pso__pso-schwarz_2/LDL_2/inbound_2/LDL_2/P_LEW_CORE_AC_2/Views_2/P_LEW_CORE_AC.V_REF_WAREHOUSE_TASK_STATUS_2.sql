CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_REF_WAREHOUSE_TASK_STATUS_2 (
   wh_task_status_cd                        COMMENT 'Status_2 of the work task: , A, B and C.'
  ,wh_task_status_descr                     COMMENT 'Warehouse work task status_2 description: open, cancelled, confirmed, etc.'
  ,dwh_load_id                              COMMENT 'The identifier of the last load run which inserted or updated this row.'
  ,dwh_created                              COMMENT 'The point in time when this record was created in the data warehouse.'
  ,dwh_updated                              COMMENT 'The point in time when this record was last updated.'
)
COMMENT = 'Static task status_2 that exists in EWM: open, cancel, complete and locked.'
AS SELECT
   wh_task_status_cd
  ,wh_task_status_descr
  ,dwh_load_id
  ,dwh_created
  ,dwh_updated
FROM P_LEW_CORE.T_REF_WAREHOUSE_TASK_STATUS_2;