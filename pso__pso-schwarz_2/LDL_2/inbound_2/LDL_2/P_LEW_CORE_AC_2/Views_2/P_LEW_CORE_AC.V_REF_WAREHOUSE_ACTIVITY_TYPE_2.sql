CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_REF_WAREHOUSE_ACTIVITY_TYPE_2 (
   wh_activity_type_cd                      COMMENT 'Activity type of the work task, like pick, replenishment, stock change, internal move or putaway.'
  ,wh_activity_type_descr                   COMMENT 'Description of the activity type in the WH.'
  ,dwh_load_id                              COMMENT 'The identifier of the last load run which inserted or updated this row.'
  ,dwh_created                              COMMENT 'The point in time when this record was created in the data warehouse.'
  ,dwh_updated                              COMMENT 'The point in time when this record was last updated.'
)
COMMENT = 'The table holds the activity types in SAP EWM. The values are PTWY, PICK, INTL, STCH and REPL.'
AS SELECT
   wh_activity_type_cd
  ,wh_activity_type_descr
  ,dwh_load_id
  ,dwh_created
  ,dwh_updated
FROM P_LEW_CORE.T_REF_WAREHOUSE_ACTIVITY_TYPE_2;