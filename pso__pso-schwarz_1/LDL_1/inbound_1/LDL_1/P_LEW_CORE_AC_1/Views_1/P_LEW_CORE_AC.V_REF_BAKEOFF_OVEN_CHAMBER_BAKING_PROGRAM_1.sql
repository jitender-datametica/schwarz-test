CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_REF_BAKEOFF_OVEN_CHAMBER_BAKING_PROGRAM_1 (
   bakeoff_oven_chamber_baking_program_id   COMMENT 'ID of the baking program to which baking related events in the chamber can be grouped. The ID represents the intended meaning of the program, in some cases the real data may differ from it.'
  ,bakeoff_oven_chamber_baking_program_name COMMENT 'Description of the baking program to which baking related events in the chamber can be grouped.'
  ,dwh_load_id                              COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.'
  ,dwh_created                              COMMENT 'Creation timestamp of the record in the DWH.'
  ,dwh_updated                              COMMENT 'Timestamp of the last update of the record in the DWH.'
)
COMMENT = 'The table contains information regarding the baking programs of some events that are reportet on an oven chamber.'
 AS 
    SELECT 
        bakeoff_oven_chamber_baking_program_id,
        bakeoff_oven_chamber_baking_program_name,
        dwh_load_id,
        dwh_created,
        dwh_updated

FROM P_LEW_CORE.T_REF_BAKEOFF_OVEN_CHAMBER_BAKING_PROGRAM_1 ;