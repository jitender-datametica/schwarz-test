CREATE OR REPLACE VIEW ldl_data_production_fe_mstr_app_fraud_detection.v_fraud_detection_order_reason (order_reason_cd
OPTIONS(description='The revision reason code for an analysis, if it is for threshold definition or fraud analysis'),
order_reason_descr OPTIONS(description='Textual description for the order reason'), dwh_created_tmsp
OPTIONS(description='The point in time when this record was created in the data warehouse.'), dwh_updated_tmsp
OPTIONS(description='The point in time when this record was created or last updated.'), dwh_load_id
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'))
OPTIONS(DESCRIPTION = `REASON WHY THE FRAUD DETECTION WAS ORDERED.REASON (FOR EXAMPLE):INTER AUDIT, RPARAMETER DEFITION`)
AS SELECT order_reason_cd,
 order_reason_descr,
 dwh_created_tmsp,
 dwh_updated_tmsp,
 dwh_load_id,
 dwh_node_cd
FROM ldl_data_production_core_app_fraud_detection.t_fraud_detection_order_reason AS main;