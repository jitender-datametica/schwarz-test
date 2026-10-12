/* --------------------------------------------------------------------------------
   DDL for table: t_ref_work_package_status_2
   generated from Powerdesigner on Mittwoch, 5. Juni 2024 16:03:58
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_work_package_status_2 (
work_package_status_cd STRING(100) NOT NULL OPTIONS(description='Status_2 of the work package_2: , A, B, C and D.'),
work_package_status_descr STRING(250)
OPTIONS(description='Warehouse work package_2 status_2 description: open, cancelled, confirmed, etc.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The identifier of the last load run which inserted or updated this row.'),
dwh_created DATETIME NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (work_package_status_cd) NOT ENFORCED
)
OPTIONS(description='Static order (work package_2) status_2 that exists in EWM: open, in progress, cancel, complete and locked.');