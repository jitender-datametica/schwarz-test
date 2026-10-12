CREATE OR REPLACE TABLE ldl_data_production_core_app_fraud_detection.t_fraud_detection_parameter_value_2 (
param_id INTEGER NOT NULL OPTIONS(description='The unique identifier of parameter (thereshold) of a scenario'),
country_org_cd STRING(2) NOT NULL
OPTIONS(description='The code of the related business country. (The business country_2 is not identical to a political country_2'),
param_status_cd STRING(20) NOT NULL
OPTIONS(description='The status_2 of a parameter value if it is approved, requested or denied.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
param_val_qty NUMERIC(29,5) OPTIONS(description='The value of scenario parameter, which is provided by end user.'),
requestor_user_name STRING(100) OPTIONS(description='The MSTR-User who enters the value to the system'),
request_tmsp TIMESTAMP OPTIONS(description='The point of the time, when the entry is done.'),
approver_user_name STRING(100) OPTIONS(description='The MSTR-User who approves the value entered to the system'),
approved_tmsp TIMESTAMP OPTIONS(description='The point of the time when the entry is approved.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (param_id, country_org_cd, param_status_cd, dwh_valid_from_tmsp) NOT ENFORCED
) OPTIONS(description='A parameter can have a value which then impact the scenario result');