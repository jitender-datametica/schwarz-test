/* --------------------------------------------------------------------------------
   DDL for table: t_fraud_analysis_status_type_1
   generated from Powerdesigner on Montag, 14. Oktober 2024 12:35:56
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_data_core_app_fraud_detection.t_fraud_analysis_status_type_1 (
fraud_analysis_status_cd STRING(20) NOT NULL
OPTIONS(description='Indicator showing it user has manually clasified this transaction, if it suspicious or not. First status_1 comes: SP-suspicious and then maybe later on NSP- not suspicious'),
fraud_analysis_status_cd_descr STRING(250) NOT NULL OPTIONS(description='Textual description for the marked code'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (fraud_analysis_status_cd) NOT ENFORCED
) OPTIONS(description='');