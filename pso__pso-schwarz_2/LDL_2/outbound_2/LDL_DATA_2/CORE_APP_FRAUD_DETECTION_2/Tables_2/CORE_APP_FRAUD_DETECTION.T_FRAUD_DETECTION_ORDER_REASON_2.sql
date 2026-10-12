/* --------------------------------------------------------------------------------
   DDL for table: t_fraud_detection_order_reason_2
   generated from Powerdesigner on Mittwoch, 14. August 2024 15:10:31
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_data_core_app_fraud_detection.t_fraud_detection_order_reason_2 (
order_reason_cd STRING(20) NOT NULL
OPTIONS(description='The revision reason code for an analysis, if it is for threshold definition or fraud analysis'),
order_reason_descr STRING(250) NOT NULL OPTIONS(description='Textual description for the order reason'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (order_reason_cd) NOT ENFORCED
)
OPTIONS(description='Reason why the fraud detection was ordered.Reason (for example):Inter audit, rparameter defition');