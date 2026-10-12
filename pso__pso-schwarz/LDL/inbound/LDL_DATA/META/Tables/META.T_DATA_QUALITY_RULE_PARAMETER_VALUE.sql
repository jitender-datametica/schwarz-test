/* --------------------------------------------------------------------------------
   DDL for table: t_data_quality_rule_parameter_value
   generated from Powerdesigner on Donnerstag, 21. September 2023 14:44:55
*/ --------------------------------------------------------------------------------

CREATE TABLE meta.T_DATA_QUALITY_RULE_PARAMETER_VALUE (
   test_sid                            NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for a parametrized formal data quality rule.',
   dq_rule_param_name                  VARCHAR(100)    NOT NULL COMMENT 'The code identifying the parameter which need to be set for parametrized data quality rules.',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   dwh_valid_fg                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   dq_rule_param_txt                   VARCHAR(1000)   NOT NULL COMMENT 'The value which is used for the given parameter type.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_DATA_QUALITY_RULE_PARAMETER_VALUE PRIMARY KEY (test_sid, dq_rule_param_name, dwh_valid_from_tmsp) NOT ENFORCED
 )  COMMENT= 'This entity tracks the parameter values which have been used to configure a formal data quality rule.';
