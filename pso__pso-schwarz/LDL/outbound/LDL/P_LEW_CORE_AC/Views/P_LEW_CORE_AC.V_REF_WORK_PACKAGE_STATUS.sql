CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_work_package_status (work_package_status_cd
OPTIONS(description='Status of the work package: , A, B, C and D.'), work_package_status_descr
OPTIONS(description='Warehouse work package status description: open, cancelled, confirmed, etc.'), dwh_load_id
OPTIONS(description='The identifier of the last load run which inserted or updated this row.'), dwh_created
OPTIONS(description='The point in time when this record was created in the data warehouse.'), dwh_updated
OPTIONS(description='The point in time when this record was last updated.'))
OPTIONS(DESCRIPTION = `STATIC ORDER (WORK PACKAGE) STATUS THAT EXISTS IN EWM: OPEN, IN PROGRESS, CANCEL, COMPLETE AND LOCKED.`)
AS SELECT work_package_status_cd,
 work_package_status_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_work_package_status;