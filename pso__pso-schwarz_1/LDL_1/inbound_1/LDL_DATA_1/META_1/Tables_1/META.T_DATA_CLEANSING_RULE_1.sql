/* --------------------------------------------------------------------------------
   DDL for table: t_data_cleansing_rule_1
   generated from Powerdesigner on Donnerstag, 21. September 2023 14:44:55
*/ --------------------------------------------------------------------------------

CREATE TABLE meta.T_DATA_CLEANSING_RULE_1 (
   data_cleansing_rule_name            VARCHAR(100)    NOT NULL COMMENT 'The name for the data cleansing rule.',
   data_cleansing_rule_descr           VARCHAR(250)    NOT NULL COMMENT 'A textual description for operations that get performed as part of the data cleansing rule.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_DATA_CLEANSING_RULE PRIMARY KEY (data_cleansing_rule_name) NOT ENFORCED
 )  COMMENT= 'Source data is cleansed based on a set of rules. E.g. missing columns are filled with default values. This minor entity defines those rules.';
