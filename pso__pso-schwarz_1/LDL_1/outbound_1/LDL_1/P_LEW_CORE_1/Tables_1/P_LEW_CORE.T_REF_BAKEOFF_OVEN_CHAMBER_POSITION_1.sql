/* --------------------------------------------------------------------------------
   DDL for table: t_ref_bakeoff_oven_chamber_position_1
   generated from Powerdesigner on Montag, 6. Oktober 2025 15:40:37
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_bakeoff_oven_chamber_position_1 (
bakeoff_oven_chamber_pos_cd STRING(100) NOT NULL
OPTIONS(description='Alphanumeric Code which identifies if the chamber is placed on "top" or on the "bottom" in the oven.'),
bakeoff_oven_chamber_pos_descr STRING(250) NOT NULL
OPTIONS(description='Description of the Code which identifies if the chamber is placed on "top" or on the "bottom" in the oven.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (bakeoff_oven_chamber_pos_cd) NOT ENFORCED
)
OPTIONS(description='Table contains information about the possible places where the oven chamber is placed in the oven.');