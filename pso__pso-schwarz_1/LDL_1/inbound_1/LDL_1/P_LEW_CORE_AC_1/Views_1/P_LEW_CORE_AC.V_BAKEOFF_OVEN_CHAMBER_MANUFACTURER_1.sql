CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_BAKEOFF_OVEN_CHAMBER_MANUFACTURER_1 (
   bakeoff_oven_chamber_manufacturer_cd     COMMENT 'The unique code for the Manufacturer of the Baking Oven Chamber.'
  ,bakeoff_oven_chamber_manufacturer_name   COMMENT 'Then name for the Manufacturer of the Baking Oven Chamber.'
  ,dwh_load_id                              COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.'
  ,dwh_created                              COMMENT 'Creation timestamp of the record in the DWH.'
  ,dwh_updated                              COMMENT 'Timestamp of the last update of the record in the DWH.'
)
COMMENT = 'The table contains the different Manufacturers of the baking oven chambers.'
 AS 
    SELECT 
        bakeoff_oven_chamber_manufacturer_cd,
        bakeoff_oven_chamber_manufacturer_name,
        dwh_load_id,
        dwh_created,
        dwh_updated

FROM P_LEW_CORE.T_BAKEOFF_OVEN_CHAMBER_MANUFACTURER_1 ;