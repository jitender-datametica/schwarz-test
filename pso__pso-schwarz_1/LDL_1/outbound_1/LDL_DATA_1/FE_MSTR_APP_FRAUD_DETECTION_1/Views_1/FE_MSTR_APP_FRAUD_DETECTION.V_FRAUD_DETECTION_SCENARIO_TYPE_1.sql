CREATE OR REPLACE VIEW ldl_data_fe_mstr_app_fraud_detection.v_fraud_detection_scenario_type_1 (scenario_type_cd
OPTIONS(description='The code of the scenario'), scenario_type_descr
OPTIONS(description='Describes a type of scenario Automaticly or manuall'), dwh_created_tmsp
OPTIONS(description='The point in time when this record was created in the data warehouse.'), dwh_updated_tmsp
OPTIONS(description='The point in time when this record was created or last updated.'), dwh_load_id
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'))
OPTIONS(DESCRIPTION = `DESCRIBES A TYPE OF SCENARIO. AUTOMATICLY OR MANUALL`) AS SELECT *
FROM ldl_data_core_app_fraud_detection.t_fraud_detection_scenario_type_1 AS MAIN;