/* --------------------------------------------------------------------------------
   DDL for table: t_ref_warehouse_task_status
   generated from Powerdesigner on Mittwoch, 5. Juni 2024 15:59:03
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_warehouse_task_status (
wh_task_status_cd STRING(100) NOT NULL OPTIONS(description='Status of the work task: , A, B and C.'),
wh_task_status_descr STRING(250) NOT NULL
OPTIONS(description='Warehouse work task status description: open, cancelled, confirmed, etc.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The identifier of the last load run which inserted or updated this row.'),
dwh_created DATETIME NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (wh_task_status_cd) NOT ENFORCED
) OPTIONS(description='Static task status that exists in EWM: open, cancel, complete and locked.');