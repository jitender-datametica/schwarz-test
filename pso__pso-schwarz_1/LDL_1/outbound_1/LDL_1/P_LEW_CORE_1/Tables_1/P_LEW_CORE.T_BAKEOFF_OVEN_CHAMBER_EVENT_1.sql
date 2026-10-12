/* --------------------------------------------------------------------------------
   DDL for table: t_bakeoff_oven_chamber_event_1
   generated from Powerdesigner on Dienstag, 28. Oktober 2025 11:22:15
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_bakeoff_oven_chamber_event_1 (
bakeoff_oven_chamber_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate Key of the oven chamber where the event is captured.'),
bakeoff_oven_chamber_event_dt DATE NOT NULL OPTIONS(description='Date when the event happened.'),
bakeoff_oven_chamber_event_tm TIME NOT NULL OPTIONS(description='Time when the event happened.'),
bakeoff_oven_chamber_event_timezone_name STRING(100) NOT NULL
OPTIONS(description='Timezone in which the event happend at the specific date and time.'),
bakeoff_oven_chamber_event_type_cd STRING(100) NOT NULL OPTIONS(description='The code for the type of the event.'),
bakeoff_oven_chamber_baking_program_id BIGNUMERIC(38,0)
OPTIONS(description='ID of the baking program to which baking related events in the chamber can be grouped. The ID represents the intended meaning of the program, in some cases the real data may differ from it.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (bakeoff_oven_chamber_sid, bakeoff_oven_chamber_event_dt, bakeoff_oven_chamber_event_tm) NOT ENFORCED
)
OPTIONS(description='Table contains events which are captured for a bakeoff oven chamber which is part of an oven in a store.');