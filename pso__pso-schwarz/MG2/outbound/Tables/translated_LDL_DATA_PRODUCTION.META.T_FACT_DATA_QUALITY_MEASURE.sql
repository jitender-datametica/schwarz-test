CREATE OR REPLACE TABLE ldl_data_production_meta.t_fact_data_quality_measure (
dq_rule_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) for a data quality rule.'),
cal_dt DATE NOT NULL
OPTIONS(description='The day represented as a calendar date of the form YYYY-MM-DD. YYYY is the calendar year, MM (between 1 and 12) the calendar month and DD the day of the calendar month (between 1 and 31). '),
total_rec_cnt INTEGER NOT NULL
OPTIONS(description='The total number of records which were the input for this data quality check.'),
skipped_rec_cnt INTEGER NOT NULL
OPTIONS(description='The number of records for which the data quality check was not executed.'),
passed_rec_cnt INTEGER NOT NULL OPTIONS(description='The number of records which passed the data quality check.'),
failed_rec_cnt INTEGER NOT NULL OPTIONS(description='The number of records which failed the data quality check.'),
test_exec_status_cd STRING(20) NOT NULL
OPTIONS(description='A code identifying the overall result of a test, e.g. success or failed.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (dq_rule_sid, cal_dt) NOT ENFORCED
)
OPTIONS(description='The execution of a data quality check leads to a result. There is one record for each check and day. If the check has not been executed on a given day, the last available result is taken.');