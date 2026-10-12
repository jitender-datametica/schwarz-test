CREATE OR REPLACE TABLE ldl_data_production_core_app_fraud_detection.t_fraud_detection_mstr_metric_2 (
metric_id INTEGER NOT NULL OPTIONS(description='The unique identifier of microstratey metric'),
scenario_id INTEGER NOT NULL OPTIONS(description='The unique identifier of fraud detection scenario'),
metric_name STRING(100) NOT NULL OPTIONS(description='The name of the microstrategy metric presented at frontend.'),
metric_descr STRING(250) NOT NULL OPTIONS(description='Describes the MicroStrategy Metric.'),
calculation_type_cd STRING(20) NOT NULL
OPTIONS(description='Type of calculation, code which defines type of calculation like SUM, weighted Average, count'),
format_type_cd STRING(20) NOT NULL
OPTIONS(description='Type of format, code which defines metric format like integer, percent, currency'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (metric_id) NOT ENFORCED
) OPTIONS(description='Keeps the fraud detection metrics for MicroStrategy Dynamic Dashboards ');