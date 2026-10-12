CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_bakeoff_oven_chamber_manufacturer (bakeoff_oven_chamber_manufacturer_cd
OPTIONS(description='The unique code for the Manufacturer of the Baking Oven Chamber.'),
bakeoff_oven_chamber_manufacturer_name OPTIONS(description='Then name for the Manufacturer of the Baking Oven Chamber.'),
dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created OPTIONS(description='Creation timestamp of the record in the DWH.'), dwh_updated
OPTIONS(description='Timestamp of the last update of the record in the DWH.'))
OPTIONS(DESCRIPTION = `THE TABLE CONTAINS THE DIFFERENT MANUFACTURERS OF THE BAKING OVEN CHAMBERS.`) AS SELECT
 bakeoff_oven_chamber_manufacturer_cd,
 bakeoff_oven_chamber_manufacturer_name,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_bakeoff_oven_chamber_manufacturer;