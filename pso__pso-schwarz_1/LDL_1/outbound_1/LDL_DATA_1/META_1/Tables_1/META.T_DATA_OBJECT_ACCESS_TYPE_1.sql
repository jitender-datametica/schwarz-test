/* --------------------------------------------------------------------------------
   DDL for table: t_data_object_access_type_1
   generated from Powerdesigner on Donnerstag, 21. September 2023 14:44:55
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_data_meta.t_data_object_access_type_1 (
data_obj_access_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the way how a data object is used by an ETL job.'),
data_obj_access_type_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the way how a data object is used by an ETL job.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (data_obj_access_type_cd) NOT ENFORCED
)
OPTIONS(description='An ETL job may use a data object in various different ways. It may read from the object, it may write it, it may reference it as a lookup or use it as an intermediate storage. This minor entity defines the way, how the data object is used by an ETL job,');