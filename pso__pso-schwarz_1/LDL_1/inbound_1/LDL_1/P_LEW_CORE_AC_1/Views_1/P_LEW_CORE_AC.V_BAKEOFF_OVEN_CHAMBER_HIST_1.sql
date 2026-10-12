CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_BAKEOFF_OVEN_CHAMBER_HIST_1 (
   bakeoff_oven_chamber_sid                 COMMENT 'The unique surrogate identifier for a Chamber in the Oven.'
  ,dwh_valid_from                           COMMENT 'Begin of the validity_1 interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).'
  ,dwh_valid_to                             COMMENT 'End of the validity_1 interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).'
  ,deleted_fg                               COMMENT 'Attribute set was not delivered by source system (anymore), if deleted_fg=1.'
  ,store_loc_sid                            COMMENT 'Surrogate Key LOCATION_1 (eindeutig ueber alle Laender / Mandanten hinweg).'
  ,client_id                                COMMENT 'Surrogate Key CLIENT.'
  ,ip_address_nr                            COMMENT 'The IP address_1 for the Baking Oven Chamber.'
  ,bakeoff_oven_chamber_name                COMMENT 'Name of the baking oven chamber.'
  ,bakeoff_oven_pos_nr                      COMMENT 'A numerical Number which identifies the position of the oven in the store. Most stores will have up to three different ovens.'
  ,bakeoff_oven_chamber_pos_cd              COMMENT 'Alphanumeric Code which identifies if the chamber is placed on "top" or on the "bottom" in the oven. '
  ,bakeoff_oven_chamber_serial_nr           COMMENT 'The serial number for the Oven chamber.'
  ,bakeoff_oven_chamber_model_name          COMMENT 'The name for the model type of the Oven chamber.'
  ,bakeoff_oven_chamber_construction_year   COMMENT 'The year of construction for the Oven chamber.'
  ,bakeoff_oven_chamber_eow_dt               COMMENT 'End of Warranty Date of the oven chamber.'
  ,dwh_load_id                              COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.'
  ,dwh_created                              COMMENT 'Creation timestamp of the record in the DWH.'
  ,dwh_updated                              COMMENT 'Timestamp of the last update of the record in the DWH.'
)
COMMENT = 'Table contains historized data for oven chambers which are located in a store and send event data. Several chambers (mostly two) can be grouped into an oven,'
 AS 
    SELECT 
        bakeoff_oven_chamber_sid,
        dwh_valid_from,
        dwh_valid_to,
        deleted_fg,
        store_loc_sid,
        client_id,
        ip_address_nr,
        bakeoff_oven_chamber_name,
        bakeoff_oven_pos_nr,
        bakeoff_oven_chamber_pos_cd,
        bakeoff_oven_chamber_serial_nr,
        bakeoff_oven_chamber_model_name,
        bakeoff_oven_chamber_construction_year,
        bakeoff_oven_chamber_eow_dt,
        dwh_load_id,
        dwh_created,
        dwh_updated

FROM P_LEW_CORE.T_BAKEOFF_OVEN_CHAMBER_HIST_1 ;