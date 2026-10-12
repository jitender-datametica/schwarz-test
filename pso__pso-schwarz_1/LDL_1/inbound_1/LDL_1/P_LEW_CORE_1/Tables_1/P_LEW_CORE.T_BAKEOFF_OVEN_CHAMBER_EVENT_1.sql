/* --------------------------------------------------------------------------------
   DDL for table: t_bakeoff_oven_chamber_event_1
   generated from Powerdesigner on Dienstag, 28. Oktober 2025 11:22:15
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_BAKEOFF_OVEN_CHAMBER_EVENT_1 (
   bakeoff_oven_chamber_sid            NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key of the oven chamber where the event is captured.',
   bakeoff_oven_chamber_event_dt       DATE             NOT NULL COMMENT 'Date when the event happened.',
   bakeoff_oven_chamber_event_tm       TIME(9)          NOT NULL COMMENT 'Time when the event happened.',
   bakeoff_oven_chamber_event_timezone_name VARCHAR(100)     NOT NULL COMMENT 'Timezone in which the event happend at the specific date and time.',
   bakeoff_oven_chamber_event_type_cd  VARCHAR(100)     NOT NULL COMMENT 'The code for the type of the event.',
   bakeoff_oven_chamber_baking_program_id NUMBER(38,0)     COMMENT 'ID of the baking program to which baking related events in the chamber can be grouped. The ID represents the intended meaning of the program, in some cases the real data may differ from it.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_BAKEOFF_OVEN_CHAMBER_EVENT PRIMARY KEY (bakeoff_oven_chamber_sid, bakeoff_oven_chamber_event_dt, bakeoff_oven_chamber_event_tm) NOT ENFORCED 
)  COMMENT = 'Table contains events which are captured for a bakeoff oven chamber which is part of an oven in a store.';
