/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_WAREHOUSE_TASK_STATUS
   GENERATED FROM POWERDESIGNER ON Dienstag, 14. Juni 2022 11:18:31
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_warehouse_task_status (
wh_task_status_cd STRING(5) NOT NULL OPTIONS(description='The code for warehouse task status'),
wh_task_status_descr STRING(250) NOT NULL OPTIONS(description='The description for warehouse task status'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (wh_task_status_cd) NOT ENFORCED
) OPTIONS(description='The minor dimension defines warehouse task status');