CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_REF_UNIFORM_PICK_AREA_2 (
   pick_area_nr                             COMMENT 'Picking area ID as per WAMAS.'
  ,pick_area_descr                          COMMENT 'Description of the picking area.'
  ,pick_main_area_nr                        COMMENT 'Main picking area ID.'
  ,dwh_load_id                              COMMENT 'The identifier of the last load run which inserted or updated this row.'
  ,dwh_created                              COMMENT 'The point in time when this record was created in the data warehouse.'
  ,dwh_updated                              COMMENT 'The point in time when this record was last updated.'
)
COMMENT = 'The table holds picking area information like high rack (Hochregal), freezer, chiller, etc.. from the global input.'
AS SELECT
   pick_area_nr
  ,pick_area_descr
  ,pick_main_area_nr
  ,dwh_load_id
  ,dwh_created
  ,dwh_updated
FROM P_LEW_CORE.T_REF_UNIFORM_PICK_AREA_2;