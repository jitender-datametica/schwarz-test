--==============================================================
-- Table: T_DATA_QUALITY_RULE_PARAMETER_VALUE_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_DATA_QUALITY_RULE_PARAMETER_VALUE_2
   generated from Powerdesigner on Montag, 7. November 2022 10:16:19
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS produktion_meta.t_data_quality_rule_parameter_value_2 (
test_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for a parametrized formal data quality rule.'),
dq_rule_param_name STRING(100) NOT NULL
OPTIONS(description='The code identifying the parameter which need to be set for parametrized data quality rules.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
dq_rule_param_txt STRING(1000) NOT NULL OPTIONS(description='The value which is used for the given parameter type.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (test_sid, dq_rule_param_name, dwh_valid_to_tmsp) NOT ENFORCED
)
OPTIONS(description='Major Entity - This entity tracks the parameter values which have been used to configure a formal data quality rule.');