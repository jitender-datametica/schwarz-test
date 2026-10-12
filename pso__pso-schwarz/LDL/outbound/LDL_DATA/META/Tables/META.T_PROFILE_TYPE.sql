/* --------------------------------------------------------------------------------
   DDL for table: t_profile_type
   generated from Powerdesigner on Donnerstag, 21. September 2023 14:44:55
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_data_meta.t_profile_type (
test_result_type_cd STRING(20) NOT NULL
OPTIONS(description='A code identifying the type of result value that is produced by a data profiling rule.'),
test_result_type_name STRING(100) NOT NULL
OPTIONS(description='The name for the type of result value that is produced by a data profiling rule. E.g. minimum.'),
test_result_type_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the type of result value that is produced by a data profiling rule.'),
template_sql_txt STRING(1000)
OPTIONS(description='In case the profiling is done via SQL, this is the template for the statement.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (test_result_type_cd) NOT ENFORCED
)
OPTIONS(description='A data profiling rule returns one result value, e.g. the minimum value of a numeric column or the number of NULL values. This minor entity defines the kind of result.');