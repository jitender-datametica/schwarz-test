CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_bakeoff_oven_chamber_position_2 (bakeoff_oven_chamber_pos_cd
OPTIONS(description='Alphanumeric Code which identifies if the chamber is placed on "top" or on the "bottom" in the oven.'),
bakeoff_oven_chamber_pos_descr
OPTIONS(description='Description of the Code which identifies if the chamber is placed on "top" or on the "bottom" in the oven.'),
dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created OPTIONS(description='Creation timestamp of the record in the DWH.'), dwh_updated
OPTIONS(description='Timestamp of the last update of the record in the DWH.'))
OPTIONS(DESCRIPTION = `TABLE CONTAINS INFORMATION ABOUT THE POSSIBLE PLACES WHERE THE OVEN CHAMBER IS PLACED IN THE OVEN.`)
AS SELECT bakeoff_oven_chamber_pos_cd,
 bakeoff_oven_chamber_pos_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_bakeoff_oven_chamber_position_2;