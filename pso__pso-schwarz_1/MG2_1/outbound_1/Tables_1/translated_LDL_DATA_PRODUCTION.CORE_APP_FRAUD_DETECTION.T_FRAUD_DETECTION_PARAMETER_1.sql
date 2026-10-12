CREATE OR REPLACE TABLE ldl_data_production_core_app_fraud_detection.t_fraud_detection_parameter_1 (
scenario_id INTEGER NOT NULL OPTIONS(description='The unique identifier of fraud detection scenario.'),
param_id INTEGER NOT NULL OPTIONS(description='The unique identifier of parameter (thereshold) of a scenario'),
param_name STRING(100) NOT NULL OPTIONS(description='The name of a scenario parameter'),
param_descr STRING(250) NOT NULL OPTIONS(description='The description of scenario paramter.'),
param_default_val_qty NUMERIC(29,5) OPTIONS(description='The default value of a scenario parameter.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (param_id) NOT ENFORCED
)
OPTIONS(description='One scenario defines one or several parameters.Several scenarios can use parameters with the same name.');