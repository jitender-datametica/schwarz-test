--==============================================================
-- Table: T_DEVELOPMENT_TEST_TYPE
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_DEVELOPMENT_TEST_TYPE
   generated from Powerdesigner on Montag, 7. November 2022 10:16:19
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS produktion_meta.t_development_test_type (
dev_test_type_cd STRING(50) NOT NULL
OPTIONS(description='The code for the subtype discriminators for development tests. It distinguishes between unit tests, integration tests and user acceptance tests.'),
dev_test_type_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the subtype discriminators for development tests.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (dev_test_type_cd) NOT ENFORCED
)
OPTIONS(description='Minor Entity - This minor entity defines the subtype discriminators for development tests. It distinguishes between unit tests, integration tests and user acceptance tests.');