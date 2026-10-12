--==============================================================
-- Table: T_TEST_KEY_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_TEST_KEY_1
   generated from Powerdesigner on Montag, 7. November 2022 10:16:20
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS produktion_meta.t_test_key_1 (
test_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the Test.'),
test_key_type_cd STRING(50) NOT NULL
OPTIONS(description='The code for the type of natural key which identifies the Test.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
test_nat_key_nr STRING(250) NOT NULL
OPTIONS(description='The natural key which identifies the Test.In case the natural key consist of several columns, all components get concatenated.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (test_sid, test_key_type_cd, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='Key table for the Test_1 key space. A surrogate key is identified by one or several natural keys. The kind of natural key is defined by the key type code. In case the natural key consists of several columns, all components get concatenated using a separator character. The association between a natural key and its surrogate key can change over time, e.g. because of a re_1-numbering in the source. That is why the key table is historized.');