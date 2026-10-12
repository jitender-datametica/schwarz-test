CREATE OR REPLACE TABLE ldl_data_production_meta.t_query_1 (
query_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the query.'),
query_start_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time, when the query was started.'),
query_end_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time, when the query finished.'),
sql_txt STRING(1000) NOT NULL OPTIONS(description='The SQL statement.'),
user_name STRING(100) OPTIONS(description='The name of the user that submitted the query.'),
session_nr STRING(20)
OPTIONS(description='The number which identifies a session on a system at a given point in time. (Session numbers may be re_1-used.)'),
role_name STRING(100) OPTIONS(description='The name of the role under which the query was executed.'),
snowflake_wh_name STRING(100)
OPTIONS(description='The name for the compute resource on Snowflake which executes a query.'),
workload_class_cd STRING(20)
OPTIONS(description='The code identifying the workload. E.g. customer segmentation queries, data mining, etc.'),
query_error_cd STRING(20)
OPTIONS(description='The error code of the query, as defined by the database engine. If the query was executed successfully, the error code is empty.'),
query_error_txt STRING(1000) OPTIONS(description='The error message'),
returned_rec_cnt INTEGER
OPTIONS(description='The number of records which were returned to the user as the result of the query.'),
inserted_rec_cnt INTEGER OPTIONS(description='The number of records which were inserted as the result of the query.'),
deleted_rec_cnt INTEGER OPTIONS(description='The number of records which were deleted as the result of the query.'),
updated_rec_cnt INTEGER OPTIONS(description='The number of records which were updated as the result of the query.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (query_sid) NOT ENFORCED
)
OPTIONS(description='A query is a piece of SQL (or a similar language) which is executed against a database management system.');