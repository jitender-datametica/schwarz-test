CREATE OR REPLACE TABLE ldl_data_production_core_app_fraud_detection.t_environment_config_1 (
param_name STRING(100) NOT NULL
OPTIONS(description='Holds the parameter value, E.g. param_name warehouse size and param_val_txt would have a XL or M.'),
param_val_txt STRING(1000) NOT NULL
OPTIONS(description='Holds the parameter value, E.g. XL for the parameter value for the param_name warehouse size.'),
comment_txt STRING(1000) OPTIONS(description='Detail description of the parameter.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (param_name) NOT ENFORCED
) OPTIONS(description='Holds the ZKP Application parameter values.');