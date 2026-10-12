/* --------------------------------------------------------------------------------
   DDL for table: t_bakeoff_oven_chamber_2
   generated from Powerdesigner on Montag, 6. Oktober 2025 15:38:06
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_bakeoff_oven_chamber_2 (
bakeoff_oven_chamber_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique surrogate identifier for a chamber in the Oven.'),
bakeoff_oven_chamber_nr STRING(100) NOT NULL
OPTIONS(description='The identifier for the Oven chamber which is unique in combination with the manufacturer and country.'),
bakeoff_oven_chamber_manufacturer_cd STRING(100) NOT NULL
OPTIONS(description='The unique code for the Manufacturer of the Baking Oven chamber.'),
bakeoff_oven_chamber_country_cd STRING(100) NOT NULL
OPTIONS(description='Country_2 Code from the manufacturer where the oven chamber is located.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (bakeoff_oven_chamber_sid) NOT ENFORCED
)
OPTIONS(description='Table contains all chambers which are located in a store and sends event data. Several chambers (mostly two) can be grouped in an oven.');