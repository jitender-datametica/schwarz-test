CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_work_group_2 (wh_work_grp_nr
OPTIONS(description='Queue identifier from EWM which is used to group work package_2 and task.'), wh_work_grp_descr
OPTIONS(description='Description of the WH work group.'), pick_area_nr
OPTIONS(description='Picking area ID as per WAMAS.'), dwh_load_id
OPTIONS(description='The identifier of the last load run which inserted or updated this row.'), dwh_created
OPTIONS(description='The point in time when this record was created in the data warehouse.'), dwh_updated
OPTIONS(description='The point in time when this record was last updated.'))
OPTIONS(DESCRIPTION = `THE TABLE HOLDS REFERENCES OF EWM QUEUE TO WAMAS PICK AREA.THIS IS A GLOBAL MAPPING THAT BUSINESS WILL MAINTAIN.`)
AS SELECT wh_work_grp_nr,
 wh_work_grp_descr,
 pick_area_nr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_work_group_2;