CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_uniform_pick_area (pick_area_nr
OPTIONS(description='Picking area ID as per WAMAS.'), pick_area_descr
OPTIONS(description='Description of the picking area.'), pick_main_area_nr OPTIONS(description='Main picking area ID.'),
dwh_load_id OPTIONS(description='The identifier of the last load run which inserted or updated this row.'), dwh_created
OPTIONS(description='The point in time when this record was created in the data warehouse.'), dwh_updated
OPTIONS(description='The point in time when this record was last updated.'))
OPTIONS(DESCRIPTION = `THE TABLE HOLDS PICKING AREA INFORMATION LIKE HIGH RACK (HOCHREGAL), FREEZER, CHILLER, ETC.. FROM THE GLOBAL INPUT.`)
AS SELECT pick_area_nr,
 pick_area_descr,
 pick_main_area_nr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_uniform_pick_area;