/* --------------------------------------------------------------------------------
   DDL for table: t_ref_bakeoff_oven_chamber_baking_program_1
   generated from Powerdesigner on Dienstag, 28. Oktober 2025 11:23:03
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_bakeoff_oven_chamber_baking_program_1 (
bakeoff_oven_chamber_baking_program_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID of the baking program to which baking related events in the chamber can be grouped. The ID represents the intended meaning of the program, in some cases the real data may differ from it.'),
bakeoff_oven_chamber_baking_program_name STRING(100) NOT NULL
OPTIONS(description='Description of the baking program to which baking related events in the chamber can be grouped.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (bakeoff_oven_chamber_baking_program_id) NOT ENFORCED
)
OPTIONS(description='The table contains information regarding the baking programs of some events that are reportet on an oven chamber.');