CREATE OR REPLACE TABLE ldl_data_production_meta.t_etl_audit (
test_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) for an ETL audit.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
etl_audit_name STRING(250) NOT NULL OPTIONS(description='The name by which the ETL audit has been defined.'),
etl_audit_descr STRING(250) OPTIONS(description='A free text describing the character and purpose of the ETL audit.'),
tested_data_obj_sid INTEGER
OPTIONS(description='The unique identifier (surrogate key) of the data object which is the target of this test.'),
tested_data_struct_name STRING(250)
OPTIONS(description='The name of the data structure, which is the target of this test.'),
tested_data_elem_name STRING(250) OPTIONS(description='The name of the data element, which is the target of this test.'),
test_origin_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the operational source which defines the test.'),
test_lifecycle_status_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the lifecycle status of a test. E.g. draft, approved, expired, ...'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (test_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='An ETL audit monitors the execution of an ETL job. E.g. it checks the number of files which have been processed or the number of new surrogate keys that were generated. In general, an ETL audit compares an observed measure with an expected value.');