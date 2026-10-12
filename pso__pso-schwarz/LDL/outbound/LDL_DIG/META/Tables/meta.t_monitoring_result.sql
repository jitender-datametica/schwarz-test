CREATE TABLE IF NOT EXISTS ldl_dig_meta.t_monitoring_result (
monitoring_result_id INTEGER NOT NULL OPTIONS(description='The unique identifier'),
monitoring_execution_id INTEGER NOT NULL OPTIONS(description='The monitoring execution identifier'),
monitoring_group_id INTEGER NOT NULL OPTIONS(description='The monitoring group identifier'),
monitoring_query_id INTEGER NOT NULL OPTIONS(description='The monitoring query identifier'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
name STRING(250) NOT NULL OPTIONS(description='The name of executed check.'),
info STRING(250) OPTIONS(description='Additional check information.'),
result STRING(250) NOT NULL OPTIONS(description='The result of query.'),
rescode STRING(10) NOT NULL OPTIONS(description='The result of checking: FAILURE, ERROR, WARNING, OK, ... .')
) OPTIONS(description='Results of testing queries');