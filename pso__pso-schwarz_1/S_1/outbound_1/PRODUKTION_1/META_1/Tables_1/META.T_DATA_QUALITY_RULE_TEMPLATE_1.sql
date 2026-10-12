--==============================================================
-- Table: T_DATA_QUALITY_RULE_TEMPLATE_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_DATA_QUALITY_RULE_TEMPLATE_1
   generated from Powerdesigner on Montag, 7. November 2022 10:16:19
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS produktion_meta.t_data_quality_rule_template_1 (
dq_rule_template_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the template for formal data quality rules.'),
dq_rule_template_name STRING(100) NOT NULL
OPTIONS(description='The name of the template script which was used to generate a formal data quality rule.'),
dq_rule_template_descr STRING(250) NOT NULL
OPTIONS(description='A free text describing the purpose and structure of the template for formal data quality rules.'),
template_sql_txt STRING(1000) OPTIONS(description='The SQL template for the data quality check.'),
dq_rule_type_cd STRING(50)
OPTIONS(description='A code for the subtype discriminators for data quality rules. It distinguishes between business rules, generated and parametrized rules.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (dq_rule_template_sid) NOT ENFORCED
) OPTIONS(description='Minor Entity - Formal data quality checks can generated based on a template.');