CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_bakeoff_oven_chamber_event (bakeoff_oven_chamber_sid
OPTIONS(description='Surrogate Key of the oven chamber where the event is captured.'), bakeoff_oven_chamber_event_dt
OPTIONS(description='Date when the event happened.'), bakeoff_oven_chamber_event_tm
OPTIONS(description='Time when the event happened.'), bakeoff_oven_chamber_event_timezone_name
OPTIONS(description='Timezone in which the event happend at the specific date and time.'),
bakeoff_oven_chamber_event_type_cd OPTIONS(description='The code for the type of the event.'),
bakeoff_oven_chamber_baking_program_id
OPTIONS(description='ID of the baking program to which baking related events in the chamber can be grouped. The ID represents the intended meaning of the program, in some cases the real data may differ from it.'),
dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created OPTIONS(description='Creation timestamp of the record in the DWH.'), dwh_updated
OPTIONS(description='Timestamp of the last update of the record in the DWH.'))
OPTIONS(DESCRIPTION = `TABLE CONTAINS EVENTS WHICH ARE CAPTURED FOR A BAKEOFF OVEN CHAMBER WHICH IS PART OF AN OVEN IN A STORE.`)
AS SELECT bakeoff_oven_chamber_sid,
 bakeoff_oven_chamber_event_dt,
 bakeoff_oven_chamber_event_tm,
 bakeoff_oven_chamber_event_timezone_name,
 bakeoff_oven_chamber_event_type_cd,
 bakeoff_oven_chamber_baking_program_id,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_bakeoff_oven_chamber_event;