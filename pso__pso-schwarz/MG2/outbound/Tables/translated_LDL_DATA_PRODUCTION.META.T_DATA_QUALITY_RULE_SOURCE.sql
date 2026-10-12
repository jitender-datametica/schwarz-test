CREATE OR REPLACE TABLE ldl_data_production_meta.t_data_quality_rule_source (
dq_rule_src_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the origin of the data quality rule. A rule may be defined by business or by the data modelling team or because of a formal guideline, such as checking all foreign keys for referential integrity violations. (Note that the origin of a data quality rule is independent from the way how it is implemented, i.e. as a generated rule, a parametrized rule or as a business rule.)'),
dq_rule_src_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the origin of the data quality rule.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (dq_rule_src_cd) NOT ENFORCED
)
OPTIONS(description='This minor entity defines the origin of the data quality rule. A rule may be defined by business or by the data modelling team or because of a formal guideline, such as checking all foreign keys for referential integrity violations. (Note that the origin of a data quality rule is independent from the way how it is implemented, i.e. as a generated rule, a parametrized rule or as a business rule.)');