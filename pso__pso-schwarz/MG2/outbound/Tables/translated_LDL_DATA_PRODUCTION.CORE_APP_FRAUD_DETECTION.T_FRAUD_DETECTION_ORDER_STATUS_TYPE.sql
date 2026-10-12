CREATE OR REPLACE TABLE ldl_data_production_core_app_fraud_detection.t_fraud_detection_order_status_type (
order_parameter_status_cd STRING(20) NOT NULL
OPTIONS(description='The status of a order parameter if it is approved, requested or denied.'),
order_parameter_status_seq INTEGER NOT NULL,
order_parameter_status_descr STRING(250) NOT NULL OPTIONS(description='Textual describes of the lifecycle status'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (order_parameter_status_cd) NOT ENFORCED
) OPTIONS(description='This look-up table defines the status of the revision order');