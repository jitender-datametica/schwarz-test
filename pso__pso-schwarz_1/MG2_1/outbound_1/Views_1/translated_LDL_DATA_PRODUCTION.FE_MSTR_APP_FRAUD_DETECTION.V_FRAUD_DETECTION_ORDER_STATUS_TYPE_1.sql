CREATE OR REPLACE VIEW ldl_data_production_fe_mstr_app_fraud_detection.v_fraud_detection_order_status_type_1 (order_parameter_status_cd
OPTIONS(description='The status_1 of a order parameter if it is approved, requested or denied.'),
order_parameter_status_seq OPTIONS(description='Display order in frontend drop-down'), order_parameter_status_descr
OPTIONS(description='Textual describes of the lifecycle status_1'), dwh_created_tmsp
OPTIONS(description='The point in time when this record was created in the data warehouse.'), dwh_updated_tmsp
OPTIONS(description='The point in time when this record was created or last updated.'), dwh_load_id
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'))
OPTIONS(DESCRIPTION = `THIS LOOK-UP TABLE DEFINES THE STATUS_1 OF THE REVISION ORDER`) AS SELECT order_parameter_status_cd
 ,
 order_parameter_status_seq,
 order_parameter_status_descr,
 dwh_created_tmsp,
 dwh_updated_tmsp,
 dwh_load_id,
 dwh_node_cd
FROM ldl_data_production_core_app_fraud_detection.t_fraud_detection_order_status_type_1 AS main;