--==============================================================
-- Table: T_DEVELOPMENT_TEST_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_DEVELOPMENT_TEST_2
   generated from Powerdesigner on Montag, 7. November 2022 10:16:19
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS produktion_meta.t_development_test_2 (
test_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unique identifier (surrogate key) for a development test.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
dev_test_name STRING(250) NOT NULL OPTIONS(description='The name by which the development test_2 has been defined.'),
dev_test_descr STRING(250)
OPTIONS(description='A free text describing the character and purpose of the development test.'),
dev_test_type_cd STRING(50) NOT NULL
OPTIONS(description='The code for the subtype discriminators for development tests. It distinguishes between unit_2 tests, integration tests and user acceptance tests.'),
tested_data_obj_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) of the data object which is the target of this test.'),
tested_data_struct_name STRING(100) NOT NULL
OPTIONS(description='The name of the data structure, which is the target of this test.'),
tested_data_elem_name STRING(100) OPTIONS(description='The name of the data element, which is the target of this test.'),
test_origin_cd STRING(50) NOT NULL
OPTIONS(description='The code identifying the operational source which defines the test.'),
test_lifecycle_status_cd STRING(50) NOT NULL
OPTIONS(description='The code identifying the lifecycle status_2 of a test. E.g. draft, approved, expired, ...'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (test_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='Major Entity - Any test_2 which are done as part of the development of new software. A development test_2 leads to a BYTES result, i.e. pass or fail.');