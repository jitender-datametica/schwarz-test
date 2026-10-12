/* --------------------------------------------------------------------------------
   DDL for table: t_ref_bakeoff_oven_chamber_event_type_2
   generated from Powerdesigner on Montag, 6. Oktober 2025 15:39:27
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_bakeoff_oven_chamber_event_type_2 (
bakeoff_oven_chamber_event_type_cd STRING(100) NOT NULL
OPTIONS(description='The unique code for the type of the event in an oven chamber.'),
bakeoff_oven_chamber_event_type_descr STRING(250) NOT NULL
OPTIONS(description='The description for the type of the event in an oven chamber.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (bakeoff_oven_chamber_event_type_cd) NOT ENFORCED
)
OPTIONS(description='The table contains information regarding the type of events that are reported from an Oven Chamber.');