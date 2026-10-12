CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_bakeoff_oven_chamber_hist_1 (bakeoff_oven_chamber_sid
OPTIONS(description='The unique surrogate identifier for a Chamber in the Oven.'), dwh_valid_from
OPTIONS(description='Begin of the validity_1 interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).'),
dwh_valid_to
OPTIONS(description='End of the validity_1 interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).'),
deleted_fg OPTIONS(description='Attribute set was not delivered by source system (anymore), if deleted_fg=1.'),
store_loc_sid OPTIONS(description='Surrogate Key LOCATION_1 (eindeutig ueber alle Laender / Mandanten hinweg).'),
client_id OPTIONS(description='Surrogate Key CLIENT.'), ip_address_nr
OPTIONS(description='The IP address_1 for the Baking Oven Chamber.'), bakeoff_oven_chamber_name
OPTIONS(description='Name of the baking oven chamber.'), bakeoff_oven_pos_nr
OPTIONS(description='A numerical Number which identifies the position of the oven in the store. Most stores will have up to three different ovens.'),
bakeoff_oven_chamber_pos_cd
OPTIONS(description='Alphanumeric Code which identifies if the chamber is placed on "top" or on the "bottom" in the oven. '),
bakeoff_oven_chamber_serial_nr OPTIONS(description='The serial number for the Oven chamber.'),
bakeoff_oven_chamber_model_name OPTIONS(description='The name for the model type of the Oven chamber.'),
bakeoff_oven_chamber_construction_year OPTIONS(description='The year of construction for the Oven chamber.'),
bakeoff_oven_chamber_eow_dt OPTIONS(description='End of Warranty Date of the oven chamber.'), dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created OPTIONS(description='Creation timestamp of the record in the DWH.'), dwh_updated
OPTIONS(description='Timestamp of the last update of the record in the DWH.'))
OPTIONS(DESCRIPTION = `TABLE CONTAINS HISTORIZED DATA FOR OVEN CHAMBERS WHICH ARE LOCATED IN A STORE AND SEND EVENT DATA. SEVERAL CHAMBERS (MOSTLY TWO) CAN BE GROUPED INTO AN OVEN,`)
AS SELECT bakeoff_oven_chamber_sid,
 dwh_valid_from,
 dwh_valid_to,
 deleted_fg,
 store_loc_sid,
 client_id,
 ip_address_nr,
 bakeoff_oven_chamber_name,
 bakeoff_oven_pos_nr,
 bakeoff_oven_chamber_pos_cd,
 bakeoff_oven_chamber_serial_nr,
 bakeoff_oven_chamber_model_name,
 bakeoff_oven_chamber_construction_year,
 bakeoff_oven_chamber_eow_dt,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_bakeoff_oven_chamber_hist_1;