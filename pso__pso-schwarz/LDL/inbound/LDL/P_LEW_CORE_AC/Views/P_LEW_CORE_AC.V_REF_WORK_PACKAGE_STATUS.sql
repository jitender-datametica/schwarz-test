CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_REF_WORK_PACKAGE_STATUS (
   work_package_status_cd                   COMMENT 'Status of the work package: , A, B, C and D.'
  ,work_package_status_descr                COMMENT 'Warehouse work package status description: open, cancelled, confirmed, etc.'
  ,dwh_load_id                              COMMENT 'The identifier of the last load run which inserted or updated this row.'
  ,dwh_created                              COMMENT 'The point in time when this record was created in the data warehouse.'
  ,dwh_updated                              COMMENT 'The point in time when this record was last updated.'
)
COMMENT = 'Static order (work package) status that exists in EWM: open, in progress, cancel, complete and locked.'
AS SELECT
   work_package_status_cd
  ,work_package_status_descr
  ,dwh_load_id
  ,dwh_created
  ,dwh_updated
FROM P_LEW_CORE.T_REF_WORK_PACKAGE_STATUS;