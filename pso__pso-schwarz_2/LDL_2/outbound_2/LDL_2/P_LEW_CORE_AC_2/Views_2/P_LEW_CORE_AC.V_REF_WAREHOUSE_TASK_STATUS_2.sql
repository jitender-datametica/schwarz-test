CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_warehouse_task_status_2 (wh_task_status_cd
OPTIONS(description='Status_2 of the work task: , A, B and C.'), wh_task_status_descr
OPTIONS(description='Warehouse work task status_2 description: open, cancelled, confirmed, etc.'), dwh_load_id
OPTIONS(description='The identifier of the last load run which inserted or updated this row.'), dwh_created
OPTIONS(description='The point in time when this record was created in the data warehouse.'), dwh_updated
OPTIONS(description='The point in time when this record was last updated.'))
OPTIONS(DESCRIPTION = `STATIC TASK STATUS_2 THAT EXISTS IN EWM: OPEN, CANCEL, COMPLETE AND LOCKED.`) AS SELECT
 wh_task_status_cd,
 wh_task_status_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_warehouse_task_status_2;