/* --------------------------------------------------------------------------------
   DDL for table: t_load_metric_1
   generated from Powerdesigner on Donnerstag, 21. September 2023 14:44:55
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_meta.t_load_metric_1 (
load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the execution of an ETL job.'),
load_metric_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the type of metric which is collected during the execution of an ETL job.'),
load_metric_meas BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='The value for the metric that has been collected during the execution of the ETL job.'),
uom_cd STRING(20) NOT NULL OPTIONS(description='The code identifying the unit_1 of measure.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (load_metric_type_cd, load_id) NOT ENFORCED
)
OPTIONS(description='Various statistics can be collected during the execution of an ETL job, such as the CPU or memory usage. The type of metric is defined by the metric type code.');