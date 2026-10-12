/* --------------------------------------------------------------------------------
   DDL for table: t_bakeoff_oven_chamber_manufacturer
   generated from Powerdesigner on Montag, 6. Oktober 2025 15:40:02
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_bakeoff_oven_chamber_manufacturer (
bakeoff_oven_chamber_manufacturer_cd STRING(100) NOT NULL
OPTIONS(description='The unique code for the Manufacturer of the Baking Oven Chamber.'),
bakeoff_oven_chamber_manufacturer_name STRING(100) NOT NULL
OPTIONS(description='Then name for the Manufacturer of the Baking Oven Chamber.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (bakeoff_oven_chamber_manufacturer_cd) NOT ENFORCED
) OPTIONS(description='The table contains the different Manufacturers of the baking oven chambers.');