/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_WAREHOUSE_TRANSPORTATION_UNIT_ACTIVITY_LJX_2
   GENERATED FROM POWERDESIGNER ON Montag, 10. Juni 2024 17:26:24
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_warehouse_transportation_unit_activity_ljx_2 (
wh_transportation_unit_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique surrogate key for the warehouse transportation unit. The SID is generated based on wh_transportation_unit_nr, sap_client_id and sap_system_name. '),
wh_transportation_unit_activity_nr STRING(20) NOT NULL
OPTIONS(description='The unique ID for the activity of the transportation unit_2 at the warehouse. The activity relates to the process of loading and unloading, whenever a transportation unit_2 is docked at the warehouse. '),
wh_transportation_unit_nr STRING(50)
OPTIONS(description='The unique internal ID for the warehouse transportation unit_2 delivering the products associated with a given order line. This internal ID is generated for the originally provided warehouse transportation unit_2 number by the external transportation service provider (alt_wh_transportation_unit_nr).  In case the alternate warehouse transportation unit_2 number changes, the internal ID will remain the same and there will be another row for the new unique combination of alt_wh_transportation_unit_nr and wh_transportation_unit_nr'),
activity_start_actual_tmsp TIMESTAMP
OPTIONS(description='The timestamp when the activity of loading or unloading of the transportation unit_2 actually starts at the warehouse.'),
activity_end_actual_tmsp TIMESTAMP
OPTIONS(description='The timestamp when the activity of loading or unloading of the transportation unit_2 actually ends at the warehouse.'),
activity_start_plan_tmsp TIMESTAMP
OPTIONS(description='The timestamp when the activity of loading or unloading of the transportation unit_2 was planned at the warehouse. It could be different than activity_start_actual_tmsp.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
src_table_name STRING(100) OPTIONS(description='The name of the source table'),
PRIMARY KEY (wh_transportation_unit_sid, wh_transportation_unit_activity_nr) NOT ENFORCED
)
OPTIONS(description='An ETL table to represent the shipping and receiving activities of a transportation unit_2 from the LJX source system.');