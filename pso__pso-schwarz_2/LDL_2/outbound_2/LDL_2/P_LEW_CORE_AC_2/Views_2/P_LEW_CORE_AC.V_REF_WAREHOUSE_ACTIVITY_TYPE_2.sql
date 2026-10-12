CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_warehouse_activity_type_2 (wh_activity_type_cd
OPTIONS(description='Activity type of the work task, like pick, replenishment, stock change, internal move or putaway.'),
wh_activity_type_descr OPTIONS(description='Description of the activity type in the WH.'), dwh_load_id
OPTIONS(description='The identifier of the last load run which inserted or updated this row.'), dwh_created
OPTIONS(description='The point in time when this record was created in the data warehouse.'), dwh_updated
OPTIONS(description='The point in time when this record was last updated.'))
OPTIONS(DESCRIPTION = `THE TABLE HOLDS THE ACTIVITY TYPES IN SAP EWM. THE VALUES ARE PTWY, PICK, INTL, STCH AND REPL.`)
AS SELECT wh_activity_type_cd,
 wh_activity_type_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_warehouse_activity_type_2;