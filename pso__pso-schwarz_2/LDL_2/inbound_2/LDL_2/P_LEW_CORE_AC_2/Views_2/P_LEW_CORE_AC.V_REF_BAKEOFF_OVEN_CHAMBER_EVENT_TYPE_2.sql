CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_REF_BAKEOFF_OVEN_CHAMBER_EVENT_TYPE_2 (
   bakeoff_oven_chamber_event_type_cd       COMMENT 'The unique code for the type of the event in an oven chamber.'
  ,bakeoff_oven_chamber_event_type_descr    COMMENT 'The description for the type of the event in an oven chamber.'
  ,dwh_load_id                              COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.'
  ,dwh_created                              COMMENT 'Creation timestamp of the record in the DWH.'
  ,dwh_updated                              COMMENT 'Timestamp of the last update of the record in the DWH.'
)
COMMENT = 'The table contains information regarding the type of events that are reported from an Oven Chamber.'
 AS 
    SELECT 
        bakeoff_oven_chamber_event_type_cd,
        bakeoff_oven_chamber_event_type_descr,
        dwh_load_id,
        dwh_created,
        dwh_updated

FROM P_LEW_CORE.T_REF_BAKEOFF_OVEN_CHAMBER_EVENT_TYPE_2 ;