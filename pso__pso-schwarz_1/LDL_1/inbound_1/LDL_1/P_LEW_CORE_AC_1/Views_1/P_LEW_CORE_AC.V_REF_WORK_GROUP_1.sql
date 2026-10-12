CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_REF_WORK_GROUP_1 (
   wh_work_grp_nr                           COMMENT 'Queue identifier from EWM which is used to group work package_1 and task.'
  ,wh_work_grp_descr                        COMMENT 'Description of the WH work group.'
  ,pick_area_nr                             COMMENT 'Picking area ID as per WAMAS.'
  ,dwh_load_id                              COMMENT 'The identifier of the last load run which inserted or updated this row.'
  ,dwh_created                              COMMENT 'The point in time when this record was created in the data warehouse.'
  ,dwh_updated                              COMMENT 'The point in time when this record was last updated.'
)
COMMENT = 'The table holds references of EWM Queue to WAMAS Pick Area.
This is a global mapping that business will maintain.'
AS SELECT
   wh_work_grp_nr
  ,wh_work_grp_descr
  ,pick_area_nr
  ,dwh_load_id
  ,dwh_created
  ,dwh_updated
FROM P_LEW_CORE.T_REF_WORK_GROUP_1;