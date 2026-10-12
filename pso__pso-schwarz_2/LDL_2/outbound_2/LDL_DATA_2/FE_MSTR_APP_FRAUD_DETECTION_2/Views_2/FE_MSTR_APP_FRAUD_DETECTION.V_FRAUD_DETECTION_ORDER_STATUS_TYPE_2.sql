CREATE OR REPLACE VIEW ldl_data_fe_mstr_app_fraud_detection.v_fraud_detection_order_status_type_2 (order_parameter_status_cd
OPTIONS(description='The status_2 of a order parameter if it is approved, requested or denied.'),
order_parameter_status_seq OPTIONS(description='Display order in frontend drop-down'), order_parameter_status_descr
OPTIONS(description='Textual describes of the lifecycle status_2'), dwh_created_tmsp
OPTIONS(description='The point in time when this record was created in the data warehouse.'), dwh_updated_tmsp
OPTIONS(description='The point in time when this record was created or last updated.'), dwh_load_id
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'))
OPTIONS(DESCRIPTION = `THIS LOOK-UP TABLE DEFINES THE STATUS_2 OF THE REVISION ORDER`) AS SELECT *
FROM ldl_data_core_app_fraud_detection.t_fraud_detection_order_status_type_2 AS MAIN;