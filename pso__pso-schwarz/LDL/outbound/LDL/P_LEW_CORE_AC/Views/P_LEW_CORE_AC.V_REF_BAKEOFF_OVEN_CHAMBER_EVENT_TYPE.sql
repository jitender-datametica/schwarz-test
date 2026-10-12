CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_bakeoff_oven_chamber_event_type (bakeoff_oven_chamber_event_type_cd
OPTIONS(description='The unique code for the type of the event in an oven chamber.'),
bakeoff_oven_chamber_event_type_descr
OPTIONS(description='The description for the type of the event in an oven chamber.'), dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created OPTIONS(description='Creation timestamp of the record in the DWH.'), dwh_updated
OPTIONS(description='Timestamp of the last update of the record in the DWH.'))
OPTIONS(DESCRIPTION = `THE TABLE CONTAINS INFORMATION REGARDING THE TYPE OF EVENTS THAT ARE REPORTED FROM AN OVEN CHAMBER.`)
AS SELECT bakeoff_oven_chamber_event_type_cd,
 bakeoff_oven_chamber_event_type_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_bakeoff_oven_chamber_event_type;