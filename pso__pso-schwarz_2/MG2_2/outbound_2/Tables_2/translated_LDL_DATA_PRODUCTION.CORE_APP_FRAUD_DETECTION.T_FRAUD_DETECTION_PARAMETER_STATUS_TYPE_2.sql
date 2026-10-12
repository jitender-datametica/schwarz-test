CREATE OR REPLACE TABLE ldl_data_production_core_app_fraud_detection.t_fraud_detection_parameter_status_type_2 (
param_status_cd STRING(20) NOT NULL
OPTIONS(description='The status_2 of a parameter value if it is approved, requested or denied.'),
param_status_descr STRING(250) NOT NULL OPTIONS(description='The short name of parameter value status.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (param_status_cd) NOT ENFORCED
) OPTIONS(description='The entity definies the lifecycle of the fraud detection parameter.');