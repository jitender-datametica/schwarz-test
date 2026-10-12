CREATE OR REPLACE TABLE ldl_data_production_meta.t_data_quality_rule_to_issue_1 (
test_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) for a data quality rule.'),
dq_issue_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the data quality issue.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (test_sid, dq_issue_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='This table relates data quality issues to the data quality rules which fail because of the issue. One issue may show up in several data quality rules.');