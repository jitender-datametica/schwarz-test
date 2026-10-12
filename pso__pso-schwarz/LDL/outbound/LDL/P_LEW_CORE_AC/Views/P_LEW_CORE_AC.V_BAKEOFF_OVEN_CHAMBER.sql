CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_bakeoff_oven_chamber (bakeoff_oven_chamber_sid
OPTIONS(description='The unique surrogate identifier for a chamber in the Oven.'), bakeoff_oven_chamber_nr
OPTIONS(description='The identifier for the Oven chamber which is unique in combination with the manufacturer and country.'),
bakeoff_oven_chamber_manufacturer_cd
OPTIONS(description='The unique code for the Manufacturer of the Baking Oven chamber.'), bakeoff_oven_chamber_country_cd
OPTIONS(description='Country Code from the manufacturer where the oven chamber is located.'), dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created OPTIONS(description='Creation timestamp of the record in the DWH.'), dwh_updated
OPTIONS(description='Timestamp of the last update of the record in the DWH.'))
OPTIONS(DESCRIPTION = `TABLE CONTAINS ALL CHAMBERS WHICH ARE LOCATED IN A STORE AND SENDS EVENT DATA. SEVERAL CHAMBERS (MOSTLY TWO) CAN BE GROUPED IN AN OVEN.`)
AS SELECT bakeoff_oven_chamber_sid,
 bakeoff_oven_chamber_nr,
 bakeoff_oven_chamber_manufacturer_cd,
 bakeoff_oven_chamber_country_cd,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_bakeoff_oven_chamber;