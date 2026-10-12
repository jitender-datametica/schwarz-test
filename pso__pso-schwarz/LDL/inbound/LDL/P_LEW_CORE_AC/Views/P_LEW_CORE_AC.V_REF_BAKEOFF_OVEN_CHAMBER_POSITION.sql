CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_REF_BAKEOFF_OVEN_CHAMBER_POSITION (
   bakeoff_oven_chamber_pos_cd              COMMENT 'Alphanumeric Code which identifies if the chamber is placed on "top" or on the "bottom" in the oven.'
  ,bakeoff_oven_chamber_pos_descr           COMMENT 'Description of the Code which identifies if the chamber is placed on "top" or on the "bottom" in the oven.'
  ,dwh_load_id                              COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.'
  ,dwh_created                              COMMENT 'Creation timestamp of the record in the DWH.'
  ,dwh_updated                              COMMENT 'Timestamp of the last update of the record in the DWH.'
)
COMMENT = 'Table contains information about the possible places where the oven chamber is placed in the oven.'
 AS 
    SELECT 
        bakeoff_oven_chamber_pos_cd,
        bakeoff_oven_chamber_pos_descr,
        dwh_load_id,
        dwh_created,
        dwh_updated

FROM P_LEW_CORE.T_REF_BAKEOFF_OVEN_CHAMBER_POSITION ;