CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_pick_main_area_2 (pick_main_area_nr
OPTIONS(description='Picking main area ID that consolidates the picking area.'), pick_main_area_descr
OPTIONS(description='Description of the picking main area.'), dwh_load_id
OPTIONS(description='The identifier of the last load run which inserted or updated this row.'), dwh_created
OPTIONS(description='The point in time when this record was created in the data warehouse.'), dwh_updated
OPTIONS(description='The point in time when this record was last updated.'))
OPTIONS(DESCRIPTION = `REFERENCE TABLE OF PICKING AREA TO THE PICKING MAIN AREA. PICKING MAIN AREAS ARE GROUPINGS OF PICKING AREAS.`)
AS SELECT pick_main_area_nr,
 pick_main_area_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_pick_main_area_2;