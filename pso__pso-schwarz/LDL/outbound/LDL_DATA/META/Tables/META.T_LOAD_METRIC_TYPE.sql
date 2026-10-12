/* --------------------------------------------------------------------------------
   DDL for table: t_load_metric_type
   generated from Powerdesigner on Donnerstag, 21. September 2023 14:44:55
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_data_meta.t_load_metric_type (
load_metric_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the type of metric which is collected during the execution of an ETL job.'),
load_metric_type_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the type of metric which is collected during the execution of an ETL job.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (load_metric_type_cd) NOT ENFORCED
)
OPTIONS(description='This minor entity defines the kind of measure which is collected during the execution of an ETL job.');