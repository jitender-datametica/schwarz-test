CREATE OR REPLACE VIEW ldl_data_production_fe_mstr_app_fraud_detection.v_fraud_analysis_status_type_2 (fraud_analysis_status_cd
OPTIONS(description='Indicator showing it user has manually clasified this transaction, if it suspicious or not. First status_2 comes: SP-suspicious and then maybe later on NSP- not suspicious'),
fraud_analysis_status_cd_descr OPTIONS(description='Textual description for the marked code'), dwh_created_tmsp
OPTIONS(description='The point in time when this record was created in the data warehouse.'), dwh_updated_tmsp
OPTIONS(description='The point in time when this record was created or last updated.'), dwh_load_id
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'))
OPTIONS(DESCRIPTION = `LOOKUP FOR THE INDICATOR SHOWING IT USER HAS MANUALLY CLASSIFIED THIS TRANSACTION`) AS SELECT
 fraud_analysis_status_cd,
 fraud_analysis_status_cd_descr,
 dwh_created_tmsp,
 dwh_updated_tmsp,
 dwh_load_id,
 dwh_node_cd
FROM ldl_data_production_core_app_fraud_detection.t_fraud_analysis_status_type_2 AS main;