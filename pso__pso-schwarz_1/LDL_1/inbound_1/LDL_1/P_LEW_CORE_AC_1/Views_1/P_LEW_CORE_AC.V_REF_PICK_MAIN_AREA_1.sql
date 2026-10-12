CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_REF_PICK_MAIN_AREA_1 (
   pick_main_area_nr                        COMMENT 'Picking main area ID that consolidates the picking area.'
  ,pick_main_area_descr                     COMMENT 'Description of the picking main area.'
  ,dwh_load_id                              COMMENT 'The identifier of the last load run which inserted or updated this row.'
  ,dwh_created                              COMMENT 'The point in time when this record was created in the data warehouse.'
  ,dwh_updated                              COMMENT 'The point in time when this record was last updated.'
)
COMMENT = 'Reference table of picking area to the picking main area. Picking main areas are groupings of picking areas.'
AS SELECT
   pick_main_area_nr
  ,pick_main_area_descr
  ,dwh_load_id
  ,dwh_created
  ,dwh_updated
FROM P_LEW_CORE.T_REF_PICK_MAIN_AREA_1;