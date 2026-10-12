CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_bakeoff_oven_chamber_baking_program (bakeoff_oven_chamber_baking_program_id
OPTIONS(description='ID of the baking program to which baking related events in the chamber can be grouped. The ID represents the intended meaning of the program, in some cases the real data may differ from it.'),
bakeoff_oven_chamber_baking_program_name
OPTIONS(description='Description of the baking program to which baking related events in the chamber can be grouped.'),
dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created OPTIONS(description='Creation timestamp of the record in the DWH.'), dwh_updated
OPTIONS(description='Timestamp of the last update of the record in the DWH.'))
OPTIONS(DESCRIPTION = `THE TABLE CONTAINS INFORMATION REGARDING THE BAKING PROGRAMS OF SOME EVENTS THAT ARE REPORTET ON AN OVEN CHAMBER.`)
AS SELECT bakeoff_oven_chamber_baking_program_id,
 bakeoff_oven_chamber_baking_program_name,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_bakeoff_oven_chamber_baking_program;