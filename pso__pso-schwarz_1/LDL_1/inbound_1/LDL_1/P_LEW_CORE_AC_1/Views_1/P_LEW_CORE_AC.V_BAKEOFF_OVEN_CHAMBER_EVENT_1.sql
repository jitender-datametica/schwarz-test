CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_BAKEOFF_OVEN_CHAMBER_EVENT_1 (
   bakeoff_oven_chamber_sid                 COMMENT 'Surrogate Key of the oven chamber where the event is captured.'
  ,bakeoff_oven_chamber_event_dt            COMMENT 'Date when the event happened.'
  ,bakeoff_oven_chamber_event_tm            COMMENT 'Time when the event happened.'
  ,bakeoff_oven_chamber_event_timezone_name COMMENT 'Timezone in which the event happend at the specific date and time.'
  ,bakeoff_oven_chamber_event_type_cd       COMMENT 'The code for the type of the event.'
  ,bakeoff_oven_chamber_baking_program_id   COMMENT 'ID of the baking program to which baking related events in the chamber can be grouped. The ID represents the intended meaning of the program, in some cases the real data may differ from it.'
  ,dwh_load_id                              COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.'
  ,dwh_created                              COMMENT 'Creation timestamp of the record in the DWH.'
  ,dwh_updated                              COMMENT 'Timestamp of the last update of the record in the DWH.'
)
COMMENT = 'Table contains events which are captured for a bakeoff oven chamber which is part of an oven in a store.'
 AS 
    SELECT 
        bakeoff_oven_chamber_sid,
        bakeoff_oven_chamber_event_dt,
        bakeoff_oven_chamber_event_tm,
        bakeoff_oven_chamber_event_timezone_name,
        bakeoff_oven_chamber_event_type_cd,
        bakeoff_oven_chamber_baking_program_id,
        dwh_load_id,
        dwh_created,
        dwh_updated

FROM P_LEW_CORE.T_BAKEOFF_OVEN_CHAMBER_EVENT_1 ;