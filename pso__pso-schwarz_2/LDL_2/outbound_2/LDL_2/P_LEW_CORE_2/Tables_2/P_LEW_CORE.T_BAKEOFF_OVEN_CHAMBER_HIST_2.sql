/* --------------------------------------------------------------------------------
   DDL for table: t_bakeoff_oven_chamber_hist_2
   generated from Powerdesigner on Montag, 6. Oktober 2025 15:38:50
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_bakeoff_oven_chamber_hist_2 (
bakeoff_oven_chamber_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique surrogate identifier for a Chamber in the Oven.'),
dwh_valid_from DATE NOT NULL
OPTIONS(description='Begin of the validity_2 interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).'),
dwh_valid_to DATE NOT NULL
OPTIONS(description='End of the validity_2 interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).'),
deleted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Attribute set was not delivered by source system (anymore), if deleted_fg=1.'),
store_loc_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate Key LOCATION_2 (eindeutig ueber alle Laender / Mandanten hinweg).'),
client_id BIGNUMERIC(38,0) OPTIONS(description='Surrogate Key CLIENT.'),
ip_address_nr STRING(100) OPTIONS(description='The IP address_2 for the Baking Oven Chamber.'),
bakeoff_oven_chamber_name STRING(100) NOT NULL OPTIONS(description='Name of the baking oven chamber.'),
bakeoff_oven_pos_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='A numerical Number which identifies the position of the oven in the store. Most stores will have up to three different ovens.'),
bakeoff_oven_chamber_pos_cd STRING(100) NOT NULL
OPTIONS(description='Alphanumeric Code which identifies if the chamber is placed on "top" or on the "bottom" in the oven. '),
bakeoff_oven_chamber_serial_nr STRING(100) OPTIONS(description='The serial number for the Oven chamber.'),
bakeoff_oven_chamber_model_name STRING(100) OPTIONS(description='The name for the model type of the Oven chamber.'),
bakeoff_oven_chamber_construction_year BIGNUMERIC(38,0)
OPTIONS(description='The year of construction for the Oven chamber.'),
bakeoff_oven_chamber_eow_dt DATE OPTIONS(description='End of Warranty Date of the oven chamber.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (bakeoff_oven_chamber_sid, dwh_valid_from) NOT ENFORCED
)
OPTIONS(description='Table contains historized data for oven chambers which are located in a store and send event data. Several chambers (mostly two) can be grouped into an oven,');