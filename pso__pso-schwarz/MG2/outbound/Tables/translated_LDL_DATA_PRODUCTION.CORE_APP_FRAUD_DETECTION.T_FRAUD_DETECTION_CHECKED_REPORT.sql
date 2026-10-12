CREATE OR REPLACE TABLE ldl_data_production_core_app_fraud_detection.t_fraud_detection_checked_report (
int_org_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the internal organizatio (store or sales company/VGES)'),
request_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record requested by the MicroStrategy-User.'),
report_id INTEGER NOT NULL OPTIONS(description='The unique identifier of MicroStrategy Report'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
checked_by_user_name STRING(100) NOT NULL OPTIONS(description='The end user, who sets the audit flag'),
comment_by_user STRING(100) OPTIONS(description='The comment of the user'),
PRIMARY KEY (int_org_sid, request_tmsp, report_id) NOT ENFORCED
) OPTIONS(description='Keeps the fraud detection audit list, to know which organisation is approved for which report');