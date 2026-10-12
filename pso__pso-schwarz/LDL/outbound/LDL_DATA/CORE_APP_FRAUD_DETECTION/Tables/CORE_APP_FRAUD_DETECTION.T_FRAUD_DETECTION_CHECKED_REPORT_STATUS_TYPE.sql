CREATE TABLE IF NOT EXISTS ldl_data_core_app_fraud_detection.t_fraud_detection_checked_report_status_type (
report_status_cd STRING(20) NOT NULL
OPTIONS(description='The unique code indicating the status of the checked report (e.g. OPEN, COMMENTED, APPROVED ).'),
report_status_descr STRING(250) NOT NULL OPTIONS(description='The descriptive name or explanation of the status.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update.'),
dwh_node_cd STRING(20) NOT NULL OPTIONS(description='The code for the source system from which this record was loaded.'),
PRIMARY KEY (report_status_cd) NOT ENFORCED
) OPTIONS(description='Reference table defining the possible lifecycle statuses of a fraud detection checked report.');