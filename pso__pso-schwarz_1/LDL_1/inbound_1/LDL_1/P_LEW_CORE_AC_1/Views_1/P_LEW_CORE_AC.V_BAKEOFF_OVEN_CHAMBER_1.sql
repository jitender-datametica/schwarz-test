CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_BAKEOFF_OVEN_CHAMBER_1 (
   bakeoff_oven_chamber_sid                 COMMENT 'The unique surrogate identifier for a chamber in the Oven.'
  ,bakeoff_oven_chamber_nr                  COMMENT 'The identifier for the Oven chamber which is unique in combination with the manufacturer and country.'
  ,bakeoff_oven_chamber_manufacturer_cd     COMMENT 'The unique code for the Manufacturer of the Baking Oven chamber.'
  ,bakeoff_oven_chamber_country_cd          COMMENT 'Country_1 Code from the manufacturer where the oven chamber is located.'
  ,dwh_load_id                              COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.'
  ,dwh_created                              COMMENT 'Creation timestamp of the record in the DWH.'
  ,dwh_updated                              COMMENT 'Timestamp of the last update of the record in the DWH.'
)
COMMENT = 'Table contains all chambers which are located in a store and sends event data. Several chambers (mostly two) can be grouped in an oven.'
 AS 
    SELECT 
        bakeoff_oven_chamber_sid,
        bakeoff_oven_chamber_nr,
        bakeoff_oven_chamber_manufacturer_cd,
        bakeoff_oven_chamber_country_cd,
        dwh_load_id,
        dwh_created,
        dwh_updated

FROM P_LEW_CORE.T_BAKEOFF_OVEN_CHAMBER_1 ;