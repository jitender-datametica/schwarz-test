CREATE OR REPLACE TABLE ldl_data_production_meta.t_etl_job_data_structure (
etl_job_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the ETL job'),
data_struct_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) of the data structure.'),
data_obj_access_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the way how a data object is used by an ETL job.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (etl_job_sid, data_obj_access_type_cd, data_struct_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='An ETL job may use a data object in various different ways. It may read from the object, it may write it, it may reference it as a lookup or use it as an intermediate storage. This entity links an ETL job to all its referenced data objects. The way how the data object is used, is defined by the usage type.');